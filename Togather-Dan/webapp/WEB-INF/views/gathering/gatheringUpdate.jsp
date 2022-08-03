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
    <header id="header" class="fixed-top">
      <div class="container d-flex align-items-center">
        <h1 class="logo me-auto"><a href="../">Togather</a></h1>
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
