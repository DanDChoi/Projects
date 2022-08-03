package team1.togather.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import team1.togather.domain.MembermgCriteria;
import team1.togather.domain.Member;
import team1.togather.mapper.MembermgMapper;

@Log4j
@Service
@AllArgsConstructor
public class MembermgServiceImpl implements MembermgService {
    private MembermgMapper membermgMapper;


    @Override
    public List<Member> mmlistPageCri(MembermgCriteria cri) {
        return membermgMapper.mmlistPageCri(cri);
    }

    @Override
    public int mmpageCount() {
        return membermgMapper.mmpageCount();
    }

    @Override
    public Member getMember(long mnum) {
        Member member = membermgMapper.selectmnum(mnum);
        return member;
    }

    @Override
    public void mmedit(Member member) {
        membermgMapper.mmupdate(member);
    }
    @Override
    public void mmremove(long mnum) {
        membermgMapper.mmdelete(mnum);
    }

    @Override
    public List<Member> getMembermgBySearch(Map map){
        return membermgMapper.getMembermgBySearch(map);
    }



}