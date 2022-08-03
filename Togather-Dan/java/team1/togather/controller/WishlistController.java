package team1.togather.controller;

import java.util.ArrayList;
import java.util.List;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import team1.togather.domain.GroupTab;
import team1.togather.domain.Member;
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
	public ModelAndView wishList(Long mnum) {
		log.info("mnum: "+ mnum);
		List<WishList> wishList = wishservice.getWishLists(mnum);
		List<GroupTab> groupList = new ArrayList<>();
		List<Member> namelist = new ArrayList<>();
		List<Long> groupMemberCount = new ArrayList<>();

		for(WishList wli: wishList) {
			groupList.add(groupservice.selectByGSeqS(wli.getGseq()));
			System.out.println(wli.getGseq());
			if(wishList.size()>=9) {
				wishList.remove(8);
			}
		}
		for(GroupTab gli: groupList) {
			namelist.add(groupservice.groupInfoMemberName(gli.getGseq()));
			if(groupList.size()>=9) {
				groupList.remove(8);
			}
		}
		for(GroupTab gli: groupList){
			groupMemberCount.add(groupservice.groupMemberCount(gli.getGseq()));
		}

		ModelAndView mv = new ModelAndView("wishTab/wishList","groupList",groupList);
		System.out.println("groupList = " + groupList);
		mv.addObject("namelist", namelist);
		mv.addObject("groupMemberCount", groupMemberCount);
		return mv;
	}

}
