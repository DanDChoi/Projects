<%@ page contentType="text/html;charset=utf-8" %> <%@ taglib
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

    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet" />
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script
      type="text/javascript"
      language="javascript"
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"
    ></script>
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
    <!-- ======= Header ======= -->
    <jsp:include page="../header.jsp" flush="true" />
    <!-- End Header -->
    <main id="main">
      <!-- ======= Breadcrumbs ======= -->
      <div class="breadcrumbs" data-aos="fade-in">
        <div class="container">
          <h1>모임 수정하기</h1>
        </div>
      </div>

      <section
        class="h-100"
        style="background-color: #eee; box-sizing: content-box"
      >
        <div class="container h-100" data-aos="flip-down">
          <div
            class="row d-flex justify-content-center align-items-center h-100"
          >
            <div class="col-lg-12 col-xl-11">
              <div class="card text-black" style="border-radius: 25px">
                <div class="card-body p-md-5">
                  <div class="row justify-content-center">
                    <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">
                      <!--모임지역/이름/모임소개/관심사/정원/모임사진-->
                      <form
                        class="mx-1 mx-md-4"
                        method="post"
                        action="groupUpdate.do"
                        enctype="multipart/form-data"
                      >
                        <input
                          type="hidden"
                          id="gseq"
                          name="gseq"
                          value="${updateList.gseq}"
                        />
                        <div class="d-flex flex-row align-items-center mb-0">
                          <i class="bi bi-map fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-2">
                            <label class="form-label mb-0" for="form3Example1c"
                              >모임지역</label
                            >
                            <div class="col-md-4">
                              <select
                                id="selectGLoc"
                                class="form-select border-0 py-3"
                                name="gloc"
                                required
                              >
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

                        <div class="d-flex flex-row align-items-center mb-0">
                          <i class="bi bi-tag fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-2">
                            <label class="form-label mb-0" for="form3Example1c"
                              >모임이름</label
                            >
                            <input
                              type="text"
                              id="form3Example1c"
                              class="form-control"
                              name="gname"
                              value="${updateList.gname}"
                            />
                          </div>
                        </div>

                        <div class="d-flex flex-row align-items-center mb-0">
                          <i class="bi bi-chat-right-text fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-2">
                            <label class="form-label mb-0" for="form3Example4c"
                              >모임소개</label
                            >
                            <textarea
                              name="gintro"
                              placeholder="글을 작성해주세요"
                              maxlength="2000"
                              cols="53"
                              id="form3Example4c"
                              class="form-control"
                            >
${updateList.gintro}</textarea
                            >
                          </div>
                        </div>

                        <div class="d-flex flex-row align-items-center mb-0">
                          <i class="bi bi-star fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-2">
                            <label class="form-label mb-0" for="form3Example4cd"
                              >관심사</label
                            >
                            <input
                              type="text"
                              id="form3Example1c"
                              class="form-control"
                              name="interest"
                              value="${updateList.interest}"
                              readonly
                            />
                          </div>
                        </div>

                        <div class="d-flex flex-row align-items-center mb-0">
                          <i class="bi bi-people fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-2">
                            <label class="form-label mb-0" for="form3Example1c"
                              >정원</label
                            >
                            <input
                              type="number"
                              id="form3Example1c"
                              class="form-control"
                              name="limit"
                              min="2"
                              max="100"
                              placeholder="2~100"
                              value="${updateList.limit}"
                            />
                          </div>
                        </div>

                        <div class="d-flex flex-row align-items-center mb-0">
                          <i class="bi bi-card-image fa-lg me-3 fa-fw"></i>
                          <div class="form-outline flex-fill mb-2">
                            <label class="form-label mb-0" for="form3Example1c"
                              >모임대표사진</label
                            >
                            <input
                              type="file"
                              id="form3Example1c"
                              class="form-control"
                              name="uploadFile"
                              accept="image/*"
                              value="${updateList.fname}"
                              required
                            />
                          </div>
                        </div>

                        <div
                          class="d-flex justify-content-center mx-4 mb-3 mb-lg-4"
                        >
                          <button
                            type="submit"
                            class="btn btn-success"
                            style="margin-right: 30px"
                          >
                            수정
                          </button>
                          <button type="button" class="btn btn-secondary">
                            취소
                          </button>
                        </div>
                      </form>
                    </div>
                  </div>
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
