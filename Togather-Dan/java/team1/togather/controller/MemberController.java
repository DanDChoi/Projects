package team1.togather.controller;

import static team1.togather.constant.CheckedConstant.*;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import org.springframework.web.util.WebUtils;
import team1.togather.domain.Block;
import team1.togather.domain.Category;
import team1.togather.domain.IndexCriteria;
import team1.togather.domain.IndexPage;
import team1.togather.domain.MemInGroup;
import team1.togather.domain.Member;
import team1.togather.domain.Message;
import team1.togather.service.GroupTabService;
import team1.togather.service.MemberService;


@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/member/")
public class MemberController {
	@Autowired
	private MemberService service;
	@Autowired
	private GroupTabService groupTabService;
	@GetMapping("/joinform.do")
	public ModelAndView join() {
		List<Category> firstCategory = service.firstCategory();
		ModelAndView mv = new ModelAndView("member/join","firstCategory",firstCategory);
		return mv;
	}

	@GetMapping("/category")
	@ResponseBody
	public List<Category> category(Category category,long sequence) {
		List<Category> categorys= new ArrayList<>();
		if(sequence==2) {
			categorys = service.secondCategory(category);
		}else if(sequence==3) {
			log.info(sequence);
			categorys = service.thirdCategory(category);
			log.info("categorys: "+ categorys);
			log.warn("categorys: "+ categorys);
		}
		return categorys;
	}


	@RequestMapping("/join")
	@ResponseBody
	public int join(Member member,HttpSession session,String category_first,String category_second,String category_third) {
		int join = service.join(member);
		if(join==YES_JOIN) {
			Member m = service.login(member);
			session.setAttribute("m", m);
		}
		return join;
	}

	@GetMapping("/login.do")
	public String login() {
		return "member/login";
	}

	@GetMapping("/memberInfo")
	public ModelAndView memberInfo(MemInGroup memInGroup,HttpSession session) {
		Member memberInfo = service.memberInfo(memInGroup);
		long gseq=memInGroup.getGseq();
		List<String> blockedNameList = service.blockedNameList(session);
		String blockedCheck="";
		if(blockedNameList.size()!=0) {
			for(int i =0;i<blockedNameList.size();i++) {
				if(blockedNameList.get(i).equals(memberInfo.getMname())) {
					blockedCheck="차단한 회원입니다";
				}
			}
		}
		Member m = (Member)session.getAttribute("m");
		memInGroup.setMnum(m.getMnum());
		Long grade = groupTabService.grade(memInGroup);
		ModelAndView mv = new ModelAndView("/member/memberInfo", "memberInfo", memberInfo);
		mv.addObject("blockedCheck", blockedCheck);
		mv.addObject("gseq", gseq);
		mv.addObject("grade", grade);
		return mv;
	}



	@PostMapping("/blocking")
	@ResponseBody
	public int blocking(Block block) {
		service.blocking(block);
		return 1;
	}
	@PostMapping("/blockingCancel")
	@ResponseBody
	public int blockingCancel(Block block) {
		service.blockingCancel(block);
		return 1;
	}
	@PostMapping("/login")
	@ResponseBody
	public int logincheck(Member member, HttpSession session, String useCookie, HttpServletResponse response) {
		int logincheck = service.logincheck(member);
		if(logincheck==YES_ID_PWD) {
			Member m = service.login(member);
			session.setAttribute("m", m);
			if(useCookie!=null) {
				// 쿠키 사용한다는게 체크되어 있으면...
				// 쿠키를 생성하고 현재 로그인되어 있을 때 생성되었던 세션의 id를 쿠키에 저장한다.
				Cookie cookie =new Cookie("loginCookie", session.getId());
				// 쿠키를 찾을 경로를 컨텍스트 경로로 변경해 주고...
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*7);// 단위는 (초)임으로 7일정도로 유효시간을 설정해 준다.
				// 쿠키를 적용해 준다.
				response.addCookie(cookie);
				// currentTimeMills()가 1/1000초 단위임으로 1000곱해서 더해야함
				int amount = 60*60*24*7;
				Date sessionLimit =new Date(System.currentTimeMillis() + (1000*amount));

				Map<String,Object> map =new HashMap<>();
				map.put("mnum",m.getMnum());
				map.put("sessionId",session.getId());
				map.put("sessionLimit",sessionLimit);
				service.keepLogin(map);
				System.out.println("sessionId: "+session.getId());
				System.out.println("sessionLimit: "+sessionLimit);
				System.out.println("useCookie: "+useCookie);
			}

		}
		return logincheck;
	}
	@PostMapping("/kakaologin")
	@ResponseBody
	public int kakaologincheck(Member member,HttpSession session) {
		int kakaologincheck = service.kakaologincheck(member);
		if(kakaologincheck==YES_ID_PWD) {
			Member m = service.kakaologin(member);
			session.setAttribute("m", m);
			System.out.println("카카오로그인 m: "+m);
		}
		return  kakaologincheck;
	}
	@GetMapping("/logout.do")
	public String logout(HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		Member m = (Member)session.getAttribute("m");
		if(m!=null) {
			session.removeAttribute("m");
			session.invalidate();
			Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
			if ( loginCookie !=null ){
				// null이 아니면 존재하면!
				loginCookie.setPath("/");
				// 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
				loginCookie.setMaxAge(0);
				// 쿠키 설정을 적용한다.
				response.addCookie(loginCookie);
				// 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
				Date date =new Date(System.currentTimeMillis());
				Map<String,Object> map =new HashMap<>();
				map.put("mnum",m.getMnum());
				map.put("sessionId",session.getId());
				map.put("sessionLimit",date);
				service.keepLogin(map);
			}
		}
		return "redirect:/";
	}
	/////////////////////////
	@GetMapping("/sendMessageForm")
	public ModelAndView sendMessageForm(Message message,long gseq) {
		ModelAndView mv = new ModelAndView("member/sendMessageForm", "message", message);
		mv.addObject("gseq", gseq);
		return mv;
	}

	@PostMapping("/sendMessage")
	public String sendMessage(Message message,long gseq) {
		service.sendMessage(message);
		String memberInfoBack="";
		memberInfoBack+="redirect:memberInfo?mnum="+message.getFrom_mnum()+"&gseq="+gseq;
		return memberInfoBack;
	}

	@GetMapping("/messageList")
	public ModelAndView messageList(HttpSession session,IndexCriteria cri,HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		Map<String,Object> map = new HashMap<String,Object>();
		Member m = (Member)session.getAttribute("m");
		map.put("mnum",m.getMnum());
		map.put("startRow",cri.getStartRow());
		map.put("endRow",cri.getEndRow());
		if(request.getParameter("page")!=null) {
			String pageAt = request.getParameter("page");
			cri.setPage(Integer.parseInt(pageAt));
		}
		if(request.getParameter("pageSize")!=null) {
			String pageSize = request.getParameter("pageSize");
			cri.setPageSize(Integer.parseInt(pageSize));
		}
		IndexPage pm = new IndexPage();
		pm.setCri(cri);
		pm.setTotalCount(service.messageCount(m.getMnum())); //calcDate()실행

		mv.addObject("pm", pm);
		mv.addObject("cri", cri);
		List<Message> messageList = service.messageList(map);
		mv.addObject("messageList", messageList);
		return mv;
	}

	@GetMapping("/messageContent")
	public ModelAndView messageContent(long meseq,IndexCriteria cri,HttpServletRequest request) {
		Message messageContent = service.messageContent(meseq);
		service.messageChecked(meseq);
		ModelAndView mv = new ModelAndView("member/messageContent", "messageContent", messageContent);
		if(request.getParameter("page")!=null) {
			String pageAt = request.getParameter("page");
			mv.addObject("page", pageAt);
		}
		if(request.getParameter("pageSize")!=null) {
			String pageSize = request.getParameter("pageSize");
			mv.addObject("pageSize", pageSize);
		}
		return mv;
	}

	@PostMapping("/replyToMessage")
	public String replyToMessage(Message message,IndexCriteria cri,HttpServletRequest request) {
		service.replyToMessage(message);
		String pageAt="";
		String pageSize="";
		if(request.getParameter("page")!=null) {
			pageAt = request.getParameter("page");
		}
		if(request.getParameter("pageSize")!=null) {
			pageSize = request.getParameter("pageSize");
		}
		return "redirect:messageContent?mnum="+message.getTo_mnum()+"&page="+pageAt+"&pageSize="+pageSize+"&meseq="+message.getMeseq();
	}

	@GetMapping("/messageDelete")
	public String messageDelete(long meseq,long mnum,IndexCriteria cri,HttpServletRequest request) {
		service.messageDelete(meseq);
		String pageAt="";
		String pageSize="";
		if(request.getParameter("page")!=null) {
			pageAt = request.getParameter("page");
		}
		if(request.getParameter("pageSize")!=null) {
			pageSize = request.getParameter("pageSize");
		}
		return "redirect:messageList?mnum="+mnum+"&page="+pageAt+"&pageSize="+pageSize;
	}

	@PostMapping("/nextMessageCheck")
	@ResponseBody
	public Long nextMessageCheck(Message message) {
		Long nextMeseq = service.nextPostMessage(message);
		return nextMeseq;

	}

	@PostMapping("/previousMessage")
	@ResponseBody
	public Long previousMessage(Message message) {
		Long nextMeseq = service.previousMessage(message);
		return nextMeseq;
	}
}