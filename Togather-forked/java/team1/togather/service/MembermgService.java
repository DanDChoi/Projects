package team1.togather.service;

import java.util.List;
import java.util.Map;


import team1.togather.domain.MembermgCriteria;
import team1.togather.domain.MmGbCriteria;
import team1.togather.domain.MmGbRCriteria;
import team1.togather.domain.GBReply;
import team1.togather.domain.GBoard;
import team1.togather.domain.Member;

public interface MembermgService {
    //회원관리 리스트
    public List<Member> mmlistPageCri(MembermgCriteria cri);

    Member getMember(long mnum);

    void mmedit(Member member);
    void mmremove(long mnum);

    public List<Member> getMembermgBySearch(Map map);

    public int mmpageCount();

    //작성한 회원 모임게시판리스트
    public List<GBoard> MmGbListPageCri(MmGbCriteria cri);

    public List<GBoard> getMmGbBySearch(Map map);

    public int MmGbPageCount(long mnum);

    //작성한 회원 모임게시판 댓글 리스트
    public List<GBReply> MmGbRListPageCri(MmGbRCriteria cri);

    public List<GBReply> getMmGbRBySearch(Map map);

    public int MmGbRPageCount(long mnum);
}