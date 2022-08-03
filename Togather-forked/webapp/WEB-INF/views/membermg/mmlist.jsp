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
        $("tr:even").css("background", "#faf7f2");
      });

      $(function () {
        $("#membermgSearch").on("keyup", function () {
          var mnum = "${mnum}";
          var table = document.getElementById("membermgTest");
          $.ajax({
            url: "mmlistRest",
            type: "GET",
            dataType: "json",
            contentType: "application/json",
            data: {
              membermgSearch: $("#membermgSearch").val(),
              option: $("#option").val(),
              mnum: mnum,
            },
            success: function (result) {
              var data = result;
              var obj_length = Object.keys(result).length;
              var trlength = $("#membermgTest tr").length;
              for (var t = trlength - 1; t > 0; t--) {
                table.deleteRow(t);
              }
              console.log("result: " + result[0].athur);
              for (var i = 0; i <= obj_length; i++) {
                if (result[i].athur == 2) {
                  result[i].athur = "일반회원";
                } else if (result[i].athur == 1) {
                  result[i].athur = "운영진";
                } else {
                  result[i].athur = "관리자";
                }
                $("#membermgTest tr:even").css("background", "#faf7f2");
                $("#membermgTest").append(
                  "<tr onClick=\"location.href='MmGbListPage?mnum=" +
                    result[i].mnum +
                    "'\">" +
                    "<td class='column1'>" +
                    result[i].mnum +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].mname +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].gender +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].birth +
                    "</td>" +
                    "<td class='column3'>" +
                    result[i].maddr +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].email +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].phone +
                    "</td>" +
                    "<td class='column1'>" +
                    result[i].athur +
                    "</td>" +
                    "<td class='column1'><a style='color:#05b1f0' href='mmupdate.do?mnum=" +
                    result[i].mnum +
                    "'>수정</a>" +
                    "<a style='color:#05b1f0'  href='mmdel.do?mnum=" +
                    result[i].mnum +
                    "'>삭제</a></td></tr>"
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
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->

    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fade-in">
        <div class="container">
          <h1>회원관리</h1>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Cource Details Section ======= -->

      <section id="course-details" class="course-details">
        <div class="container" data-aos="fade-up" style="margin-top: 10px">
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
              style="margin-left: 1200px; font-weight: bold; width: 1500px"
              class="bi bi-person-badge-fill"
            >
              ${pm.totalCount}명</i
            >
            <ul class="dropdown-menu">
              <li>
                <a class="dropdown-item" href="mmlistPage?pageSize=1">1</a>
              </li>
              <li>
                <a class="dropdown-item" href="mmlistPage?pageSize=5">5</a>
              </li>
              <li>
                <a class="dropdown-item" href="mmlistPage?pageSize=10">10</a>
              </li>
              <li>
                <a class="dropdown-item" href="mmlistPage?pageSize=15">15</a>
              </li>
            </ul>
          </div>

          <table
            id="membermgTest"
            class="type07"
            style="text-align: center; margin-left: 0px"
          >
            <thead>
              <tr>
                <th class="col-sm-1">회원번호</th>
                <th class="col-sm-1">회원이름</th>
                <th class="col-sm-1">성별</th>
                <th class="col-sm-1">생년월일</th>
                <th class="col-sm-3">거주지</th>
                <th class="col-sm-1">이메일</th>
                <th class="col-sm-1">핸드폰번호</th>
                <th class="col-sm-1">회원권한</th>
                <th class="col-sm-1">
                  <a style="margin-right: 10px">회원관리</a>
                </th>
              </tr>
            </thead>
            <tbody>
              <c:if test="${empty MembermgList}">
                <tr align="center">
                  <td colspan="5">데이터가 하나도 없음</td>
                </tr>
              </c:if>
              <c:if test="${not empty MembermgList}">
                <c:forEach var="member" items="${MembermgList }">
                  <tr
                    style="cursor: pointer"
                    onmouseover='this.style.background="#e0e0e0";'
                    onmouseleave=' $("tr:even").css("background","#faf7f2"); $("tr:odd").css("background","white");'
                    onClick="location.href='MmGbListPage?mnum=${member.mnum}'"
                  >
                    <td class="col-sm-1">${member.mnum}</td>
                    <td class="col-sm-1">${member.mname }</td>
                    <td class="col-sm-1">${member.gender }</td>
                    <td class="col-sm-1">${member.birth }</td>
                    <td class="col-sm-3">${member.maddr }</td>
                    <td class="col-sm-1">${member.email }</td>
                    <td class="col-sm-1">${member.phone }</td>
                    <c:choose>
                      <c:when test="${member.athur eq 2}">
                        <td class="col-sm-1">일반회원</td>
                      </c:when>
                      <c:when test="${member.athur eq 1}">
                        <td class="col-sm-1">운영진</td>
                      </c:when>
                      <c:otherwise>
                        <td class="col-sm-1">관리자</td>
                      </c:otherwise>
                    </c:choose>
                    <td class="col-sm-1">
                      <a
                        style="color: #05b1f0"
                        href="mmupdate.do?mnum=${member.mnum}"
                        >수정</a
                      >
                      <a
                        style="color: #05b1f0"
                        href="mmdel.do?mnum=${member.mnum}"
                        >삭제</a
                      >
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
              <option value="mname">이름</option>
              <option value="athur">회원권한</option>
              <option value="maddr">주소</option>
            </select>
            <input
              id="membermgSearch"
              name="membermgSearch"
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
                      href="mmlistPage?page=${pm.startPage-1}&pageSize=${cri.pageSize}"
                      >처음</a
                    >
                  </li>
                </c:if>
                <c:if test="${pm.prev}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="mmlistPage?page=${cri.page-1}&pageSize=${cri.pageSize}"
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
                      href="mmlistPage?page=${idx }&pageSize=${cri.pageSize}"
                      >${idx}</a
                    >
                  </li>
                </c:forEach>
                <c:if test="${pm.next && pm.endPage > 0}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="mmlistPage?page=${cri.page+1}&pageSize=${cri.pageSize}"
                      >다음</a
                    >
                  </li>
                </c:if>
                <c:if test="${pm.next && pm.endPage > 0}">
                  <li class="page-item">
                    <a
                      class="page-link"
                      href="mmlistPage?page=${pm.endPage}&pageSize=${cri.pageSize}"
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
