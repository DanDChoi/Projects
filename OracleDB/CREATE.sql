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

create table SUPPLY( --��ǰ // ���ް���                                   
   supplyNumber number(10) not null,
   FranchiseNumber number(5) not null,
   drinkCount number(5) default 0,  
   alcholeCount number(5) default 0,  
   chickenCount number(5) default 0
);
 
alter table SUPPLY add constraint Supply_PK primary key(supplyNumber);

------------------------------------------------------------------------------------------------

create table MENU(  -- �޴� �޴������� -> �̸��ֱ� 
   menuName nvarchar2(30) not null check(menuName in('drink' , 'chicken' , 'alcohole')), --�޴��̸�
   price number(20) not null --����  
);
alter table MENU add constraint menuName_PK primary key(menuName);
--------------------------------------------------------------------------------------
create table FRANCHISE(  --������  �̸��ֱ� 
   FranchiseNumber number(5) not null, --��������ȣ
   FranchiseName nvarchar2(30) not null, --������
   star number(10 , 3) , --���� �굵 Ʈ�����ʿ��ѵ�. ���ν����� �ʿ��ѵ�
   employeeCount number(2) not null, --������
   FLoc nvarchar2(200) not null, --������ �ּ�
   businessOwner nvarchar2(20) default '����', --�����
   businesshours nvarchar2(40) default 'AM 11��00 ~ AM 1��00' ,--�����ð�
   drinkCount number(5)  default 0,  
   alcholeCount number(5)  default 0,  
   chickenCount number(5)  default 0
);
alter table FRANCHISE add constraint Franchise_PK primary key(FranchiseNumber);
---------------------------------------------------------------------------------------

create table EMPLOYEE(  --���� �̸��ֱ� 
   employeeNumber number(10) not null,--������ȣ
   employeeName nvarchar2(20) not null, --�����̸�
   salary number(20), --�޿�
   position nvarchar2(30) not null check(position in( '�Ƹ�����Ʈ', '���', '�Ŵ���','����', '�����')), 
   FranchiseNumber number(5) not null
);
alter table EMPLOYEE add constraint Employee_PK primary key(employeeNumber);
alter table EMPLOYEE add constraint Employee_FK foreign key(FranchiseNumber) references FRANCHISE(FranchiseNumber);


-------------------------------------------------------------------------------------------

create table INVENTORYCONTROL(  --������
   supplyNumber number(10) not null,
   FranchiseNumber number(5) not null,
   warehousingDATE DATE default SYSDATE not null, --�԰���
   drinkCount number(5) default 0,  
   alcholeCount number(5) default 0,  
   chickenCount number(5) default 0
);
alter table INVENTORYCONTROL add constraint supplyNumberIN_PK primary key(supplyNumber);
alter table INVENTORYCONTROL add constraint supplyNumber_FK foreign key(supplyNumber) references SUPPLY(supplyNumber);
alter table INVENTORYCONTROL add constraint FranchiseNumber_FK foreign key(FranchiseNumber) references FRANCHISE(FranchiseNumber);


--------------------------------------------------------------------------------------------------------

create table ORDERS(  -- �ֹ�   RESERVATION r   r. 
   orderNumber number(8) not null,
   ID nvarchar2(40) default '�湮' not null, -- �ֹ���ȣ -- �����ݾ�
   star number(1) check(star in( 1 , 2 , 3 , 4 , 5)), --����
   FranchiseNumber number(5) not null, -- ��������ȣ
   orderDATE DATE, -- �ֹ�(�湮)����
   payment nvarchar2(50) not null check(payment in('����' , 'ī��' , '������ü' , '�Ｚ����' , 'īī������' )), --�������
   drinkCount number(5)  default 0,  
   alcholeCount number(5)  default 0,  
   chickenCount number(5)  default 0
);

alter table ORDERS add constraint orders_PK primary key(orderNumber);
alter table ORDERS add constraint orders_FranchiseNumber_FK foreign key(FranchiseNumber) references FRANCHISE(FranchiseNumber);

----------------------------------------------------------------------------------------------------

create table DELICUSTOMER(  -- �̸��־�ΰ� 
        ID nvarchar2(40) not null, --����ȣ
        customerName nvarchar2(40) not null, --���̸�
        Loc nvarchar2(200) , -- ���ּ�
        customerPhonenumber nvarchar2(80) , -- ����ȭ��ȣ
        joinDATE DATE default SYSDATE      
);
alter table DELICUSTOMER add constraint DELICUSTOMER_PK primary key(ID);

---------------------------------------------------------------------------------------------------
create table VISIT( --�湮
   orderNumber number(8) not null, --�ֹ���ȣ
   drinkCount number(5)  default 0,  
   alcholeCount number(5)  default 0,  
   chickenCount number(5)  default 0,
   customercost number(20) not null, --�����ݾ�
   FranchiseNumber number(5) not null, --
   payment nvarchar2(50) not null check(payment in('����' , 'ī��' , '������ü' , '�Ｚ����' , 'īī������' )),
   orderDATE DATE,
   star number(1) check(star in( 1 , 2 , 3 , 4 , 5))
);
alter table VISIT add constraint Visit_PK primary key(orderNumber);
alter table VISIT add constraint Visit_FK foreign key(orderNumber) references ORDERS(orderNumber) on delete cascade;
select constraint_name, constraint_type from user_constraints where table_name='VISIT';

-----------------------------------------------------------------------------------------------------------
create table DELIVERY( --���
   orderNumber number(8) not null, --�ֹ���ȣ
   ID nvarchar2(40) not null, --����ȣ ���̵� ����������
   FranchiseNumber number(5) not null, --��������ȣ
   drinkCount number(5)  default 0,  
   alcholeCount number(5)  default 0,  
   chickenCount number(5)  default 0,
   customercost number(20) not null,
   Loc nvarchar2(200) not null, -- ���ּ�
   customerPhonenumber nvarchar2(80) not null , -- ����ȣ
   payment nvarchar2(50) not null check(payment in('����' , 'ī��' , '������ü' , '�Ｚ����' , 'īī������' )),
   orderDATE DATE,
   star number(1) check(star in( 1 , 2 , 3 , 4 , 5))
);
alter table DELIVERY add constraint DELIVERY_PK primary key(orderNumber);
alter table DELIVERY add constraint DELIVERY_FK foreign key(orderNumber) references ORDERS on delete cascade;
alter table DELIVERY add constraint DELIVERY_ID_FK foreign key(ID) references DELICUSTOMER(ID);

----------------------------------------------------------------------------------------------------------------
create table SALES( --����ǥ
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




