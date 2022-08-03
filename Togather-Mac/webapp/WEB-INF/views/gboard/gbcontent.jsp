<%@ page language="java" contentType="text/html; charset=utf-8" import="java.util.*, team1.togather.domain.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <script type="text/javascript" language="javascript"
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <link
            href="/assets/vendor/bootstrap-icons/bootstrap-icons.css"
            rel="stylesheet"
    />
    <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet" />
    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet" />
    <link href="/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet" />

    <!-- Template Main CSS File -->

    <link href="/assets/css/style.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Setup - Corporate Category Bootstrap Responsive Web Template - Blog Single : W3Layouts</title>
    <!-- google-fonts -->
    <link href="http://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&amp;display=swap" rel="stylesheet">
    <!-- //google-fonts -->
    <!-- Font-Awesome-Icons-CSS -->
    <link rel="stylesheet" href="/assets/css/fontawesome-all.min.css">
    <!-- Template CSS Style link -->
    <link rel="stylesheet" href="/assets/css/style-liberty.css">
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

<section class="text-11 py-5">
    <div class="text11 py-md-5 py-4">
        <div class="container">
            <div class="row">
                <div class="col-lg-9 text11-content m-auto">

                    <h4>${gboard.gbtitle}</h4>
                    <h6><span class="fa fa-user mr-1 icon-color"></span>${gboard.mname}, <fmt:formatDate value="${gboard.rdate}" pattern="yyyy-MM-dd (E) HH:mm" />.</h6>
                    View: ${gboard.gbview}
                    <p class="mt-4 mb-3">${gboard.gbcontent}
                    </p>
                    <p style="color:gray" class="mt-4 mb-3" >업로드 된 파일:   <a style="color:gray"  href="gbfdownload.do?gbfname=${gboard.gbofname}&gbnum=${gboard.gbnum}">${gboard.gbofname}</a>
                    </p>




                    <div class="new-posts mt-5">

                        <c:if test = "${ m.mnum eq gboard.mnum || m.athur ne 2}" >

                            <a href="gbupdate.do?gbnum=${gboard.gbnum}">수정</a>
                            <a href="gblistPage?gseq=${gboard.gseq}">목록</a>
                            <a href="gbdel.do?gbnum=${gboard.gbnum}&gbfname=${gboard.gbofname}&gseq=${gboard.gseq}">삭제</a>

                        </c:if>
                    </div>
                    <div id="outerreplyform" class="comments mt-5">
                        <h3 id="commentsNum" class="aside-title ">Recent comments</h3>
                        <c:forEach items="${gbrlist}" var="gbreply">
                            <div class="comments-grids">
                                <div id="middleform" class="media-grid">
                                    <div class="media">
                                        <div class="me"style="width: 100px; height: 100px; transform: scaleX(-1); left: 50%; right: 50%; margin-left: -40px;">
                                            <h1><i class="bi bi-chat-dots"></i></h1>
                                        </div>
                                            <div class="media-body comments-grid-right" style="width:700px">
                                            <h5>${gbreply.mname }</h5>
                                            <ul class="p-0 comment">
                                                <li class=""><fmt:formatDate value="${gbreply.rdate}" pattern="yyyy-MM-dd (E) HH:mm" /></li>
                                            </ul>
                                            <p style="word-break:break-word">${gbreply.gbrcontent}</p>
                                            <c:if test = "${ m.mnum eq gbreply.mnum || m.athur ne 2}" >
                                                <div align="right">
                                                    <a style="color:blue; margin-right:15px" href='../gbreply/gbrupdate.do?gbnum=${gboard.gbnum}&gbrseq=${gbreply.gbrseq}&gbrcontent=${gbreply.gbrcontent}
                                                       &mname=${gbreply.mname}&rdate=${gbreply.rdate}'>수정</a>
                                                    <a style="color:blue" href='../gbreply/gbrdel.do?gbnum=${gboard.gbnum}&gbrseq=${gbreply.gbrseq}'>삭제</a>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </c:forEach>
                    </div>
                    <div class="leave-comment-form" id="comment">
                        <h3 class="aside-title">Leave a reply</h3>
                        <form action="gbrwrite.do?gbnum=${gboard.gbnum}" method="post">
                            <div class="input-grids">
                                <div class="form-group">
                                    <input type="hidden" name="mname" value="${m.mname}" class="form-control" placeholder="Your Name"
                                           required="">
                                </div>
                                <div class="form-group">
                                    <input type="hidden" name="mnum" value="${m.mnum}" class="form-control" placeholder="Email"
                                           required="">
                                </div>
                                <div class="form-group">
                                    <textarea name="gbrcontent" class="form-control" placeholder="Your Comment"
                                              required=""></textarea>
                                </div>
                            </div>
                            <div class="text-right mt-4">
                                <button class="btn button-style">Post Comment</a>
                            </div>
                        </form>
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
                        서울시 금천구<br/>
                        가산 디지털 2로 123<br/>
                        월드메르디앙 2차<br/><br/>
                        <strong>Phone:</strong>+82 2 1234 1234<br/>
                        <strong>Email:</strong>service@togather.com<br/>
                    </p>
                </div>

                <div class="col-lg-2 col-md-6 footer-links">
                    <h4>Useful Links</h4>
                    <ul>
                        <li>
                            <i class="bx bx-chevron-right"></i> <a href="../">Home</a>
                        </li>
                        <li>
                            <i class="bx bx-chevron-right"></i> <a href="../about">About us</a>
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

                <div  class="col-lg-3 col-md-6 footer-links">
                    <h4>Our Services</h4>
                    <ul>
                        <li>
                            <i class="bx bx-chevron-right"></i> <a href="../notification/notice">공지사항</a>
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
                            <i class="bx bx-chevron-right"></i> <a href="../contact">Contact</a>
                        </li>
                    </ul>
                </div>

                <div class="col-lg-4 col-md-6 footer-newsletter">
                    <h4>뉴스레터 구독하기</h4>
                    <p>
                        최신뉴스 및 프로모션 행사에 대한 안내메일을 받으실 수 있습니다.
                    </p>
                    <form action="" method="post">
                        <input type="email" name="email"/><input
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
</body>
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
</html>