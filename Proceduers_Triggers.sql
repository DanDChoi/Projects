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
-- 납품받음.
create or replace trigger supply_trigger  
after insert on SUPPLY for each row
begin
    insert into INVENTORYCONTROL values( :new.supplyNumber , :new.FranchiseNumber , SYSDATE ,:new.drinkCount , :new.alcholeCount , :new.chickenCount );
end;
/

--납품표
create or replace trigger inven_trigger  
after insert on INVENTORYCONTROL for each row    
begin
    update FRANCHISE set drinkCount = (drinkCount + :new.drinkCount)  , alcholeCount = (alcholeCount + :new.alcholeCount) , chickenCount = ( chickenCount + :new.chickenCount ) where FranchiseNumber = :new.FranchiseNumber ;
end;
/


------------------------------------------------------------------
-- 프렌차이즈별로 수량체크하고 0 개가 되면 주문거부하는 프로시져
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
   RAISE_APPLICATION_ERROR(-20002,'드링크의 재고가 없습니다');
   end if;
   
   select alcholeCount into newalcholeCount from FRANCHISE where FranchiseNumber = r3;
   newalcholeCount := newalcholeCount-r1;
   
   if newalcholeCount>=0 
   then
   update FRANCHISE set alcholeCount=newalcholeCount where FranchiseNumber = r3;
   elsif newalcholeCount<0
   then
   RAISE_APPLICATION_ERROR(-20003,'술의 재고가 없습니다');
   end if;
   
   select chickenCount into newchiCount from FRANCHISE where FranchiseNumber = r3;
   newchiCount := newchiCount-r2;
   if newchiCount>=0 
   then
   update FRANCHISE set chickenCount=newchiCount where FranchiseNumber = r3;
   elsif newchiCount<0
   then
   RAISE_APPLICATION_ERROR(-20004,'닭의 재고가 없습니다');
   end if;
end;
/


-- 오더들어오면 프렌차이즈 수량변화함 
create or replace trigger buy_inven_trigger
after insert on ORDERS for each row 
begin
   buy_inven_procedure(:new.drinkCount , :new.alcholeCount , :new.chickenCount , :new.FranchiseNumber);
end;
/
--------------------------------------------------------------------


  


-----------------------------------------------------------------------------------------------------

-- 아이디(배달), 방문 나누기 + 주문표금액 cost
create or replace trigger sorting
after insert on ORDERS 
for each row
begin

if( :new.ID = '방문') 
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

-- 프렌차이즈별 쌓는 프로시져
create or replace procedure SALESCAL (r in number , r1 in number )
is
   v_total number;  
begin
    select totalSAL into v_total from toSALES where FranchiseNumber = r;
    v_total := v_total + r1;          
    update toSALES set totalSAL = v_total where FranchiseNumber = r;
end;
/



-- 프렌차이즈 별 매출액 
create or replace trigger total_SALES
after insert on SALES for each row
begin
    SALESCAL(:new.FranchiseNumber, :new.orderSALES);
end;
/

--딜리버리업데이트시 매출표로
create or replace trigger Deli_SALES 
after insert on  delivery  for each row 
begin 
     insert into SALES values (:new.orderNumber , :new.FranchiseNumber , :new.orderDATE , :new.customercost , :new.star); 
end;
/

--방문고객업데이트시 매출표로
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
   select avg(sum(star)) into avgCount from SALES  where FRANCHISENUMBER = :new.FRANCHISENUMBER group by orderNumber;  --해당 가맹점의 주문번호   
   update FRANCHISE set star = avgCount where FRANCHISENUMBER = :new.FRANCHISENUMBER;
end;
/

------------------------------------------------------
--직원 입사/퇴사 하면 해당 프렌차이즈 직원 수 변경 되는 트리거 
--직원 입사 하면 해당 프렌차이즈 직원수 증가
create or replace trigger plus_employee_trigger
after insert on EMPLOYEE for each row
begin

	update franchise set employeecount=(employeeCount+1)
	where franchiseNumber=:new.franchiseNumber;
end;
/

--직원 퇴사 하면 해당 프렌차이즈직원수 감소 되는 트리거
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
   RAISE_APPLICATION_ERROR(-20006 , '직원수가 0 명입니다 더 이상 해고할 사람이 없습니다.');
end if;
end;
/

--delete from employee;
--update franchise set employeecount=0;