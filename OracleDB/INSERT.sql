--1. �޴��� ���� �ٲ�� �˾Ƽ� ���� cost �ֹ� ���ݵ� �ٲ��.
--2. �ֹ��� ������ �Ȱ� �Ǹ� ������������ ������ �����Ѵ�.
--3. �ֹ��� �����ٰ� �����ؼ� 0�� �Ǹ� �ֹ��� �����Ѵ�. show error
--4. �ֹ��� ������ ��� �� �湮 �մ����� ����� �����ͺ��̽��� �״´�. ��޿� �ʿ��� ������ ȸ���������̺��� ������. 
--5. ������ �׾Ƽ� ����� ���� ���� ���� ������ �˻��� �� �ִ� , ������� ���� ���� ��������� ����.
--6. ���������� ���ϴ� ��ŭ ��Ḧ ����Ѵ�.


--(0) ����
insert into MENU values('chicken', 20000 );
insert into MENU values('alcohole', 4000);
insert into MENU values('drink', 3000);

--(1) ������ 0 ����
insert into FRANCHISE values (1, '��������д�����', 0, 0, '����Ư���� ��õ�� ��������д����� 3', '��ġŲ', 'PM12 ~ AM12' , 0 , 0, 0);
insert into FRANCHISE values (2, '���ε����д�����', 0, 0, '����Ư���� ���α� ���η� 53', '�����', 'PM2 ~ PM10', 0 , 0, 0);
insert into FRANCHISE values (3, '������', 0, 0, '����Ư���� ��õ�� ����� 55', '�ּ���', 'AM11 ~ AM2', 0 , 0, 0);
insert into FRANCHISE values (4, '������', 0, 0, '����Ư���� ���ﱸ ����� 66', '������', 'PM12 ~ AM12', 0 , 0, 0);
insert into FRANCHISE values (5, 'õ�տ���', 0, 0, '����Ư���� õ�ձ� õ�շ� 12', '��Ȳ��', 'PM3 ~ PM9', 0 , 0, 0);

select franchiseNumber, employeecount from franchise;
insert into EMPLOYEE values (511, '��ġŲ', 4900000, '�����', 1);
insert into EMPLOYEE values (99, '�����', 5300000, '�����' , 2);
insert into EMPLOYEE values (134, '�ּ���', 6100000, '�����', 3);
insert into EMPLOYEE values (223, '������', 5500000, '�����', 4);
insert into EMPLOYEE values (122, '��Ȳ��', 4800000, '����' , 5);
insert into EMPLOYEE values (45, '�̰���', 3200000, '�Ŵ���' , 1);
insert into EMPLOYEE values (52, '�ڳ���', 3000000, '�Ŵ���' , 2);
insert into EMPLOYEE values (103, '��ٶ�', 2500000, '���' , 1);
insert into EMPLOYEE values (178, '�ָ���', 2700000, '���' , 1);
insert into EMPLOYEE values (145, '�����', 1800000, '�Ƹ�����Ʈ', 1);
insert into EMPLOYEE values (155, '������', 1900000, '�Ƹ�����Ʈ', 3);
insert into EMPLOYEE values (172, '��Ÿī', 1500000, '�Ƹ�����Ʈ' , 4);
insert into EMPLOYEE values (391, '������', 1200000, '�Ƹ�����Ʈ', 5);
insert into EMPLOYEE values (444, '�̰���', 3100000, '�Ŵ���' , 4);
insert into EMPLOYEE values (445, '�ְ���', 3600000, '�Ŵ���' , 3);
insert into EMPLOYEE values (159, '������', 2600000, '���' ,2);
insert into EMPLOYEE values (162, '�質��', 2500000, '���' , 3);
insert into EMPLOYEE values (101, '������', 2000000, '�Ƹ�����Ʈ', 3);
insert into EMPLOYEE values (102, '�����', 1950000, '�Ƹ�����Ʈ', 3);
insert into EMPLOYEE values (105, '�̷��', 1600000, '�Ƹ�����Ʈ' , 4);
insert into EMPLOYEE values (104, '�ֹڻ�', 1400000, '�Ƹ�����Ʈ', 5);
select franchiseNumber, employeecount from franchise;

delete from employee where employeename='�ֹڻ�';


--(3) ����
insert into toSALES values ( 1 , 0 );
insert into toSALES values ( 2 , 0 );
insert into toSALES values ( 3 , 0 );
insert into toSALES values ( 4 , 0 );
insert into toSALES values ( 5 , 0 );

--(4) ����
insert into DELICUSTOMER values (3842, '���翵', '����Ư���� ������ ������ 1', '010-1212-3434', SYSDATE);
insert into DELICUSTOMER values (5341, '���ѿ�', '����Ư���� ��õ�� ���������1�� 13', '010-5552-2233', SYSDATE);
insert into DELICUSTOMER values (9374, '�̳���', '����Ư���� ���α� �ƹ����� 13', '010-1122-3334', SYSDATE);
insert into DELICUSTOMER values (2012, '�ۺ���', '����Ư���� ������ ������ 45', '010-1552-3534', SYSDATE);
insert into DELICUSTOMER values (2038, '�ִ���', '����Ư���� ������ ������ 56', '010-6485-3458', SYSDATE);
insert into DELICUSTOMER values (7492, 'ȫ�浿', '����Ư���� ��¼�� �׷���� 9', '010-6953-4534', SYSDATE);
insert into DELICUSTOMER values (4752, '�̼���', '����Ư���� ��¼�� ġŲ�� 30-1', '010-0394-3452', SYSDATE);
insert into DELICUSTOMER values (5583, '���ڿ�', '����Ư���� ���ﱸ ����� 6', '010-6945-3433', SYSDATE);
insert into DELICUSTOMER values (5823, '��浿', '����Ư���� �汸 ȿ�ڷ� 19', '010-3958-3754', SYSDATE);
insert into DELICUSTOMER values ('qaz', '������', '����Ư���� ������ ��� 61', '010-4335-3445', SYSDATE);
insert into DELICUSTOMER values ('fgh', '���ȯ', '����Ư���� �߱� �ؿ��� 59', '010-4538-3494', SYSDATE);
insert into DELICUSTOMER values ('sdf', '������', '����Ư���� ��� �η� 73', '010-6455-3758', '22/01/01');
insert into DELICUSTOMER values ('wer', '������', '����Ư���� ������ �߷� 95', '010-3928-3454', '21/12/31');
insert into DELICUSTOMER values ('zxc', '������', '����Ư���� �߱� ����� 45', '010-3335-7758', SYSDATE);
insert into DELICUSTOMER values ('qwe', '��ΰ�', '����Ư���� ������ �η� 90', '010-4458-3294', '21/01/04');
insert into DELICUSTOMER values ('asd', '�ź�ö', '����Ư���� ������ �ȳ�� 6', '010-777-3348', SYSDATE);
insert into DELICUSTOMER values ('xcv', '������', '����Ư���� ���ȱ� ���Ǵ�� 49', '010-3778-3194', '21/05/01');
insert into DELICUSTOMER values ('dfg', '������', '����Ư���� ���ﱸ ����� 55', '010-6666-3438', '21/03/04');
insert into DELICUSTOMER values ('wsx', '�ִ���', '����Ư���� �λ걸 ������ 47', '010-3455-3533', SYSDATE);
insert into DELICUSTOMER values (1579, '����', '����Ư���� ������ ������ 2', '010-1212-3433', SYSDATE);
insert into DELICUSTOMER values (2345, 'ȫ����', '����Ư���� ��õ�� ���������1�� 15', '010-5552-2124', SYSDATE);
insert into DELICUSTOMER values (6364, '���̻�', '����Ư���� ���α� �ƹ����� 17', '010-1232-3334', SYSDATE);
insert into DELICUSTOMER values (4865, '��ö��', '����Ư���� ������ ������ 49', '010-1545-3534', SYSDATE);
insert into DELICUSTOMER values (6786, '�ݺ���', '����Ư���� ������ ������ 59', '010-6255-3458', SYSDATE);
insert into DELICUSTOMER values (4145, '������', '����Ư���� ��¼�� �׷���� 23', '010-6753-4534', SYSDATE);
insert into DELICUSTOMER values (3775, '������', '����Ư���� ��¼�� ġŲ�� 31-1', '010-0854-3452', SYSDATE);
insert into DELICUSTOMER values (8768, '���γ�', '����Ư���� ���ﱸ ����� 5', '010-6958-3458', SYSDATE);
insert into DELICUSTOMER values (7632, '������', '����Ư���� �λ걸 �ؿ��� 12', '010-4254-3494', SYSDATE);
insert into DELICUSTOMER values (94334, '��ȣȣ', '����Ư���� ������ ���� 49', '010-7755-9994', SYSDATE);
insert into DELICUSTOMER values (6465, '�ٴ�', '����Ư���� ������ �����Ϸ� 59', '010-6255-5888', SYSDATE);
insert into DELICUSTOMER values (46601, '�̹�', '����Ư���� ��¼�� �׸��� 23', '010-6763-4777', SYSDATE);
insert into DELICUSTOMER values (54323, '�������', '����Ư���� ��¼�� ȥ���ΰ͸� 31-1', '010-0424-3452', SYSDATE);
insert into DELICUSTOMER values (89975, '����', '����Ư���� ���ﱸ ���Ʊ׷� 5', '010-4318-6668', SYSDATE);

--(5-1)�ֱ����� ���ø� ��� ���������� �ֹ� �Ұ��Ѱ� �����ֱ�.
insert into ORDERS values (orderCount_SEQ.nextval, 'asd', 4, 3, SYSDATE, '����', 1, 0, 2);

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
-- �ֱ����� ���ø� ��� ���������� �ֹ� �Ұ��Ѱ� �����ֱ�.
-- ���⸹�� �ְ� ���ν��� �����ϸ鼭 �����ϱ�.
insert into ORDERS values (orderCount_SEQ.nextval, 'asd', 4, 3, SYSDATE, '����', 1, 0, 2);
insert into ORDERS values (orderCount_SEQ.nextval, 'qwe', 4, 2, SYSDATE, '����', 10, 1, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx', 5, 1, SYSDATE, 'ī��', 15, 1, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 'qaz', 3, 4, SYSDATE, '�Ｚ����', 5, 0, 2);
insert into ORDERS values (orderCount_SEQ.nextval, 'fgh', 4, 5, SYSDATE, 'ī��', 2, 10, 2);
insert into ORDERS values (orderCount_SEQ.nextval,  5823, 3, 2, SYSDATE, 'ī��', 5, 2, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '����', 2, 20, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 9374, 5, 5, SYSDATE, 'ī��', 1, 0, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 2038, 4, 5, SYSDATE, 'ī��', 5, 5, 5);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 1, 1, SYSDATE, 'ī��', 1, 1, 10);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 1, SYSDATE, 'ī��', 20, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 3, 3, SYSDATE, '����', 1, 15, 2);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 5, SYSDATE, 'ī��', 2, 1, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 4, 5, SYSDATE, '������ü', 2, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 1, SYSDATE, 'ī��', 5, 13, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 3, 3, SYSDATE, '����', 1, 9, 8);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 2, SYSDATE, 'ī��', 2, 7, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 4, 5, SYSDATE, 'īī������', 10, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 89975, 1, 2, SYSDATE, '����', 2, 0, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 94334, 5, 5, SYSDATE, 'ī��', 40, 0, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 'fgh' , 5, 2, SYSDATE, '����', 2, 7, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 2, SYSDATE, 'ī��', 4, 7, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 'qwe' , 5, 2, SYSDATE, 'ī��', 2, 5, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 6465, 4, 5, SYSDATE, 'ī��', 5, 30, 5);
insert into ORDERS values (orderCount_SEQ.nextval, 46601 , 1, 1, SYSDATE, 'ī��', 1, 1, 2);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 1, SYSDATE, 'ī��', 20, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 3, 3, SYSDATE, '����', 1, 50, 2);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 4, SYSDATE, 'ī��', 2, 40, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 4, 4, SYSDATE, '������ü', 0, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '����', 2, 20, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 2345, 5, 5, SYSDATE, 'ī��', 40, 0, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 8768, 4, 5, SYSDATE, 'ī��', 5, 7, 13);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx' , 1, 1, SYSDATE, 'ī��', 0, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 3, SYSDATE, 'ī��', 20, 1, 8);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 3, 3, SYSDATE, '����', 1, 10, 11);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 2, SYSDATE, '������ü', 55, 40, 30);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 4, 3, SYSDATE, '����', 1, 50, 2);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 5, 4, SYSDATE, 'ī��', 2, 40, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 4, 4, SYSDATE, '������ü', 0, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '����', 2, 10, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 'qwe', 4, 2, SYSDATE, '����', 0, 5, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx', 5, 1, SYSDATE, 'ī��', 0, 1, 7);
insert into ORDERS values (orderCount_SEQ.nextval, 'qaz', 3, 4, SYSDATE, '�Ｚ����', 5, 0, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 8768, 4, 5, SYSDATE, 'ī��', 5, 6, 1);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx' , 1, 1, SYSDATE, 'ī��', 0, 1, 1);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 1, 3, SYSDATE, 'ī��', 20, 1, 8);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 3, 3, SYSDATE, '����', 1, 5, 11);
insert into ORDERS values (orderCount_SEQ.nextval, 'qaz' , 5, 2, SYSDATE, '������ü', 0, 1, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 3, 3, SYSDATE, '����', 1, 50, 2);
insert into ORDERS values (orderCount_SEQ.nextval, 'asd' , 5, 4, SYSDATE, 'ī��', 40, 5, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 4, 4, SYSDATE, '������ü', 0, 15, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '����', 2, 10, 3);
insert into ORDERS values (orderCount_SEQ.nextval, 'qwe', 4, 2, SYSDATE, '����', 10, 5, 4);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx', 5, 1, SYSDATE, 'ī��', 0, 10, 7);
insert into ORDERS values (orderCount_SEQ.nextval, 'qaz', 3, 4, SYSDATE, '�Ｚ����', 5, 0, 5);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮' , 4, 4, SYSDATE, '������ü', 0, 15, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 4145, 4, 3, SYSDATE, '����', 2, 10, 3);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮',  4, 2, SYSDATE, '����', 10, 5, 10);
insert into ORDERS values (orderCount_SEQ.nextval, 'wsx', 5, 5, SYSDATE, 'ī��', 4, 0, 7);
insert into ORDERS values (orderCount_SEQ.nextval, '�湮', 5, 4, SYSDATE, '�Ｚ����', 5, 0, 5);

-- ȸ������ ���� ���� ��� �ֹ� �Ұ�
insert into ORDERS values (orderCount_SEQ.nextval,0000, 4, 2, SYSDATE, '����', 2, 0, 4); 


--- ���� ������ 
select franchiseNumber , drinkcount , star from franchise;
select * from inventorycontrol;
select franchiseNumber,drinkcount , chickencount , alcholecount from franchise;
select * from sales; --��ü �ֹ� ����(�湮+���)
select * from tosales; -- �� ������ �Ѹ����
select * from visit; -- �湮 �ֹ� ����
select * from delivery; -- ��� �ֹ� ����

-------

1. �޴��� ���� �ٲ�� �˾Ƽ� ���� cost �ֹ� ���ݵ� �ٲ��.
2. �ֹ��� ������ �Ȱ� �Ǹ� ������������ ������ �����Ѵ�.
3. �ֹ��� �����ٰ� �����ؼ� 0�� �Ǹ� �ֹ��� �����Ѵ�. show error
4. �ֹ��� ������ ��� �� �湮 �մ����� ����� �����ͺ��̽��� �״´�. ��޿� �ʿ��� ������ ȸ���������̺��� ������. 
5. ������ �׾Ƽ� ����� ���� ���� ���� ������ �˻��� �� �ִ� , ������� ���� ���� ��������� ����.
6. ���������� ���ϴ� ��ŭ ��Ḧ ����Ѵ�.