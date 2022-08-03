<%@ page  contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Setup - Corporate Category Bootstrap Responsive Web Template - Blog Single : W3Layouts</title>
	<!-- google-fonts -->
    <link href="http://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&amp;display=swap" rel="stylesheet">
    <!-- //google-fonts -->
    <!-- Font-Awesome-Icons-CSS -->
    <link rel="stylesheet" href="/assets/css/fontawesome-all.min.css">
    <!-- Template CSS Style link -->
    <link rel="stylesheet" href="/assets/css/style-liberty.css">
	<!-- alert  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<!-- alert -->
    <script type="text/javascript" language="javascript" 
		     src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
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
    
    function previousPost(athur){
    	console.log(athur);
		var qseq = ${qanda.qseq};
		console.log(qseq);
		var athur = athur;
		var result = {"athur":athur,"qseq":qseq};
		$(function(){
			$.ajax({
					url: "qaPreviousPostCheck.json",
					type: "POST",
					data: result,
					success: function(data){
						console.log(data);
						var PreviousQseq =data;
						
						if($.isNumeric(data)){
   							location.href="qaContent?qseq="+PreviousQseq+"&page=${page}&pageSize=${pageSize}";
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
    
    function nextPost(athur){
			var qseq = ${qanda.qseq};
			var athur = athur;
			var result = {"athur":athur,"qseq":qseq};
			$(function(){
				$.ajax({
   					url: "qaNextPostCheck.json",
   					type: "POST",
   					data: result,
   					success: function(data){
   						console.log(data);
   						var nextQseq =data;
   						if($.isNumeric(data)){
	   							location.href="qaContent?qseq="+nextQseq+"&page=${page}&pageSize=${pageSize}";
	   						
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
    	function updateCheck(mnumCheck){
    		var mnum = mnumCheck;
  			var qseq = ${qanda.qseq};
  			var result = {"mnum":mnum,"qseq":qseq};
  			var athur = ${m.athur}
	   			$(function(){
    				$.ajax({
	   					url: "qaUpdateCheck.json",
	   					type: "POST",
	   					data: result,
	   					success: function(data){
	   						if(athur==0){
	   							upDate();
	   						}else if(athur==1){
                                upDate();
                            }else{
		   						if(data==0){//없을때
		   							Swal.fire({
		   								title:"본인만 수정가능합니다",
		   								icon:"warning"
		   								});
		   						}else {
		   							upDate();
		   						}
	   						}
	   					}
	   				});  
	   			});
    	}
    	
    	function deleteCheck(mnumCheck){
    		var mnum = mnumCheck;
  			var qseq = ${qanda.qseq};
  			var result = {"mnum":mnum,"qseq":qseq};
  			var athur = ${m.athur}
	   			$(function(){
    				$.ajax({
	   					url: "qaUpdateCheck.json",
	   					type: "POST",
	   					data: result,
	   					success: function(data){
	   						if(athur==0){
	   							qaDelete();
	   						}else if(athur==1){
                                qaDelete();
                            }else{
		   						if(data==0){//없을때
		   							Swal.fire({
		   								title:"본인만 삭제가능합니다",
		   								icon:"warning"
		   								});
		   						}else {
		   							qaDelete();
		   						}
	   						}
	   					}
	   				});  
	   			});
    	}
    	
    	function upDate(){
            location="qaUpDate?qseq=${qanda.qseq}&page=${page}&pageSize=${pageSize}";
    	}
    	function qaDelete(){
    		location="qaDelete?qseq=${qanda.qseq}";
    	}
		
    	function comment2(i,index,mnumCheck,athur){
    		var num=index;
    		var mnum= mnumCheck;
    		var athur = athur;
    		var liUp="liup";
    		liUp+=index;
    		var liDown="lidown";
    		liDown+=index;
    		$(function(){
    			$('#comment').remove();
    			$('#'+liDown).remove();
    			var li="";
    			li+="<li id='"+liDown+"'>";
    			li+="<a href='javascript:void(0)' onclick=\"location.href='javascript:comment(1,"+num+","+mnum+","+athur+")'\"><i class='fa fa-reply mr-1' aria-hidden='true'></i>Reply</a>";
    			li+="</li>";
    			$('#'+liUp).after(                     
                       li              		
        		);
    		});

    	}
    	
    	function comment(i,index,mnumCheck,athur){
        	var num=index;
        	var liUp="liup";
    		liUp+=index;
    		var liDown="lidown";
    		liDown+=index;
    		var mnum= mnumCheck;
    		var qamnum=${qanda.mnum};
    		var athur = athur;
    		if(athur == 0 ||mnum==qamnum){
    			$('#comment').remove();
    			if(i==1){
    	    		$(function(){
    	    			$('#'+liDown).remove();
    	    			var li="";
    	    			li+="<li id='"+liDown+"'>";
    	    			li+="<a href='javascript:void(0)' onclick=\"location.href='javascript:comment2(0,"+num+","+mnum+","+athur+")'\"><i class='fa fa-reply mr-1' aria-hidden='true'></i>Reply</a>";
    	    			li+="</li>";
    	    			$('#'+liUp).after(                     
    	                    li              		
    	    			);
    					$('#divtest2').append(
    						"<div class='leave-comment-form' id='comment'> "
    						+"<h3 class='aside-title'>Leave a reply</h3>"
    						+ "<form action='qaReply?&mnum=${m.mnum}&qseq=${qanda.qseq}&mname=${m.mname}' method='post'>"
    						+ "<div class='input-grids'>"
    						+ "<div class='form-group'>"
    						+ "<input type='text' name='mname' class='form-control'  value='${m.mname}' required disabled>"
    						+ "</div>"
    						+ "<div class='form-group'>"
    						+"<textarea name='qarcontent' class='form-control' placeholder='Your Comment' required></textarea>"
    						+"</div>"
    						+"</div>"
    						+"<div class='text-right mt-4'>"
    						+"<button class='btn button-style'>Post Comment</button>"
    						+"</div>"
    						+"</form>"
    						+"</div>"
    					);
    					});
    	    		}else{
    	    			$('#comment').remove();
    	    		}
    		}else{
    			if(mnum!=qamnum){
        			Swal.fire({
    						title:"글쓴이만 가능합니다",
    						icon:"warning"
    						});
        			return false;
        		}
    		}
    		
    	}
    	
    </script>
  </head>

  <body >
    <!-- ======= Header ======= -->
    <jsp:include page="../header.jsp" flush="true"/>
    <!-- End Header -->
    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fade-in">
        <div class="container">
          <h1>Q & A</h1>
        </div>
      </div>
    <section id="course-details" class="course-details">
        <div class="container">
            <div class="row">
                <div class="col-lg-9 text11-content m-auto">
                    
                    <h4>${qanda.qtitle}</h4> 
                    <h6><span class="fa fa-user mr-1 icon-color"></span>${qanda.mnum}, ${qanda.qdate}</h6>
                    <a href="#post" class="post"></a>
                    <p class="mt-4 mb-3">${qanda.qcontent}</p>
                    <c:choose>
						<c:when test="${m eq null}" >
							<c:set var="athur" value="2"/>
						</c:when>
						<c:otherwise>
							<c:set var="athur" value="${m.athur}"/>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${m eq null}" >
							<c:set var="mnum" value="0"/>
						</c:when>
						<c:otherwise>
							<c:set var="mnum" value="${m.mnum}"/>
						</c:otherwise>
					</c:choose>
	                    <div class="new-posts mt-5">
	                        <a class="prev-post pull-left" href="javascript:previousPost(${athur})"><span class="fa fa-arrow-left"
	                                aria-hidden="true"></span>
	                            Previous Post</a>
	                       <a href="javascript:void(0)" onclick="location.href='javascript:updateCheck(${mnum})'">수정</a>
	                       <a href="qa?page=${page}&pageSize=${pageSize}">목록</a>
	                       <a href="javascript:void(0)" onclick="location.href='javascript: deleteCheck(${mnum})'">삭제</a>
	                        <a class="next-post pull-right" href="javascript:nextPost(${athur})">Next Post <span class="fa fa-arrow-right"
	                                aria-hidden="true"></span></a>
	                    </div>
                    <div id="divtest2" class="comments mt-5">
                        <h3 class="aside-title ">Recent comments(${qreplyCount })</h3>
                        <div class="comments-grids">
                            <!-- 여기부터 루프 -->

                <c:if test="${qaReply ne null }">
                <c:forEach var="qaReply" items="${qaReply }" varStatus="index">
                            <div class="media-grid">
                                <div class="media">
                                    <a class="comment-img" href="javascript:void(0)"><img src="/assets/img/trainers/trainer-1.jpg"
                                            class="img-responsive" width="100px" alt="placeholder image"></a>
                                    <div id="replyDiv" class="media-body comments-grid-right">
                                        <h5>${qaReply.mname}</h5>
                                        <ul id="ul" class="p-0 comment">
                                            <li id="liup${index.index}">${qaReply.qardate}</li>                         
                                            	<li id="lidown${index.index}">
                                                <a  href="javascript:void(0)" onclick="location.href='javascript:comment(1,${index.index},${mnum},${athur})'"><i class="fa fa-reply mr-1" aria-hidden="true"></i>Reply</a>
                                                </li>              
                                        </ul>
                                        <p>${qaReply.qarcontent }</p>
                                    </div>
                                </div>
                            </div>
                    </c:forEach>
                </c:if>
					</div>
                </div>
                    <c:if test="${m.athur eq 0 || m.athur eq 1}">
                    
	                    <div class="leave-comment-form" id="comment">
	                        <h3 class="aside-title">Leave a reply</h3>
	                        <form action="/admin/qaReply?&mnum=${m.mnum}&qseq=${qanda.qseq}&mname=${m.mname}" method="post">
	                            <div class="input-grids">
	                                <div class="form-group">
	                                    <input type="text" name="Name" class="form-control"  value="${m.mname}" required disabled>
	                                </div>
	                                <div class="form-group">
	                                    <textarea name="qarcontent" class="form-control" placeholder="Your Comment" required></textarea>
	                                </div>
	                            </div>
	                            <div class="text-right mt-4">
	                                <button class="btn button-style">Post Comment</button>
	                            </div>
	                            </form> 
	                        </div>                          
	                  </c:if>          
                </div>      
            </div>

    </div>
</section>
    </main>
    <!-- End #main -->

    <!-- ======= Footer ======= -->
    <jsp:include page="../footer.jsp" flush="true"/>
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
