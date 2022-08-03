package team1.togather.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import team1.togather.domain.ChatMessage;

@Controller
public class ChatController {

  @MessageMapping("/chat.sendMessage/{gseq}")
  @SendTo("/topic/public/{gseq}")
  public ChatMessage sendMessage(@Payload ChatMessage chatMessage) {
    return chatMessage;
  }

  @MessageMapping("/chat.addUser/{gseq}")
  @SendTo("/topic/public/{gseq}")
  public ChatMessage addUser(
    @Payload ChatMessage chatMessage,
    SimpMessageHeaderAccessor headerAccessor
  ) {
    headerAccessor
      .getSessionAttributes()
      .put("username", chatMessage.getSender());
    headerAccessor.getSessionAttributes().put("gseq", chatMessage.getGseq());
    return chatMessage;
  }
}
