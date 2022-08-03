<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
  <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet" />
  <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet" />
  <link href="/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet" />

  <!-- Template Main CSS File -->
  <link href="/assets/css/style.css" rel="stylesheet" />
  <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
  <script>
    Kakao.init('11400a9267d93835389eb9255fcaad0b');
    function signout(){
      if(Kakao.Auth.getAccessToken() != null){
        Kakao.Auth.logout(function(){
          setTimeout(function(){
            location.href="../member/logout.do";
          },500);
        });
      }else{
        location.href="../member/logout.do";
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
          <li><a class="manage" href="../membermg/mmlistPage">회원관리</a></li>
        </c:if>
        <li><a class="active" href="../">Home</a></li>
        <li><a href="../about">About</a></li>
        <li><a href="../board/listPage">게시판</a></li>
        <c:if test="${m ne null}">
          <li><a href="../groupTab/myGroup.do?mnum=${m.mnum }">나의 모임</a></li><!--로그인시에만 보이게 하기-->
          <li><a href="../wishTab/wishList?mnum=${m.mnum }">찜목록
            <span id="numberOfWish" class="badge bg-dark text-white ms-1 rounded-pill">${wishsize }</span>
          </a></li>
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
            <li><a href="javascript:void(0);" onclick="signout();">로그아웃</a></li>
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
        <a href="../groupTab/groupCreate.do" class="get-started-btn">모임만들기</a>
      </c:otherwise>
    </c:choose>


  </div>
</header>
<!-- End Header -->
<main id="main">
  <!-- ======= Breadcrumbs ======= -->
  <div class="breadcrumbs" data-aos="fade-in">
    <div class="container">
      <h1>FAQ 글쓰기</h1>
    </div>
  </div>

  <section
          class="h-100"
          style="background-color: #eee; box-sizing: content-box"
  >
    <div class="container h-100" data-aos="flip-down">
      <div
              class="row d-flex justify-content-center align-items-center h-100"
      >
        <div class="col-lg-12 col-xl-11">
          <div class="card text-black" style="border-radius: 25px">
            <div class="card-body p-md-5">
              <div class="row justify-content-center">
                <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
                  <!--모임지역/이름/모임소개/관심사/정원/모임사진-->
                  <form class="mx-1 mx-md-4" method="post" action="faqInput.do?mnum=${m.mnum}">
                    <div class="d-flex flex-row align-items-center mb-0">
                      <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-2">
                        <label class="form-label mb-0" for="form3Example1c"
                        >자주하는 질문</label
                        >
                        <input
                                type="text"
                                placeholder="제목"
                                id="form3Example1c"
                                class="form-control"
                                name="ftitle"
                        />
                      </div>
                    </div>

                    <div class="d-flex flex-row align-items-center mb-0">
                      <i class="fas fa-user fa-lg me-3 fa-fw"></i>
                      <div class="form-outline flex-fill mb-2">
                        <label class="form-label mb-0" for="form3Example4c"
                        >답변</label
                        >
                        <textarea
                                name="fcontent"
                                placeholder="답변"
                                maxlength="550"
                                cols="53"
                                id="form3Example4c"
                                class="form-control"
                        ></textarea>
                      </div>
                    </div>

                    <div
                            class="d-flex justify-content-center mx-4 mb-3 mb-lg-4"
                    >
                      <button
                              type="submit"
                              class="btn btn-success"
                              style="margin-right: 30px"
                      >
                        완료
                      </button>
                      <button type="button" class="btn btn-secondary">
                        취소
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
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
            서울시 금천구 <br />
            가산 디지털 2로 123<br />
            월드메르디앙 2차 <br /><br />
            <strong>Phone:</strong> +82 2 1234 1234<br />
            <strong>Email:</strong> service@togather.com<br />
          </p>
        </div>

        <div class="col-lg-2 col-md-6 footer-links">
          <h4>Useful Links</h4>
          <ul>
            <li>
              <i class="bx bx-chevron-right"></i>
              <a href="../../">Home</a>
            </li>
            <li>
              <i class="bx bx-chevron-right"></i>
              <a href="./about">About us</a>
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
        &copy; Copyright <strong><span>Togather</span></strong
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
