<%@ page language="java" contentType="text/html; charset=utf-8" import="java.util.*, team1.togather.domain.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <!-- alert  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <!-- Font-Awesome-Icons-CSS -->
    <link rel="stylesheet" href="/assets/css/fontawesome-all.min.css">
    <!-- Template CSS Style link -->
    <link rel="stylesheet" href="/assets/css/style-liberty.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script type="text/javascript">

        function previousPost(){
            var bnum = ${bnum};
            var result = {"bnum":bnum};
            $(function(){
                $.ajax({
                    url: "boardPreviousPostCheck.json",
                    type: "POST",
                    data: result,
                    success: function(data){
                        var PreviousBnum =data;
                        if($.isNumeric(data)){
                            location.href="boardContent?bnum="+PreviousBnum+"&page=${page}&pageSize=${pageSize}";
                        }else{
                            Swal.fire({
                                title:"이전 글이 없습니다",
                                icon:"warning"
                            });
                        }
                    }
                });
            });
        }

        function nextPost(){
            var bnum = ${bnum};
            var result = {"bnum":bnum};
            $(function(){
                $.ajax({
                    url: "boardNextPostCheck.json",
                    type: "POST",
                    data: result,
                    success: function(data){
                        var nextBnum =data;
                        if($.isNumeric(data)){
                            location.href="boardContent?bnum="+nextBnum+"&page=${page}&pageSize=${pageSize}";
                        }else if(jQuery.isEmptyObject(data)){
                            Swal.fire({
                                title:"마지막 글입니다",
                                icon:"warning"
                            });
                        }
                    }
                });
            });
        }
        $(document).on("click","#postComment" ,function(){
            var outerform = document.getElementById('div#outerreplyform');
            var data = JSON.stringify({
                content:$("#content").val(),
                mnum:"${m.mnum}",
                mname:"${m.mname}",
                bnum:"${bnum}"
            });
            $.ajax({
                url:"/board/addReply",
                type:"POST",
                dataType:"json",
                contentType: "application/json",
                data: data,
                success: function(result){
                    console.log("1postcomment success");
                    var divlen = $("#outerreplyform #middleform").length;
                    if(divlen!=0){
                        for(var t=0;t<divlen;t++){
                            console.log("44middle div길이: "+divlen);
                            $("#outerreplyform #middleform").empty();
                        }
                    }
                    let mnum=${m.mnum};
                    let rseq = $('.hidden')
                    let bool=true;
                    $(result).each(function(index){
                        bool=true;
                        console.log("index: "+index);
                        if(this.content==null){
                            console.log("contentnull");
                            this.content=" ";
                        }
                        $("#outerreplyform").append(
                            "<div id=\"middleform\" class=\"media-grid\">"
                            +"<div class=\"media\">"
                            +"<div class=\"me\"style=\"width: 100px; height: 100px; transform: scaleX(-1); left: 50%; right: 50%; margin-left: -40px;\">"
                            +"<h1><i class=\"bi bi-chat-dots\"></i></h1>"
                            +"</div>"
                            +"<div id=\"innerreplyform\" class=\"media-body comments-grid-right\" style=\"width: 700px\">"
                            +"<h5>"+this.mname+"</h5>"
                            +"<ul class=\"p-0 comment\">"
                            +"<li>"+this.rdate+"</li>"
                            <c:if test='${m ne null }'>
                            +"<li><p>"+this.r_like+"</p><a onclick=\"setR_like(this)\"><i class=\"bi bi-hand-thumbs-up\" aria-hidden=\"true\"></i>좋아요</a>"
                            +"<div id='"+index+"'class=\"hiddenrseq\" style=\"display:none\">"+this.rseq+"</div></li>"
                            +"<input type='hidden' id='input"+index+"' value='"+this.mnum+"'/>"
                            </c:if>
                            <c:if test='${m eq null }'>
                            +"<li>"
                            +"<p>"+this.r_like+"</p>"
                            +"<a > 좋아요<i class=\"bi bi-hand-thumbs-up\" aria-hidden=\"true\"></i></a>"
                            +"<div class=\"hiddenrseq\" style=\"display:none\">"+this.rseq+"</div>"
                            +"</li>"
                            </c:if>
                            +"</ul>"
                            +"<p>"+this.content+"</p>"
                            +"</div></div></div>"
                        );

                        $("#content").val("");
                        var totalreply = result.length;
                        document.getElementById('commentsNum').innerHTML = "Recent Comments("+totalreply+")";
                    });
                    $(result).each(function(index){
                        let hiddenRseq = $('#'+index).text();

                        if(mnum==this.mnum && hiddenRseq == this.rseq){
                            let indexStr = String(index);
                            console.log("indexStr: " );
                            console.log("스트링합치기: "+'#'.concat(indexStr));
                            $('#'.concat(indexStr)).after(
                                "<div align=\"right\">"
                                +"<a style=\"color:blue\" href='../board/deleteReply?bnum="+this.bnum+"&rseq="+this.rseq+"'>삭제</a>"
                                +"</div>"
                            );
                        }
                    });
                },
                error: function(error){
                    console.log("##postComment error");
                }

            });
        });


    </script>
    <script>
        function setR_like(e){
            var data = JSON.stringify({
                rseq: $(e).find('div').text(),
                mnum:"${m.mnum}"
            })
            $.ajax({
                url:"/board/setR_like",
                type:"POST",
                dataType:"json",
                contentType: "application/json",
                data : data,
                success: function(result){
                    console.log("##success: "+result);
                    $(e).find('p').text(result);
                },
                error: function(error){
                    console.log("##error: "+error);
                }
            });
        }
    </script>
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
                    <h4>${board.btitle}</h4>
                    <h6><span class="fa fa-user mr-1 icon-color"></span>${board.mname}, ${board.rdate}</h6>
                    <a href="#post" class="post">${board.bcategory}</a>
                    <p class="mt-4 mb-3">${board.bcontent}</p>
                    <div class="new-posts mt-5">
                        <a class="prev-post pull-left" href="javascript:previousPost()"><span class="fa fa-arrow-left"
                                                                          aria-hidden="true"></span>
                            Previous Post</a>
                        <a href="boardUpdate?bnum=${bnum }">수정</a>
                        <a href="listPage?page=${page }&pageSize=${pageSize}">목록</a>
                        <a href="boardDelete?bnum=${bnum }">삭제</a>
                        <a class="next-post pull-right" href="javascript:nextPost()">Next Post <span class="fa fa-arrow-right"
                                                                                     aria-hidden="true"></span></a>
                    </div>
                    <div id="outerreplyform" class="comments mt-5">
                        <h3 id="commentsNum" class="aside-title ">Recent comments(${totalReply })</h3>
                        <div class="comments-grids">
                            <!-- 여기부터 루프 -->
                            <c:if test="${not empty reply }">
                                <c:forEach var="replyList" items="${reply }">
                                    <div  >
                                        <div id="middleform" class="media-grid">
                                            <div class="media">
                                                <div class="me"style="width: 100px; height: 100px; transform: scaleX(-1); left: 50%; right: 50%; margin-left: -40px;">
                                                    <h1><i class="bi bi-chat-dots"></i></h1>
                                                </div>
                                                <div id="innerreplyform" class="media-body comments-grid-right" style="width: 700px">
                                                    <h5>${replyList.mname }</h5>
                                                    <ul class="p-0 comment">
                                                        <li class="">${replyList.rdate }</li>
                                                        <c:if test="${m ne null }">
                                                            <li onclick="setR_like(this)">
                                                                <p>${replyList.r_like}</p>
                                                                <a > 좋아요<i class="bi bi-hand-thumbs-up"
                                                                           aria-hidden="true"></i> </a>

                                                                <div class="hiddenrseq" style="display:none">${replyList.rseq }</div>
                                                            </li>
                                                            <c:if test = '${ m.mnum eq replyList.mnum || m.athur ne 2}' >
                                                                <div align="right">
                                                                    <a style="color:blue" href='../board/deleteReply?bnum=${replyList.bnum}&rseq=${replyList.rseq}'>삭제</a>
                                                                </div>
                                                            </c:if>
                                                        </c:if>
                                                        <c:if test="${m eq null }">
                                                            <li>
                                                                <p>${replyList.r_like}</p>
                                                                <a > 좋아요<i class="bi bi-hand-thumbs-up"
                                                                           aria-hidden="true"></i></a>

                                                                <div class="hiddenrseq" style="display:none">${replyList.rseq }</div>
                                                            </li>
                                                        </c:if>
                                                    </ul>
                                                    <p>${replyList.content }</p>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    <div class="leave-comment-form" id="comment">
                        <h3 class="aside-title">Leave a reply</h3>
                        <c:if test="${m ne null}">
                            <div class="input-grids">
                                <div class="form-group">
                                    <textarea id="content" name="content" class="form-control" placeholder="Your Comment"
                                              required></textarea>
                                </div>
                            </div>
                            <div class="text-right mt-4">
                                <button id="postComment"  class="btn button-style">Post Comment</button>
                            </div>
                        </c:if>
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
