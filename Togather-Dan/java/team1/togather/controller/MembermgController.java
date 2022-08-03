package team1.togather.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import team1.togather.domain.Member;
import team1.togather.domain.MMPageMaker;
import team1.togather.domain.MembermgCriteria;
import team1.togather.service.MembermgService;

@Log4j
@AllArgsConstructor
@Controller
@RequestMapping("/membermg")
public class MembermgController {
    private MembermgService membermgService;

    @ResponseBody
    @GetMapping("mmlistRest")
    public List<Member> mmlistRest(String option, String membermgSearch, MembermgCriteria cri, HttpServletRequest request){
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("option", option);
        if(membermgSearch.contains("관")) {
            membermgSearch = "0";
        }else if(membermgSearch.contains("운")) {
            membermgSearch = "1";
        }else if(membermgSearch.contains("일")) {
            membermgSearch = "2";
        }
        map.put("membermgSearch", membermgSearch);
        map.put("startRow", String.valueOf(cri.getStartRow()));
        map.put("endRow", String.valueOf(cri.getEndRow()));

        if(request.getParameter("page")!=null) {
            String pageAt = request.getParameter("page");
            cri.setPage(Integer.parseInt(pageAt));
        }
        if(request.getParameter("pageSize")!=null) {
            String pageSize = request.getParameter("pageSize");
            cri.setPageSize(Integer.parseInt(pageSize));
        }

        MMPageMaker pm = new MMPageMaker();
        pm.setCri(cri);
        pm.setTotalCount(membermgService.mmpageCount()); //calcDate()실행
        return membermgService.getMembermgBySearch(map);
    }
    @GetMapping("/mmlistCri")
    public void mmlistCriGET(Model model, MembermgCriteria cri) {
        model.addAttribute("MembermgList", membermgService.mmlistPageCri(cri));
    }

    @GetMapping("mmlistPage")
    public ModelAndView MembermgList(MembermgCriteria cri, Model model, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("MembermgList", membermgService.mmlistPageCri(cri)); // =listPageCri()
        if(request.getParameter("page")!=null) {
            String pageAt = request.getParameter("page");
            cri.setPage(Integer.parseInt(pageAt));
        }
        if(request.getParameter("pageSize")!=null) {
            String pageSize = request.getParameter("pageSize");
            cri.setPageSize(Integer.parseInt(pageSize));
        }
        MMPageMaker pm = new MMPageMaker();
        pm.setCri(cri);
        pm.setTotalCount(membermgService.mmpageCount()); //calcDate()실행
        mv.addObject("pm", pm);
        mv.addObject("cri", cri);
        mv.setViewName("membermg/mmlist");
        return mv;
    }
    @GetMapping("membermgWithSearch")
    public String membermgListWithSearch() {
        return "membermg/mmlist";
    }


    @GetMapping("mmupdate.do")
    public ModelAndView mmupdate(long mnum, HttpSession session) {
        Member member = membermgService.getMember(mnum);
        ModelAndView mv = new ModelAndView("membermg/mmupdate", "member", member);
        return mv;
    }
    @PostMapping("mmupdate.do")
    public String mmupdate(Member member, HttpServletRequest request) {
        membermgService.mmedit(member);
        return "redirect:mmlistPage.do";
    }
    @GetMapping("mmdel.do")
    public String mmdelete(long mnum, HttpServletRequest request) {
        membermgService.mmremove(mnum);
        return "redirect:mmlistPage.do";
    }

}