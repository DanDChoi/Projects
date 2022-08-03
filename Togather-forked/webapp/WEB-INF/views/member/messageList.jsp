<%@ page session="true" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<!-- alert  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
                          location.href="../member/logout.do";
                      },500);
                  });
              }else{
                  location.href="../member/logout.do";
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
          <h1>받은 메세지</h1>
        </div>
      </div>
	  <section id="course-details" class="course-details">
	   <div class="container" data-aos="fade-up">
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
                  <li><a class="dropdown-item" href="messageList?pageSize=1">1</a></li>
                  <li><a class="dropdown-item" href="messageList?pageSize=5">5</a></li>
                  <li><a class="dropdown-item" href="messageList?pageSize=10">10</a></li>
                  <li><a class="dropdown-item" href="messageList?pageSize=15">15</a></li>
                </ul>
          </div>
          <table class="table table-hover" style="text-align: center">
            <thead>
              <tr>
                <th class="col-sm-2">글번호</th>
                <th class="col-sm-6">제목</th>
                <th scope="col-sm-2">보낸사람</th>
                <th scope="col-sm-2">작성일</th>
              </tr>
            </thead>
           
            <tbody>
            <c:if test="${empty messageList}">
						<tr align="center" noshade>
						   <td colspan="4">데이터가 하나도 없음</td>
						</tr>
		    </c:if>
		    <c:if test="${not empty messageList}">
            <c:forEach items="${messageList}" var="list" varStatus="status">
	            		<tr>
			                <th scope="row">${list.meseq }</th>
			                <td><a style="<c:if test='${list.mecheck == 0}'>color:blue;</c:if>" id="messageColor" href="messageContent?meseq=${list.meseq}&page=${cri.page}&pageSize=${cri.pageSize}" >${list.metitle}</a></td>
			                <td>${list.to_mname}</td>
			                <td><fmt:formatDate value="${list.medate}" pattern="yyyy-MM-dd (E) HH:mm" /></td>
			           </tr>
            </c:forEach>  
            </c:if>
            </tbody>
          </table>

          <div>
            <nav aria-label="Page navigation example">
                  <ul
                    id="paging"
                    class="pagination"
                    style="justify-content: center"
                  >
                  <c:if test="${pm.prev}">
                    <li class="page-item">
                      <a class="page-link" href="messageList?page=${pm.startPage-1}&pageSize=${cri.pageSize}">처음</a>
                    </li>
                  </c:if>
                  <c:if test="${pm.prev}">
                    <li class="page-item">
                      <a class="page-link" href="messageList?page=${cri.page-1}&pageSize=${cri.pageSize}">이전</a>
                    </li>
                  </c:if>
                  <c:forEach var="idx" begin="${pm.startPage }" end="${pm.endPage }">
                    <li class="page-item">
                      <a class="page-link" href="messageList?page=${idx }&pageSize=${cri.pageSize}">${idx}</a>
                    </li> 
                  </c:forEach>
                  <c:if test="${pm.next && pm.endPage > 0}">
                    <li class="page-item">
                      <a class="page-link" href="messageList?page=${cri.page+1}&pageSize=${cri.pageSize}">다음</a>
                    </li>
                  </c:if>
                  <c:if test="${pm.next && pm.endPage > 0}">
                    <li class="page-item">
                      <a class="page-link" href="messageList?page=${pm.endPage}&pageSize=${cri.pageSize}">끝</a>
                    </li>
                  </c:if>
                  </ul>
                </nav>
          </div>
        </div>
		</div>
      </section>
    </main>
    <!-- End #main -->
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
