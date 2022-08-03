<%@ page language="java" contentType="text/html; charset=utf-8"
import="java.sql.Date, java.util.*, team1.togather.domain.* "%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <style>
    table.type07 {
      border-collapse: collapse;
      text-align: left;
      line-height: 1.5;
      border: 1px solid #ccc;
      margin: 20px 10px;
    }
    table.type07 thead {
      border-right: 1px solid #ccc;
      border-left: 1px solid #ccc;
      background: #b7adad;
    }
    table.type07 thead th {
      padding: 10px;
      font-weight: bold;
      vertical-align: top;
    }
    table.type07 tbody th {
      width: 150px;
      padding: 10px;
      font-weight: bold;
      vertical-align: top;
      border-bottom: 1px solid #ccc;
      background: #fcf1f4;
    }
    table.type07 td {
      width: 350px;
      padding: 10px;
      vertical-align: top;
      border-bottom: 1px solid #ccc;
    }
    table.type07 .even {
      background: #fdf3f5;
    }
  </style>
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Togather</title>
    <meta content="" name="description" />
    <meta content="" name="keywords" />

    <!-- Favicons -->
    <link href="/assets/img/favicon.png" rel="icon" />
    <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon" />

    <!-- Google Fonts -->
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
      rel="stylesheet"
    />

    <!-- Vendor CSS Files -->
    <link href="/assets/vendor/animate.css/animate.min.css" rel="stylesheet" />
    <link href="/assets/vendor/aos/aos.css" rel="stylesheet" />
    <link
      href="/assets/vendor/bootstrap/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
      rel="stylesheet"
    />

    <link
      href="/assets/vendor/bootstrap-icons/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      href="/assets/vendor/boxicons/css/boxicons.min.css"
      rel="stylesheet"
    />
    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet" />
    <link href="/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet" />

    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript">
      $(function () {
        //$("tr:odd").css("background","red");
        $("tr:even").css("background", "#faf7f2");
      });

      $(function () {
        $("#MmGbRSearch").on("keyup", function () {
          var mnum = "${mnum}";
          var table = document.getElementById("MmGbRTest");
          $.ajax({
            url: "MmGbRListRest",
            type: "GET",
            dataType: "json",
            contentType: "application/json",
            data: {
              MmGbRSearch: $("#MmGbRSearch").val(),
              option: $("#option").val(),
              mnum: mnum,
            },
            success: function (result) {
              var data = result;
              var obj_length = Object.keys(result).length;
              var trlength = $("#MmGbRTest tr").length;
              for (var t = trlength - 1; t > 0; t--) {
                table.deleteRow(t);
              }
              for (var i = 0; i <= obj_length; i++) {
                $("#MmGbRTest tr:even").css("background", "#faf7f2");
                $("#MmGbRTest").append(
                  "<tr onClick=\"location.href='../gboard/gbcontent.do?gbnum=" +
                    result[i].gbnum +
                    "'\">" +
                    "<td class='column1'>" +
                    result[i].gbnum +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].gbrseq +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].mname +
                    "</td>" +
                    "<td class='column2'>" +
                    result[i].gbrcontent +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].rdate +
                    "</td>"
                );
              }
            },
            error: function (error) {
              console.log("##error: " + error);
            },
          });
        });
      });
    </script>
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script>
      Kakao.init("11400a9267d93835389eb9255fcaad0b");
      function signout() {
        if (Kakao.Auth.getAccessToken() != null) {
          Kakao.Auth.logout(function () {
            setTimeout(function () {
              location.href = "../member/logout.do";
            }, 500);
          });
        } else {
          location.href = "../member/logout.do";
        }
      }
    </script>
  </head>
  <body>
    <!-- ======= Header ======= -->
    <header id="header" class="fixed-top">
      <div class="container d-flex align-items-center">
        <h1 class="logo me-auto"><a href="../">Togather</a></h1>
        <!-- Uncomment below if you prefer to use an image logo -->
        <!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

        <nav id="navbar" class="navbar order-last order-lg-0">
          <ul>
            <c:if test="${m.athur eq 0}">
              <li>
                <a class="manage" href="../membermg/mmlistPage">회원관리</a>
              </li>
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
                <li>
                  <a href="../member/login.do">로그인 ${sessionScope.m} </a>
                </li>
              </c:when>
              <c:otherwise>
                <li>
                  <a href="javascript:void(0);" onclick="signout();"
                    >로그아웃</a
                  >
                </li>
                <li><a href="../mypage/main">마이페이지</a></li>
              </c:otherwise>
            </c:choose>
          </ul>
          <i class="bi bi-list mobile-nav-toggle"></i>
        </nav>
        <!-- .navbar -->

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
    <!-- End Header -->

    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fade-in">
        <div class="container">
          <h1>작성한 모임게시판 댓글</h1>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Cource Details Section ======= -->
      <section id="course-details" class="course-details">
        <div class="container" data-aos="fade-up" style="margin-top: 10px">
          <ul class="nav nav-tabs mb-3">
            <li class="nav-item">
              <a class="nav-link" href="MmGbListPage?mnum=${mnum}">모임게시판</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" aria-current="page">모임게시판 댓글</a>
            </li>
          </ul>
          <div class="button_group">
            <button
              style="margin-top: 10px"
              class="btn btn-outline-dark btn-sm dropdown-toggle mb-1 mx-md-0"
              type="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
              style="float: left"
            >
              페이지당 게시글 수
            </button>
            <i
              class="bi bi-journal-text"
              style="margin-left: 1000px; font-weight: bold; width: 1500px"
            >
              총 댓글 수: ${pm.totalCount}개</i
            >
            <ul class="dropdown-menu">
              <li>
                <a
                  class="dropdown-item"
                  href="MmGbRListPage?pageSize=1&mnum=${mnum}"
                  >1</a
                >
              </li>
              <li>
                <a
                  class="dropdown-item"
                  href="MmGbRListPage?pageSize=5&mnum=${mnum}"
                  >5</a
                >
              </li>
              <li>
                <a
                  class="dropdown-item"
                  href="MmGbRListPage?pageSize=10&mnum=${mnum}"
                  >10</a
                >
              </li>
              <li>
                <a
                  class="dropdown-item"
                  href="MmGbRListPage?pageSize=15&mnum=${mnum}"
                  >15</a
                >
              </li>
            </ul>
          </div>

          <table
            id="MmGbRTest"
            class="type07"
            style="text-align: center; margin-left: 0px"
          >
            <thead>
              <tr>
                <th class="col-sm-1">게시글 번호</th>
                <th class="col-sm-1">댓글번호</th>
                <th class="col-sm-1">작성자</th>
                <th class="col-sm-2">댓글내용</th>
                <th class="col-sm-1">작성일</th>
              </tr>
            </thead>
            <tbody>
              <c:if test="${empty MmGbRList}">
                <tr align="center">
                  <td colspan="5">데이터가 하나도 없음</td>
                </tr>
              </c:if>
              <c:if test="${not empty MmGbRList}">
                <c:forEach var="MmGbR" items="${MmGbRList }">
                  <tr
                    style="cursor: pointer"
                    onmouseover='this.style.background="#e0e0e0";'
                    onmouseleave=' $("tr:even").css("background","#faf7f2"); $("tr:odd").css("background","white");'
                    onClick="location.href='../gboard/gbcontent.do?gbnum=${MmGbR.gbnum}&gseq=${gseq}'"
                  >
                    <td class="col-sm-1">${MmGbR.gbnum}</td>
                    <td class="col-sm-1">${MmGbR.gbrseq }</td>
                    <td class="col-sm-1">${MmGbR.mname }</td>
                    <td class="col-sm-2">${MmGbR.gbrcontent }</td>
                    <td class="col-sm-1">
                      <fmt:formatDate
                        value="${MmGbR.rdate }"
                        pattern="yyyy-MM-dd (E) HH:mm"
                      />
                    </td>
                  </tr>
                </c:forEach>
              </c:if>
            </tbody>
          </table>
          <div
            class="input-group input-group-sm mb-3"
            style="width: 300px; height: auto"
          >
            <select
              class="btn btn-outline-dark"
              data-bs-toggle="dropdown"
              aria-expanded="false"
              name="option"
              id="option"
            >
              <option value="gbrseq">댓글번호</option>
              <option value="gbrcontent">내용</option>
              <option value="gbnum">게시글번호</option>
            </select>
            <input
              id="MmGbRSearch"
              name="MmGbRSearch"
              type="text"
              aria-label="Text input with dropdown button"
            />
          </div>
          <div id="firstpage">
            <nav id="nav1" aria-label="Page navigation example">
              <ul
                id="paging"
                class="pagination"
                style="justify-content: center"
              >
                <c:if test="${pm.prev}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="MmGbRListPage?page=${pm.startPage-1}&pageSize=${cri.pageSize}&mnum=${mnum}"
                      >처음</a
                    >
                  </li>
                </c:if>
                <c:if test="${pm.prev}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="MmGbRListPage?page=${cri.page-1}&pageSize=${cri.pageSize}&mnum=${mnum}"
                      >이전</a
                    >
                  </li>
                </c:if>
                <c:forEach
                  var="idx"
                  begin="${pm.startPage }"
                  end="${pm.endPage }"
                >
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="MmGbRListPage?page=${idx }&pageSize=${cri.pageSize}&mnum=${mnum}"
                      >${idx}</a
                    >
                  </li>
                </c:forEach>
                <c:if test="${pm.next && pm.endPage > 0}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="MmGbRListPage?page=${cri.page+1}&pageSize=${cri.pageSize}&mnum=${mnum}"
                      >다음</a
                    >
                  </li>
                </c:if>
                <c:if test="${pm.next && pm.endPage > 0}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="MmGbRListPage?page=${pm.endPage}&pageSize=${cri.pageSize}&mnum=${mnum}"
                      >끝</a
                    >
                  </li>
                </c:if>
              </ul>
            </nav>
          </div>
        </div>
      </section>
      <!-- End Cource Details Section -->
    </main>
    <!-- End #main -->

    <!-- ======= Footer ======= -->
    <footer id="footer">
      <div class="footer-top">
        <div class="container">
          <div class="row">
            <div class="col-lg-3 col-md-6 footer-contact">
              <h3>Togather</h3>
              <p>
                서울시 금천구<br />
                가산 디지털 2로 123<br />
                월드메르디앙 2차<br /><br />
                <strong>Phone:</strong>+82 2 1234 1234<br />
                <strong>Email:</strong>service@togather.com<br />
              </p>
            </div>

            <div class="col-lg-2 col-md-6 footer-links">
              <h4>Useful Links</h4>
              <ul>
                <li>
                  <i class="bx bx-chevron-right"></i> <a href="../">Home</a>
                </li>
                <li>
                  <i class="bx bx-chevron-right"></i>
                  <a href="../about">About us</a>
                </li>
                <li>
                  <i class="bx bx-chevron-right"></i> <a href="#">Services</a>
                </li>
                <li>
                  <i class="bx bx-chevron-right"></i>
                  <a href="#">Terms of service</a>
                </li>
                <li>
                  <i class="bx bx-chevron-right"></i>
                  <a href="#">Privacy policy</a>
                </li>
              </ul>
            </div>

            <div class="col-lg-3 col-md-6 footer-links">
              <h4>Our Services</h4>
              <ul>
                <li>
                  <i class="bx bx-chevron-right"></i>
                  <a href="../notification/notice">공지사항</a>
                </li>
                <li>
                  <i class="bx bx-chevron-right"></i>
                  <a href="../faq/faqList">자주 묻는 질문</a>
                </li>
                <li>
                  <i class="bx bx-chevron-right"></i>
                  <a href="../qa">Q & A</a>
                </li>
                <li>
                  <i class="bx bx-chevron-right"></i>
                  <a href="../contact">Contact</a>
                </li>
              </ul>
            </div>

            <div class="col-lg-4 col-md-6 footer-newsletter">
              <h4>뉴스레터 구독하기</h4>
              <p>
                최신뉴스 및 프로모션 행사에 대한 안내메일을 받으실 수 있습니다.
              </p>
              <form action="" method="post">
                <input type="email" name="email" /><input
                  type="submit"
                  value="Subscribe"
                />
              </form>
            </div>
          </div>
        </div>
      </div>

      <div class="container d-md-flex py-4">
        <div class="me-md-auto text-center text-md-start">
          <div class="copyright">
            &copy; Copyright<strong><span>Togather</span></strong
            >. All Rights Reserved
          </div>
        </div>
        <div class="social-links text-center text-md-right pt-3 pt-md-0">
          <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
          <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
          <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
          <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
          <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
        </div>
      </div>
    </footer>
    <!-- End Footer -->

    <div id="preloader"></div>
    <a
      href="#"
      class="back-to-top d-flex align-items-center justify-content-center"
      ><i class="bi bi-arrow-up-short"></i
    ></a>

    <!-- Vendor JS Files -->
    <script src="/assets/vendor/purecounter/purecounter.js"></script>
    <script src="/assets/vendor/aos/aos.js"></script>
    <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="/assets/vendor/php-email-form/validate.js"></script>

    <!-- Template Main JS File -->
    <script src="/assets/js/main.js"></script>
  </body>
</html>
