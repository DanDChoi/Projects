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

    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="/table/images/icons/favicon.ico" />
    <!--===============================================================================================-->
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/vendor/bootstrap/css/bootstrap.min.css"
    />
    <!--===============================================================================================-->
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/fonts/font-awesome-4.7.0/css/font-awesome.min.css"
    />
    <!--===============================================================================================-->
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/vendor/animate/animate.css"
    />
    <!--===============================================================================================-->
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/vendor/select2/select2.min.css"
    />
    <!--===============================================================================================-->
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/vendor/perfect-scrollbar/perfect-scrollbar.css"
    />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/table/css/util.css" />
    <link rel="stylesheet" type="text/css" href="/table/css/main.css" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript">
      $(function () {
        $("#boardSearch").on("keyup", function () {
          var page = "${cri.page}";
          var pageSize = "${cri.pageSize}";
          var table = document.getElementById("boardTest");
          var data = {
            boardSearch: $("#boardSearch").val(),
            option: $("#option").val(),
            page: page,
            pageSize: pageSize,
          };
          console.log("page1: " + page + " pageSize: " + pageSize);
          $.ajax({
            url: "/board/listRest",
            type: "GET",
            dataType: "json",
            contentType: "application/json",
            data: data,
            success: function (result) {
              console.log("##result: " + result);
              var trlength = $("#boardTest tr").length;
              for (var t = trlength - 1; t > 0; t--) {
                table.deleteRow(t);
              }
              $(result).each(function () {
                $("#boardTest").append(
                  "<tr onClick=\"location.href='boardContent?bnum=" +
                    this.bnum +
                    "&page=${cri.page}&pageSize=${cri.pageSize}'\">" +
                    "<td class='column1'>" +
                    this.bnum +
                    "</td>" +
                    "<td class='column2'>" +
                    this.bcategory +
                    "</td>" +
                    "<td class='column3'>" +
                    this.btitle +
                    "</td>" +
                    "<td class='column4'>" +
                    this.mname +
                    "</td>" +
                    "<td class='column5'>" +
                    this.bview +
                    "</td>" +
                    "<td class='column6'>" +
                    this.rdate +
                    "</td></tr>"
                );
              });
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
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->

    <main id="main" data-aos="fade-in">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs">
        <div class="container">
          <h2>자유게시판</h2>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Trainers Section ======= -->
      <section id="trainers" class="trainers" style="padding-top: 0">
        <div class="table">
          <div class="container-table100" >
            <div class="wrap-table100" style="width: 1200px">
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
                <ul class="dropdown-menu">
                  <li>
                    <a class="dropdown-item" href="listPage?pageSize=1">1</a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="listPage?pageSize=5">5</a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="listPage?pageSize=10">10</a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="listPage?pageSize=15">15</a>
                  </li>
                </ul>

                <!--운영자만 가능한 글쓰기 버튼-->
                <c:if test="${m ne null}">
                  <a
                    type="submit"
                    class="btn btn-dark btn-sm mb-1"
                    style="float: right"
                    href="boardInput"
                  >
                    글쓰기
                  </a>
                </c:if>
              </div>
              <div class="table100">
                <table id="boardTest">
                  <thead>
                    <tr class="table100-head">
                      <th class="col-sm-1">글번호</th>
                      <th class="col-sm-2">관심사</th>
                      <th class="col-sm-5">제목</th>
                      <th class="col-sm-1">작성자</th>
                      <th class="col-sm-1">조회수</th>
                      <th class="col-sm-4">등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:if test="${empty boardList}">
                      <tr align="center" noshade>
                        <td colspan="6">데이터가 하나도 없음</td>
                      </tr>
                    </c:if>
                    <c:if test="${not empty boardList}">
                      <c:forEach var="board" items="${boardList }">
                        <tr
                          onClick="location.href='boardContent?bnum=${board.bnum}&page=${cri.page}&pageSize=${cri.pageSize}'"
                        >
                          <td class="col-sm-1">${board.bnum}</td>
                          <td class="col-sm-2">${board.bcategory }</td>
                          <td class="col-sm-5">${board.btitle }</td>
                          <td class="col-sm-1">${board.mname }</td>
                          <td class="col-sm-1">${board.bview }</td>
                          <td class="col-sm-4">
                            <fmt:formatDate
                              value="${board.rdate }"
                              pattern="yyyy-MM-dd (E) HH:mm"
                            />
                          </td>
                        </tr>
                      </c:forEach>
                    </c:if>
                  </tbody>
                </table>
              </div>
              <div
                class="input-group input-group-sm mb-3"
                style="width: 300px; height: auto"
              >
                <form name="searchbar" method="post" action="boardWithSearch">
                  <select
                    class="btn btn-outline-dark"
                    data-bs-toggle="dropdown"
                    aria-expanded="false"
                    name="option"
                    id="option"
                    style="margin-bottom: 5px"
                  >
                    <option value="btitle">제목</option>
                    <option value="bcategory">관심사</option>
                    <option value="mname">작성자</option>
                  </select>
                  <input
                    id="boardSearch"
                    name="boardSearch"
                    type="text"
                    aria-label="Text input with dropdown button"
                    style="width:160px; height: 40px; border: solid 1px; border-radius: 5px"
                  />
                </form>
              </div>
              <!--  class="form-control"이거 input안에 있었음 -->
              <!--Page navigation-->
              <div>
                <nav aria-label="Page navigation example">
                  <ul
                    id="paging"
                    class="pagination"
                    style="justify-content: center"
                  >
                    <c:if test="${pm.prev}">
                      <li class="page-item">
                        <a
                          class="page-link"
                          href="listPage?page=${pm.startPage-1}&pageSize=${cri.pageSize}"
                          >처음</a
                        >
                      </li>
                    </c:if>
                    <c:if test="${pm.prev}">
                      <li class="page-item">
                        <a
                          class="page-link"
                          href="listPage?page=${cri.page-1}&pageSize=${cri.pageSize}"
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
                          href="listPage?page=${idx }&pageSize=${cri.pageSize}"
                          >${idx}</a
                        >
                      </li>
                    </c:forEach>
                    <c:if test="${pm.next && pm.endPage > 0}">
                      <li class="page-item">
                        <a
                          class="page-link"
                          href="listPage?page=${cri.page+1}&pageSize=${cri.pageSize}"
                          >다음</a
                        >
                      </li>
                    </c:if>
                    <c:if test="${pm.next && pm.endPage > 0}">
                      <li class="page-item">
                        <a
                          class="page-link"
                          href="listPage?page=${pm.endPage}&pageSize=${cri.pageSize}"
                          >끝</a
                        >
                      </li>
                    </c:if>
                  </ul>
                </nav>
              </div>
              <center><p>${cri.page} / ${pm.endPage }</p></center>
            </div>
          </div>
        </div>
      </section>
      <!-- End Trainers Section -->
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
