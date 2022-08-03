<%@ page language="java" contentType="text/html; charset=utf-8"
import="java.sql.Date, java.util.*, team1.togather.domain.* "%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
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
    <script type="text/javascript">
      $(function () {
        $("#gboardSearch").on("keyup", function () {
          var gseq = "${gseq}";
          var table = document.getElementById("gboardTest");
          $.ajax({
            url: "gblistRest",
            type: "GET",
            dataType: "json",
            contentType: "application/json",
            data: {
              gboardSearch: $("#gboardSearch").val(),
              option: $("#option").val(),
              gseq: gseq,
            },
            success: function (result) {
              var data = result;

              var obj_length = Object.keys(result).length;
              var trlength = $("#gboardTest tr").length;
              for (var t = trlength - 1; t > 0; t--) {
                table.deleteRow(t);
              }

              for (var i = 0; i < obj_length; i++) {
                $("#gboardTest").append(
                  "<tr onClick=\"location.href='gbcontent.do?gbnum=" +
                    result[i].gbnum +
                    "&gseq=" +
                    result[i].gseq +
                    "'\">" +
                    "<td class='col-sm-1'>" +
                    result[i].gbnum +
                    "</td>" +
                    "<td class='col-sm-1'>" +
                    result[i].mname +
                    "</td>" +
                    "<td class='col-sm-6'>" +
                    result[i].gbtitle +
                    "</td>" +
                    "<td class='col-sm-1'>" +
                    result[i].gbview +
                    "</td>" +
                    "<td class='col-sm-4'>" +
                    result[i].rdate +
                    "</td></tr>"
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
  </head>
  <body>
    <!-- ======= Header ======= -->
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->

    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fade-in">
        <div class="container">
          <h1>모임 게시판</h1>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Cource Details Section ======= -->

      <section id="course-details" class="course-details">
        <div class="container" data-aos="fade-up">
          <ul class="nav nav-tabs mb-3">
            <li class="nav-item">
              <a
                class="nav-link"
                href="../groupTab/groupInfo.do?gseq=${cri.gseq}&mnum=${m.mnum}"
                >정보</a
              >
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="../groupTab/groupGallery.do?gseq=${cri.gseq}&mnum=${m.mnum}"
                >사진첩</a
              >
            </li>
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="#">게시판</a>
            </li>
          </ul>
          <i class="bi bi-journal-text" style="margin-left:1100px; font-weight : bold; width: 1500px">    총 게시글: ${pm.totalCount}개</i>
          <div class="button_group">
            <button
                    class="btn btn-outline-dark btn-sm dropdown-toggle mb-1 mx-md-0"
                    type="button"
                    data-bs-toggle="dropdown"
                    aria-expanded="false"
                    style="float: left"
            >
              페이지당 게시글 수
            </button>
            <c:forEach var="gboard" items="${gboardList }">
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="gblistPage?pageSize=1&gseq=${gboard.gseq}">1</a></li>
                <li><a class="dropdown-item" href="gblistPage?pageSize=5&gseq=${gboard.gseq}">5</a></li>
                <li><a class="dropdown-item" href="gblistPage?pageSize=10&gseq=${gboard.gseq}">10</a></li>
                <li><a class="dropdown-item" href="gblistPage?pageSize=15&gseq=${gboard.gseq}">15</a></li>
              </ul>
            </c:forEach>

            <a
              type="submit"
              class="btn btn-dark btn-sm mb-1"
              style="float: right"
              href="gbwrite.do?gseq=${cri.gseq}"
            >
              글쓰기
            </a>
          </div>
          <table
            id="gboardTest"
            class="table table-hover"
            style="text-align: center"
          >
            <thead>
              <tr>
                <th class="col-sm-1">글번호</th>
                <th class="col-sm-1">작성자</th>
                <th class="col-sm-6">제목</th>
                <th class="col-sm-1">조회수</th>
                <th class="col-sm-4">등록일</th>
              </tr>
            </thead>
            <tbody>
              <c:if test="${empty gboardList}">
                <tr align="center">
                  <td colspan="5">데이터가 하나도 없음</td>
                </tr>
              </c:if>
              <c:if test="${not empty gboardList}">
                <c:forEach var="gboard" items="${gboardList }">
                  <tr
                    style="cursor: pointer"
                    onmouseover='this.style.background="#8ef5b0";'
                    onmouseleave='this.style.background="white";'
                    onClick="location.href='gbcontent.do?gbnum=${gboard.gbnum}&gseq=${cri.gseq}'"
                  >
                    <td class="col-sm-1">${gboard.gbnum}</td>
                    <td class="col-sm-1">${gboard.mname }</td>
                    <td class="col-sm-6" style="cursor: pointer">
                      ${gboard.gbtitle }
                    </td>
                    <td class="col-sm-1">${gboard.gbview }</td>
                    <td class="col-sm-4">
                      <fmt:formatDate
                        value="${gboard.rdate }"
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
              <option value="gbtitle">제목</option>
              <option value="mname">작성자</option>
            </select>
            <input
              id="gboardSearch"
              name="gboardSearch"
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
                      href="gblistPage?page=${pm.startPage-1}&pageSize=${cri.pageSize}&gseq=${cri.gseq}"
                      >처음</a
                    >
                  </li>
                </c:if>
                <c:if test="${pm.prev}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="gblistPage?page=${cri.page-1}&pageSize=${cri.pageSize}&gseq=${cri.gseq}"
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
                      href="gblistPage?page=${idx }&pageSize=${cri.pageSize}&gseq=${cri.gseq}"
                      >${idx}</a
                    >
                  </li>
                </c:forEach>
                <c:if test="${pm.next && pm.endPage > 0}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="gblistPage?page=${cri.page+1}&pageSize=${cri.pageSize}&gseq=${cri.gseq}"
                      >다음</a
                    >
                  </li>
                </c:if>
                <c:if test="${pm.next && pm.endPage > 0}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="gblistPage?page=${pm.endPage}&pageSize=${cri.pageSize}&gseq=${cri.gseq}"
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
    <jsp:include page="../footer.jsp" flush="true" />
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
