<%@ page contentType="text/html;charset=utf-8" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, minimum-scale=1.0"
    />
    <title>채팅방</title>
    <link rel="stylesheet" href="/css/main.css" />
    <script>
      function ready() {
        username = document.querySelector("#name").value.trim();

        if (username) {
          usernamePage.classList.add("hidden");
          chatPage.classList.remove("hidden");

          var socket = new SockJS("/ws");
          stompClient = Stomp.over(socket);

          stompClient.connect({}, onConnected, onError);
        }
        event.preventDefault();
      }
    </script>
  </head>
  <body onload="ready()">
    <div id="username-page">
      <div class="username-page-container">
        <h1 class="title">username을 입력하세요</h1>
        <form id="usernameForm" name="usernameForm">
          <div class="form-group">
            <input
              type="text"
              id="name"
              placeholder="Username"
              value="${m.mname}"
              autocomplete="off"
              class="form-control"
            />
          </div>
          <div class="form-group">
            <button type="submit" class="accent username-submit">
              채팅 시작하기
            </button>
          </div>
        </form>
      </div>
    </div>
    <input type="hidden" id="chatGseq" value="${gseq}" />
    <div id="chat-page" class="hidden">
      <div class="chat-container">
        <div class="chat-header">
          <h2>${gname} 채팅방</h2>
        </div>
        <div class="connecting">연결중...</div>
        <ul id="messageArea"></ul>
        <form id="messageForm" name="messageForm">
          <div class="form-group">
            <div class="input-group clearfix">
              <input
                type="text"
                id="message"
                placeholder="Type a message..."
                autocomplete="off"
                class="form-control"
              />
              <button type="submit" class="primary">보내기</button>
            </div>
          </div>
        </form>
      </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="/js/main.js"></script>
  </body>
</html>
