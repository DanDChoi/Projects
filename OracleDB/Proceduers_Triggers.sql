drop trigger buy_inven_trigger;
drop trigger inven_trigger  ;
drop trigger supply_trigger ;
drop trigger avgstar;
drop trigger sorting;
drop trigger total_SALES;
drop trigger Deli_SALES;
drop trigger visit_SALES;
drop trigger avgstar1;
drop trigger plus_employee_trigger;
drop trigger minus_employee_trigger;
drop procedure SALESCAL;
drop procedure buy_inven_procedure;
drop sequence supply_SEQ;
drop sequence orderCount_SEQ;

create sequence supply_SEQ increment by 1 start with 1 nocache;
create sequence orderCount_SEQ increment by 1 start with 1 nocache;
-- ��ǰ����.
create or replace trigger supply_trigger  
after insert on SUPPLY for each row
begin
    insert into INVENTORYCONTROL values( :new.supplyNumber , :new.FranchiseNumber , SYSDATE ,:new.drinkCount , :new.alcholeCount , :new.chickenCount );
end;
/

--��ǰǥ
create or replace trigger inven_trigger  
after insert on INVENTORYCONTROL for each row    
begin
    update FRANCHISE set drinkCount = (drinkCount + :new.drinkCount)  , alcholeCount = (alcholeCount + :new.alcholeCount) , chickenCount = ( chickenCount + :new.chickenCount ) where FranchiseNumber = :new.FranchiseNumber ;
end;
/


------------------------------------------------------------------
-- ����������� ����üũ�ϰ� 0 ���� �Ǹ� �ֹ��ź��ϴ� ���ν���
create or replace procedure buy_inven_procedure(r in NUMBER , r1 in NUMBER , r2 in NUMBER , r3 in NUMBER)
is
   newdrinkCount number;
   newalcholeCount number;
   newchiCount number;
   ifdrinCount number;
begin
   select drinkCount into newdrinkCount from FRANCHISE where FranchiseNumber = r3;
   
   newdrinkCount := newdrinkCount-r; 
   if newdrinkCount>=0 
   then
   update FRANCHISE set drinkCount=newdrinkCount where FranchiseNumber = r3; 
  
   elsif newdrinkCount<0
   then
   RAISE_APPLICATION_ERROR(-20002,'�帵ũ�� ��� �����ϴ�');
   end if;
   
   select alcholeCount into newalcholeCount from FRANCHISE where FranchiseNumber = r3;
   newalcholeCount := newalcholeCount-r1;
   
   if newalcholeCount>=0 
   then
   update FRANCHISE set alcholeCount=newalcholeCount where FranchiseNumber = r3;
   elsif newalcholeCount<0
   then
   RAISE_APPLICATION_ERROR(-20003,'���� ��� �����ϴ�');
   end if;
   
   select chickenCount into newchiCount from FRANCHISE where FranchiseNumber = r3;
   newchiCount := newchiCount-r2;
   if newchiCount>=0 
   then
   update FRANCHISE set chickenCount=newchiCount where FranchiseNumber = r3;
   elsif newchiCount<0
   then
   RAISE_APPLICATION_ERROR(-20004,'���� ��� �����ϴ�');
   end if;
end;
/


-- ���������� ���������� ������ȭ�� 
create or replace trigger buy_inven_trigger
after insert on ORDERS for each row 
begin
   buy_inven_procedure(:new.drinkCount , :new.alcholeCount , :new.chickenCount , :new.FranchiseNumber);
end;
/
--------------------------------------------------------------------


  


-----------------------------------------------------------------------------------------------------

-- ���̵�(���), �湮 ������ + �ֹ�ǥ�ݾ� cost
create or replace trigger sorting
after insert on ORDERS 
for each row
begin

if( :new.ID = '�湮') 
then
    insert into VISIT (orderNumber,  drinkCount, alcholeCount, chickenCount, customercost, FranchiseNumber, payment , orderDATE , star) 
    values (:new.orderNumber, :new.drinkCount, :new.alcholeCount, :new.chickenCount, ((:new.drinkCount*(select price from menu where menuName = 'drink'))+(:new.alcholeCount*(select price from menu where menuName = 'alcohole'))+(:new.chickenCount*(select price from menu where menuName = 'chicken'))), :new.FranchiseNumber, :new.payment , :new.orderDATE , :new.star);
else
    insert into DELIVERY values ( :new.orderNumber , :new.ID , :new.FranchiseNumber,:new.drinkCount, 
    :new.alcholeCount, :new.chickenCount, ((:new.drinkCount*(select price from menu where menuName = 'drink'))+(:new.alcholeCount*(select price from menu where menuName = 'alcohole'))+(:new.chickenCount*(select price from menu where menuName = 'chicken'))) ,
    (select Loc from DELICUSTOMER where ID = :new.ID) , (select customerPhonenumber from DELICUSTOMER where ID = :new.ID), :new.payment , :new.orderDATE , :new.star);
end if;
end;
/
-------------------------------------------------------------------------------------------------------

-- ��������� �״� ���ν���
create or replace procedure SALESCAL (r in number , r1 in number )
is
   v_total number;  
begin
    select totalSAL into v_total from toSALES where FranchiseNumber = r;
    v_total := v_total + r1;          
    update toSALES set totalSAL = v_total where FranchiseNumber = r;
end;
/



-- ���������� �� ����� 
create or replace trigger total_SALES
after insert on SALES for each row
begin
    SALESCAL(:new.FranchiseNumber, :new.orderSALES);
end;
/

--��������������Ʈ�� ����ǥ��
create or replace trigger Deli_SALES 
after insert on  delivery  for each row 
begin 
     insert into SALES values (:new.orderNumber , :new.FranchiseNumber , :new.orderDATE , :new.customercost , :new.star); 
end;
/

--�湮��������Ʈ�� ����ǥ��
create or replace trigger visit_SALES
after insert on  visit  for each row 
begin  
     insert into SALES values (:new.orderNumber , :new.FranchiseNumber , :new.orderDATE , :new.customercost, :new.star);
end;
/

create or replace trigger avgstar1
after insert on ORDERS
for each row
DECLARE
   avgCount number;
begin
   select avg(sum(star)) into avgCount from SALES  where FRANCHISENUMBER = :new.FRANCHISENUMBER group by orderNumber;  --�ش� �������� �ֹ���ȣ   
   update FRANCHISE set star = avgCount where FRANCHISENUMBER = :new.FRANCHISENUMBER;
end;
/

------------------------------------------------------
--���� �Ի�/��� �ϸ� �ش� ���������� ���� �� ���� �Ǵ� Ʈ���� 
--���� �Ի� �ϸ� �ش� ���������� ������ ����
create or replace trigger plus_employee_trigger
after insert on EMPLOYEE for each row
begin

	update franchise set employeecount=(employeeCount+1)
	where franchiseNumber=:new.franchiseNumber;
end;
/

--���� ��� �ϸ� �ش� ���������������� ���� �Ǵ� Ʈ����
create or replace trigger minus_employee_trigger
before delete on EMPLOYEE
for each row
DECLARE
    ecount number;
begin
    select employeecount into ecount from franchise where franchiseNumber = :old.franchiseNumber;
 IF ecount > 0
   then
   update franchise set employeecount = (employeecount-1) where franchiseNumber = :old.franchiseNumber;
else
   RAISE_APPLICATION_ERROR(-20006 , '�������� 0 ���Դϴ� �� �̻� �ذ��� ����� �����ϴ�.');
end if;
end;
/

--delete from employee;
--update franchise set employeecount=0;