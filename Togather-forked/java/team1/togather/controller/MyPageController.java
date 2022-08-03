package team1.togather.controller;

import static team1.togather.constant.CheckedConstant.NOTSAME_PWD;
import static team1.togather.constant.CheckedConstant.SAME_PWD;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import team1.togather.domain.Category;
import team1.togather.domain.Member;
import team1.togather.service.MyPageService;

@Log4j
@Controller
@RequestMapping("mypage")
public class MyPageController {

  @Autowired
  private MyPageService mypageservice;

  @GetMapping("main")
  public ModelAndView main(HttpServletRequest request) {
    HttpSession session = request.getSession();
    Member member = (Member) session.getAttribute("m");
    long mnum = member.getMnum();
    Member member1 = mypageservice.list(mnum);
    ModelAndView mv = new ModelAndView("mypage/main", "member", member1);
    return mv;
  }

  @PostMapping("nowpassword")
  @ResponseBody
  public int nowpassword(Member member, HttpSession session) {
    int nowpassword = mypageservice.nowpassword(member);
    if (nowpassword == SAME_PWD) {
      return SAME_PWD;
    } else return NOTSAME_PWD;
  }

  @GetMapping("updatepassword")
  public String updatepassword(Member member) {
    mypageservice.updatepassword(member);
    return "redirect:main";
  }

  @GetMapping("updateemail")
  public ModelAndView updateemail(Member member, HttpSession session) {
    Member updatemember = (Member) session.getAttribute("m");
    updatemember.setEmail(member.getEmail());
    ModelAndView mv = new ModelAndView(
      "mypage/updateemail",
      "member",
      updatemember
    );
    return mv;
  }

  @ResponseBody
  @PostMapping("updateemail")
  public ModelAndView updateemail2(Member member, HttpSession session) {
    mypageservice.updateemail(member);
    Member updatemember = (Member) session.getAttribute("m");
    ModelAndView mv = new ModelAndView(
      "mypage/updateemail",
      "member",
      updatemember
    );
    return mv;
  }

  @PostMapping("emailcheck")
  @ResponseBody
  public int emailcheck(String email, HttpSession session) {
    int email_check = mypageservice.emailcheck(email);
    System.out.println("email_check : " + email_check);
    if (email_check == 1) {
      return 1;
    } else return 0;
  }

  @ResponseBody
  @PostMapping("updatemaddrandpfr_loc")
  public int updatemaddrandpfr_loc(Member member, HttpSession session) {
    Member m = (Member) session.getAttribute("m");
    String str = member.getMaddr();
    String result = str.replaceFirst(",", " ");
    if (
      result.equals(m.getMaddr()) && member.getPfr_loc().equals(m.getPfr_loc())
    ) {
      member.setMaddr(result);
      return 0;
    } else {
      member.setMnum(m.getMnum());
      member.setMaddr(result);
      mypageservice.updatemaddrandpfr_loc(member);
      m.setMaddr(member.getMaddr());
      m.setPfr_loc(member.getPfr_loc());
      return 1;
    }
  }

  @GetMapping("updatemaddrandpfr_loc")
  public String updatemaddrandpfr_loc(Member member) {
    mypageservice.updatemaddrandpfr_loc(member);
    return "redirect:main";
  }

  @GetMapping("categoryform.do")
  public ModelAndView join() {
    List<Category> firstCategory = mypageservice.firstCategory();
    ModelAndView mv = new ModelAndView(
      "mypage/updatecategory",
      "firstCategory",
      firstCategory
    );
    return mv;
  }

  @ResponseBody
  @GetMapping("category")
  public List<Category> category(
    HttpSession session,
    Category category,
    long sequence
  ) {
    List<Category> categorys = new ArrayList<>();
    if (sequence == 2) {
      categorys = mypageservice.secondCategory(category);
    } else if (sequence == 3) {
      categorys = mypageservice.thirdCategory(category);
    }
    return categorys;
  }

  @ResponseBody
  @PostMapping("updatecategory")
  public int updatecategory(Member member, HttpSession session) {
    Member m = (Member) session.getAttribute("m");
    member.setMnum(m.getMnum());
    mypageservice.updateCategory(member);
    if (member.getCategory_first() != null) {
      m.setCategory_first(member.getCategory_first());
    }

    if (member.getCategory_second() != null) {
      m.setCategory_second(member.getCategory_second());
    }
    if (member.getCategory_third() != null) {
      m.setCategory_third(member.getCategory_third());
    }

    return 1;
  }

  @ResponseBody
  @RequestMapping("makesecondCategoryblank")
  public ModelAndView makesecondCategoryblank(
    long second,
    HttpSession session,
    Member member
  ) {
    Member m = (Member) session.getAttribute("m");
    member.setMnum(m.getMnum());
    m.setCategory_second(member.getCategory_second());
    if (second == 2) {
      mypageservice.makesecondCategoryblank(member.getMnum()); //null
    }
    ModelAndView mv = new ModelAndView("mypage/main", "m", m);
    return mv;
  }

  @ResponseBody
  @RequestMapping("makethirdCategoryblank")
  public ModelAndView makethirdCategoryblank(
    long third,
    Member member,
    HttpSession session
  ) {
    Member m = (Member) session.getAttribute("m");
    member.setMnum(m.getMnum());
    m.setCategory_third(member.getCategory_third());
    if (third == 2) {
      mypageservice.makesecondCategoryblank(member.getMnum());
    }
    ModelAndView mv = new ModelAndView("mypage/main", "m", m);
    return mv;
  }
}
