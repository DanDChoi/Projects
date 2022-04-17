<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
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
	<!-- alert  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!-- alert -->
	<!-- my page  -->
	<link href="/assets/css/mypage.css" rel="stylesheet" />
	<!-- Template Main CSS File -->
	<link href="/assets/css/style.css" rel="stylesheet" />
	<!-- 전화번호 숨김 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.main i').on('click',function(){
				$('input').toggleClass('active');
				if($('input').hasClass('active')){
					$(this).attr('class',"fa fa-eye-slash fa-lg")
							.prev('input').attr('type',"text");
				}else{
					$(this).attr('class',"fa fa-eye fa-lg")
							.prev('input').attr('type','password');
				}
			});
		});

		$(function(){
			$("#updatebutton").on("click",function(){
				$.ajax({
					url: "../mypage/nowpassword.json",
					type: "POST",
					data: $('#updateform').serialize(),
					success: function(data){
						console.log(data);

						if(data==0){
							var pwcheck = $("#pwd1").val();
							var pwcheck2 = $("#pwd2").val();
							if(pwcheck!=pwcheck2){
								Swal.fire({
									title:"비밀번호가 다릅니다",
									icon:"warning"
								})
								return false;
							}
							else{
								var pwcheck = $("#pwd1").val();
								Swal.fire({
									title: '수정 성공!',
									icon: 'success',
									confirmButtonColor: '#3085d6',
									cancelButtonColor: '#d33',
									confirmButtonText: 'oK'
								}).then((result) => {
									console.log(result.isConfirmed);
									if (result.isConfirmed) {
										location.href="../mypage/updatepassword?mnum=${m.mnum}&pwd="+pwcheck;
									}
								});

							}
						}else if(data==1){
							Swal.fire({
								title:"틀림",
								icon:"error"
							});
						}
					}
				});
			});
		});

		$(function(){
			$("#updatebutton2").on("click",function(){
				$.ajax({
					url: "../mypage/updatemaddrandpfr_loc.json",
					type: "POST",
					data: $('#updateform2').serialize(),
					success: function(data){

						if(data==0 ){
							var pfr_loc = $("#pfr_loc").val();
							var maddr = $("#maddr").val();
							Swal.fire({
								title: ' 수정 내용이 없습니다.',
								icon: 'warning',
								confirmButtonColor: '#3085d6',
								cancelButtonColor: '#d33',
								confirmButtonText: 'oK'
							});
							return false;
						}else{
							var pfr_loc = $("#pfr_loc").val();
							var maddr = $("#maddr").val();
							Swal.fire({
								title: '수정 성공!',
								icon: 'success',
								confirmButtonColor: '#3085d6',
								cancelButtonColor: '#d33',
								confirmButtonText: 'oK'
							}).then((result) => {
								console.log(result.isConfirmed);
								if (result.isConfirmed) {
									location.href="../mypage/main";

								}
							});
						}
					}
				});
			});
		});
		function sample6_execDaumPostcode() {
			new daum.Postcode({
				oncomplete: function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					if(data.userSelectedType === 'R'){
						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							extraAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if(data.buildingName !== '' && data.apartment === 'Y'){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if(extraAddr !== ''){
							extraAddr = ' (' + extraAddr + ')';
						}
						// 조합된 참고항목을 해당 필드에 넣는다.
						//document.getElementById("sample6_extraAddress").value = extraAddr;

					} else {
						//document.getElementById("sample6_extraAddress").value = '';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					//document.getElementById('sample6_postcode').value = data.zonecode;//우편번호
					document.getElementById("maddr").value = addr;
					// 커서를 상세주소 필드로 이동한다.
					document.getElementById("maddr2").focus();
				}
			}).open();
		}

	</script>


	<script type="text/javascript">
		function winPopup() {
			let email = $("#email").val();
			var popUrl = "updateemail?email="+email;
			var popOption = "width=430, height=500, left= 600,status=no,scrollbars=no";
			window.open(popUrl,"이메일 변경", popOption);
		}

		function winPopup2() {
			var popUrl = "categoryform.do";
			var popOption = "width=600, height=700, left= 600,status=no,scrollbars=no";
			window.open(popUrl,"관심사 수정", popOption);
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
<!-- End Header -->
<main id="main" data-aos="fade-in">
	<!-- ======= Breadcrumbs ======= -->
	<div class="breadcrumbs">
		<div class="container">
			<h2>마이페이지</h2>
		</div>
	</div>

	<!-- ======= Breadcrumbs ======= -->

	<!-- End Breadcrumbs -->

	<!-- ======= Contact Section ======= -->
	<section id="contact" class="contact">
		<div data-aos="fade-up">
		</div>

		<div class="container" style="margin-top: 100px">
			<div class="row gutters">
				<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
					<div class="card h-100">
						<div class="card-body mt-5">
							<div class="account-settings">
								<div class="user-profile">
									<h5 class="user-name">${m.mname}</h5>
									<h6 class="user-email">${member.email}</h6>
								</div>
								<div class="user-profile">
									<button type="button" class="btn btn-sm btn-outline-dark" onclick="location.href='../member/messageList?mnum=${m.mnum}'">메세지함</button>
								</div>
								<div class="about">
									<h5>관심사</h5>

									<p><c:choose>
										<c:when test="${m.category_first eq null}">

										</c:when>
										<c:otherwise>
											${m.category_first}
										</c:otherwise>
									</c:choose></p>
									<p>
										<!-- 두번째 추가했을때 구현 해야함 -->
									<p>
										<c:choose>
											<c:when test="${ not empty m.category_second }">
												${m.category_second}
											</c:when>
											<c:otherwise>

											</c:otherwise>
										</c:choose>
									</p>
									<p>
										<!-- 세번째 추가 했을때 구현해야함-->
									<p>
										<c:choose>
											<c:when test="${not empty m.category_third }">
												${m.category_third}
											</c:when>
											<c:otherwise>

											</c:otherwise>
										</c:choose>
									</p>
									<p>
										<button type="button" class="btn btn-secondary"  onclick="winPopup2();">수정</button>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xl-9 col-lg-9 col-md-12 col-sm-12 col-12">
					<div class="card h-100">
						<div class="card-body">
							<form name="f" id="updateform" name="updateform">
								<div class="row gutters">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
										<h6 class="mb-2 text-primary">개인정보</h6>
									</div>

									<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
										<div class="form-group">
											<label for="mname">이름</label>
											<input type="text" name = "mname" value = "${m.mname}"class="form-control" id="mname" placeholder="Enter full name" disabled>
										</div>
									</div>
									<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
										<div class="form-group">
											<label for="password">현재비밀번호</label>
											<input type="password" name = "pwd" value = "" class="form-control" id="pwd" >
										</div>
									</div>

									<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">

										<div class="form-group">

											<label for="phone">전화번호</label>
											<div class = "main" style="position:relative">
												<input type="password" name = "phone" value = "${m.phone}"  class="form-control" id="phone" style="display:inline-block" readonly  >
												<i class="fa fa-eye fa-lg" style="position:absolute; left:420px; bottom:10px"></i>
											</div>
										</div>
									</div>


									<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
										<div class="form-group">
											<label for="pwd1">비밀번호</label>
											<input type="password" id = "pwd1" name = "pwd1" value = "" class="form-control" >
										</div>
									</div>
									<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
										<div class="form-group">
											<label for="website">이메일</label>
											<div class = "input-group">
												<input type="url" name = "email" id = "email" value = "${member.email}" readonly class="form-control" id="email" >
												<span class="input-group-btn">
                        <button type="button" class="btn btn-secondary"  onclick="winPopup();">수정</button>
                     </span>
											</div>
										</div>
									</div>

									<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
										<div class="form-group" >
											<label for=pwd2>비밀번호 확인</label>
											<div align = "right">
												<input type="password" id = "pwd2" name = "pwd2" value = "" class="form-control" >

												<button type="button" id="updatebutton" name="updatebutton" class="btn btn-secondary mt-2">수정</button>
											</div>
										</div>
									</div>
								</div>
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">

								</div>
							</form>

							<form name="f2" id="updateform2" name="updateform2" method = "POST">
								<div class="row gutters">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
										<h6 class="mt-3 mb-2 text-primary">수정사항</h6>
									</div>
									<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">

										<div class="form-group">
											<label for="website">주소지</label>

											<input type="text" name = "maddr" id = "maddr" onclick="sample6_execDaumPostcode()" value = "${member.maddr}"  class="form-control"  readonly>
											<input
													id="maddr2"
													type="text"
													name="maddr"
													class="form-control"
													value=""
													placeholder="상세주소"


											/>
											<div align = "right">
												<button type="button" id="updatebutton2" name="updatebutton2" class="btn btn-primary mt-2 float-right " >수정</button>
											</div>
										</div>
									</div>
									<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
										<div class="form-group">
											<label for="ciTy">관심지역</label>
											<select class="form-control"  name="pfr_loc" id = "pfr_loc">
												<option selected >${member.pfr_loc}</option>
												<option value="서울">서울</option>
												<option value="경기">경기</option>
												<option value="인천">인천</option>
												<option value="강원">강원</option>
												<option value="충북">충북</option>
												<option value="충남">충남</option>
												<option value="전북">전북</option>
												<option value="전남">전남</option>
												<option value="경북">경북</option>
												<option value="경남">경남</option>
												<option value="제주">제주</option>
											</select>

										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

	</section>
	<!-- End Contact Section -->
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