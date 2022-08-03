<%@ page session="true" contentType="text/html; charset=utf-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>send</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" type="image/png" href="images/icons/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="/assets/css/util.css" />
    <link rel="stylesheet" type="text/css" href="/assets/css/main.css" />
    <!-- alert  -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <script
      type="text/javascript"
      language="javascript"
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"
    ></script>

    <script>
      function send() {
        $.ajax({
          url: "sendMessage.json",
          type: "POST",
          data: $("#form").serialize(),
          success: function (data) {
            console.log("#uploadCheck(data): " + data);
            swal({
              title: "전송 성공!",
              icon: "success",
              button: {
                text: "확인",
                value: true,
              },
              closeOnClickOutside: false,
            }).then((result) => {
              if (result) {
                window.close();
              }
            });
          },
          error: function (error) {
            console.log("##error: " + error);
          },
        });
      }
      function pass() {
        close();
      }
    </script>
  </head>
  <body>
    <div class="limiter">
      <div class="container-login100">
        <div class="wrap-login100">
          <form class="mx-1 mx-md-4" id="form" name="f" autocomplete="off">
            <input
              type="hidden"
              name="from_mnum"
              value="${message.from_mnum}"
            />
            <input type="hidden" name="gseq" value="${gseq}" />
            <input type="hidden" name="to_mnum" value="${m.mnum}" />
            <input type="hidden" name="to_mname" value="${m.mname}" />
            <input
              type="hidden"
              name="from_mname"
              value="${message.from_mname}"
            />
            <span class="login100-form-title p-b-26"> 쪽지보내기 </span>

            <div
              class="wrap-input100 validate-input"
              data-validate="Valid email is: a@b.c"
            >
              <label class="form-label mb-0" for="form3Example1c"
                >보내는 사람</label
              >
              <input
                type="text"
                name="to_mname"
                class="input100"
                value="${m.mname}"
                disabled
              />
            </div>

            <div
              class="wrap-input100 validate-input"
              data-validate="Valid email is: a@b.c"
            >
              <label class="form-label mb-0" for="form3Example1c"
                >받는사람</label
              >
              <input
                type="text"
                name="from_mname"
                class="input100"
                value="${message.from_mname}"
                disabled
              />
            </div>

            <div
              class="wrap-input100 validate-input"
              data-validate="Valid email is: a@b.c"
            >
              <input
                type="text"
                name="metitle"
                class="input100"
                value=""
                required
              />
              <span class="focus-input100" data-placeholder="메세지제목"></span>
            </div>

            <div class="wrap-input100 validate-input">
              <textarea
                type="text"
                name="mecontent"
                class="input100"
                value=""
                required
              ></textarea>
              <span class="focus-input100" data-placeholder="메세지내용"></span>
            </div>

            <div class="container-login100-form-btn">
              <div class="wrap-login100-form-btn">
                <div class="login100-form-bgbtn"></div>
                <button
                  type="button"
                  class="login100-form-btn"
                  onclick="javascript:send()"
                >
                  쪽지보내기
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>

    <div id="dropDownSelect1"></div>
    <script src="/js/main2.js"></script>
  </body>
</html>
