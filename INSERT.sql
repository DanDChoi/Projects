--1. 메뉴의 값이 바뀌면 알아서 오더 cost 주문 가격도 바뀐다.
--2. 주문이 들어오고 팔게 되면 프렌차이즈의 재고들이 감소한다.
--3. 주문이 들어오다가 감소해서 0이 되면 주문을 거절한다. show error
--4. 주문이 들어오면 배달 과 방문 손님으로 나누어서 데이터베이스를 쌓는다. 배달에 필요한 정보는 회원가입테이블에서 가져옴. 
--5. 평점을 쌓아서 평균을 낸뒤 매장 별로 평점을 검색할 수 있다 , 매출액이 가장 높은 프렌차이즈도 가능.
--6. 가맹점별로 원하는 만큼 재료를 배당한다.


--(0) 먼저
insert into MENU values('chicken', 20000 );
insert into MENU values('alcohole', 4000);
insert into MENU values('drink', 3000);

--(1) 직원수 0 먼저
insert into FRANCHISE values (1, '가산디지털단지점', 0, 0, '서울특별시 금천구 가산디지털단지로 3', '김치킨', 'PM12 ~ AM12' , 0 , 0, 0);
insert into FRANCHISE values (2, '구로디지털단지점', 0, 0, '서울특별시 구로구 구로로 53', '박통닭', 'PM2 ~ PM10', 0 , 0, 0);
insert into FRANCHISE values (3, '가산점', 0, 0, '서울특별시 금천구 가산로 55', '최순살', 'AM11 ~ AM2', 0 , 0, 0);
insert into FRANCHISE values (4, '서울점', 0, 0, '서울특별시 서울구 서울로 66', '이후추', 'PM12 ~ AM12', 0 , 0, 0);
insert into FRANCHISE values (5, '천왕역점', 0, 0, '서울특별시 천왕구 천왕로 12', '강황금', 'PM3 ~ PM9', 0 , 0, 0);

select franchiseNumber, employeecount from franchise;
insert into EMPLOYEE values (511, '김치킨', 4900000, '사업주', 1);
insert into EMPLOYEE values (99, '박통닭', 5300000, '사업주' , 2);
insert into EMPLOYEE values (134, '최순살', 6100000, '사업주', 3);
insert into EMPLOYEE values (223, '이후추', 5500000, '사업주', 4);
insert into EMPLOYEE values (122, '강황금', 4800000, '점장' , 5);
insert into EMPLOYEE values (45, '이가나', 3200000, '매니저' , 1);
insert into EMPLOYEE values (52, '박나나', 3000000, '매니저' , 2);
insert into EMPLOYEE values (103, '김다라', 2500000, '사원' , 1);
insert into EMPLOYEE values (178, '최마바', 2700000, '사원' , 1);
insert into EMPLOYEE values (145, '강사아', 1800000, '아르바이트', 1);
insert into EMPLOYEE values (155, '손자차', 1900000, '아르바이트', 3);
insert into EMPLOYEE values (172, '정타카', 1500000, '아르바이트' , 4);
insert into EMPLOYEE values (391, '하파하', 1200000, '아르바이트', 5);
insert into EMPLOYEE values (444, '이가네', 3100000, '매니저' , 4);
insert into EMPLOYEE values (445, '최가네', 3600000, '매니저' , 3);
insert into EMPLOYEE values (159, '감나라', 2600000, '사원' ,2);
insert into EMPLOYEE values (162, '배나라', 2500000, '사원' , 3);
insert into EMPLOYEE values (101, '아이유', 2000000, '아르바이트', 3);
insert into EMPLOYEE values (102, '김고은', 1950000, '아르바이트', 3);
insert into EMPLOYEE values (105, '이루다', 1600000, '아르바이트' , 4);
insert into EMPLOYEE values (104, '최박사', 1400000, '아르바이트', 5);
select franchiseNumber, employeecount from franchise;

delete from employee where employeename='최박사';


--(3) 먼저
insert into toSALES values ( 1 , 0 );
insert into toSALES values ( 2 , 0 );
insert into toSALES values ( 3 , 0 );
insert into toSALES values ( 4 , 0 );
insert into toSALES values ( 5 , 0 );

--(4) 먼저
insert into DELICUSTOMER values (3842, '이재영', '서울특별시 강남구 도산대로 1', '010-1212-3434', SYSDATE);
insert into DELICUSTOMER values (5341, '조한영', '서울특별시 금천구 가산디지털1로 13', '010-5552-2233', SYSDATE);
insert into DELICUSTOMER values (9374, '이나영', '서울특별시 종로구 아무개로 13', '010-1122-3334', SYSDATE);
insert into DELICUSTOMER values (2012, '송보석', '서울특별시 강서구 강서로 45', '010-1552-3534', SYSDATE);
insert into DELICUSTOMER values (2038, '최대현', '서울특별시 강서구 강강로 56', '010-6485-3458', SYSDATE);
insert into DELICUSTOMER values (7492, '홍길동', '서울특별시 어쩌구 그런대로 9', '010-6953-4534', SYSDATE);
insert into DELICUSTOMER values (4752, '이순신', '서울특별시 저쩌구 치킨로 30-1', '010-0394-3452', SYSDATE);
insert into DELICUSTOMER values (5583, '조핸영', '서울특별시 서울구 서울로 6', '010-6945-3433', SYSDATE);
insert into DELICUSTOMER values (5823, '고길동', '서울특별시 방구 효자로 19', '010-3958-3754', SYSDATE);
insert into DELICUSTOMER values ('qaz', '허희진', '서울특별시 강서구 비로 61', '010-4335-3445', SYSDATE);
insert into DELICUSTOMER values ('fgh', '김수환', '서울특별시 중구 해운대로 59', '010-4538-3494', SYSDATE);
insert into DELICUSTOMER values ('sdf', '이제학', '서울특별시 라라구 민로 73', '010-6455-3758', '22/01/01');
insert into DELICUSTOMER values ('wer', '형수쌤', '서울특별시 강남구 닭로 95', '010-3928-3454', '21/12/31');
insert into DELICUSTOMER values ('zxc', '아이유', '서울특별시 중구 서울로 45', '010-3335-7758', SYSDATE);
insert into DELICUSTOMER values ('qwe', '김민경', '서울특별시 강서구 민로 90', '010-4458-3294', '21/01/04');
insert into DELICUSTOMER values ('asd', '신병철', '서울특별시 강동구 안녕로 6', '010-777-3348', SYSDATE);
insert into DELICUSTOMER values ('xcv', '김진운', '서울특별시 동안구 관악대로 49', '010-3778-3194', '21/05/01');
insert into DELICUSTOMER values ('dfg', '김지수', '서울특별시 서울구 서울로 55', '010-6666-3438', '21/03/04');
insert into DELICUSTOMER values ('wsx', '최다인', '서울특별시 부산구 관양대로 47', '010-3455-3533', SYSDATE);
insert into DELICUSTOMER values (1579, '고길상', '서울특별시 강남구 도산대로 2', '010-1212-3433', SYSDATE);
insert into DELICUSTOMER values (2345, '홍반장', '서울특별시 금천구 가산디지털1로 15', '010-5552-2124', SYSDATE);
insert into DELICUSTOMER values (6364, '나이쁨', '서울특별시 종로구 아무개로 17', '010-1232-3334', SYSDATE);
insert into DELICUSTOMER values (4865, '이철수', '서울특별시 강서구 강서로 49', '010-1545-3534', SYSDATE);
insert into DELICUSTOMER values (6786, '금보석', '서울특별시 강서구 강강로 59', '010-6255-3458', SYSDATE);
insert into DELICUSTOMER values (4145, '마진수', '서울특별시 어쩌구 그런대로 23', '010-6753-4534', SYSDATE);
insert into DELICUSTOMER values (3775, '정해인', '서울특별시 저쩌구 치킨로 31-1', '010-0854-3452', SYSDATE);
insert into DELICUSTOMER values (8768, '유인나', '서울특별시 서울구 서울로 5', '010-6958-3458', SYSDATE);
insert into DELICUSTOMER values (7632, '고은아', '서울특별시 부산구 해운대로 12', '010-4254-3494', SYSDATE);
insert into DELICUSTOMER values (94334, '하호호', '서울특별시 강서구 대대로 49', '010-7755-9994', SYSDATE);
insert into DELICUSTOMER values (6465, '다다', '서울특별시 강서구 강변북로 59', '010-6255-5888', SYSDATE);
insert into DELICUSTOMER values (46601, '미미', '서울특별시 어쩌구 그마음 23', '010-6763-4777', SYSDATE);
insert into DELICUSTOMER values (54323, '당신은누', '서울특별시 저쩌구 혼자인것만 31-1', '010-0424-3452', SYSDATE);
insert into DELICUSTOMER values (89975, '라잉', '서울특별시 서울구 같아그래 5', '010-4318-6668', SYSDATE);

--(5-1)넣기전에 서플리 없어서 재고없음으로 주문 불가한거 보여주기.
insert into ORDERS values (orderCount_SEQ.nextval, 'asd', 4, 3, SYSDATE, '현금', 1, 0, 2);

insert into SUPPLY values (supply_SEQ.nextval, 1, 200, 100, 500);
insert into SUPPLY values (supply_SEQ.nextval, 2, 400, 200, 600);
insert into SUPPLY values (supply_SEQ.nextval, 3, 500, 300, 700);
insert into SUPPLY values (supply_SEQ.nextval, 4, 600, 400, 800);
insert into SUPPLY values (supply_SEQ.nextval, 5, 700, 500, 900);
insert into SUPPLY values (supply_SEQ.nextval, 1, 200, 100, 500);
insert into SUPPLY values (supply_SEQ.nextval, 2, 400, 200, 600);
insert into SUPPLY values (supply_SEQ.nextval, 3, 500, 300, 700);
insert into SUPPLY values (supply_SEQ.nextval, 4, 600, 400, 800);
insert into SUPPLY values (supply_SEQ.nextval, 5, 700, 500, 900);


--(5-2)
-- 넣기전에 서플리 없어서 재고없음으로 주문 불가한거 보여주기.
-- 여기많금 넣고 프로시져 구현하면서 설명하기.
insert into ORDERS values (orderCount_SEQ.nextval, 'asd', 4, 3, SYSDATE, '현금', 1, 0, 2);
insert into ORDERS values (orderCount_SEQ.nextval, 'qwe', 4, 2, SYSDATE, '현금', 10, 1, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx', 5, 1, SYSDATE, '카드', 15, 1, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 'qaz', 3, 4, SYSDATE, '삼성페이', 5, 0, 2);
insert into ORDERS values (orderCount_SEQ.nextval, 'fgh', 4, 5, SYSDATE, '카드', 2, 10, 2);
insert into ORDERS values (orderCount_SEQ.nextval,  5823, 3, 2, SYSDATE, '카드', 5, 2, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '현금', 2, 20, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 9374, 5, 5, SYSDATE, '카드', 1, 0, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 2038, 4, 5, SYSDATE, '카드', 5, 5, 5);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 1, 1, SYSDATE, '카드', 1, 1, 10);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 1, SYSDATE, '카드', 20, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 3, 3, SYSDATE, '현금', 1, 15, 2);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 5, SYSDATE, '카드', 2, 1, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 4, 5, SYSDATE, '계좌이체', 2, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 1, SYSDATE, '카드', 5, 13, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 3, 3, SYSDATE, '현금', 1, 9, 8);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 2, SYSDATE, '카드', 2, 7, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 4, 5, SYSDATE, '카카오페이', 10, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 89975, 1, 2, SYSDATE, '현금', 2, 0, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 94334, 5, 5, SYSDATE, '카드', 40, 0, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 'fgh' , 5, 2, SYSDATE, '현금', 2, 7, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 2, SYSDATE, '카드', 4, 7, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 'qwe' , 5, 2, SYSDATE, '카드', 2, 5, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 6465, 4, 5, SYSDATE, '카드', 5, 30, 5);
insert into ORDERS values (orderCount_SEQ.nextval, 46601 , 1, 1, SYSDATE, '카드', 1, 1, 2);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 1, SYSDATE, '카드', 20, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 3, 3, SYSDATE, '현금', 1, 50, 2);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 4, SYSDATE, '카드', 2, 40, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 4, 4, SYSDATE, '계좌이체', 0, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '현금', 2, 20, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 2345, 5, 5, SYSDATE, '카드', 40, 0, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 8768, 4, 5, SYSDATE, '카드', 5, 7, 13);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx' , 1, 1, SYSDATE, '카드', 0, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 3, SYSDATE, '카드', 20, 1, 8);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 3, 3, SYSDATE, '현금', 1, 10, 11);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 2, SYSDATE, '계좌이체', 55, 40, 30);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 4, 3, SYSDATE, '현금', 1, 50, 2);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 5, 4, SYSDATE, '카드', 2, 40, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 4, 4, SYSDATE, '계좌이체', 0, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '현금', 2, 10, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 'qwe', 4, 2, SYSDATE, '현금', 0, 5, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx', 5, 1, SYSDATE, '카드', 0, 1, 7);
insert into ORDERS values (orderCount_SEQ.nextval, 'qaz', 3, 4, SYSDATE, '삼성페이', 5, 0, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 8768, 4, 5, SYSDATE, '카드', 5, 6, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx' , 1, 1, SYSDATE, '카드', 0, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 1, 3, SYSDATE, '카드', 20, 1, 8);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 3, 3, SYSDATE, '현금', 1, 5, 11);
insert into ORDERS values (orderCount_SEQ.nextval, 'qaz' , 5, 2, SYSDATE, '계좌이체', 0, 1, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 3, 3, SYSDATE, '현금', 1, 50, 2);
insert into ORDERS values (orderCount_SEQ.nextval, 'asd' , 5, 4, SYSDATE, '카드', 40, 5, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 4, 4, SYSDATE, '계좌이체', 0, 15, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '현금', 2, 10, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 'qwe', 4, 2, SYSDATE, '현금', 10, 5, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx', 5, 1, SYSDATE, '카드', 0, 10, 7);
insert into ORDERS values (orderCount_SEQ.nextval, 'qaz', 3, 4, SYSDATE, '삼성페이', 5, 0, 5);
insert into ORDERS values (orderCount_SEQ.nextval, '방문' , 4, 4, SYSDATE, '계좌이체', 0, 15, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '현금', 2, 10, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '방문',  4, 2, SYSDATE, '현금', 10, 5, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx', 5, 5, SYSDATE, '카드', 4, 0, 7);
insert into ORDERS values (orderCount_SEQ.nextval, '방문', 5, 4, SYSDATE, '삼성페이', 5, 0, 5);

-- 회원가입 안한 고객은 배달 주문 불가
insert into ORDERS values (orderCount_SEQ.nextval,0000, 4, 2, SYSDATE, '현금', 2, 0, 4); 


--- 검증 셀렉문 
select franchiseNumber , drinkcount , star from franchise;
select * from inventorycontrol;
select franchiseNumber,drinkcount , chickencount , alcholecount from franchise;
select * from sales; --전체 주문 내용(방문+배달)
select * from tosales; -- 각 지점별 총매출액
select * from visit; -- 방문 주문 내역
select * from delivery; -- 배달 주문 내역

-------

1. 메뉴의 값이 바뀌면 알아서 오더 cost 주문 가격도 바뀐다.
2. 주문이 들어오고 팔게 되면 프렌차이즈의 재고들이 감소한다.
3. 주문이 들어오다가 감소해서 0이 되면 주문을 거절한다. show error
4. 주문이 들어오면 배달 과 방문 손님으로 나누어서 데이터베이스를 쌓는다. 배달에 필요한 정보는 회원가입테이블에서 가져옴. 
5. 평점을 쌓아서 평균을 낸뒤 매장 별로 평점을 검색할 수 있다 , 매출액이 가장 높은 프렌차이즈도 가능.
6. 가맹점별로 원하는 만큼 재료를 배당한다.