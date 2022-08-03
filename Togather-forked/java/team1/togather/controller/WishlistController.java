package team1.togather.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import team1.togather.domain.GroupTab;
import team1.togather.domain.Member;
import team1.togather.domain.WishCheck;
import team1.togather.domain.WishList;
import team1.togather.service.GroupTabService;
import team1.togather.service.WishListService;

@Log4j
@Controller
@RequestMapping("/wishTab")
public class WishlistController {

  @Autowired
  private GroupTabService groupservice;

  @Autowired
  private WishListService wishservice;

  @GetMapping("/wishList")
  public ModelAndView wishList(Long mnum, HttpSession session) {
    log.info("mnum: " + mnum);
    List<WishList> wishList = wishservice.getWishLists(mnum);
    List<GroupTab> groupList = new ArrayList<>();
    List<Member> namelist = new ArrayList<>();
    List<Long> groupMemberCount = new ArrayList<>();

    for (WishList wli : wishList) {
      groupList.add(groupservice.selectByGSeqS(wli.getGseq()));
      if (wishList.size() >= 9) {
        wishList.remove(8);
      }
    }
    for (GroupTab gli : groupList) {
      namelist.add(groupservice.groupInfoMemberName(gli.getGseq()));
      if (groupList.size() >= 9) {
        groupList.remove(8);
      }
    }
    for (GroupTab gli : groupList) {
      groupMemberCount.add(groupservice.groupMemberCount(gli.getGseq()));
    }
    int wishNumOfM = 0;
    List<GroupTab> list = new ArrayList<>();
    Member m = (Member) session.getAttribute("m");
    Map<String, Long> wishmap = new HashMap<>();
    List<WishCheck> checkedWishList = new ArrayList<>(); //gseq값과 flag를 저장
    if (m != null) {
      List<WishList> WishOfM = wishservice.getWishLists(m.getMnum());
      wishNumOfM = WishOfM.size();
      for (GroupTab li : list) {
        wishmap.put("mnum", m.getMnum());
        wishmap.put("gseq", li.getGseq());
        if (
          wishservice.wishListFlagCheck(wishmap) != null &&
          wishservice.wishListFlagCheck(wishmap) == 1
        ) {
          checkedWishList.add(new WishCheck(li.getGseq(), 1));
          wishmap.clear();
        }
      }
    }
    ModelAndView mv = new ModelAndView(
      "wishTab/wishList",
      "groupList",
      groupList
    );
    mv.addObject("namelist", namelist);
    mv.addObject("groupMemberCount", groupMemberCount);
    session.setAttribute("wishsize", wishNumOfM);
    return mv;
  }
}
