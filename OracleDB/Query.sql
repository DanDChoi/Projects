

<1> 1�� �������� ���ʷ�  ����� ��û��  '��'�� �����͸� ��� ���� ��û.
    ��ID, ���̸�, ��ȭ��ȣ, �ּ�, �ֹ����� ���
	select c.ID, c.customername, c.Loc, c.customernumber from delivery d , delicustomer c 
	where d.ordernumber =(select min(ordernumber) from delivery);

<2> ���� �̿��� �������� ����(star)�� ���� �� �������� ���� ���� ��û.
    ���� ��������ȣ, �������̸�, ���� ���
       - ��, ������ ���� ������ ���
	select FranchiseNumber, FranchiseName, star from Franchise order by star desc;

<3> ���� �ֹ��� �湮���� ������� �����ϰ�, ����� ����� ���� ���� �� �ֹ����� 
    Ȯ�ο�û.
     ��2�� �������� ����� ��û�� ID, ���̸�, �ֹ���ȣ, ��ȭ��ȣ ���
	select ID, customerName, orderDATE, customerPhonenumber from delivery 
	where frachisenumber=2;


<4> �������� ���Ի���� �Ի��� ���, �ش� �������� ������ ������Ʈ�� �ڵ����� �ǰ� 
    �϶�. (���� ����� �߻� �� ���� �� ���� �ʿ�)
     ��1�� �������� ������ȣ, �����̸� ���
	select FranchiseNumber, employeeNumber, employeeName from Employee 
	where FranchiseNumber=1;

     ��1�� �������� �������� ���� �������� ������� ���.
	select FranchiseNumber from Employee 
	where FranchiseNumber=1 and count(*) in (select count(*) from employee group by FranchiseNumber);

<5> �ش� �������� ����ֹ��� �ϸ� ���� �������� ������Ʈ �ǰ�, �ű� �ֹ������� 
    �߻��Ͽ� �ֹ������� ������Ʈ �ǵ��� �ϰ�, ���� ������ ����ֹ��� ������ ����϶�.
     ����������ȣ, �ֹ���ȣ, ID, ����ȭ��ȣ ���
     select FranchiseNumber, orderNumber, ID, customerPhonenumber from delivery
     where orderNumber = (select max(orderNumber) from delivery);

<6> ���������� ��ǰ��ü�� �ʿ��� ��ǰ�� ���ؼ� ���� ������ŭ ��û���� ��� ��ǰ����
    ������Ʈ �ǵ��� ��û.
     ����������ȣ, ��ǰ��ȣ, ��û�� ��ǰ���� ���
     select FranchiseNumber, supplyNumber, drinkCount, alcholeCount, chickenCount from INVENTORYCONTROL;

<7> �� �������� ����� ������ �� �� �ְ��Ͽ�, �� �������� ������� ������ Ȯ���϶�.
     ����������ȣ, ������� ���.  (��, ������� ���� ������� ���)
     select FranchiseNumber, totlaSAL from toSALES order by totalSAL;

<8> �������� �湮 ���� ��� �� �� �� ���� ���� �ֹ��� ����� �������� ����϶�.
     ��2�� �������� �湮�� �� �� ��� 
       select count(*) from visit where FranchiseNumber=2;
     ��2�� �������� ����� �� �� ��� 
       select count(*) from delivery where FranchiseNumber=2;
 /*    ��2�� �������� ���� ���� �Ǹŵ� ����� ���� �� ��, ��� �ǸŰ���, ����ū �ǸŰ����� ��� -- ������� ����
       select count(*), avg(price), max(price)
       where 
*/
<9> 1�� �������� ����� �߿� 2�� �������� �Ƹ�����Ʈ ���� ���� ������ �ϴ� ����� ����϶�.
     �������̸�, ������ȣ, ����, �޿� ��� (��, �޿��� ���� ������ ����)
     select employeeName, employeeNumber, position, salary from Employee
     where FranchiseNumber = 1 and position = (select position from employee where FranchiseNumber =2 and position ='�Ƹ�����Ʈ');

<10> 2�� �������� ��� �޿����� ���� �޴� 1�� �������� ������� ����϶�.
     �������̸�, ������ȣ, ����, �޿� ���
     select employeeName, employeeNumber, position, salary from Employee
     where FranchiseNumber = 1 and salary > (select avg(salary) from Employee where FranchiseNumber = 2);

<11> 21�� 12�� 31�� ��޵� ��� ġŲ�� ������ ���� ����� ������ �� ������� ����϶�.
     ����޵� �� ġŲ ��, �� �� �� ���
     select sum(chickenCount), count(*) from delivery 
     where chickenCount >(select avg(chickenCount) from delivery where orderDATE='21/12/31');
