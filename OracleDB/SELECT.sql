 -- 1�� �������߿� 1���� ��� ���� ���� ���� �Ǹž��� ���� ������� 1~3������� ������ �̸�, �����ð� , �Ǹűݾ� , �ֹ���ȣ , �ּҸ� �˰� �ʹ�.
select * FROM (select d.orderNumber,o.FranchiseName,d.customercost , o.businesshours , o.FLoc 
	       from (select orderNumber,franchiseNumber,customercost from delivery)d, FRANCHISE o 
	       where  o.FranchiseNumber = d.FranchiseNumber AND d.customercost > 0 order by customercost desc)
where rownum between 1 and 3;     --rownum ��ȸ ������� ��ȣ �ű�
      
--  2�� �������� �Ҽӵ� ������� �̸��� ����, ���� ������ ���ÿ�. java �� case
   select employee.employeeName, employee.position,
            decode(franchise.franchiseNumber, --�÷�
          1,'������', --����,����� -->������ ��µ�
          2,'������',
          3,'������',
          4,'������',
          5,'õ����',
          'UNKNOWN')����
       from employee, franchise
       where franchise.franchiseNumber = employee.franchiseNumber;


 --3�� ������(������ ����)�� ������ �� , �������� �̸�,������ ��ȣ, ���� , ������ �̸��� �޿� , ���� ���� ���Ͻÿ�.
  select f.franchiseName , f.franchiseNumber , f.star , e.employeeName , e.salary , f.employeeCount
  from franchise f , employee e where exists(select * from employee where position = '����') 
  and e.franchiseNumber=  f.franchiseNumber and e.franchiseNumber = (select franchiseNumber from employee where position ='����');

  --4  ceil , round , foot , trunc  
       ��ü �ֹ� �� 15 �� ��, �ֹ���ȣ�� 1�� �������� ����, �������� �̸� , ����� , ��������ȣ�� ����Ͻÿ�. 
       (�� , ������ �Ҽ��� ù°¥�������� ����Ͻÿ� , or �ݿø� �Ǵ� �ڸ��� ) 

       select (select orderNumber from orders where orderNumber = 15) as orderNumber  , round(f.star, 2) 
       , f.franchiseName ,  t.totalSAL , f.franchiseNumber from franchise f , toSALES t
       where (select orderNumber from orders where orderNumber = 15) = 15
       and f.franchiseNumber = 1
       and f.franchiseNumber = t.franchiseNumber;

         --4  ceil , round , foot , trunc  
       ��ü �ֹ����� �� �ֹ���ȣ�� 15 �� ��, �ֹ���ȣ�� 1�� �������� ����, �������� �̸� , ����� , ��������ȣ�� ����Ͻÿ�. 
       (�� , ������ �Ҽ��� ù°¥�������� ����Ͻÿ� , or �ݿø� �Ǵ� �ڸ��� ) 

       select (select orderNumber from orders where orderNumber = 15) as orderNumber  , round(f.star, 2) 
       , f.franchiseName ,  t.totalSAL , f.franchiseNumber from franchise f , toSALES t
       where (select orderNumber from orders where orderNumber = 15) = 15
       and f.franchiseNumber = 1
       and f.franchiseNumber = t.franchiseNumber;
              
     
	--5  ���� ��� �ֹ��� �� ����� �̸��� , ����ó , �ּҸ� �̰� �������� ��ȣ, �������̸��� ����Ͻÿ�.

	select t.customerName, t.customerPhoneNumber , t.Loc , f.franchiseNumber , f.franchiseName   
	from DELICUSTOMER t , franchise f where t.ID = ( select * from 
								(select ID  from delivery Group by ID order by count(ID) desc ) 
							where rownum = 1)
	and f.franchiseNumber = ( select * from 
					(select franchiseNumber from delivery 
					 where ID = ( select * from 
							(select ID  from delivery Group by ID order by count(ID) desc )
						     where rownum = 1)
					 Group by franchiseNumber order by count(ID) desc)
			         where rownum = 1);