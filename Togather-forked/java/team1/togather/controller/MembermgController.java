package team1.togather.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import team1.togather.domain.GBReply;
import team1.togather.domain.GBoard;
import team1.togather.domain.MMPageMaker;
import team1.togather.domain.Member;
import team1.togather.domain.MembermgCriteria;
import team1.togather.domain.MmGbCriteria;
import team1.togather.domain.MmGbPageMaker;
import team1.togather.domain.MmGbRCriteria;
import team1.togather.domain.MmGbRPageMaker;
import team1.togather.service.MembermgService;

@Log4j
@AllArgsConstructor
@Controller
@RequestMapping("/membermg")
public class MembermgController {

  private MembermgService membermgService;

  // 회원관리
  @ResponseBody
  @GetMapping("mmlistRest")
  public List<Member> mmlistRest(
    String option,
    String membermgSearch,
    MembermgCriteria cri,
    HttpServletRequest request
  ) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("option", option);
    if (membermgSearch.contains("관")) {
      membermgSearch = "0";
    } else if (membermgSearch.contains("운")) {
      membermgSearch = "1";
    } else if (membermgSearch.contains("일")) {
      membermgSearch = "2";
    }
    map.put("membermgSearch", membermgSearch);
    map.put("startRow", String.valueOf(cri.getStartRow()));
    map.put("endRow", String.valueOf(cri.getEndRow()));

    if (request.getParameter("page") != null) {
      String pageAt = request.getParameter("page");
      cri.setPage(Integer.parseInt(pageAt));
    }
    if (request.getParameter("pageSize") != null) {
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
  public ModelAndView MembermgList(
    MembermgCriteria cri,
    Model model,
    HttpServletRequest request
  ) {
    ModelAndView mv = new ModelAndView();
    mv.addObject("MembermgList", membermgService.mmlistPageCri(cri)); // =listPageCri()
    if (request.getParameter("page") != null) {
      String pageAt = request.getParameter("page");
      cri.setPage(Integer.parseInt(pageAt));
    }
    if (request.getParameter("pageSize") != null) {
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

  //회원이 작성한 모임게시판글목록
  @ResponseBody
  @GetMapping("MmGbListRest")
  public List<GBoard> MmGbListRest(
    String option,
    String MmGbSearch,
    MmGbCriteria cri,
    HttpServletRequest request,
    long mnum
  ) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("option", option);
    map.put("MmGbSearch", MmGbSearch);
    map.put("startRow", String.valueOf(cri.getStartRow()));
    map.put("endRow", String.valueOf(cri.getEndRow()));
    map.put("mnum", cri.getMnum());

    if (request.getParameter("page") != null) {
      String pageAt = request.getParameter("page");
      cri.setPage(Long.parseLong(pageAt));
    }
    if (request.getParameter("pageSize") != null) {
      String pageSize = request.getParameter("pageSize");
      cri.setPageSize(Long.parseLong(pageSize));
    }

    MmGbPageMaker pm = new MmGbPageMaker();
    pm.setCri(cri);
    pm.setTotalCount(membermgService.MmGbPageCount(mnum)); //calcDate()실행
    return membermgService.getMmGbBySearch(map);
  }

  @GetMapping("/MmGbListCri")
  public void MmGbListCriGET(Model model, MmGbCriteria cri) {
    model.addAttribute("MmGbList", membermgService.MmGbListPageCri(cri));
  }

  @GetMapping("MmGbListPage")
  public ModelAndView MmGbList(
    MmGbCriteria cri,
    Model model,
    HttpServletRequest request,
    Long mnum
  ) {
    System.out.println("mun: " + mnum);
    ModelAndView mv = new ModelAndView();
    mv.addObject("MmGbList", membermgService.MmGbListPageCri(cri)); // =listPageCri()
    if (request.getParameter("page") != null) {
      String pageAt = request.getParameter("page");
      cri.setPage(Long.parseLong(pageAt));
    }
    if (request.getParameter("pageSize") != null) {
      String pageSize = request.getParameter("pageSize");
      cri.setPageSize(Long.parseLong(pageSize));
    }
    MmGbPageMaker pm = new MmGbPageMaker();
    pm.setCri(cri);
    pm.setTotalCount(membermgService.MmGbPageCount(mnum)); //calcDate()실행
    mv.addObject("mnum", cri.getMnum());
    mv.addObject("pm", pm);
    mv.addObject("cri", cri);
    mv.setViewName("membermg/MmGbList");
    return mv;
  }

  @GetMapping("MmGbWithSearch")
  public String MmGbListWithSearch() {
    return "membermg/MmGbList";
  }

  //회원이 작성한 모임게시판 댓글목록
  @ResponseBody
  @GetMapping("MmGbRListRest")
  public List<GBReply> MmGbRListRest(
    String option,
    String MmGbRSearch,
    MmGbRCriteria cri,
    HttpServletRequest request,
    long mnum
  ) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("option", option);
    map.put("MmGbRSearch", MmGbRSearch);
    map.put("startRow", String.valueOf(cri.getStartRow()));
    map.put("endRow", String.valueOf(cri.getEndRow()));
    map.put("mnum", cri.getMnum());

    if (request.getParameter("page") != null) {
      String pageAt = request.getParameter("page");
      cri.setPage(Long.parseLong(pageAt));
    }
    if (request.getParameter("pageSize") != null) {
      String pageSize = request.getParameter("pageSize");
      cri.setPageSize(Long.parseLong(pageSize));
    }

    MmGbRPageMaker pm = new MmGbRPageMaker();
    pm.setCri(cri);
    pm.setTotalCount(membermgService.MmGbRPageCount(mnum)); //calcDate()실행
    return membermgService.getMmGbRBySearch(map);
  }

  @GetMapping("/MmGbRListCri")
  public void MmGbRListCriGET(Model model, MmGbRCriteria cri) {
    model.addAttribute("MmGbRList", membermgService.MmGbRListPageCri(cri));
  }

  @GetMapping("MmGbRListPage")
  public ModelAndView MmGbRList(
    MmGbRCriteria cri,
    Model model,
    HttpServletRequest request,
    Long mnum,
    Long gseq
  ) {
    ModelAndView mv = new ModelAndView();
    mv.addObject("MmGbRList", membermgService.MmGbRListPageCri(cri)); // =listPageCri()
    if (request.getParameter("page") != null) {
      String pageAt = request.getParameter("page");
      cri.setPage(Long.parseLong(pageAt));
    }
    if (request.getParameter("pageSize") != null) {
      String pageSize = request.getParameter("pageSize");
      cri.setPageSize(Long.parseLong(pageSize));
    }
    MmGbRPageMaker pm = new MmGbRPageMaker();
    pm.setCri(cri);
    pm.setTotalCount(membermgService.MmGbRPageCount(mnum)); //calcDate()실행
    mv.addObject("mnum", cri.getMnum());
    mv.addObject("pm", pm);
    mv.addObject("cri", cri);
    mv.setViewName("membermg/MmGbRList");
    return mv;
  }

  @GetMapping("MmGbRWithSearch")
  public String MmGbRListWithSearch() {
    return "membermg/MmGbRList";
  }
}
