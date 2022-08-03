package team1.togather.controller;

import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import team1.togather.domain.GBReply;
import team1.togather.domain.GBoard;
import team1.togather.service.GBReplyService;
import team1.togather.service.GBoardService;

@AllArgsConstructor
@Controller
@RequestMapping("gbreply")
public class GBReplyController {

  private GBReplyService gbreplyService;
  private GBoardService gboardService;

  @GetMapping("gbrupdate.do")
  public ModelAndView gbrupdate(
    long gbnum,
    long gbrseq,
    String gbrcontent,
    String mname,
    Date rdate
  ) {
    GBoard gboard = gboardService.getGBoard(gbnum);
    ArrayList<GBReply> gbrlist = gbreplyService.gbrlistS(gbnum);
    GBReply gbreply = gbreplyService.getGBReply(gbrseq);
    ModelAndView mv = new ModelAndView("gbreply/gbrupdate", "gboard", gboard);
    mv.addObject("gbrlist", gbrlist);
    mv.addObject("gbrseq", gbrseq);
    mv.addObject("gbnum", gbnum);
    mv.addObject("gbrcontent", gbrcontent);
    mv.addObject("mname", mname);
    mv.addObject("rdate", rdate);

    return mv;
  }

  @PostMapping("gbrupdate.do")
  public String gbrupdate(
    GBReply gbreply,
    HttpServletRequest request,
    HttpServletResponse response
  ) {
    gbreplyService.gbrupdateS(gbreply);
    long gbnum = Long.parseLong(request.getParameter("gbnum"));
    long gbrseq = Long.parseLong(request.getParameter("gbrseq"));
    return "redirect:../gboard/gbcontent.do?gbnum=" + gbnum + "";
  }

  @GetMapping("gbrdel.do")
  public String gbdelete(
    long gbrseq,
    HttpServletRequest request,
    HttpServletResponse response
  ) {
    gbreplyService.gbrdeleteS(gbrseq);
    long gbnum = Long.parseLong(request.getParameter("gbnum"));
    return "redirect:../gboard/gbcontent.do?gbnum=" + gbnum + "";
  }
}
