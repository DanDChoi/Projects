<%@ page contentType="text/html;charset=utf-8" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
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
    <!-- alert -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <!-- alert -->
    <script
      type="text/javascript"
      language="javascript"
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"
    ></script>
    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet" />
    <script type="text/javascript">
      $(function(){
        document.getElementById('my_btn').click();
      });
      function endTimeGatheringCheck(EndCheck,noticeCheck){
        if(EndCheck!=null && noticeCheck==0){
          $('#count').hide();
          var endDayCheck;
          var endTimeCheck;

          var timeName;
          endDayCheck="${endTimeGathering.ga_date}";
          endTimeCheck="${endTimeGathering.time}";
          var dday = new Date(endDayCheck+" "+endTimeCheck).getTime();
          //setInterval(function() {
          var today = new Date().getTime();
          var gap = dday - today;
          var day = Math.floor(gap / (1000 * 60 * 60 * 24));
          if(0<=day && day<7){
            var hour = Math.floor((gap % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var min = Math.floor((gap % (1000 * 60 * 60)) / (1000 * 60));
            var sec = Math.floor((gap % (1000 * 60)) / 1000);
            document.getElementById("count").innerHTML = "${name}?????? ??????(${gatheringName})??? D-DAY?????? " + day + "??? " + hour + "?????? " + min + "??? " + sec + "??? ???????????????.";

            $('#hiddenInput').val($('#count').text());
          }
          //}, 1000);
          timeName+=$('#hiddenInput').val();
          if(0<=day && day<7){
            var ga_seq=${notice.ga_seq};
            checkTime(ga_seq);
          }
        }

      }


      function checkTime(ga_seq){
        const Toast = Swal.mixin({
          toast: true,
          position: 'top-end',
          showConfirmButton: true,
          showCancelButton: true,
          confirmButtonText : "?????? ??????",
          timer: 3000,
          timerProgressBar: true,
          didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer);
            toast.addEventListener('mouseleave', Swal.resumeTimer);
          }
        })
        Toast.fire({
          icon: 'success',
          title: $('#hiddenInput').val()
        }).then((result) => {
          if (result.isConfirmed) {//????????? ?????? ????????? ????????????
            var mnum = ${m.mnum};
            var result = {"ga_seq":ga_seq,"mnum":mnum};
            $.ajax({
              url: "noticeChecked.json",
              type: "POST",
              data: result,
              success: function(data){
                console.log(data);
              }
            });

          } else if (
                  result.dismiss === Swal.DismissReason.cancel
          ) {//????????? ?????? ????????????

          }
        })
      }

      function groupJoin(){
        Swal.fire({
          title: '????????? ?????? ???????????????????',
          icon: 'question',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes'
        }).then((result) => {
          console.log(result.isConfirmed);
          if (result.isConfirmed) {
            var mnum = ${m.mnum};
            var gseq = ${groupInfo.gseq};
            var result = {"mnum":mnum,"gseq":gseq};
            $.ajax({
              url: "memInGroup.json",
              type: "POST",
              data: result,
              success: function(data){
                if(data==1){
                  Swal.fire({
                    title: "?????? ????????? ??? ????????????",
                    icon: "error"
                  });
                }else{
                  location.reload();
                }
              }
            });
          }
        });
      }

      function groupQuit(){
        var mnum = ${m.mnum};
        var arr = new Array();
        <c:forEach var="memInGroupName" items="${memInGroupName}" varStatus="index">
        arr.push({gseq: "${groupInfo.gseq}", mnum: "${memInGroupName.MNUM}", grade: "${memInGroupName.GRADE}"});
        </c:forEach>

        if(mnum == arr[0].mnum){ //????????? ??? ????????? ???????????????? ( ???????????? ?????? ?????? ????????? ????????? => order by grade, mnum )
          grade = arr[0].grade;
        }else{ //????????? or ????????????
        }

        $(function(){
          $.ajax({
            url: "kingQuitCheck.json",
            type: "POST",
            data: {gseq: "${groupInfo.gseq}", mnum: "${m.mnum}", grade: "${grade}"},
            success: function(data){
              if(data == 0){
                Swal.fire({
                  title: '???????????? ???????????? ??? ?????? </br> ???????????? ???????????? ???????????????.',
                  icon: 'question',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Yes'
                }).then((result) => {
                  if(result.isConfirmed){
                    location="delegate.do?gseq=${groupInfo.gseq}&mnum=${m.mnum}&grade=${grade}";
                  }
                })
              }else{
                Swal.fire({
                  title: '???????????? ?????? ???????????????????',
                  icon: 'question',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Yes'
                }).then((result) => {
                  if (result.isConfirmed) {
                    var mnum = ${m.mnum};
                    var gseq = ${groupInfo.gseq};
                    var result = {"mnum":mnum,"gseq":gseq};
                    $(function(){
                      $.ajax({
                        url: "groupQuit.json",
                        type: "POST",
                        data: result,
                        success: function(data){
                        }
                      });
                      location.reload();
                    });
                  }
                });
              }
            }
          })
        })
      }

      function groupDeleteCheck(){
        var mnum = ${m.mnum};
        var gseq = ${groupInfo.gseq};
        var result = {"mnum":mnum,"gseq":gseq};
        $(function(){
          $.ajax({
            url: "groupDeletecheck.json",
            type: "POST",
            data: result,
            success: function(data){
              if(data==0 || ${m.athur eq 0}){//?????????????????????
                Swal.fire({
                  title: '????????? ?????? ???????????????????',
                  icon: 'question',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Yes'
                }).then((result) => {
                  console.log(result.isConfirmed);
                  if (result.isConfirmed) {
                    groupDelete();
                  }
                });
                console.log("check0: "+data);
              }else if(data==1 || ${m.athur eq 1}){//???????????????
                Swal.fire({
                  title: '????????? ?????? ???????????????????',
                  icon: 'question',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Yes'
                }).then((result) => {
                  console.log(result.isConfirmed);
                  if (result.isConfirmed) {
                    groupDelete();
                  }
                });
                console.log("check0: "+data);
              }else{//????????? ?????????
                console.log("check1: "+data);
                Swal.fire({
                  title: "???????????? ?????? ???????????????",
                  icon: "error"
                });
              }
            }
          });
        });
      }

      function groupUpdateCheck(){
        var mnum = ${m.mnum};
        var gseq = ${groupInfo.gseq};
        var result = {"mnum":mnum,"gseq":gseq};
        $(function(){
          $.ajax({
            url: "groupUpdatecheck.json",
            type: "POST",
            data: result,
            success: function(data){
              if(data==0 || ${m.athur eq 0}){//?????????????????????
                groupUpdate();
                console.log("check0: "+data);
              }else if(data==1 || ${m.athur eq 1}){//???????????????
                groupUpdate();
                console.log("check1: "+data);
                //swal("?????????,???????????? ?????? ???????????????");
              }else if(data==2){//????????????
                console.log("check2: "+data);
                Swal.fire({
                  title: "?????????,???????????? ?????? ???????????????",
                  icon: "error"
                });
              }else {//??????????????????
                Swal.fire({
                  title: "?????????,???????????? ?????? ???????????????",
                  icon: "error"
                });
                console.log("check3: "+data);
              }
            }
          });
        });
      }

      function groupUpdate(){
        location="groupUpdate.do?gseq=${groupInfo.gseq}";
      }

      function groupDelete(){
        location="groupDelete.do?gseq=${groupInfo.gseq}";
      }

      function memberInfo(index){
        var arr = new Array();
        <c:forEach var="memInGroupName" items="${memInGroupName}" varStatus="index">
        arr.push({mnum: "${memInGroupName.MNUM}", mname: "${memInGroupName.MNAME}", birth: "${memInGroupName.BIRTH}", maddr: "${memInGroupName.MADDR}"});
        </c:forEach>

        $("#memInfo").replaceWith(
                "<div class='col-lg-9 mt-4 mt-lg-0' id='memInfo'>"
                +"<div class='tab-content'>"
                +"<div class='tab-pane active show' id='tab-1'>"
                +"<div class='row'>"
                +"<div class='col-lg-8 details order-2 order-lg-1'>"
                +"<h3>????????????</h3>"
                +"<input id='input"+[index]+"'type='hidden' value='"+arr[index].mnum+"'/>"
                +"<input id='mname"+[index]+"'type='hidden' value='"+arr[index].mname+"'/>"
                +"<p id='p"+[index]+"'>??????: "+arr[index].mname+"</p>"
                +"<p>????????????: "+arr[index].birth+"</p>"
                +"<p>?????????: "+arr[index].maddr+"</p>"
                +"<button id='button"+[index]+"' type='button' class='btn btn-outline-dark btn-sm' onclick='javascript:send("+[index]+")'>"
                +"???????????????"
                +"</button>"
                +"<div class='d-grid gap-2 mt-3 mb-3'>"
                +"<c:if test='${grade == 0 || grade==1}'>"
                +"<button type='button' id='deleMan' class='btn btn-outline-secondary' onclick='delegateManCheck("+index+")'>"
                +"????????? ??????/??????"
                +"</button>"
                +"</c:if>"
                +"</div>"
                +"</div>"
                +"<div class='col-lg-4 text-center order-1 order-lg-2'>"
                +"</div>"
                +"</div>"
                +"</div>"
                +"</div>"
                +"</div>"
        );
      }
      function send(index){
        var mname=$('#mname'+index).val();
        var mnum=$('#input'+index).val();
        var popupX = (window.screen.width / 2);
        var popupY = (window.screen.height / 2) - (650 / 2);
        var popUrl = "../member/sendMessageForm?to_mnum=${m.mnum}&to_mname=${m.mname}&from_mnum="+mnum+"&from_mname="+mname+"&gseq=${groupInfo.gseq}";
        var popOption = "width=600, height=650, top="+popupY+", right="+popupX+"";
        window.open(popUrl, "Message", popOption);
      }

      function delegateManCheck(index){
        console.log(index);
        console.log("????????? ??????");
        var arr = new Array();
        <c:forEach var="memInGroupName" items="${memInGroupName}" varStatus="index">
        arr.push({gseq: "${groupInfo.gseq}", mnum: "${memInGroupName.MNUM}", grade: "${memInGroupName.GRADE}"});
        </c:forEach>
        console.log(arr);

        $(function(){
          $.ajax({
            url: "delegateCheck.json",
            type: "POST",
            data: {gseq: "${groupInfo.gseq}", mnum: arr[index].mnum, grade: arr[index].grade},
            success: function(data){
              console.log("controller_delegate return ???: " + data);
              if(data == 0){
                Swal.fire({
                  title: "?????? ??????????????????.",
                  icon: "error"
                });
              }else if(data == 1){
                Swal.fire({
                  title: "?????? ??????????????????. ?????????????????????????",
                  icon: "question",
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Yes'
                }).then((result) => {
                  console.log("???????????? ???: " + result.isConfirmed);
                  if(result.isConfirmed){
                    Swal.fire({
                      title: "????????? ????????? ??????????????????.",
                      icon: "success"
                    }).then((result) =>{
                      location="delegate.do?gseq=${groupInfo.gseq}&mnum="+arr[index].mnum+"&grade="+arr[index].grade+"";
                    })
                  }
                })
              }else{
                Swal.fire({
                  title: '????????? ????????? ???????????????????',
                  icon: 'question',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  confirmButtonText: 'Yes'
                }).then((result) => {
                  console.log("?????? ????????? ???: " + result.isConfirmed);
                  if(result.isConfirmed){
                    Swal.fire({
                      title: "??????????????? ??????????????????.",
                      icon: "success"
                    }).then((result) =>{
                      location="delegate.do?gseq=${groupInfo.gseq}&mnum="+arr[index].mnum+"&grade="+arr[index].grade+"";
                    })
                  }
                })
              }
            }
          });
        });
      }
    </script>
    <script type="text/javascript">
      function gatheringCreateCheck(){
        var gseq = ${groupInfo.gseq};
        var result = {"gseq":gseq};
        $(function(){
          $.ajax({
            url: "gatheringCreateCheck.json",
            type: "POST",
            data: result,
            success: function(data){
              if(data == 0){
                Swal.fire({
                  title: '????????? 5???????????? ?????? ???????????????.',
                  icon: 'warning',
                  showCancelButton: false,
                  confirmButtonColor: '#3085d6',
                  confirmButtonText: 'Yes'
                });
              }else{
                gatheringCreate();
              }
            }
          });
        });
      }

      function gatheringCreate(){
        location="../gathering/gatheringCreate.do?gseq=${groupInfo.gseq}&mnum=${m.mnum}";
      }
    </script>
    <!-- 04/11 ???????????? (??????????????????)-->
    <c:forEach items="${memInGroupName}" var="memInGroupName">
      <script type="text/javascript">
        function groupMembercheck(){
          var mnum = ${m.mnum};
          var gseq = ${groupInfo.gseq};
          var result = {"mnum":mnum,"gseq":gseq};
          $(function(){
            $.ajax({
              url: "groupMembercheck.json",
              type: "POST",
              data: result,
              success: function(data){
                if(data==0 || ${m.athur eq 0}){//?????????????????????
                  groupMember();
                }else if(data==1  || ${m.athur eq 1}){//???????????????
                  groupMember();
                  //swal("?????????,???????????? ?????? ???????????????");
                }else if(data==2){//????????????
                  groupMember();
                }else {//??????????????????
                  Swal.fire({
                    title: "??????????????? ????????? ???????????????.",
                    icon: "error"
                  });
                }
              }
            });
          });
        }

        function groupMember(){
          location="../gboard/gblistPage?gseq=${groupInfo.gseq}&mnum=${memInGroupName.MNUM}";
        }
      </script>
      <script type="text/javascript">
        function groupChat() {
          window.name = "parentForm";
          openWin = window.open(
            "chat?gseq=${groupInfo.gseq}&gname=${groupInfo.gname}",
            "gatheringSearchMap",
            "width=1000, height=530, top=100, left=100"
          );
        }
      </script>
    </c:forEach>
    <!-- 04/05 ???????????? (????????? ????????????)-->
    <c:forEach items="${memInGroupName}" var="memInGroupName">
      <script type="text/javascript">
        function galleryCheck(){
          var mnum = ${m.mnum};
          var gseq = ${groupInfo.gseq};
          var result = {"mnum":mnum,"gseq":gseq};
          $(function(){
            $.ajax({
              url: "galleryCheck.json",
              type: "POST",
              data: result,
              success: function(data){
                if(data==0 || ${m.athur eq 0}){//?????????????????????
                  galleryMember();
                }else if(data==1  || ${m.athur eq 1}){//???????????????
                  galleryMember();
                  //swal("?????????,???????????? ?????? ???????????????");
                }else if(data==2){//????????????
                  galleryMember();
                }else {//??????????????????
                  Swal.fire({
                    title: "??????????????? ????????? ???????????????.",
                    icon: "error"
                  });
                }
              }
            });
          });
        }
        function galleryMember(){
          location="groupGallery.do?gseq=${groupInfo.gseq}&mnum=${m.mnum}";
        }
      </script>
    </c:forEach>
    <!-- 04/05 ???????????? ???-->

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
  </head>

  <body>
    <c:choose>
      <c:when test="${endTimeGathering eq null}">
        <c:set value="null" var="endTimeGathering" />
      </c:when>
      <c:otherwise>
        <c:set value="1" var="endTimeGathering" />
      </c:otherwise>
    </c:choose>
    <input
      id="my_btn"
      type="button"
      onclick="endTimeGatheringCheck(${endTimeGathering},${notice.notice})"
    />
    <!-- ======= Header ======= -->
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->

    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fade-in">
        <div class="container">
          <h1>${groupInfo.gname}</h1>
          <p>${groupInfo.rdate }</p>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Cource Details Section ======= -->
      <section id="course-details" class="course-details">
        <div class="container" data-aos="fade-up">
          <!-- ???????????? ?????? ???????????? div (0415 ????????????)-->
          <div style="position: relative">
            <ul class="nav nav-tabs mb-3">
              <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="#">??????</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="javascript:galleryCheck()">?????????</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="javascript:groupMembercheck()"
                  >?????????</a
                >
              </li>
              <c:if
                test="${memInGroupCheck ne null || m.athur eq 0 || m.athur eq 1}"
              >
                <button
                  class="btn btn-outline-dark"
                  style="position: absolute; left: 93%"
                  onclick="javascript:groupChat()"
                >
                  ????????????
                </button>
              </c:if>
            </ul>
          </div>
          <div class="row">
            <div class="col-lg-8">
              <img
                src="/assets/img/groupImages/${groupInfo.fname}"
                width="856px"
                height="383px"
                alt=""
              />
              <h3>${groupInfo.gname}</h3>
              <p>${groupInfo.gintro}</p>
            </div>
            <div class="col-lg-4">
              <div
                class="course-info d-flex justify-content-between align-items-center"
              >
                <h5>?????????</h5>
                <p><a href="#">${groupMemberName.mname }</a></p>
              </div>

              <div
                class="course-info d-flex justify-content-between align-items-center"
              >
                <h5>??????</h5>
                <p>${groupInfo.gloc}</p>
              </div>

              <div
                class="course-info d-flex justify-content-between align-items-center"
              >
                <h5>?????????</h5>
                <p>${groupInfo.interest}</p>
              </div>

              <div
                class="course-info d-flex justify-content-between align-items-center"
              >
                <h5>??????</h5>
                <p>${groupMemberCount}/${groupInfo.limit}</p>
              </div>
              <!-- ???????????? ??????-->
              <c:if test="${memInGroupCheck ne null || m.athur eq 0 || m.athur eq 1}">
                <div class="accordion acoordion-flush" id="accordionExample">
                  <div class="accordion-item">
                    <h2 class="accordion-header" id="headingOne">
                      <button
                        class="accordion-button collapsed"
                        type="button"
                        data-bs-toggle="collapse"
                        data-bs-target="#collapseOne"
                        aria-expanded="true"
                        aria-controls="collapseOne"
                      >
                        ????????????(${gatheringCountInGroup}/5)
                      </button>
                    </h2>
                    <div
                      id="collapseOne"
                      class="accordion-collapse collapse"
                      aria-labelledby="headingOne"
                      data-bs-parent="#accordionExample"
                    >
                      <c:forEach items="${gatheringList}" var="gathering">
                        <div class="accordion-body">
                          <a href="../gathering/gatheringInfo.do?ga_seq=${gathering.ga_seq}&mnum=${m.mnum}"
                            >${gathering.ga_name}</a>
                        </div>
                      </c:forEach>
                    </div>
                  </div>
                </div>
              </c:if>
              <!--???????????? ???-->
              <div class="d-grid gap-2 mt-3 mb-3">
                <c:if
                  test="${memInGroupCheck ne null || m.athur eq 0 || m.athur eq 1}"
                >
                  <button
                    type="button"
                    class="btn btn-outline-success"
                    onclick="location.href='javascript:gatheringCreateCheck()'"
                  >
                    ???????????????
                  </button>
                </c:if>
                <button
                  type="button"
                  class="btn btn-outline-secondary"
                  onclick="location.href='javascript:groupUpdateCheck()'"
                >
                  ?????? ????????????
                </button>
                <button
                  type="button"
                  class="btn btn-outline-danger"
                  onclick="location.href='javascript:groupDeleteCheck()'"
                >
                  ?????? ????????????
                </button>
                <c:choose>
                  <c:when test="${memInGroupCheck eq null}">
                    <button
                      type="button"
                      class="btn btn-outline-primary"
                      onclick="location.href='javascript:groupJoin()'"
                    >
                      ?????? ????????????
                    </button>
                  </c:when>
                  <c:otherwise>
                    <button
                      type="button"
                      class="btn btn-outline-dark"
                      onclick="location.href='javascript:groupQuit()'"
                    >
                      ?????? ????????????
                    </button>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- End Cource Details Section -->

      <!-- ======= Cource Details Tabs Section ======= -->
      <section id="cource-details-tabs" class="cource-details-tabs">
        <div class="container" data-aos="fade-up">
          <div class="row">
            <div class="col-lg-3" style="overflow: auto; height: 250px">
              <h3>?????? ??????</h3>
              <ul class="nav nav-tabs flex-column">
                <c:forEach
                  var="memInGroupName"
                  items="${memInGroupName}"
                  varStatus="index"
                >
                  <c:choose>
                    <c:when test="${memInGroupName.GRADE eq 0}">
                      <c:set var="grade" value="?????????" />
                    </c:when>
                    <c:when test="${memInGroupName.GRADE eq 1}">
                      <c:set var="grade" value="?????????" />
                    </c:when>
                    <c:otherwise>
                      <c:set var="grade" value="" />
                    </c:otherwise>
                  </c:choose>
                  <li class="nav-item">
                    <a
                      class="nav-link"
                      data-bs-toggle="tab"
                      href="javascript:void(0);"
                      onclick="memberInfo(${index.index});"
                      >${memInGroupName.MNAME}&nbsp;&nbsp;&nbsp;${grade}</a
                    >
                  </li>
                </c:forEach>
              </ul>
            </div>
            <div class="col-lg-9 mt-4 mt-lg-0" id="memInfo">
              <div class="tab-content">
                <div class="tab-pane active show" id="tab-1">
                  <div class="row">
                    <div class="col-lg-8 details order-2 order-lg-1">
                      <h3>?????? ??????</h3>
                      <p><b>??????: </b>${memberInfo.mname}</p>
                      <p><b>????????????: </b>${memberInfo.birth}</p>
                      <p><b>?????????: </b>${memberInfo.maddr}</p>
                    </div>
                    <div class="col-lg-4 text-center order-1 order-lg-2"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- End Cource Details Tabs Section -->
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
