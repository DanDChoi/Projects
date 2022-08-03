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

    <link rel="icon" type="image/png" href="/assets/img/favicon.png" />
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/vendor/bootstrap/css/bootstrap.min.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/fonts/font-awesome-4.7.0/css/font-awesome.min.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/vendor/animate/animate.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/vendor/select2/select2.min.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="/table/vendor/perfect-scrollbar/perfect-scrollbar.css"
    />
    <link rel="stylesheet" type="text/css" href="/table/css/util.css" />
    <link rel="stylesheet" type="text/css" href="/table/css/main.css" />
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript">
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
          <h2>자주 묻는 질문</h2>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Trainers Section ======= -->
      <section id="trainers" class="h-100" style="padding-top: 0">
        <div class="table">
          <div class="container-table100">
            <div class="wrap-table100">
              <!-- 상단 알림바 -->
              <div
                class="alert alert-secondary text-center"
                role="alert"
                style="background-color: lightgray"
              >
                1:1 문의는
                <a href="../qa" class="Q&A">Q&A</a>를 이용해 주세요.
              </div>

              <div class="button_group" style="padding-top: 0">
                <!--운영자만 가능한 글쓰기 버튼 만들기-->
                <c:if test="${m.athur eq 0 || m.athur eq 1}">
                  <a
                    type="submit"
                    class="btn btn-dark btn-sm mb-1"
                    style="float: right"
                    href="faqInput"
                  >
                    글쓰기
                  </a>
                </c:if>
              </div>
              <div class="table100" style="padding-top: 50px" id="faqList">
                <div
                  class="accordion accordion-flush border"
                  id="accordionFlushExample"
                >
                  <c:forEach var="faqList" items="${list}" varStatus="index">
                    <h2
                      class="accordion-header border"
                      id="flush-heading${faqList.fseq}"
                    >
                      <button
                        class="accordion-button collapsed"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#flush-collapse${faqList.fseq}"
                        aria-expanded="false"
                        aria-controls="flush-collapse${faqList.fseq}"
                      >
                        ${faqList.fseq}. ${faqList.ftitle}
                      </button>
                    </h2>
                    <div
                      id="flush-collapse${faqList.fseq}"
                      class="accordion-collapse collapse"
                      aria-labelledby="flush-heading${faqList.fseq}"
                      data-bs-parent="#accordionFlushExample"
                    >
                      <div
                        class="accordion-body border"
                        style="background-color: lightblue"
                      >
                        ${faqList.fcontent}<br />
                        <c:if test="${m.athur eq 0}">
                          <a href="faqUpdate?fseq=${faqList.fseq}"> 수정 </a>
                          <a href="faqDelete?fseq=${faqList.fseq}"> 삭제 </a>
                        </c:if>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </div>
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
