package team1.togather.domain;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class MmGbCriteria {

  private long page;
  private long pageSize;
  private String option = "글쓴이";
  private String ocontent = "장";
  private long mnum;

  public MmGbCriteria(long page, long pageSize, long mnum) {
    this.page = page;
    this.pageSize = pageSize;
    this.mnum = mnum;
  }

  public MmGbCriteria() {
    this.page = 1;
    this.pageSize = 10;
  }

  public long getStartRow() {
    return (page - 1) * pageSize;
  }

  public long getEndRow() {
    return page * pageSize;
  }

  public long getPage() {
    return page;
  }

  public void setPage(long page) {
    if (page <= 0) {
      this.page = 1;
      return;
    }
    this.page = page;
  }

  public long getPageSize() {
    return pageSize;
  }

  public void setPageSize(long pageSize) {
    if (pageSize <= 0 || pageSize > 100) {
      this.pageSize = 10;
      return;
    }
    this.pageSize = pageSize;
  }

  //페이징처리 시작하는 값생성
  //멤버변수가 아니지만 getter와 setter를 생성하면 Mapper에서 접근가능하다.
  //Mapper에서 사용하는 법 #{pageStart}
  public long getPageStart() {
    return (this.page - 1) * this.pageSize;
  }

  public long getMnum() {
    return mnum;
  }

  public void setMnum(long mnum) {
    this.mnum = mnum;
  }

  //toString()
  @Override
  public String toString() {
    return "Criteria [page=" + page + ", pageSize=" + pageSize + "]";
  }
}
