<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" contentType="text/html; charset=utf-8"%>
<%@page isELIgnored="false" %>
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

    <!-- video용 css 04.06 대현 추가-->
    <link href="/assets/css/video.css" rel="stylesheet" />
    <script src="/assets/js/video.js" defer></script>
    <script src="/assets/js/splitting.js"></script>
    <script src="/assets/js/trim.js"></script>
    <script src="/assets/js/typed.js"></script>
    <!-- video용 css 끝 -->

    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet" />
    <!-- alert  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <!-- jquery -->
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
        $(function(){
            document.getElementById('my_btn').click();
        });
        function buttonCheck(messageCheck,loginCheck){
            console.log("messageCheck: "+messageCheck);
            console.log("토큰확인: "+Kakao.Auth.getAccessToken());
            var mnum = loginCheck;
            if(messageCheck !=null && messageCheck!=0){//checkNum이 널이면 로그인이 안되어있거나 메세지가없는것,0이면 알림을끝상태
                const Toast = Swal.mixin({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: true,
                    showCancelButton: true,
                    confirmButtonText : "메세지 보러가기",
                    cancelButtonText: '알림끄기',
                    timer: 3000,
                    timerProgressBar: true,
                    didOpen: (toast) => {
                        toast.addEventListener('mouseenter', Swal.stopTimer);
                        toast.addEventListener('mouseleave', Swal.resumeTimer);
                    }
                })
                Toast.fire({
                    icon: 'success',
                    title: '새로운 메세지가 있습니다'
                }).then((result) => {
                    if (result.isConfirmed) {//여기에 로직 메세지 이동하는
                        location.href="member/messageList?mnum="+mnum;

                    } else if (
                        result.dismiss === Swal.DismissReason.cancel
                    ) {//여기에 로직 알림끄는
                        var result = {"mnum":mnum};
                        $.ajax({
                            url: "viewChecked.json",
                            type: "POST",
                            data: result,
                            success: function(data){
                                console.log(data);
                            }
                        });
                    }
                })
            }
        }
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
    </script>
    <script type="text/javascript">
        function showGroups(e){
            var word = $(e).find('h3').text();
            var word2 = word.substring(word.lastIndexOf(')') + 1);
            $.ajax({
                url:"/showGroups",
                type:"GET",
                dataType:"json",
                contentType: "application/json",
                data :{
                    category:word2
                },
                success: function(result){
                    console.log("##5showGroups success: "+result);
                    if(result.length==0){
                        $("#popularSection").empty();
                        $("#pageDiv").hide();
                        document.getElementById('showGroupform').innerText = "해당 관심사의 개설된 모임이 없습니다";
                    }else{
                        $("#pageDiv").show();
                        $("#popularSection").empty();
                        var inter = result[0].interest;
                        document.getElementById('showGroupform').innerText = "관심사: "+inter;
                        $(result).each(function(){
                            $("#popularSection").append(
                                "<div class=\"col-lg-4 col-md-6 d-flex align-items-stretch mb-4\">"
                                +"<div class=\"course-item\">"
                                +"<img src=\"/assets/img/groupImages/"+this.fname+"\" width=\"414px\" height=\"275px\"/>"
                                +"<div class=\"course-content\">"
                                +"<div class=\"d-flex justify-content-between align-items-center mb-3\">"
                                +"<h4>"+this.interest+"</h4>"
                                +"<p class=\"price\">"+this.gloc+"</p>"
                                +"</div>"
                                +"<h3><a href=\"groupTab/groupInfo.do?gseq="+this.gseq+"&mnum=${m.mnum}\">"+this.gname+"</a></h3>"
                                +"<div style=\"height: 40px; overflow:auto; margin-bottom: 15px\">"
                                +"<p>"+this.gintro+"</p>"
                                +"</div>"
                                +"<div class=\"d-flex justify-content-between align-items-center\">"
                                +"<div>"
                                +"<p><i class=\"fa fa-map-marker-alt text-primary me-2\"></i>"+this.gloc+"</p>"
                                +"</div>"
                                +"<div>"
                                <c:set var='loop_flag' value='false' />
                                <c:if test='${m ne null }'>
                                        <c:if test='${not loop_flag }'>
                                            <c:forEach var='wishCheck' items='${wishCheckList}'>
                                                <c:choose>
                                                    <c:when test='${groupList.gseq eq wishCheck.gseq and wishCheck.flag eq 1}'>
                                                        +"<button onclick='applyWishList(this)' type='button' class='btn btn-danger mb-1' value="+this.gseq+">찜 취소</button>"
                                                     <c:set var='loop_flag' value='true' />
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                        </c:if>
                                    <c:if test='${not loop_flag }'>
                                        +"<button onclick='applyWishList(this)' type='button' class='btn btn-outline-danger mb-1' value="+this.gseq+">찜 하기</button>"
                                    <c:set var='loop_flag' value='false' />
                                    </c:if>
                                </c:if>
                                +"</div>"
                                +"</div>"
                                +"<div class=\"trainer d-flex justify-content-between align-items-center\">"
                                +"<div class=\"trainer-profile d-flex align-items-center\">"
                                +"<h3><i class=\"bi bi-person-circle\"></i></h3>"
                                +"<span style=\"margin-bottom: 7px\">"+this.mname+"</span>"
                                +"</div>"
                                +"<div class=\"trainer-rank d-flex align-items-center\">"
                                +"<i class=\"bx bx-user\"></i>&nbsp;"+this.memInGroupCount+""
                                +"</div>"
                                +"</div>"
                                +"</div>"
                                +"</div>"
                                +"</div>"
                            );
                        })
                    }
                },
                error: function(error){
                    console.log("##error: "+error);
                }
            });
        }
    </script>

    <script type="text/javascript">
        function showInCate(e){
            $.ajax({
                url:"/showInCategory",
                type:"GET",
                dataType:"json",
                contentType: "application/json",
                data :{
                    int_out:$(e).find('a').text()
                },
                success: function(result){
                    $('#pageDiv').hide();
                    console.log("##success: "+result);
                    $("#addInCateForm").empty();
                    $("#addInCateForm2").empty();
                    $("#addInCateForm3").empty();
                    var tmp;
                    $(result).each(function(){
                        if(this.int_out!='업종/직무'&&this.int_out!='게임/오락' ){
                            $("#addInCateForm").append(
                                "<div onClick='showGroups(this)' class=\"col-lg-3 col-md-4\">"
                                +"<div class=\"icon-box\">"
                                +"<h3><a >"+this.int_in+"</a></h3>"
                                +"</div></div>"
                            );
                        }else if(this.int_out=='업종/직무'){
                            if(this.int_in=='업종'){
                                $('#addInCateForm #catetheme').text("업종");
                                $("#addInCateForm").append(
                                    "<div onClick='showGroups(this)' class=\"col-lg-3 col-md-4\">"
                                    +"<div class=\"icon-box\">"
                                    +"<h3>("+this.int_in+")<a >"+this.first_option+"</a></h3>"
                                    +"</div></div>"
                                );
                            }
                            if(this.int_in=='직무'){
                                $('#addInCateForm2 #catetheme2').text("직무");
                                $("#addInCateForm2").append(
                                    "<div onClick='showGroups(this)' class=\"col-lg-3 col-md-4\">"
                                    +"<div class=\"icon-box\">"
                                    +"<h3>("+this.int_in+")<a >"+this.first_option+"</a></h3>"
                                    +"</div></div>"
                                );
                            }
                            if(this.int_in=='테마'){
                                $('#addInCateForm3 #catetheme3').text("테마");
                                $("#addInCateForm3").append(
                                    "<div onClick='showGroups(this)' class=\"col-lg-3 col-md-4\">"
                                    +"<div class=\"icon-box\">"
                                    +"<h3>("+this.int_in+")<a >"+this.first_option+"</a></h3>"
                                    +"</div></div>"
                                );
                            }
                        }else if(this.int_out=='게임/오락'){
                            if(this.int_in=='온라인게임'){
                                $('#addInCateForm #catetheme').text("업종");
                                $("#addInCateForm").append(
                                    "<div onClick='showGroups(this)' class=\"col-lg-3 col-md-4\">"
                                    +"<div class=\"icon-box\">"
                                    +"<h3>("+this.int_in+")<a >"+this.first_option+"</a></h3>"
                                    +"</div></div>"
                                );
                            }
                            if(this.int_in=='보드게임'){
                                $('#addInCateForm2 #catetheme2').text("직무");
                                $("#addInCateForm2").append(
                                    "<div onClick='showGroups(this)' class=\"col-lg-3 col-md-4\">"
                                    +"<div class=\"icon-box\">"
                                    +"<h3>("+this.int_in+")<a >"+this.first_option+"</a></h3>"
                                    +"</div></div>"
                                );
                            }
                            if(this.int_in=='단체놀이'){
                                $('#addInCateForm3 #catetheme3').text("테마");
                                $("#addInCateForm3").append(
                                    "<div onClick='showGroups(this)' class=\"col-lg-3 col-md-4\">"
                                    +"<div class=\"icon-box\">"
                                    +"<h3>("+this.int_in+")<a >"+this.first_option+"</a></h3>"
                                    +"</div></div>"
                                );
                            }
                        }
                    })
                },
                error: function(error){
                    console.log("##error: "+error);
                }

            });
        }
        var wishFlag=0;
        function applyWishList(e){
            console.log($(e).val());
            var data = JSON.stringify({
                gseq:$(e).val()
            });
            $.ajax({
                url:"handleWishList",
                type:"POST",
                dataType:"json",
                contentType:"application/json",
                data:data,
                success: function(result){
                    console.log("success!: "+result);
                    $('#numberOfWish').text(result);
                    if($(e).text()=='찜 하기'){
                        $(e).text('찜 취소');
                        $(e).removeClass('btn-outline-danger').addClass('btn-danger');
                    }else if($(e).text()=='찜 취소'){
                        $(e).text('찜 하기');
                        $(e).removeClass('btn-danger').addClass('btn-outline-danger');
                    }
                },
                error:function(error){
                    console.log("failure!: "+error);
                }
            });
        }
        <!-- 현기 추가 -->
        $(function(){
            $("#getSearch").on("click", function(){
                var gname = $("#gname").val();
                var int_out = $("#int_out").val();
                var gloc = $("#gloc").val();
                if(gname=="" && int_out=="" && gloc==""){
                    Swal.fire({
                        title: '모임이름, 관심사, 지역 중 <br/> 한 가지 이상을 입력해주세요.',
                        icon: 'error',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'Yes'
                    }).then((result) => {
                        $('#pageDiv').show();
                        location.href="../";
                    });
                }

                $.ajax({
                    url: "/getSearchGroupList.json",
                    type: "GET",
                    data: $("#searchForm").serialize(),
                    success: function(result){
                        $('#pageDiv').hide();
                        if(result == ""){
                            Swal.fire({
                                title: '검색하신 모임이 존재하지않습니다.',
                                text: '첫 페이지로 돌아갑니다.',
                                icon: 'error',
                                confirmButtonColor: '#3085d6',
                                confirmButtonText: 'Yes'
                            }).then((result) => {
                                $('#pageDiv').show();
                                location.href="../";
                            });
                        }
                        console.log("result: " + result);

                        $('#popularSection').empty();

                        //검색한 모임 리스트를 띄워줘야함
                        $('#section-title').replaceWith(
                            "<section id='popular-courses' class='courses'>"
                            +"<div class='container' data-aos='fade-up'>"
                            +"<div class='section-title' style='padding-bottom: 0px' id='section-title'>"
                            +"<h2>소모임</h2>"
                            +"<p id='showGroupform'>Searched Groups</p>"
                            +"</div>"
                        );

                        $(result).each(function(index, item){
                            console.log("index: " + index);
                            console.log("item: " + item);
                            $('#popularSection').append(
                                "<div class='col-lg-4 col-md-6 d-flex align-items-stretch mb-4'>"
                                    +"<div class='course-item'>"
                                        +"<img src='/assets/img/groupImages/"+item.fname+"' width='414px' height='275px' alt='...'/>"
                                    +"<div class='course-content'>"
                                        +"<div class='d-flex justify-content-between align-items-center mb-3'>"
                                            +"<h4>"+item.interest+"</h4>"
                                            +"<p class='price'>"+item.gloc+"</p>"
                                        +"</div>"
                                        +"<h3><a href='groupTab/groupInfo.do?gseq="+item.gseq+"&mnum=${m.mnum}'>"+item.gname+"</a></h3>"
                                        +"<div style='height:40px; overflow:auto; margin-bottom: 15px'>"
                                            +"<p>"+item.gintro+"</p>"
                                        +"</div>"
                                        +"<div class='d-flex justify-content-between align-items-center'>"
                                        +"<div><p><i class='fa fa-map-marker-alt text-primary me-2'></i>"+item.gloc+"</p></div>"
                                        +"<div>"
                                            <c:set var='loop_flag' value='false' />
                                            <c:if test='${m ne null }'>
                                                <c:if test='${not loop_flag}'>
                                                    <c:forEach var='wishCheck' items='${wishCheckList }'>
                                                        <c:choose>
                                                            <c:when test='${groupList.gseq eq wishCheck.gseq and wishCheck.flag eq 1 }'>
                                                                +"<button onclick='applyWishList(this)' type='button' class='btn btn-danger mb-1' value="+item.gseq+">찜 취소</button>"
                                                                <c:set var='loop_flag' value='true' />
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test='${not loop_flag }'>
                                                    +"<button onclick='applyWishList(this)' type='button' class='btn btn-outline-danger mb-1' value="+item.gseq+">찜 하기</button>"
                                                    <c:set var='loop_flag' value='false' />
                                                </c:if>
                                            </c:if>
                                        +"</div>"
                                        +"</div>"
                                    +"<div class='trainer d-flex justify-content-between align-items-center'>"
                                    +"<div class='trainer-profile d-flex align-items-center'>"
                                    +"<h3><i class='bi bi-person-circle'></i></h3>"
                                    +"<span style='margin-bottom: 7px'>"+item.mname+"</span>"
                                    +"</div>"
                                    +"<div class='trainer-rank d-flex align-items-center'>"
                                    +"<i class='bx bx-user'></i>&nbsp;"+item.limit+"&nbsp;&nbsp;"
                                    +"</div>"
                                    +"</div>"
                                    +"</div>"
                                    +"</div>"
                                    +"</div>"
                                +"</div>"

                            );
                        })
                    },
                    error:function(error){
                        console.log("##error: "+error);
                    }
                });
            });
        });
    </script>
</head>

<body>
<c:choose>
    <c:when test="${message eq null}">
        <c:set value="null" var="message"/>
    </c:when>
    <c:otherwise>
        <c:set value="${message}" var="message"/>
    </c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${m eq null}">
        <c:set value="null" var="loginCheck"/>
    </c:when>
    <c:otherwise>
        <c:set value="${m.mnum}" var="loginCheck"/>
    </c:otherwise>
</c:choose>
<input
        id='my_btn'
        type='button'
        onclick='buttonCheck(${message},${loginCheck})'
/>
<!-- ======= Header ======= -->
<jsp:include page="header.jsp" flush="true"/>
<!-- End Header -->

<!-- ======= Video Section ======= -->
<section style="padding-bottom: 0">
        <div class="wrap">
            <div id="intro">
                <div class="typing">
                    <span class="txt"></span>
                </div>
                <div class="video">
                    <video
                            source
                            src="../resources/assets/videos/background.mp4"
                            type="video/mp4"
                            autoplay
                            loop
                            muted
                    ></video>
                </div>
            </div>
        </div>
</section>
<!-- End Video -->
<!-- Search Start -->
<div
        class="container-fluid mb-5 wow fadeIn mt-5"
        data-wow-delay="0.1s"
        style="padding: 35px; background-color: #5fcf80"
>
    <form  id="searchForm" autocomplete="off">
        <div class="container">
            <div class="row g-2">
                <div class="col-md-10">
                    <div class="row g-2">
                        <div class="col-md-4">
                            <input
                                    type="text"
                                    class="form-control border-0 py-3"
                                    placeholder="모임이름"
                                    name="gname"
                                    id="gname"
                            />
                        </div>
                        <div class="col-md-4">
                            <select class="form-select border-0 py-3" name="int_out" id="int_out">
                                <option selected value="">관심사</option>
                                <option value="아웃도어/여행">아웃도어/여행</option>
                                <option value="외국/언어">외국/언어</option>
                                <option value="음악/악기">음악/악기</option>
                                <option value="운동/스포츠">운동/스포츠</option>
                                <option value="차/오토바이">차/오토바이</option>
                                <option value="요리/제조">요리/제조</option>
                                <option value="업종/직무">업종/직무</option>
                                <option value="문화/공연/축제">문화/공연/축제</option>
                                <option value="공예/만들기">공예/만들기</option>
                                <option value="댄스/무용">댄스/무용</option>
                                <option value="봉사활동">봉사활동</option>
                                <option value="인문학/책/글">인문학/책/글</option>
                                <option value="사진/영상">사진/영상</option>
                                <option value="게임/오락">게임/오락</option>
                                <option value="반려동물">반려동물</option>
                                <option value="자유주제">자유주제</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <select class="form-select border-0 py-3" name="gloc" id="gloc">
                                <option selected value="">지역</option>
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
                <div class="col-md-2">
                    <button type="button" class="btn btn-dark border-0 w-100 py-3" id="getSearch">검색하기</button>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- Search End -->

<!-- ======= Counts Section ======= -->
<section id="counts" class="counts section-bg mb-5">
    <div class="container">
        <div class="row counters">
            <div onClick="showInCate(this)" class="col-lg-3 col-6 text-center">
                  <span
                          data-purecounter-start="0"
                          data-purecounter-end="${membercount+11320}"
                          data-purecounter-duration="1"
                          class="purecounter"
                  ></span>
                <p>회원수</p>
            </div>

            <div onClick="showInCate(this)" class="col-lg-3 col-6 text-center">
                  <span
                          data-purecounter-start="0"
                          data-purecounter-end="${groupcount+682}"
                          data-purecounter-duration="1"
                          class="purecounter"
                  ></span>
                <p>개설된 모임</p>
            </div>

            <div onClick="showInCate(this)" class="col-lg-3 col-6 text-center">
                  <span
                          data-purecounter-start="0"
                          data-purecounter-end="${gatheringcount+1321}"
                          data-purecounter-duration="1"
                          class="purecounter"
                  ></span>
                <p>개설된 정모</p>
            </div>

            <div onClick="showInCate(this)" class="col-lg-3 col-6 text-center">
                  <span
                          data-purecounter-start="0"
                          data-purecounter-end="${gatheringcount+6923}"
                          data-purecounter-duration="1"
                          class="purecounter"
                  ></span>
                <p>누적 정모</p>
            </div>
        </div>
    </div>
</section>
<!-- End Counts Section -->



<!-- ======= Features Section ======= -->
<section id="features" class="features">
    <div class="container" data-aos="fade-up">
        <div class="row" data-aos="zoom-in"  data-aos-delay="100">
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4">
                <div class="icon-box">
                    <i class="ri-football-fill" style="color: #ffbb2c"></i>
                    <h3><a href="">운동/스포츠</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4 mt-md-0">
                <div class="icon-box">
                    <i class="ri-footprint-line" style="color: #5578ff"></i>
                    <h3><a href="">아웃도어/여행</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4 mt-md-0">
                <div class="icon-box">
                    <i class="ri-translate-2" style="color: #e80368"></i>
                    <h3><a href="">외국/언어</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4 mt-lg-0">
                <div class="icon-box">
                    <i class="ri-music-2-line" style="color: #e361ff"></i>
                    <h3><a href="">음악/악기</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-roadster-line" style="color: #47aeff"></i>
                    <h3><a href="">차/오토바이</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-cake-3-line" style="color: #ffa76e"></i>
                    <h3><a href="">요리/제조</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-briefcase-5-line" style="color: #4233ff"></i>
                    <h3><a href="">업종/직무</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-open-arm-line" style="color: #b2904f"></i>
                    <h3><a href="">문화/공연/축제</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-palette-line" style="color: #b20969"></i>
                    <h3><a href="">공예/만들기</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-group-line" style="color: #ff5828"></i>
                    <h3><a href="">댄스/무용</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-user-heart-line" style="color: #29cc61"></i>
                    <h3><a href="">봉사활동</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-book-2-line" style="color: #11dbcf"></i>
                    <h3><a href="">인문학/책/글</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-camera-line" style="color: #26c2d6"></i>
                    <h3><a href="">사진/영상</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-gamepad-line" style="color: #e737cf"></i>
                    <h3><a href="">게임/오락</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-mickey-line" style="color: #909b00"></i>
                    <h3><a href="">반려동물</a></h3>
                </div>
            </div>
            <div onClick="showInCate(this)" class="col-lg-3 col-md-4 mt-4">
                <div class="icon-box">
                    <i class="ri-send-plane-fill" style="color: #093166"></i>
                    <h3><a href="">자유주제</a></h3>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End Features Section -->
<section id="features2" class="features">
    <div  class="container" data-aos="fade-up">
        <div id="addInCateForm" class="row" data-aos="zoom-in"  data-aos-delay="100">
            <h2 id="catetheme"></h2>
        </div>
    </div>
</section>
<section id="features2" class="features">
    <div  class="container" data-aos="fade-up">
        <div id="addInCateForm2" class="row" data-aos="zoom-in"  data-aos-delay="100">
            <h2 id="catetheme2"></h2>
        </div>
    </div>
</section>
<section id="features2" class="features">
    <div  class="container" data-aos="fade-up">
        <div id="addInCateForm3" class="row" data-aos="zoom-in"  data-aos-delay="100">
            <h2 id="catetheme3"></h2>
        </div>
    </div>
</section>
<!-- 섹션종료 -->
<!-- ======= Popular Courses Section ======= -->
<section id="popular-courses" class="courses mt-0">
    <div class="container" data-aos="fade-up">
        <div id="section-title" class="section-title">
            <h2>소모임</h2>
            <p id="showGroupform">Popular Groups</p>
        </div>
        <!--popular모임 첫번째줄 시작-->
        <div id="popularSection" class="row" data-aos="zoom-in" data-aos-delay="100">
            <c:forEach var="groupList" items="${list}" varStatus="status">

                <div class="col-lg-4 col-md-6 d-flex align-items-stretch mb-4">
                    <div class="course-item">
                        <img
                                src="/assets/img/groupImages/${groupList.fname }"
                                width="414px"
                                height="275px"
                                alt="..."
                        />
                        <div class="course-content">
                            <div
                                    class="d-flex justify-content-between align-items-center mb-3"
                            >
                                <h4>${groupList.interest}</h4>
                                <p class="price">${groupList.gloc}</p>
                            </div>

                            <h3><a href="groupTab/groupInfo.do?gseq=${groupList.gseq}&mnum=${m.mnum}">${groupList.gname}</a></h3>
                            <div style="height: 40px; overflow:auto; margin-bottom: 15px">
                            <p>
                                    ${groupList.gintro}
                            </p>
                            </div>

                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p><i class="fa fa-map-marker-alt text-primary me-2"></i>${groupList.gloc}</p>
                                </div>
                                <div>
                                    <c:set var="loop_flag" value="false" />
                                    <c:if test="${m ne null }">
                                        <c:if test="${not loop_flag }">
                                            <c:forEach var="wishCheck" items="${wishCheckList }" >
                                                <c:choose>
                                                    <c:when test="${groupList.gseq eq wishCheck.gseq and wishCheck.flag eq 1 }">
                                                        <button onclick="applyWishList(this)" type="button" class="btn btn-danger mb-1" value="${groupList.gseq }">찜 취소</button>
                                                        <c:set var="loop_flag" value="true" />
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${not loop_flag }">
                                            <button onclick="applyWishList(this)" type="button" class="btn btn-outline-danger mb-1" value="${groupList.gseq }">찜 하기</button>
                                            <c:set var="loop_flag" value="false" />
                                        </c:if>
                                    </c:if>
                                </div>
                            </div>
                            <div
                                    class="trainer d-flex justify-content-between align-items-center"
                            >
                                <div class="trainer-profile d-flex align-items-center">
                                    <h3><i class="bi bi-person-circle"></i></h3>
                                    <span style="margin-bottom: 7px">${namelist[status.index]}</span>
                                </div>
                                <div class="trainer-rank d-flex align-items-center">
                                    <i class="bx bx-user"></i>&nbsp;${groupMemberCount[status.index]}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </c:forEach>
        </div>
    </div>
    <c:if test="${m ne null }">
        <div id="pageDiv">
            <nav aria-label="Page navigation example">
                <ul
                        id="paging"
                        class="pagination"
                        style="justify-content: center"
                >
                    <c:if test="${pm.prev}">
                        <li class="page-item">
                            <a class="page-link" href="/?page=${pm.startPage-1}&pageSize=${cri.pageSize}&pageButonCheck=1">처음</a>
                        </li>
                    </c:if>
                    <c:if test="${pm.prev}">
                        <li class="page-item">
                            <a class="page-link" href="/?page=${cri.page-1}&pageSize=${cri.pageSize}&pageButonCheck=1">이전</a>
                        </li>
                    </c:if>
                    <c:forEach var="idx" begin="${pm.startPage }" end="${pm.endPage }">
                        <li class="page-item">
                            <a id="pageId" class="page-link" href="/?page=${idx}&pageSize=${cri.pageSize}&pageButonCheck=1">${idx}</a><!-- /?page=${idx}&pageSize=${cri.pageSize} -->
                        </li>
                    </c:forEach>
                    <c:if test="${pm.next && pm.endPage > 0}">
                        <li class="page-item">
                            <a class="page-link" href="/?page=${cri.page+1}&pageSize=${cri.pageSize}&pageButonCheck=1">다음</a>
                        </li>
                    </c:if>
                    <c:if test="${pm.next && pm.endPage > 0}">
                        <li class="page-item">
                            <a class="page-link" href="/?page=${pm.endPage}&pageSize=${cri.pageSize}&pageButonCheck=1">끝</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </c:if>
</section>
<!-- End Popular Courses Section -->


</main>
<!-- End #main -->

<!-- ======= Footer ======= -->
<jsp:include page="footer.jsp" flush="true"/>
<!-- End Footer -->

<div id="preloader"></div>
<a
        href="#"
        class="back-to-top d-flex align-items-center justify-content-center"
><i class="bi bi-arrow-up-short"></i
></a>

<!-- Vendor JS Files -->
<script src="../assets/vendor/purecounter/purecounter.js"></script>
<script src="../assets/vendor/aos/aos.js"></script>
<script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="../assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="/assets/js/main.js"></script>
</body>
</html>
