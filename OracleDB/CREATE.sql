drop table toSALES;
drop table SUPPLY;
drop table MENU;
drop table EMPLOYEE;
drop table INVENTORYCONTROL;
drop table SALES;
drop table DELIVERY;
drop table DELICUSTOMER;
drop table VISIT;
drop table ORDERS;
drop table FRANCHISE;
drop table toSALES;
purge recyclebin;

create table SUPPLY( --납품 // 보급같은                                   
   supplyNumber number(10) not null,
   FranchiseNumber number(5) not null,
   drinkCount number(5) default 0,  
   alcholeCount number(5) default 0,  
   chickenCount number(5) default 0
);
 
alter table SUPPLY add constraint Supply_PK primary key(supplyNumber);

------------------------------------------------------------------------------------------------

create table MENU(  -- 메뉴 메뉴네임을 -> 미리넣기 
   menuName nvarchar2(30) not null check(menuName in('drink' , 'chicken' , 'alcohole')), --메뉴이름
   price number(20) not null --가격  
);
alter table MENU add constraint menuName_PK primary key(menuName);
--------------------------------------------------------------------------------------
create table FRANCHISE(  --가맹점  미리넣기 
   FranchiseNumber number(5) not null, --가맹점번호
   FranchiseName nvarchar2(30) not null, --지점명
   star number(10 , 3) , --별점 얘도 트리거필요한데. 프로시져도 필요한데
   employeeCount number(2) not null, --직원수
   FLoc nvarchar2(200) not null, --가맹점 주소
   businessOwner nvarchar2(20) default '점장', --사업주
   businesshours nvarchar2(40) default 'AM 11시00 ~ AM 1시00' ,--영업시간
   drinkCount number(5)  default 0,  
   alcholeCount number(5)  default 0,  
   chickenCount number(5)  default 0
);
alter table FRANCHISE add constraint Franchise_PK primary key(FranchiseNumber);
---------------------------------------------------------------------------------------

create table EMPLOYEE(  --직원 미리넣기 
   employeeNumber number(10) not null,--직원번호
   employeeName nvarchar2(20) not null, --직원이름
   salary number(20), --급여
   position nvarchar2(30) not null check(position in( '아르바이트', '사원', '매니저','점장', '사업주')), 
   FranchiseNumber number(5) not null
);
alter table EMPLOYEE add constraint Employee_PK primary key(employeeNumber);
alter table EMPLOYEE add constraint Employee_FK foreign key(FranchiseNumber) references FRANCHISE(FranchiseNumber);


-------------------------------------------------------------------------------------------

create table INVENTORYCONTROL(  --재고관리
   supplyNumber number(10) not null,
   FranchiseNumber number(5) not null,
   warehousingDATE DATE default SYSDATE not null, --입고일
   drinkCount number(5) default 0,  
   alcholeCount number(5) default 0,  
   chickenCount number(5) default 0
);
alter table INVENTORYCONTROL add constraint supplyNumberIN_PK primary key(supplyNumber);
alter table INVENTORYCONTROL add constraint supplyNumber_FK foreign key(supplyNumber) references SUPPLY(supplyNumber);
alter table INVENTORYCONTROL add constraint FranchiseNumber_FK foreign key(FranchiseNumber) references FRANCHISE(FranchiseNumber);


--------------------------------------------------------------------------------------------------------

create table ORDERS(  -- 주문   RESERVATION r   r. 
   orderNumber number(8) not null,
   ID nvarchar2(40) default '방문' not null, -- 주문번호 -- 결제금액
   star number(1) check(star in( 1 , 2 , 3 , 4 , 5)), --별점
   FranchiseNumber number(5) not null, -- 가맹점번호
   orderDATE DATE, -- 주문(방문)일자
   payment nvarchar2(50) not null check(payment in('현금' , '카드' , '계좌이체' , '삼성페이' , '카카오페이' )), --결제방식
   drinkCount number(5)  default 0,  
   alcholeCount number(5)  default 0,  
   chickenCount number(5)  default 0
);

alter table ORDERS add constraint orders_PK primary key(orderNumber);
alter table ORDERS add constraint orders_FranchiseNumber_FK foreign key(FranchiseNumber) references FRANCHISE(FranchiseNumber);

----------------------------------------------------------------------------------------------------

create table DELICUSTOMER(  -- 미리넣어두고 
        ID nvarchar2(40) not null, --고객번호
        customerName nvarchar2(40) not null, --고객이름
        Loc nvarchar2(200) , -- 고객주소
        customerPhonenumber nvarchar2(80) , -- 고객전화번호
        joinDATE DATE default SYSDATE      
);
alter table DELICUSTOMER add constraint DELICUSTOMER_PK primary key(ID);

---------------------------------------------------------------------------------------------------
create table VISIT( --방문
   orderNumber number(8) not null, --주문번호
   drinkCount number(5)  default 0,  
   alcholeCount number(5)  default 0,  
   chickenCount number(5)  default 0,
   customercost number(20) not null, --결제금액
   FranchiseNumber number(5) not null, --
   payment nvarchar2(50) not null check(payment in('현금' , '카드' , '계좌이체' , '삼성페이' , '카카오페이' )),
   orderDATE DATE,
   star number(1) check(star in( 1 , 2 , 3 , 4 , 5))
);
alter table VISIT add constraint Visit_PK primary key(orderNumber);
alter table VISIT add constraint Visit_FK foreign key(orderNumber) references ORDERS(orderNumber) on delete cascade;
select constraint_name, constraint_type from user_constraints where table_name='VISIT';

-----------------------------------------------------------------------------------------------------------
create table DELIVERY( --배달
   orderNumber number(8) not null, --주문번호
   ID nvarchar2(40) not null, --고객번호 아이디강 ㅏㄴ들어오네
   FranchiseNumber number(5) not null, --가맹점번호
   drinkCount number(5)  default 0,  
   alcholeCount number(5)  default 0,  
   chickenCount number(5)  default 0,
   customercost number(20) not null,
   Loc nvarchar2(200) not null, -- 고객주소
   customerPhonenumber nvarchar2(80) not null , -- 고객번호
   payment nvarchar2(50) not null check(payment in('현금' , '카드' , '계좌이체' , '삼성페이' , '카카오페이' )),
   orderDATE DATE,
   star number(1) check(star in( 1 , 2 , 3 , 4 , 5))
);
alter table DELIVERY add constraint DELIVERY_PK primary key(orderNumber);
alter table DELIVERY add constraint DELIVERY_FK foreign key(orderNumber) references ORDERS on delete cascade;
alter table DELIVERY add constraint DELIVERY_ID_FK foreign key(ID) references DELICUSTOMER(ID);

----------------------------------------------------------------------------------------------------------------
create table SALES( --매출표
   orderNumber number(8) not null,
   FranchiseNumber number(5) not null,
   orderDATE DATE,
   orderSALES number(20) not null,
   star number(1) check(star in( 1 , 2 , 3 , 4 , 5))
);
alter table SALES add constraint SALEorderNumber_PK primary key(orderNumber);

------------------------------------------------------------------------------------------------------------
create table toSALES( 
	FranchiseNumber number(5) not null,
        totalSAL number(20) not null
);
alter table toSALES add constraint toSALES_PK primary key(FranchiseNumber);




