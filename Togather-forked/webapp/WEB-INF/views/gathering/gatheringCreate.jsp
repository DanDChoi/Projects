<%@ page contentType="text/html;charset=utf-8" session="true" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <!-- alert -->
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
    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet" />
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
    <script>
      window.onload = function () {
        today = new Date();
        today = today.toISOString().slice(0, 10);
        bir = document.getElementById("now_date");
        bir.value = today;
        bir.min = bir.value;

        document.getElementById("time").value = new Date(
          new Date().getTime() - new Date().getTimezoneOffset() * 60000
        )
          .toISOString()
          .slice(11, 16);
      };

      function Check() {
        today = new Date();
        today = today.toISOString().slice(0, 10);
        bir = document.getElementById("now_date");
        var mindate = bir.min; //여기까지 현재날짜

        var nowTime = new Date(
          new Date().getTime() - new Date().getTimezoneOffset() * 60000
        ).toISOString();
        var nowDateCheck = document.getElementById("now_date").value;
        var nowTimeCheck = nowDateCheck;
        nowTimeCheck += "T";
        nowTimeCheck += document.getElementById("time").value;

        if (bir.value < today) {
          Swal.fire({
            title: "날짜는 오늘 이후로만 가능합니다.",
            icon: "error",
          });
          return false;
        } else if (nowTimeCheck < nowTime) {
          Swal.fire({
            title: "시간은 현재시간 이후로만 가능합니다.",
            icon: "error",
          });
          return false;
        } else if (
          $("#ga_name").val() == "" ||
          $("#time").val() == "" ||
          $("#placeParent").val() == "" ||
          $("#now_date").val() == "" ||
          $("#price").val() == "" ||
          $("#ga_limit").val() == ""
        ) {
          Swal.fire({
            title: "모든 항목을 입력해주세요.",
            icon: "error",
          });
          return false;
        } else {
          f.submit();
        }
      }
    </script>
  </head>

  <body>
    <!-- ======= Header ======= -->
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->
    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fade-in">
        <div class="container">
          <h1>정모 만들기</h1>
        </div>
      </div>

      <section class="d-flex justify-content-center align-items-center">
        <div class="container py-5 h-100" data-aos="zoom-in">
          <div
            class="row d-flex justify-content-center align-items-center h-75"
            style="text-align: center"
          >
            <!--정모이름, 정모날짜, 정모장소, 정모시간, 회비, 정원-->
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
              <form
                name="f"
                action="gatheringCreate.do?gseq=${groupInfo.gseq}&mnum=${m.mnum}"
                method="post"
                autocomplete="off"
              >
                <div class="form-outline mb-4">
                  <input
                    id="ga_name"
                    type="text"
                    name="ga_name"
                    class="form-control form-control-lg"
                    placeholder="정모이름"
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    id="placeParent"
                    type="text"
                    name="ga_place"
                    class="form-control form-control-lg"
                    placeholder="장소"
                  /><button
                    style="float: right"
                    id="searchButton"
                    type="button"
                    class="btn btn-success"
                    onclick="searchMap()"
                  >
                    장소 검색하기
                  </button>
                </div>
                <div class="form-outline mb-4">
                  <input
                    id="time"
                    type="time"
                    name="time"
                    class="form-control form-control-lg"
                    placeholder="시간"
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    id="now_date"
                    type="date"
                    name="ga_date"
                    class="form-control form-control-lg"
                    placeholder="날짜"
                    max="2022-12-31"
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    id="price"
                    type="text"
                    name="price"
                    class="form-control form-control-lg"
                    placeholder="회비"
                  />
                </div>
                <div class="form-outline mb-4">
                  <input
                    id="ga_limit"
                    type="number"
                    name="ga_limit"
                    class="form-control form-control-lg"
                    min="2"
                    max="20"
                    placeholder="정원(2~20명)"
                  />
                </div>

                <button class="btn btn-success" type="button" onclick="Check()">
                  만들기
                </button>
                <button class="btn btn-secondary">취소</button>
              </form>
            </div>
          </div>
        </div>
      </section>
    </main>
    <!-- End #main -->

    <!-- ======= Footer ======= -->
    <jsp:include page="../footer.jsp" flush="true" />
    <!-- End Footer -->
    <input type="hidden" id="latitude2" name="latitude" value="" />
    <input type="hidden" id="longitude2" name="longitude" value="" />
    <input type="hidden" id="place" name="longitude" value="" />
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
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=11400a9267d93835389eb9255fcaad0b&libraries=services"
    ></script>
    <script>
      function searchMap() {
        navigator.geolocation.getCurrentPosition(function (pos) {
          var latitude = pos.coords.latitude;
          var longitude = pos.coords.longitude;
          $("#latitude2").val(latitude);
          $("#longitude2").val(longitude);
          //alert("현재 위치는 : " + latitude + ", "+ longitude);
          getAddr($("#latitude2").val(), $("#longitude2").val());
        });

        /*let lat = 33.450701;
    let lng = 126.570667;
    getAddr(lat,lng);*/
        function getAddr(lat, lng) {
          let geocoder = new kakao.maps.services.Geocoder();

          let coord = new kakao.maps.LatLng(lat, lng);
          let callback = function (result, status) {
            if (status === kakao.maps.services.Status.OK) {
              $("#place").val(result[0].address.region_3depth_name);
              let place = $("#place").val();

              window.name = "parentForm";
              openWin = window.open(
                "gatheringSearchMap.do?place=" + place,
                "gatheringSearchMap",
                "width=1000, height=530, top=100, left=100"
              );
            }
          };

          geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
        }
      }
    </script>
  </body>
</html>
