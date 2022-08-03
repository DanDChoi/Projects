<%@ page contentType="text/html;charset=utf-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <script language="javascript">
      function check() {
        for (var i = 0; i < document.input.elements.length; i++) {
          if (
            document.input.ga_name.value == "" ||
            document.input.ga_place.value == "" ||
            document.input.time.value == "" ||
            document.input.price.value == "" ||
            document.input.ga_limit.value == ""
          ) {
            alert("필수입력란이 비었습니다.Test");
            return false;
          }
        }
        document.input.submit();
      }
    </script>
  </head>

  <body>
    <!-- ======= Header ======= -->
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->
    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fa기e-in">
        <div class="container">
          <h1>정모 수정하기</h1>
        </div>
      </div>

      <section class="d-flex justify-content-center align-items-center">
        <div class="container py-5 h-100" data-aos="zoom-in">
          <div
            class="row d-flex justify-content-center align-items-center h-75"
            style="text-align: center"
          >
            <!--정모이름, 정모날짜, 정모장소, 정모시간, 회비, 정원-->
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
              <form name="input" action="gatheringUpdate.do" method="post">
                <input
                  type="hidden"
                  id="ga_seq"
                  name="ga_seq"
                  value="${updateList.ga_seq}"
                />
                <input type="hidden" id="mnum" name="mnum" value="${m.mnum }" />
                <div class="form-outline mb-4">
                  <input
                    type="text"
                    name="ga_name"
                    class="form-control form-control-lg"
                    value="${updateList.ga_name}"
                    required
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    type="text"
                    name="ga_place"
                    class="form-control form-control-lg"
                    value="${updateList.ga_place}"
                    required
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    type="time"
                    name="time"
                    class="form-control form-control-lg"
                    value="${updateList.time}"
                    required
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    type="text"
                    name="ga_date"
                    class="form-control form-control-lg"
                    value="${updateList.ga_date}"
                    disabled
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    type="text"
                    name="price"
                    class="form-control form-control-lg"
                    value="${updateList.price}"
                    required
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    type="number"
                    name="ga_limit"
                    class="form-control form-control-lg"
                    min="2"
                    max="20"
                    value="${updateList.ga_limit}"
                    required
                  />
                </div>

                <button
                  class="btn btn-success"
                  onclick="location.href='javascript:check()'"
                >
                  수정하기
                </button>
                <button
                  class="btn btn-secondary"
                  onclick="location.href='gatheringInfo.do?ga_seq=${updateList.ga_seq}'"
                >
                  취소
                </button>
              </form>
            </div>
          </div>
        </div>
      </section>
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
