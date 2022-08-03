

<1> 1번 가맹점의 최초로  배달을 요청한  '고객'의 데이터를 기록 관리 요청.
    ▷ID, 고객이름, 전화번호, 주소, 주문일자 출력
	select c.ID, c.customername, c.Loc, c.customernumber from delivery d , delicustomer c 
	where d.ordernumber =(select min(ordernumber) from delivery);

<2> 고객이 이용한 가맹점의 별점(star)을 통한 각 가맹점의 점수 관리 요청.
    ▷각 가맹점번호, 가맹점이름, 별점 출력
       - 단, 별점이 높은 순으로 출력
	select FranchiseNumber, FranchiseName, star from Franchise order by star desc;

<3> 고객의 주문이 방문인지 배달인지 구분하고, 배달한 경우의 고객의 정보 및 주문정보 
    확인요청.
     ▷2번 가맹점의 배달을 요청한 ID, 고객이름, 주문번호, 전화번호 출력
	select ID, customerName, orderDATE, customerPhonenumber from delivery 
	where frachisenumber=2;


<4> 가맹점의 신입사원이 입사할 경우, 해당 가맹점의 직원수 업데이트가 자동으로 되게 
    하라. (만약 퇴사자 발생 시 직원 수 변동 필요)
     ▷1번 가맹점의 직원번호, 직원이름 출력
	select FranchiseNumber, employeeNumber, employeeName from Employee 
	where FranchiseNumber=1;

     ▷1번 가맹점의 직원수와 같은 가맹점은 어디인지 출력.
	select FranchiseNumber from Employee 
	where FranchiseNumber=1 and count(*) in (select count(*) from employee group by FranchiseNumber);

<5> 해당 가맹점의 배달주문을 하면 고객의 정보들이 업데이트 되고, 신규 주문정보가 
    발생하여 주문정보가 업데이트 되도록 하고, 가장 마지막 배달주문의 내용을 출력하라.
     ▷가맹점번호, 주문번호, ID, 고객전화번호 출력
     select FranchiseNumber, orderNumber, ID, customerPhonenumber from delivery
     where orderNumber = (select max(orderNumber) from delivery);

<6> 가맹점에서 납품업체에 필요한 상품에 대해서 일정 수량만큼 요청했을 경우 납품정보
    업데이트 되도록 요청.
     ▷가맹점번호, 납품번호, 요청한 제품수량 출력
     select FranchiseNumber, supplyNumber, drinkCount, alcholeCount, chickenCount from INVENTORYCONTROL;

<7> 각 가맹점별 매출액 관리를 할 수 있게하여, 각 가맹점의 매출액은 얼마인지 확인하라.
     ▷가맹점번호, 매출액을 출력.  (단, 매출액이 낮은 순서대로 출력)
     select FranchiseNumber, totlaSAL from toSALES order by totalSAL;

<8> 가맹점의 방문 고객과 배달 고객 중 더 많은 고객이 주문한 방법이 무엇인지 출력하라.
     ▷2번 가맹점의 방문한 고객 수 출력 
       select count(*) from visit where FranchiseNumber=2;
     ▷2번 가맹점의 배달한 고객 수 출력 
       select count(*) from delivery where FranchiseNumber=2;
 /*    ▷2번 가맹점의 가장 많이 판매된 방법에 대한 고객 수, 평균 판매가격, 가장큰 판매가격을 출력 -- 어려워서 ㅈㅈ
       select count(*), avg(price), max(price)
       where 
*/
<9> 1번 가맹점의 사람들 중에 2번 가맹점의 아르바이트 생과 같은 업무를 하는 사람을 출력하라.
     ▷직원이름, 직원번호, 직급, 급여 출력 (단, 급여가 많은 순으로 정렬)
     select employeeName, employeeNumber, position, salary from Employee
     where FranchiseNumber = 1 and position = (select position from employee where FranchiseNumber =2 and position ='아르바이트');

<10> 2번 가맹점의 평균 급여보다 많이 받는 1번 가맹점의 사람들을 출력하라.
     ▷직원이름, 직원번호, 직급, 급여 출력
     select employeeName, employeeNumber, position, salary from Employee
     where FranchiseNumber = 1 and salary > (select avg(salary) from Employee where FranchiseNumber = 2);

<11> 21년 12월 31일 배달된 평균 치킨의 수보다 많이 배달한 고객들은 총 몇명인지 출력하라.
     ▷배달된 총 치킨 수, 총 고객 수 출력
     select sum(chickenCount), count(*) from delivery 
     where chickenCount >(select avg(chickenCount) from delivery where orderDATE='21/12/31');
