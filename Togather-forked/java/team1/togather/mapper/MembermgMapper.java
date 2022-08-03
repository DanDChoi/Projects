package team1.togather.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import team1.togather.domain.MembermgCriteria;
import team1.togather.domain.MmGbCriteria;
import team1.togather.domain.MmGbRCriteria;
import team1.togather.domain.GBReply;
import team1.togather.domain.GBoard;
import team1.togather.domain.Member;

public interface MembermgMapper {
    //회원관리
    ArrayList<Member> mmlist();
    ArrayList<Member> mmlist(int pageAt, int ps);
    ArrayList<Member> mmlist(String option, String ocontent);

    Member selectmnum(long mnum);

    void mmupdate(Member member);
    void mmdelete(long mnum);


    public List<Member> mmlistPageCri(MembermgCriteria cri);
    public Integer mmpageCount();
    public List<Member> getMembermgBySearch(Map map);

    long MemberCount();

    //회원 모임게시판 작성글
    ArrayList<GBoard> MmGbList();
    ArrayList<GBoard> MmGbList(int pageAt, int ps);
    ArrayList<GBoard> MmGbList(String option, String ocontent);

    public List<GBoard> MmGbListPageCri(MmGbCriteria cri);
    public Integer MmGbPageCount(long mnum);
    public List<GBoard> getMmGbBySearch(Map map);

    long MmGbCount();

    //회원 모임게시판 댓글
    ArrayList<GBReply> MmGbRList();
    ArrayList<GBReply> MmGbRList(int pageAt, int ps);
    ArrayList<GBReply> MmGbRList(String option, String ocontent);

    public List<GBReply> MmGbRListPageCri(MmGbRCriteria cri);
    public Integer MmGbRPageCount(long mnum);
    public List<GBReply> getMmGbRBySearch(Map map);

    long MmGbRCount();
}