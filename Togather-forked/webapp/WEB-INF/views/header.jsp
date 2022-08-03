<%@ page contentType="text/html;charset=utf-8" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header id="header" class="fixed-top">
  <div id="count"></div>
  <input id="hiddenInput" type="hidden" value="" />
  <div class="container d-flex align-items-center">
    <h1 class="logo me-auto"><a href="../">Togather</a></h1>

    <nav id="navbar" class="navbar order-last order-lg-0">
      <ul>
        <c:if test="${m.athur eq 0}">
          <li><a class="manage" href="../membermg/mmlistPage">회원관리</a></li>
        </c:if>
        <li><a class="active" href="../">Home</a></li>
        <li><a href="../about">About</a></li>
        <li><a href="../board/listPage">게시판</a></li>
        <c:if test="${m ne null}">
          <li>
            <a href="../groupTab/myGroup.do?mnum=${m.mnum }">나의 모임</a>
          </li>
          <!--로그인시에만 보이게 하기-->
          <li>
            <a href="../wishTab/wishList?mnum=${m.mnum }"
              >찜목록
              <span
                id="numberOfWish"
                class="badge bg-dark text-white ms-1 rounded-pill"
                >${wishsize }</span
              >
            </a>
          </li>
        </c:if>
        <li class="dropdown">
          <a href="#"
            ><span>고객지원</span> <i class="bi bi-chevron-down"></i
          ></a>
          <ul>
            <li><a href="../notification/notice">공지사항</a></li>
            <li><a href="../faq/faqList">자주묻는 질문</a></li>
            <li><a href="../qa">Q&A</a></li>
            <li><a href="../contact">Contact</a></li>
          </ul>
        </li>

        <c:choose>
          <c:when test="${m eq null}">
            <li><a href="../member/login.do">로그인 ${sessionScope.m} </a></li>
          </c:when>
          <c:otherwise>
            <li>
              <a href="javascript:void(0);" onclick="signout();">로그아웃</a>
            </li>
            <li><a href="../mypage/main">마이페이지</a></li>
          </c:otherwise>
        </c:choose>
      </ul>
      <i class="bi bi-list mobile-nav-toggle"></i>
    </nav>
    <!-- .navbar -->

    <!--로그인전에는 회원가입만 보이고 로그인하면 모임만들기만 보이게 하는건 어떤지??-->
    <c:choose>
      <c:when test="${m eq null}">
        <a href="../member/joinform.do" class="get-started-btn">회원가입</a>
      </c:when>
      <c:otherwise>
        <a href="../groupTab/groupCreate.do" class="get-started-btn"
          >모임만들기</a
        >
      </c:otherwise>
    </c:choose>
  </div>
</header>
