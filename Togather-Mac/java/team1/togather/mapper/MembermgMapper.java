package team1.togather.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import team1.togather.domain.MembermgCriteria;
import team1.togather.domain.Member;

public interface MembermgMapper {
    ArrayList<Member> mmlist();
    ArrayList<Member> mmlist(int pageAt, int ps);
    ArrayList<Member> mmlist(String option, String ocontent);

    Member selectmnum(long mnum);

    void mmupdate(Member member);
    void mmdelete(long mnum);


    public List<Member> mmlistPageCri(MembermgCriteria cri);
    public Integer mmpageCount();
    public List<Member> getMembermgBySearch(Map map);

}