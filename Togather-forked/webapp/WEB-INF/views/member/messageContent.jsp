<%@ page contentType="text/html; charset=utf-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
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
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <title>
      Setup - Corporate Category Bootstrap Responsive Web Template - Blog Single
      : W3Layouts
    </title>
    <!-- google-fonts -->
    <link
      href="http://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&amp;display=swap"
      rel="stylesheet"
    />
    <!-- //google-fonts -->
    <!-- Font-Awesome-Icons-CSS -->
    <link rel="stylesheet" href="/assets/css/fontawesome-all.min.css" />
    <!-- Template CSS Style link -->
    <link rel="stylesheet" href="/assets/css/style-liberty.css" />
    <!-- alert  -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <!-- alert -->
    <script
      type="text/javascript"
      language="javascript"
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"
    ></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script>
         Kakao.init('11400a9267d93835389eb9255fcaad0b');
         function signout(){
           if(Kakao.Auth.getAccessToken() != null){
       	  Kakao.Auth.logout(function(){
       	    setTimeout(function(){
                 location.href="member/logout.do";
              },500);
            });
           }else{
           	location.href="member/logout.do";
           }
         }

         function nextPost(){
      	var meseq = ${messageContent.meseq};
      	var mnum = ${m.mnum};
      	var result = {"meseq":meseq,"from_mnum":mnum};
      	$(function(){
      		$.ajax({
      				url: "nextMessageCheck.json",
      				type: "POST",
      				data: result,
      				success: function(data){
      					console.log(data);
      					var nextMeseq =data;
      					if($.isNumeric(data)){
        							location.href="messageContent?meseq="+nextMeseq+"&page=${page}&pageSize=${pageSize}";
      					}else if(jQuery.isEmptyObject(data)){
      						Swal.fire({
      							title:"마지막 메세지 입니다",
      							icon:"warning"
      							});
      					}
      				}
      			});
      		});
      }

         function previousPost(){
      	var meseq = ${messageContent.meseq};
      	var mnum = ${m.mnum};
      	var result = {"meseq":meseq,"from_mnum":mnum};
      	$(function(){
      		$.ajax({
      				url: "previousMessage.json",
      				type: "POST",
      				data: result,
      				success: function(data){
      					console.log(data);
      					var previousMeseq =data;
      					if($.isNumeric(data)){
        							location.href="messageContent?meseq="+previousMeseq+"&page=${page}&pageSize=${pageSize}";

      					}else if(jQuery.isEmptyObject(data)){
      						Swal.fire({
      							title:"이전 메세지가 없습니다",
      							icon:"warning"
      							});
      					}
      				}
      			});
      		});
      }

         function replyToMessage(sequence){
      	if(sequence==0){
      		var replyToButton="";
      		replyToButton+="<a id='replyToButton1' href='javascript:void(0)' onclick=\"location.href='javascript:replyToMessage(1)'\">답변하기</a>";
      		$('#PreviousPost').after (
      				replyToButton
      		);
      	}else if(sequence==1){
      		$('#replyToButton1').remove();
      		$('#replyToButton3').remove();
      		var replyToButton="";
      		replyToButton+="<a id='replyToButton2' href='javascript:void(0)' onclick=\"location.href='javascript:replyToMessage(2)'\">답변하기</a>";
      		$('#PreviousPost').after (
      				replyToButton
      		);

      		var replyTo="";
      		replyTo+="<div class='leave-comment-form' id='div2'>";
      		replyTo+="<h3 class='aside-title'>답변하기</h3>";
      		replyTo+="<form action='replyToMessage?to_mnum=${m.mnum}&from_mnum=${messageContent.to_mnum}&page=${page}&pageSize=${pageSize}&meseq=${messageContent.meseq}' method='post' autocomplete='off'>";
      		replyTo+="<div class='input-grids'>";
      		replyTo+="<div class='form-group'>";
      		replyTo+="<input type='text' name='to_mname' class='form-control'  value='${m.mname}' required readonly>";
      		replyTo+="</div>";
      		replyTo+="<div class='form-group'>";
      		replyTo+="<input type='text' name='from_mname' class='form-control'  value='${messageContent.to_mname}' required readonly>";
      		replyTo+="</div>";
      		replyTo+=" <div class='form-group'>";
      		replyTo+="<input type='text' name='metitle' class='form-control' placeholder='메세지 제목'   required >";
      		replyTo+="</div>";
      		replyTo+="<div class='form-group'>";
      		replyTo+="<textarea name='mecontent' class='form-control' placeholder='메세지 내용' required></textarea>";
      		replyTo+="</div>";
      		replyTo+="</div>";
      		replyTo+="<div class='text-right mt-4'>";
      		replyTo+="<button class='btn button-style'>Post Comment</button>";
      		replyTo+="</div>";
      		replyTo+="</form>";
      		replyTo+="</div>";
      		$('#div1').after(
      				replyTo
      		);
      	}else if(sequence==2){
      		$('#div2').remove();
      		$('#replyToButton2').remove();
      		var replyToButton="";
      		replyToButton+="<a id='replyToButton3' href='javascript:void(0)' onclick=\"location.href='javascript:replyToMessage(1)'\">답변하기</a>";
      		$('#PreviousPost').after (
      				replyToButton
      		);
      	}
         }
    </script>
  </head>

  <body onload="replyToMessage(0)">
    <!-- ======= Header ======= -->
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->
    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fade-in">
        <div class="container">
          <h1>메세지 내용</h1>
        </div>
      </div>
      <section class="text-11 py-5">
        <div class="text11 py-md-5 py-4">
          <div class="container">
            <div class="row">
              <div class="col-lg-9 text11-content m-auto">
                <h4>${messageContent.metitle}</h4>
                <h6>
                  <span class="fa fa-user mr-1 icon-color"></span
                  >${messageContent.to_mname}, ${messageContent.medate}
                </h6>
                <a href="#post" class="post"></a>
                <p class="mt-4 mb-3">${messageContent.mecontent}</p>
                <div id="div1" class="new-posts mt-5">
                  <a
                    id="PreviousPost"
                    class="prev-post pull-left"
                    href="javascript:previousPost()"
                    ><span class="fa fa-arrow-left" aria-hidden="true"></span>
                    Previous Post</a
                  >

                  <a
                    id="messageList"
                    href="messageList?mnum=${m.mnum}&page=${page}&pageSize=${pageSize}"
                    >목록</a
                  >
                  <a
                    href="messageDelete?mnum=${m.mnum}&meseq=${messageContent.meseq}&page=${page}&pageSize=${pageSize}"
                    >삭제</a
                  >
                  <a class="next-post pull-right" href="javascript:nextPost()"
                    >Next Post
                    <span class="fa fa-arrow-right" aria-hidden="true"></span
                  ></a>
                </div>
              </div>
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
