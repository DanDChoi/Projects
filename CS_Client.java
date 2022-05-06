import java.io.*;
import java.net.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.border.*;
import java.util.Random;
import javax.sound.sampled.*;

public class CS_Client extends JFrame implements ActionListener {
   JPanel CONTENT, panel_Main, panel_Chat, panel_Top, panel_Option, panel_Mine; // 지뢰찾기 패널
   JButton btn_Ready, btn_Exit, btn_GG, btn_BGM;// bgm까지 사용
   JLabel label_logo_CENTER, label_Timer, laClient1, laClient2, laClient3, laClient4, // 메인로고 타이머 케릭터사진
         label_Flag1, label_Flag2, label_Flag3, label_Flag4, label_leftover, label_rightclicks; // 주사기, 잔여
   Label laClient1sub, laClient2sub, laClient3sub, laClient4sub, // 케릭터 밑에 닉네임
         label_Flag1_syringe, label_Flag2_syringe, label_Flag3_syringe, label_Flag4_syringe; // 주사기맞춘갯수. ~차레입니다
   JTextField textField;
   JTextArea textArea;
   JScrollPane scrollPane;

   // 문제 탑로고
   int port = 7777;
   String playerName, playerScore, playerIdx; // 클라이언트 이름, 점수, 인덱스 관리
   boolean gameStart, auth; // 게임 시작 상태 체크 & 출제자 권한 변수
   Score2 scorelast;

   // 2021-12-14 추가 노래 재생 여부 변수
   boolean playing = false; // 노래가 재생여부 확인
   File file = new File("bgm\\Search.wav");
   AudioInputStream audioStream;
   Clip clip;
   ImageIcon iOn = new ImageIcon("image\\bgmOn.png"); // 버튼에 넣을 이미지아이콘 생성
   ImageIcon iStop = new ImageIcon("image\\bgmOff.png");

   int vScore;// 클라이언트 점수 _211214 추가
   /*------------------------------------------- 지뢰 관련 멤버변수 -------------------------------------- */
   int rows = 15;
   int cols = 15;
   int mines = 50; // 지뢰 수
   int score = 0;// 점수
   int tot = 0; // 주변의 지뢰개수 숫자 표시
   int leftMines = mines; // 잔여 지뢰개수

   Cell userField[][] = new Cell[15][15]; // 사용자에게 표시되는 필드
   Cell gameField[][] = new Cell[15][15]; // 사용자가 볼 수 없는 정답필드

   Cell selected; // 선택한 셀 참조용

   int clickChance = 30;// 클릭할 수 있는 기회는 30번
   int leftClick;// 잔여클릭횟수 30개
   int myClick = 0; // 내가 클릭한 횟수
   int findMines = 0; // 찾은 마인(지뢰) 수

   public CS_Client() {
      // 기본 GUI 설정
      setFont(new Font("나눔바른고딕", Font.PLAIN, 13));
      setVisible(true);
      setResizable(false);
      setTitle("JAVA Client"); // 파일이름
      setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      setBounds(100, 100, 1280, 720);
      setLocationRelativeTo(null); // 창 정가운데 띄우기

      // 베이스 패널
      CONTENT = new JPanel();
      CONTENT.setBorder(null);
      setContentPane(CONTENT);
      CONTENT.setLayout(new BoxLayout(CONTENT, BoxLayout.X_AXIS)); // axis는 정렬방법 좌>>우로 배치

      panel_Main = new JPanel();
      panel_Main.setFont(new Font("나눔바른고딕", Font.PLAIN, 13));
      panel_Main.setBackground(new Color(255, 255, 255));
      CONTENT.add(panel_Main);
      panel_Main.setLayout(null);

      // 참여자 목록 영역
      JPanel panelCList = new JPanel();
      JLabel label_ClientList = new JLabel(new ImageIcon("image\\user.png"));
      JLabel label_ClientList1 = new JLabel(new ImageIcon("image\\user.png"));

      panelCList.setOpaque(false);
      label_ClientList.setOpaque(false);
      label_ClientList1.setOpaque(false);
      panelCList.setBorder(new LineBorder(new Color(255, 164, 38), 2, true)); // setborder 직선보더,컬러굵기
      panelCList.setBounds(10, 105, 300, 500);
      label_ClientList.setBounds(-65, 105, 312, 500);
      label_ClientList1.setBounds(75, 105, 312, 500);
      panel_Main.add(panelCList);
      panel_Main.add(label_ClientList);
      panel_Main.add(label_ClientList1);
      panelCList.setLayout(null);

      // 참여자 영역
      laClient1 = new JLabel(new ImageIcon("image\\waiting.png"));
      laClient1.setBackground(Color.GRAY);
      laClient1.setBounds(21, 15, 120, 80);
      panelCList.add(laClient1);

      laClient1sub = new Label("[ 닉네임 ]");
      laClient1sub.setFont(new Font("나눔바른고딕", Font.BOLD, 13));
      laClient1sub.setAlignment(Label.CENTER);
      laClient1sub.setBackground(Color.WHITE);
      laClient1sub.setBounds(18, 95, 120, 30);
      panelCList.add(laClient1sub);

      laClient2 = new JLabel(new ImageIcon("image\\waiting.png"));
      laClient2.setBackground(Color.GRAY);
      laClient2.setBounds(21, 135, 120, 80);
      panelCList.add(laClient2);

      laClient2sub = new Label("[ 닉네임 ]");
      laClient2sub.setFont(new Font("나눔바른고딕", Font.BOLD, 13));
      laClient2sub.setAlignment(Label.CENTER);
      laClient2sub.setBackground(Color.WHITE);
      laClient2sub.setBounds(18, 215, 120, 30);
      panelCList.add(laClient2sub);

      laClient3 = new JLabel(new ImageIcon("image\\waiting.png"));
      laClient3.setBackground(Color.GRAY);
      laClient3.setBounds(21, 255, 120, 80);
      panelCList.add(laClient3);

      laClient3sub = new Label("[ 닉네임 ]");
      laClient3sub.setFont(new Font("나눔바른고딕", Font.BOLD, 13));
      laClient3sub.setAlignment(Label.CENTER);
      laClient3sub.setBackground(Color.WHITE);
      laClient3sub.setBounds(18, 335, 120, 30);
      panelCList.add(laClient3sub);

      laClient4 = new JLabel(new ImageIcon("image\\waiting.png"));
      laClient4.setBackground(Color.GRAY);
      laClient4.setBounds(21, 375, 120, 80);
      panelCList.add(laClient4);

      laClient4sub = new Label("[ 닉네임 ]");
      laClient4sub.setFont(new Font("나눔바른고딕", Font.BOLD, 13));
      laClient4sub.setAlignment(Label.CENTER);
      laClient4sub.setBackground(Color.WHITE);
      laClient4sub.setBounds(18, 455, 120, 30);
      panelCList.add(laClient4sub);

      // 주사기그림& 맞춘갯수 영역 (주사기 그림 아래 위치)
      label_Flag1 = new JLabel(new ImageIcon("image\\S.jpg"));
      label_Flag1.setBackground(Color.GRAY);
      label_Flag1.setBounds(160, 15, 120, 80);
      panelCList.add(label_Flag1);

      label_Flag1_syringe = new Label(" ");
      label_Flag1_syringe.setFont(new Font("나눔바른고딕", Font.BOLD, 13));
      label_Flag1_syringe.setAlignment(Label.CENTER);
      label_Flag1_syringe.setBackground(Color.WHITE);
      label_Flag1_syringe.setBounds(160, 95, 120, 30);
      panelCList.add(label_Flag1_syringe);

      label_Flag2 = new JLabel(new ImageIcon("image\\S.jpg"));
      label_Flag2.setBackground(Color.GRAY);
      label_Flag2.setBounds(160, 135, 120, 80);
      panelCList.add(label_Flag2);

      label_Flag2_syringe = new Label(" ");
      label_Flag2_syringe.setFont(new Font("나눔바른고딕", Font.BOLD, 13));
      label_Flag2_syringe.setAlignment(Label.CENTER);
      label_Flag2_syringe.setBackground(Color.WHITE);
      label_Flag2_syringe.setBounds(160, 215, 120, 30);
      panelCList.add(label_Flag2_syringe);

      label_Flag3 = new JLabel(new ImageIcon("image\\S.jpg"));
      label_Flag3.setBackground(Color.GRAY);
      label_Flag3.setBounds(160, 250, 120, 80);
      panelCList.add(label_Flag3);

      label_Flag3_syringe = new Label(" ");
      label_Flag3_syringe.setFont(new Font("나눔바른고딕", Font.BOLD, 13));
      label_Flag3_syringe.setAlignment(Label.CENTER);
      label_Flag3_syringe.setBackground(Color.WHITE);
      label_Flag3_syringe.setBounds(160, 335, 120, 30);
      panelCList.add(label_Flag3_syringe);

      label_Flag4 = new JLabel(new ImageIcon("image\\S.jpg"));
      label_Flag4.setBackground(Color.GRAY);
      label_Flag4.setBounds(160, 375, 120, 80);
      panelCList.add(label_Flag4);

      label_Flag4_syringe = new Label(" ");
      label_Flag4_syringe.setFont(new Font("나눔바른고딕", Font.BOLD, 13));
      label_Flag4_syringe.setAlignment(Label.CENTER);
      label_Flag4_syringe.setBackground(Color.WHITE);
      label_Flag4_syringe.setBounds(160, 455, 120, 30);
      panelCList.add(label_Flag4_syringe);

      // 상단패널
      panel_Top = new JPanel();
      panel_Top.setBounds(10, 10, 1245, 85);
      panel_Main.add(panel_Top);
      panel_Top.setLayout(null);

      JLabel Top_Background = new JLabel(new ImageIcon("image\\topbg.png")); // top Background
      Top_Background.setOpaque(true);// 배경색 설정
      Top_Background.setBounds(0, 0, 1245, 85);
      panel_Top.add(Top_Background);
      panel_Top.setLayout(null);

      label_logo_CENTER = new JLabel(new ImageIcon("image\\toplogo.png")); // logo covid sweepers
      label_logo_CENTER.setOpaque(false);
      label_logo_CENTER.setBounds(300, 10, 700, 85);
      Top_Background.add(label_logo_CENTER);

      // 우상단 버튼 영역
      btn_Ready = new JButton(new ImageIcon("image\\ready1.png"));
      btn_Ready.setPressedIcon(new ImageIcon("image\\readyd.png"));
      btn_Ready.setFocusPainted(false);
      btn_Ready.setBorderPainted(false);
      btn_Ready.setContentAreaFilled(false);
      btn_Ready.setBounds(991, 11, 115, 65);
      Top_Background.add(btn_Ready);
      btn_Ready.addActionListener(this);

      btn_Exit = new JButton(new ImageIcon("image\\close1.png"));
      btn_Exit.setPressedIcon(new ImageIcon("image\\closed.png"));
      btn_Exit.setFocusPainted(false);
      btn_Exit.setBorderPainted(false);
      btn_Exit.setContentAreaFilled(false);
      btn_Exit.setBounds(1118, 11, 115, 65);
      Top_Background.add(btn_Exit);
      btn_Exit.addActionListener(this);

      // 잔여 바이러스 수
      JLabel label_logo_left = new JLabel(new ImageIcon("image\\leftover.png"));
      label_logo_left.setOpaque(false);
      label_logo_left.setBorder(null);
      label_logo_left.setBounds(10, 10, 120, 65);
      label_leftover = new JLabel("N"); // 바이러스 수
      label_leftover.setHorizontalTextPosition(SwingConstants.CENTER);
      label_leftover.setHorizontalAlignment(SwingConstants.CENTER);
      label_leftover.setFont(new Font("나눔바른고딕", Font.PLAIN, 30));
      label_leftover.setForeground(Color.BLACK);
      label_leftover.setBounds(10, 10, 120, 65);
      Top_Background.add(label_leftover);
      Top_Background.add(label_logo_left);

      // 잔여 클릭 수
      JLabel label_logo_right = new JLabel(new ImageIcon("image\\leftover1.png"));
      label_logo_right.setOpaque(false);
      label_logo_right.setBorder(null);
      label_logo_right.setBounds(170, 10, 120, 65);
      label_rightclicks = new JLabel("N"); // 잔여 바이러스 수
      label_rightclicks.setHorizontalTextPosition(SwingConstants.CENTER);
      label_rightclicks.setHorizontalAlignment(SwingConstants.CENTER);
      label_rightclicks.setFont(new Font("나눔바른고딕", Font.PLAIN, 30));
      label_rightclicks.setForeground(Color.BLACK);
      label_rightclicks.setBounds(170, 10, 120, 65);
      Top_Background.add(label_rightclicks);
      Top_Background.add(label_logo_right);

      // 채팅 영역
      panel_Chat = new JPanel();
      panel_Chat.setBounds(992, 105, 263, 567);
      panel_Main.add(panel_Chat);
      panel_Chat.setLayout(null);

      scrollPane = new JScrollPane(textArea);
      scrollPane.setFont(new Font("나눔바른고딕", Font.PLAIN, 13));
      scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
      scrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
      scrollPane.setBounds(0, 0, 263, 535);
      panel_Chat.add(scrollPane);

      textArea = new JTextArea();
      textArea.setBorder(new LineBorder(new Color(255, 164, 38), 2, true));
      textArea.setFont(new Font("나눔바른고딕", Font.PLAIN, 13));
      textArea.setEditable(false);
      textArea.setLineWrap(true);
      scrollPane.setViewportView(textArea);
      textArea.setBackground(Color.WHITE);

      textField = new JTextField();
      textField.setBorder(new LineBorder(new Color(0, 0, 0), 2, true));
      textField.setBackground(Color.WHITE);
      textField.setBounds(0, 537, 263, 30);
      panel_Chat.add(textField);
      textField.setColumns(10);

      /*---2021-12-13 지뢰판 15*15 수정, 지뢰판 위치와 크기 수정---*/
      panel_Mine = new JPanel(new GridLayout(15, 15)); // 지뢰판 15*15
      panel_Mine.setBounds(345, 105, 575, 575);
      panel_Main.add(panel_Mine);
      prepareField(); // 지뢰찾기 게임필드를 초기화 하는 메소드 호출

      // 좌측하단부분 (타이머, BGM버튼)
      panel_Option = new JPanel();
      panel_Option.setOpaque(true);
      panel_Option.setBackground(Color.WHITE);
      panel_Option.setBounds(7, 615, 305, 57);
      panel_Main.add(panel_Option);
      panel_Option.setLayout(null);

      JLabel label_Timer_Back = new JLabel(new ImageIcon("image\\time.png"));
      label_Timer_Back.setOpaque(true);
      label_Timer = new JLabel("00 : 30");
      label_Timer.setHorizontalTextPosition(SwingConstants.CENTER);
      label_Timer.setHorizontalAlignment(SwingConstants.CENTER);
      label_Timer.setFont(new Font("나눔바른고딕", Font.PLAIN, 24));
      label_Timer.setForeground(Color.black);
      label_Timer_Back.setBounds(0, 0, 158, 57);
      label_Timer.setBounds(0, 10, 158, 57);
      panel_Option.add(label_Timer_Back);
      label_Timer_Back.add(label_Timer);

      btn_BGM = new JButton(new ImageIcon("image\\bgmOn.png"));
      btn_BGM.setFocusPainted(false);
      btn_BGM.setBorderPainted(false);
      btn_BGM.setContentAreaFilled(false);
      btn_BGM.setBounds(155, 0, 152, 57);
      btn_BGM.addActionListener(this); // BGM 버튼 액션리스너 추가
      panel_Option.add(btn_BGM);

      startChat();
   }

   public void startChat() {
      String nickName = CS_Login.nickName;
      String ip = CS_Login.ip;

      try {
         Socket s = new Socket(ip, port);
         Sender sender = new Sender(s, nickName);
         Listener listener = new Listener(s);

         new Thread(sender).start();
         new Thread(listener).start();

         // 이벤트 추가
         textField.addKeyListener(new Sender(s, nickName));
         btn_Ready.addActionListener(new Sender(s, nickName));

      } catch (UnknownHostException uh) {
         JOptionPane.showMessageDialog(null, "호스트를 찾을 수 없습니다!", "ERROR", JOptionPane.WARNING_MESSAGE);
      } catch (IOException io) {
         JOptionPane.showMessageDialog(null, "서버 접속 실패!\n서버가 닫혀 있는 것 같습니다.", "ERROR", JOptionPane.WARNING_MESSAGE);
         System.exit(0);
      }

   }

   // 내부 클래스 송신
   class Sender extends Thread implements KeyListener, ActionListener {
      DataOutputStream dos;
      Socket s;
      String nickName;
      String score;

      Sender(Socket s, String nickName) {
         this.s = s;
         try {
            dos = new DataOutputStream(this.s.getOutputStream());
            this.nickName = nickName;

         } catch (IOException io) {
         }
      }

      public void run() {
         try {
            dos.writeUTF(nickName);
         } catch (IOException io) {
         }
      }

      // Ready 버튼 이벤트 발생
      public void actionPerformed(ActionEvent e) {
         if (e.getSource() == btn_Ready) { // '준비' 버튼
            try {
               dos.writeUTF("//Chat " + "[ " + nickName + " 님 준비 완료 ! ]");
               dos.flush();
               dos.writeUTF("//Ready");
               dos.flush();
               btn_Ready.setEnabled(false);
            } catch (IOException io) {
            }
         }
      }

      // 채팅 입력
      public void keyReleased(KeyEvent e) {
         if (e.getKeyCode() == KeyEvent.VK_ENTER) {
            String chat = textField.getText();
            textField.setText("");
            try {
               dos.writeUTF("//Chat " + nickName + " : " + chat);
               dos.flush();
            } catch (IOException io) {
            }
         }
      }

      public void keyTyped(KeyEvent e) {
      }

      public void keyPressed(KeyEvent e) {
      }

   }

   // 내부 클래스 - 수신
   class Listener extends Thread {
      Socket s;
      DataInputStream dis;
      DataOutputStream dos;

      Listener(Socket s) {
         this.s = s;
         try {
            dis = new DataInputStream(this.s.getInputStream());
            dos = new DataOutputStream(this.s.getOutputStream());
         } catch (IOException io) {
         }
      }

      public void run() {
         while (dis != null) {
            try {
               String msg = dis.readUTF();
               if (msg.startsWith("//CList")) { // 명령어 : 클라이언트 목록 갱신
                  playerName = msg.substring(7, msg.indexOf(" "));
                  playerScore = msg.substring(msg.indexOf(" "), msg.indexOf("#"));
                  playerIdx = msg.substring(msg.indexOf("#") + 1);
                  updateClientList(); // 클라이언트 목록 갱신
               } else if (msg.startsWith("//Start")) { // 명령어 : 게임 시작 ( + 타이머)
                  try {
                     UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
                  } catch (Exception e) {
                     System.out.println(e);
                  }

                  prepareField();
                  leftMines = mines;
                  myClick = 0;// 마인초기화
                  findMines = 0;
                  start1();
                  gameStart = true;
               } else if (msg.equals("//GmGG ")) { // 명령어 : 출제자 게임 포기
                  gameStart = false;
                  auth = false;
                  textField.setEnabled(true);
                  btn_Ready.setEnabled(true);
               } else if (msg.equals("//GmEnd")) { // 명령어 : 게임 종료
                  vicc(); // vScore 값 호출
                  if (myClick > 0) {
                     myClick = 0;
                     leftClick = 0;
                     findMines = 0;
                  }
                  showFullField();
                  gameStart = false;
                  auth = false;
                  textField.setEnabled(true);
                  btn_Ready.setEnabled(true);
                  label_Timer.setText("00 : 00");
                  scorelast = new Score2(s, CS_Login.nickName);
                  dos.writeUTF("//GmEnd");
                  dos.flush();
               } else if (msg.equals("//Score")) {
               } else if (msg.startsWith("//Mouse")) {
                  if (auth == false) {
                     int tempX = Integer.parseInt(msg.substring(7, msg.indexOf(".")));
                     int tempY = Integer.parseInt(msg.substring(msg.indexOf(".") + 1));
                  }
               } else if (msg.startsWith("//Timer")) { // 명령어 : 타이머 시간 표시
                  label_Timer.setText(msg.substring(7));
               } else { // 일반 채팅 출력
                  textArea.append(msg + "\n");
                  scrollPane.getVerticalScrollBar().setValue(scrollPane.getVerticalScrollBar().getMaximum());
               }
            } catch (IOException io) {
            }
         }

      }
   } // 내부의 내부 클래스 종료

   // 내부 클래스 score2 송신
   class Score2 // extends Thread
   {
      Socket s;
      DataOutputStream dos;
      String Nick = CS_Login.nickName;// 클라이언트에 데이터를 뿌리기 위해 사용

      Score2(Socket s, String Nick) {
         this.s = s;
         this.Nick = Nick;
         try {
            dos = new DataOutputStream(this.s.getOutputStream()); // 다른 클라이언트가 출력한 값 출력하기
            String score = Integer.toString(vScore);
            String score1 = ("//score" + score + " " + Nick);
            dos.writeUTF(score1);
         } catch (IOException io) {
         }
      }
   }

   // 내부 클래스 score2 받기
   class Score2Listener // extends Thread
   {
      Socket s;
      DataInputStream dis;

      Score2Listener(Socket s) {
         this.s = s;
         try {
            dis = new DataInputStream(this.s.getInputStream());
            while (dis != null) {
               String msg = dis.readUTF();
               textArea.append(msg + "\n");

            }
         } catch (IOException io) {
         }
      }
   }

   // 클라이언트 목록 추가
   public void updateClientList() {
      ImageIcon ii, sy;
      if (Integer.parseInt(playerIdx) == 0) {
         ii = new ImageIcon("image\\RC.png");
         ii.getImage().flush();
         laClient1.setIcon(ii);
         laClient1sub.setText("[" + playerName + "]");

         sy = new ImageIcon("image\\RS.jpg");
         sy.getImage().flush();
         label_Flag1.setIcon(sy);
         deleteClientList();
      } else if (Integer.parseInt(playerIdx) == 1) {
         ii = new ImageIcon("image\\PC.png");
         ii.getImage().flush();
         laClient2.setIcon(ii);
         laClient2sub.setText("[" + playerName + "]");

         sy = new ImageIcon("image\\PS.jpg");
         sy.getImage().flush();
         label_Flag2.setIcon(sy);
         deleteClientList();
      } else if (Integer.parseInt(playerIdx) == 2) {
         ii = new ImageIcon("image\\BC.png");
         ii.getImage().flush();
         laClient3.setIcon(ii);
         laClient3sub.setText("[" + playerName + "]");

         sy = new ImageIcon("image\\BS.jpg");
         sy.getImage().flush();
         label_Flag3.setIcon(sy);
         deleteClientList();
      } else if (Integer.parseInt(playerIdx) == 3) {
         ii = new ImageIcon("image\\YC.png");
         ii.getImage().flush();
         laClient4.setIcon(ii);
         laClient4sub.setText("[" + playerName + "]");

         sy = new ImageIcon("image\\YS.jpg");
         sy.getImage().flush();
         label_Flag4.setIcon(sy);
         deleteClientList();
      }
   }

   // 클라이언트 목록 제거
   public void deleteClientList() {
      ImageIcon ii2, sy2;
      ii2 = new ImageIcon("image\\p0.png");
      sy2 = new ImageIcon("image\\S.jpg");
      if (Integer.parseInt(playerIdx) == 0) {
         laClient2.setIcon(ii2);
         laClient2sub.setText("[ 닉네임 ]");
         laClient3.setIcon(ii2);
         laClient3sub.setText("[ 닉네임 ]");
         laClient4.setIcon(ii2);
         laClient4sub.setText("[ 닉네임 ]");
         label_Flag2.setIcon(sy2);
         label_Flag3.setIcon(sy2);
         label_Flag4.setIcon(sy2);
      } else if (Integer.parseInt(playerIdx) == 1) {
         laClient3.setIcon(ii2);
         laClient3sub.setText("[ 닉네임 ]");
         laClient4.setIcon(ii2);
         laClient4sub.setText("[ 닉네임 ]");
         label_Flag3.setIcon(sy2);
         label_Flag4.setIcon(sy2);
      } else if (Integer.parseInt(playerIdx) == 2) {
         laClient4.setIcon(ii2);
         laClient4sub.setText("[ 닉네임 ]");
         label_Flag4.setIcon(sy2);
      }
   }

   /*-------------------------------------------20211214 브금 메소드-------------------------------------- */
   public void playBGM(File file) throws UnsupportedAudioFileException, IOException, LineUnavailableException {

      this.file = file;
      audioStream = AudioSystem.getAudioInputStream(file);
      clip = AudioSystem.getClip();
      clip.open(audioStream);
      clip.start();
   }

   public void muteBGM(File file) {
      clip.stop();
      clip.close();
   }

   /*------------------------------------------- 지뢰 부분 시작 -------------------------------------- */
   public void start1() {
      for (int i = 0; i < rows; i++) {
         for (int j = 0; j < cols; j++) {
            userField[i][j].setEnabled(true);
         }
      }
   }// end for start();

   void initFields() {
      panel_Mine.removeAll(); // 지뢰찾기 게임이 올라가는 패널 내용 초기화
      for (int i = 0; i < rows; i++) {
         for (int j = 0; j < cols; j++) {
            // Cell 타입으로 게임필드, 유저필드 생성
            gameField[i][j] = new Cell();
            userField[i][j] = new Cell();
            /*---2021-12-13 폰트 크기 설정, 버튼 배경색 주황색 지정---*/
            gameField[i][j].setFont(new Font("나눔바른고딕", Font.PLAIN, 10));
            userField[i][j].setFont(new Font("나눔바른고딕", Font.PLAIN, 10));
            userField[i][j].setBackground(new Color(255, 196, 116));

            panel_Mine.add(userField[i][j]); // 사용자 필드만 화면에 보이게 패널에 올림
            userField[i][j].addActionListener(this);
            userField[i][j].setEnabled(false);
         } // end for j => 게임 정보 초기화

         score = 0; // 총 지뢰개수 초기화
         label_leftover.setText(Integer.toString(mines));
         label_rightclicks.setText(Integer.toString(clickChance)); // 첫 잔여 클릭횟수는 30개
         panel_Mine.validate();
      } // end for i
   }// end of initFields()

   private void showFullField() {
      for (int row = 0; row < rows; row++) {
         for (int col = 0; col < cols; col++) {
            if (!userField[row][col].isClicked()) {
               userField[row][col].setType(gameField[row][col].getType());
               userField[row][col].setValue(gameField[row][col].getValue());
               userField[row][col].setClicked(true);
               gameField[row][col].setClicked(true);
               if (userField[row][col].getType() == 'm') {
                  /*---2021-12-13 [정답 폭탄 배경색 : 회색, 경계선: 검정색]--*/
                  userField[row][col].setBackground(new Color(127, 127, 127));// 폭탄 정답은 회색
                  LineBorder bb = new LineBorder(new Color(0, 0, 0));// 폭탄은 경계선 검정색주기
                  ImageIcon icon = new ImageIcon("image\\virus.png");
                  Image img = icon.getImage();
                  Image changeImg = img.getScaledInstance(30, 30, Image.SCALE_SMOOTH);
                  ImageIcon changeIcon = new ImageIcon(changeImg);
                  userField[row][col].setIcon(changeIcon);
               } else if (userField[row][col].getType() == 'e') {
                  /*---2021-12-13 [공란  배경색 : 흰색], 폰트 크기 설정--*/
                  userField[row][col].setFont(new Font("나눔바른고딕", Font.PLAIN, 10));
                  userField[row][col].setBackground(new Color(255, 255, 255));// 정답은 흰색
                  userField[row][col].setText("");
               } else if (userField[row][col].getType() == 'f') {
                  /*---2021-12-13 [공란  배경색 : 흰색], 폰트 크기 설정--*/
                  userField[row][col].setFont(new Font("나눔바른고딕", Font.PLAIN, 10));
                  userField[row][col].setText("B");
               } else {
                  /*---2021-12-13 [공란  배경색 : 흰색], 폰트 크기 설정--*/
                  userField[row][col].setBackground(new Color(255, 255, 255));// 정답은 흰색
                  userField[row][col].setText(String.valueOf(gameField[row][col].getValue()));
               }
               userField[row][col].setEnabled(false);
            }
         }
      }
   }

   int isAMine(int row, int col) {
      if (row < rows && col < cols && col >= 0 && row >= 0) {
         if (gameField[row][col].getType() == 'm') {
            return 1;
         }
         return 0;
      } // end of if-유효범위내
      return 0;
   }

   int nearMines(int row, int col) {
      int tot = 0;
      if (row < rows && col < cols && col >= 0 && row >= 0) {
         tot += isAMine(row - 1, col);
         tot += isAMine(row - 1, col - 1);
         tot += isAMine(row + 1, col);
         tot += isAMine(row + 1, col - 1);
         tot += isAMine(row, col - 1);
         tot += isAMine(row, col + 1);
         tot += isAMine(row - 1, col + 1);
         tot += isAMine(row + 1, col + 1);
      }
      return tot;
   }// end of nearMines()

   /*---2021-12-13 지뢰개수 minse 만큼 지뢰 만들기--*/
   void prepareField() {
      int makemine = mines;// makemine=44
      int row, col;
      Random ran = new Random();
      initFields();
      while (makemine-- > 0) { // makemine 값이 0이 될때까지
         row = ran.nextInt(rows);
         col = ran.nextInt(cols);

         if (gameField[row][col].getType() == 'm') {// 이미 지뢰타입이라면
            makemine++; // makemine 수 증가해서 --> 지뢰수 미달 나지 않게 해줘야함
         }
         if (gameField[row][col].getType() != 'm') {// 지뢰가 아니라면
            gameField[row][col].setType('m'); // 지뢰 만들어
         }
      }
      ;

      for (int i = 0; i < rows; i++) {
         for (int j = 0; j < cols; j++) {
            if (gameField[i][j].getType() != 'm') {
               if (nearMines(i, j) != 0) {
                  gameField[i][j].setType('n');
                  gameField[i][j].setValue(nearMines(i, j));
               }
            }
         } // end for j
      } // end for i
   }// end for prepaerField

   void checkEmptyCell(int row, int col) {
      if (row < rows && col < cols && col >= 0 && row >= 0) {
         if (!gameField[row][col].isClicked() && !userField[row][col].isClicked()
               && gameField[row][col].getType() == 'e') {
            /*---2021-12-13 폰트 크기 설정--*/
            userField[row][col].setFont(new Font("나눔바른고딕", Font.PLAIN, 10));
            userField[row][col].setClicked(true);
            userField[row][col].setType('e');
            userField[row][col].setValue(' ');
            userField[row][col].setText("");
            userField[row][col].setEnabled(false);
            gameField[row][col].setClicked(true);
            checkEmptyCell(row - 1, col - 1);
            checkEmptyCell(row, col - 1);
            checkEmptyCell(row + 1, col - 1);
            checkEmptyCell(row - 1, col);
            checkEmptyCell(row + 1, col);
            checkEmptyCell(row - 1, col + 1);
            checkEmptyCell(row, col + 1);
            checkEmptyCell(row + 1, col + 1);

         } else if (gameField[row][col].getType() == 'n' && gameField[row][col].getValue() != 0
               && !gameField[row][col].isClicked() && !userField[row][col].isClicked()) {
            /*---2021-12-13 폰트 크기 설정--*/
            userField[row][col].setFont(new Font("나눔바른고딕", Font.PLAIN, 10));
            userField[row][col].setType(gameField[row][col].getType());
            userField[row][col].setValue(gameField[row][col].getValue());
            userField[row][col].setClicked(true);
            gameField[row][col].setClicked(true);
            userField[row][col].setText(String.valueOf(gameField[row][col].getValue()));
            userField[row][col].setEnabled(false);
         }
      }
   }// end of checkEmptyCell()

   @Override
   public void actionPerformed(ActionEvent e) {
      Object obj = (Object) e.getSource();
      if (e.getSource() == btn_Exit) {
         int select = JOptionPane.showConfirmDialog(null, "정말 게임을 종료하시겠습니까?", "Exit", JOptionPane.OK_CANCEL_OPTION);
         if (select == JOptionPane.YES_OPTION)
            System.exit(0);
      }
      if (obj == btn_Ready) {
         // start();
      }
      if (playing == true && obj == btn_BGM) {
         btn_BGM.setIcon(iOn);
         muteBGM(file);
         playing = false;
      } else if (playing == false && obj == btn_BGM) {
         btn_BGM.setIcon(iStop); // off 이미지
         try {
            playBGM(file);
         } catch (UnsupportedAudioFileException e1) {
         } catch (IOException e1) {
         } catch (LineUnavailableException e1) {
         }
         playing = true;
         System.out.println("노래 켰다");
      }

      for (int i = 0; i < rows; i++) {
         for (int j = 0; j < cols; j++) {
            if (obj == userField[i][j] && !userField[i][j].isClicked()) {
               selected = gameField[i][j];
               if (isAMine(i, j) == 1) { // 지뢰라면--211208 수정
                  // --2021-12-13 폰트 크기 설정--
                  selected.setClicked(true);
                  userField[i][j].setClicked(true);
                  userField[i][j].setValue(selected.getValue());
                  userField[i][j].setType('f');
                  ImageIcon icon = new ImageIcon("image\\RS.jpg");
                  Image shot = icon.getImage();
                  Image changeImg1 = shot.getScaledInstance(30, 30, Image.SCALE_SMOOTH);
                  ImageIcon changeIcon = new ImageIcon(changeImg1);
                  userField[i][j].setIcon(changeIcon);

                  // ---2021-12-13 [플래그 배경색 : 더 진한 주황색, 플래그 경계선: 더더 진한 주황색]--
                  userField[i][j].setBackground(new Color(255, 165, 45));// 플래그 배경색 조금 더 진하게
                  LineBorder bb = new LineBorder(new Color(246, 141, 0));// 플래그는 경계선 회색주기
                  userField[i][j].setBorder(bb);
                  userField[i][j].setEnabled(false);

                  // 20211208 새로 추가한것
                  leftMines--; // 지뢰 수 감소
                  findMines++; // 찾은 지뢰 수
                  myClick++; // ---2021-12-13 추가 ---
                  label_rightclicks.setText(Integer.toString(myClick)); // 남은 클릭횟수
                  revalidate();
                  repaint();
               }

               else if (selected.getType() == 'n') {
                  userField[i][j].setFont(new Font("나눔바른고딕", Font.PLAIN, 10)); // ---2021-12-13 폰트 크기 설정--
                  // ---2021-12-13 추가 ---
                  myClick++;
                  selected.setClicked(true);
                  userField[i][j].setClicked(true);
                  userField[i][j].setValue(selected.getValue());
                  userField[i][j].setType('n');
                  userField[i][j].setText(String.valueOf(selected.getValue()));
                  userField[i][j].setEnabled(false);
               } else if (selected.getType() == 'e') {
                  userField[i][j].setFont(new Font("나눔바른고딕", Font.PLAIN, 10)); // ---2021-12-13 폰트 크기 설정---
                  myClick++; // ---2021-12-13 추가 ---
                  checkEmptyCell(i, j);
               }
               if (victory()) {
                  JOptionPane.showMessageDialog(null, "승리!");
                  showFullField();
                  prepareField();
               }
            } // end of if
         } // end of for j
         if (myClick == 30) {
            showFullField();
            prepareField();
            break;
         }
      } // end of for i
      leftClick = clickChance - myClick; // 30- 내가 클릭한 횟수
      label_leftover.setText(Integer.toString(leftMines));// 잔여 바이러스 수 ---2021-12-13 추가
      label_rightclicks.setText(Integer.toString(this.leftClick));
   }

   void vicc() { // 승리점수가 가장 높은
      vScore = (findMines * 3) + leftClick; // 승리 점수 = 찾은 바이러스 수 + 남은 클릭 횟수
   }

   // 211215 수정할 것 승리 메소드!!!
   boolean victory() {
      int checked = 0; // 클릭수 카운트
      for (int i = 0; i < rows; i++) {
         for (int j = 0; j < cols; j++) {
            if (gameField[i][j].isClicked() && gameField[i][j].getType() == 'm') {
               checked++;
            }
         } // end for j
      } // end for i
      if (checked == mines) {
         return true;
      }
      return false;
   }
}