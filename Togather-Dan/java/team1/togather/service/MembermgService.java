package team1.togather.service;

import java.util.List;
import java.util.Map;


import team1.togather.domain.MembermgCriteria;
import team1.togather.domain.Member;

public interface MembermgService {

    public List<Member> mmlistPageCri(MembermgCriteria cri);

    Member getMember(long mnum);

    void mmedit(Member member);
    void mmremove(long mnum);

    public List<Member> getMembermgBySearch(Map map);

    public int mmpageCount();
}