package team1.togather.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import team1.togather.domain.GBReply;
import team1.togather.domain.GBoard;
import team1.togather.domain.Member;
import team1.togather.domain.MembermgCriteria;
import team1.togather.domain.MmGbCriteria;
import team1.togather.domain.MmGbRCriteria;
import team1.togather.mapper.MembermgMapper;

@Log4j
@Service
@AllArgsConstructor
public class MembermgServiceImpl implements MembermgService {

  private MembermgMapper membermgMapper;

  //회원관리
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
  public List<Member> getMembermgBySearch(Map map) {
    return membermgMapper.getMembermgBySearch(map);
  }

  //회원이 작성한 모임게시판
  @Override
  public List<GBoard> MmGbListPageCri(MmGbCriteria cri) {
    return membermgMapper.MmGbListPageCri(cri);
  }

  @Override
  public int MmGbPageCount(long mnum) {
    return membermgMapper.MmGbPageCount(mnum);
  }

  @Override
  public List<GBoard> getMmGbBySearch(Map map) {
    return membermgMapper.getMmGbBySearch(map);
  }

  //회원이 작성한 모임게시판 댓글
  @Override
  public List<GBReply> MmGbRListPageCri(MmGbRCriteria cri) {
    return membermgMapper.MmGbRListPageCri(cri);
  }

  @Override
  public int MmGbRPageCount(long mnum) {
    return membermgMapper.MmGbRPageCount(mnum);
  }

  @Override
  public List<GBReply> getMmGbRBySearch(Map map) {
    return membermgMapper.getMmGbRBySearch(map);
  }
}
