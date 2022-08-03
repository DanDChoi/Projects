drop trigger buy_inven_trigger;
drop trigger inven_trigger  ;
drop trigger supply_trigger ;
drop trigger avgstar;
drop trigger sorting;
drop trigger total_SALES;
drop trigger Deli_SALES;
drop trigger visit_SALES;
drop trigger avgstar1;
drop procedure SALESCAL;
drop procedure buy_inven_procedure;
drop sequence supply_SEQ;
drop sequence orderCount_SEQ;

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
purge recyclebin;

select * from tab;
