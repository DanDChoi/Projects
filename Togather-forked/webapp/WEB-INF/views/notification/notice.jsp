<%@ page contentType="text/html;charset=utf-8" session="true" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib prefix="fmt"
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

      <script src="http://code.jquery.com/jquery-latest.js">
    </script>
    <script type="text/javascript">
      $(document).keypress(function (e) {
        if (e.keyCode == 13) e.preventDefault();
      });
      function enterCheck(elm) {
        $(function () {
          //$("#noticeSearch").on("keyup",function(){

          var page = "${cri.page}";
          var pageSize = "${cri.pageSize}";
          var table = document.getElementById("noticeTable");
          $.ajax({
            url: "/notification/listRest",
            type: "GET",
            dataType: "json",
            contentType: "application/json",
            data: {
              notificationSearch: $("#noticeSearch").val(),
              option: $("#option").val(),
              page: page,
              pageSize: pageSize,
            },
            success: function (result) {
              console.log("##result: " + result);
              var trlength = $("#noticeTable tr").length;
              for (var t = trlength - 1; t > 0; t--) {
                table.deleteRow(t);
              }
              $(result).each(function () {
                $("#noticeTable").append(
                  "<tr onClick=\"location.href='notificationContent?mnum=" +
                    this.mnum +
                    "&page=${cri.page}&pageSize=${cri.pageSize}'\">" +
                    "<td class='column1'>" +
                    this.nseq +
                    "</td>" +
                    "<td class='column2'>" +
                    this.ntitle +
                    "</td>" +
                    "<td class='column3'>" +
                    this.mname +
                    "</td>" +
                    "<td class='column4'>" +
                    this.rdate +
                    "</td>" +
                    "<td class='column5'>" +
                    this.nview +
                    "</td></tr>"
                );
              });
            },
            error: function (error) {
              console.log("##error: " + error);
            },
          });
        });
      }
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
          <h2>공지사항</h2>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Trainers Section ======= -->
      <section id="trainers" class="trainers" style="padding-top: 0">
        <div class="table">
          <div class="container-table100">
            <div class="wrap-table100">
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
                    <a class="dropdown-item" href="notice?pageSize=1">1</a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="notice?pageSize=5">5</a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="notice?pageSize=10">10</a>
                  </li>
                </ul>
                <c:if test="${ m.athur eq 0 || m.athur eq 1}">
                  <a
                    type="submit"
                    class="btn btn-dark btn-sm mb-1"
                    style="float: right"
                    href="noticeInput"
                  >
                    글쓰기
                  </a>
                </c:if>
              </div>
              <div class="table100">
                <table id="noticeTable">
                  <thead>
                    <tr class="table100-head">
                      <th class="column1">글번호</th>
                      <th class="column3">제목</th>
                      <th class="column4">작성자</th>
                      <th class="column5" align="center">작성일</th>
                      <th class="column6">조회수</th>
                    </tr>
                  </thead>

                  <tbody>
                    <c:forEach items="${notificationList}" var="noticelist">
                      <tr
                        onClick="location.href='noticeContent?nseq=${noticelist.nseq}'"
                      >
                        <td class="column1">${noticelist.nseq}</td>
                        <td class="column3">${noticelist.ntitle}</td>
                        <td class="column4">${noticelist.mname}</td>
                        <td>
                          <fmt:formatDate
                            value="${noticelist.rdate }"
                            pattern="yyyy-MM-dd (E) HH:mm"
                          />
                        </td>
                        <td class="column6">${noticelist.nview}</td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
              <div
                class="input-group input-group-sm mb-3"
                style="width: 400px; height: auto"
              >
                <form
                  name="searchbar"
                  method="post"
                  action="notificationWithSearch"
                >
                  <select
                    class="btn btn-outline-dark"
                    data-bs-toggle="dropdown"
                    aria-expanded="false"
                    name="option"
                    id="option"
                    style="margin-bottom: 5px"
                  >
                    <option value="noption">선택</option>
                    <option value="ntitle">제목</option>
                    <option value="mname">작성자</option>
                  </select>
                  <input
                    id="noticeSearch"
                    name="notificationSearch"
                    type="text"
                    onkeyup="enterCheck(this)"
                    aria-label="Text input with dropdown button"
                    style="width:160px; height: 40px; border: solid 1px; border-radius: 5px"
                  />
                </form>
              </div>
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
                          href="notice?page=${pm.startPage-1}&pageSize=${cri.pageSize}"
                          >처음</a
                        >
                      </li>
                    </c:if>
                    <c:if test="${pm.prev}">
                      <li class="page-item">
                        <a
                          class="page-link"
                          href="notice?page=${cri.page-1}&pageSize=${cri.pageSize}"
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
                          href="notice?page=${idx }&pageSize=${cri.pageSize}"
                          >${idx}</a
                        >
                      </li>
                    </c:forEach>
                    <c:if test="${pm.next && pm.endPage > 0}">
                      <li class="page-item">
                        <a
                          class="page-link"
                          href="notice?page=${cri.page+1}&pageSize=${cri.pageSize}"
                          >다음</a
                        >
                      </li>
                    </c:if>
                    <c:if test="${pm.next && pm.endPage > 0}">
                      <li class="page-item">
                        <a
                          class="page-link"
                          href="notice?page=${pm.endPage}&pageSize=${cri.pageSize}"
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
