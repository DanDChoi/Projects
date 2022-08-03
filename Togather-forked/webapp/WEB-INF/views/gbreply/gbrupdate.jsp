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
<jsp:include page="../header.jsp" flush="true"/>

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
                    <p style="color:gray" class="mt-4 mb-3" >업로드 된 파일:   <a style="color:#80d4ff"  href="../gboard/gbfdownload.do?gbfname=${gboard.gbofname}&gbnum=${gboard.gbnum}">${gboard.gbofname}</a>
                    </p>



                    <div class="new-posts mt-5">
                        <c:if test = "${ m.mnum eq gboard.mnum || m.athur ne 2}" >
                            <a href="/gboard/gbupdate.do?gbnum=${gboard.gbnum}">수정</a>
                            <a href="/gboard/gblistPage?gseq=${gboard.gseq}">목록</a>
                            <a href="/gboard/gbdel.do?gbnum=${gboard.gbnum}&gbfname=${gboard.gbofname}&gseq=${gboard.gseq}">삭제</a>

                        </c:if>
                    </div>
                    <div id="outerreplyform" class="comments mt-5">
                        <h3 id="commentsNum" class="aside-title ">Posted Comment</h3>
                        <div class="comments-grids">
                            <div id="middleform" class="media-grid">
                                <div class="media">
                                    <div class="me"style="width: 100px; height: 100px; transform: scaleX(-1); left: 50%; right: 50%; margin-left: -40px;">
                                        <h1><i class="bi bi-chat-dots"></i></h1>
                                    </div>
                            <div class="media-body comments-grid-right" style="width:700px">
                                        <h5>${mname }</h5>
                                        <ul class="p-0 comment">
                                            <li class=""><fmt:formatDate value="${rdate}" pattern="yyyy-MM-dd" /></li>
                                        </ul>
                                        <p style="word-break:break-word">${gbrcontent}</p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>



                    <div class="Update-comment-form" id="comment">
                        <h3 class="aside-title">Update a Comment</h3>
                        <form action="gbrupdate.do?gbrseq=${gbrseq}&gbnum=${gbnum}" method="post">
                            <div class="input-grids">
                                <div class="form-group">
                                    <input type="hidden" name="gbrseq" value="${gbrseq}" class="form-control"
                                           required="">
                                </div>
                                <div class="form-group">
                                    <textarea name="gbrcontent" value="${gbrcontent}" class="form-control" placeholder="${gbrcontent}"
                                              required=""></textarea>
                                </div>
                            </div>

                            <div class="text-right mt-4">
                                <button class="btn button-style">Update Comment</a>
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
<jsp:include page="../footer.jsp" flush="true"/>
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