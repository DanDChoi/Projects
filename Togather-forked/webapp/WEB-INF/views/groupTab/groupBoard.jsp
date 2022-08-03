<%@ page contentType="text/html;charset=utf-8" session="false" %> <%@ taglib
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
    <link href="assets/img/favicon.png" rel="icon" />
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon" />

    <!-- Google Fonts -->
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
      rel="stylesheet"
    />

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet" />
    <link href="assets/vendor/aos/aos.css" rel="stylesheet" />
    <link
      href="assets/vendor/bootstrap/css/bootstrap.min.css"
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
      href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet" />
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet" />
    <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet" />

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet" />
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
          <h1>모임 이름</h1>
          <p>모임 소개? or 지역?</p>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Cource Details Section ======= -->

      <section id="course-details" class="course-details">
        <div class="container" data-aos="fade-up">
          <ul class="nav nav-tabs mb-3">
            <li class="nav-item">
              <a class="nav-link" href="groupInfo.do?gseq=${groupInfo.gseq}"
                >정보</a
              >
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">사진첩</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="#">게시판</a>
            </li>
          </ul>
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
              <li><a class="dropdown-item" href="board.do?ps=5">5</a></li>
              <li><a class="dropdown-item" href="board.do?ps=10">10</a></li>
              <li><a class="dropdown-item" href="board.do?ps=15">15</a></li>
            </ul>

            <c:if test="${not empty userphone}">
              <a
                type="submit"
                class="btn btn-dark btn-sm mb-1"
                style="float: right"
                href="board.do?m=input"
              >
                글쓰기
              </a>
            </c:if>
          </div>
          <table class="table table-hover" style="text-align: center">
            <thead>
              <tr>
                <th class="col-sm-2">글번호</th>
                <th class="col-sm-6">제목</th>
                <th scope="col-sm-2">작성자</th>
                <th scope="col-sm-2">조회수</th>
                <th scope="col-sm-2">작성일</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="boardList" var="groupBoard">
                <tr>
                  <th scope="row">${groupBoard.gbnum}</th>
                  <td>
                    <a href="/groupBoard/read?gbnum=${groupboard.gbnum}"
                      >${groupBoard.gbtitle}</a
                    >
                  </td>
                  <td>${groupBoard.mname}</td>
                  <td>
                    <span class="badge bg-red">${groupBoard.gbview}></span>
                  </td>
                  <td>
                    <fmt:formatDate
                      value="${groupBoard.rdate}"
                      pattern="yyyy-MM-dd (E) HH:mm"
                    />
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <div>
            <nav aria-label="Page navigation example">
              <ul
                id="paging"
                class="pagination"
                style="justify-content: center"
              >
                <li class="page-item">
                  <a class="page-link" href="#">Previous</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#">1</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#">2</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#">3</a>
                </li>
                <li class="page-item">
                  <a class="page-link" href="#">Next</a>
                </li>
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
    <script src="assets/vendor/purecounter/purecounter.js"></script>
    <script src="assets/vendor/aos/aos.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>

    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>
  </body>
</html>
