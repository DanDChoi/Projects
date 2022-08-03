<%@ page language="java" contentType="text/html; charset=utf-8"
import="java.util.*, team1.togather.domain.*"%> <%@ taglib prefix="c"
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
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
      function cancelWishList(e) {
        console.log($(e).val());
        var data = JSON.stringify({
          gseq: $(e).val(),
        });
        $.ajax({
          url: "../cancelWishList",
          type: "POST",
          dataType: "json",
          contentType: "application/json",
          data: data,
          success: function (result) {
            console.log("success!: " + result);
            $(e).parents(".col-lg-4").remove();
            $("#numberOfWish").text(result);
          },
          error: function (error) {
            console.log("failure!: " + error);
          },
        });
      }
    </script>
  </head>

  <body>
    <!-- ======= Header ======= -->
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->
    <main id="main" data-aos="fade-in">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs">
        <div class="container">
          <h1>내가 찜한 모임</h1>
          <p>현재 찜해둔 모임 목록입니다. 최대 8개 까지 저장 가능합니다.</p>
        </div>
      </div>
      <!-- End Breadcrumbs -->

      <!-- ======= Courses Section ======= -->
      <section id="courses" class="courses">
        <div class="container" data-aos="fade-up">
          <div class="row" data-aos="zoom-in" data-aos-delay="100">
            <c:forEach var="groupList" items="${groupList}" varStatus="status">
              <div class="col-lg-4 col-md-6 d-flex align-items-stretch mb-4">
                <div class="course-item">
                  <img
                    src="/assets/img/groupImages/${groupList.fname }"
                    width="414px"
                    height="275px"
                    alt="그룹사진"
                  />
                  <div class="course-content">
                    <div
                      class="d-flex justify-content-between align-items-center mb-3"
                    >
                      <h4>${groupList.interest}</h4>
                      <p class="price">${groupList.gloc}</p>
                    </div>

                    <h3>
                      <a
                        href="../groupTab/groupInfo.do?gseq=${groupList.gseq}&mnum=${m.mnum}"
                        >${groupList.gname}</a
                      >
                    </h3>
                    <div
                      style="height: 40px; overflow: auto; margin-bottom: 15px"
                    >
                      <p>${groupList.gintro}</p>
                    </div>
                    <div
                      class="d-flex justify-content-between align-items-center"
                    >
                      <div>
                        <p>
                          <i class="fa fa-map-marker-alt text-primary me-2"></i
                          >${groupList.gloc}
                        </p>
                      </div>
                      <div>
                        <button
                          onclick="cancelWishList(this)"
                          type="button"
                          class="btn btn-outline-danger mb-1"
                          value="${groupList.gseq }"
                        >
                          찜 취소
                        </button>
                      </div>
                    </div>
                    <div
                      class="trainer d-flex justify-content-between align-items-center"
                    >
                      <div class="trainer-profile d-flex align-items-center">
                        <h3><i class="bi bi-person-circle"></i></h3>
                        <span style="margin-bottom: 7px"
                          >${namelist[status.index].mname}</span
                        >
                      </div>
                      <div class="trainer-rank d-flex align-items-center">
                        <i class="bx bx-user"></i
                        >&nbsp;&nbsp;${groupMemberCount[status.index]}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
            <!-- End Course Item-->
          </div>
        </div>
      </section>
      <!-- End Courses Section -->
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
