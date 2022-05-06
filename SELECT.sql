 -- 1번 가맹점중에 1건의 배달 기준 가장 높은 판매액을 가진 순서대로 1~3등까지의 지점의 이름, 영업시간 , 판매금액 , 주문번호 , 주소를 알고 싶다.
select * FROM (select d.orderNumber,o.FranchiseName,d.customercost , o.businesshours , o.FLoc 
	       from (select orderNumber,franchiseNumber,customercost from delivery)d, FRANCHISE o 
	       where  o.FranchiseNumber = d.FranchiseNumber AND d.customercost > 0 order by customercost desc)
where rownum between 1 and 3;     --rownum 조회 순서대로 번호 매김
      
--  2번 가맹점에 소속된 사원들의 이름과 직급, 약어로 지점을 쓰시오. java 의 case
   select employee.employeeName, employee.position,
            decode(franchise.franchiseNumber, --컬럼
          1,'가디점', --조건,결과값 -->지점만 출력됨
          2,'구디점',
          3,'가산점',
          4,'서울점',
          5,'천왕점',
          'UNKNOWN')지점
       from employee, franchise
       where franchise.franchiseNumber = employee.franchiseNumber;


 --3번 직영점(점장이 존재)이 존재할 때 , 직영점의 이름,직영점 번호, 평점 , 직원의 이름과 급여 , 직원 수를 구하시오.
  select f.franchiseName , f.franchiseNumber , f.star , e.employeeName , e.salary , f.employeeCount
  from franchise f , employee e where exists(select * from employee where position = '점장') 
  and e.franchiseNumber=  f.franchiseNumber and e.franchiseNumber = (select franchiseNumber from employee where position ='점장');

  --4  ceil , round , foot , trunc  
       전체 주문 수 15 일 때, 주문번호와 1번 가맹점의 평점, 가맹점의 이름 , 매출액 , 가맹점번호를 출력하시오. 
       (단 , 평점은 소숫점 첫째짜리까지만 출력하시오 , or 반올림 또는 자르기 ) 

       select (select orderNumber from orders where orderNumber = 15) as orderNumber  , round(f.star, 2) 
       , f.franchiseName ,  t.totalSAL , f.franchiseNumber from franchise f , toSALES t
       where (select orderNumber from orders where orderNumber = 15) = 15
       and f.franchiseNumber = 1
       and f.franchiseNumber = t.franchiseNumber;

         --4  ceil , round , foot , trunc  
       전체 주문내역 중 주문번호가 15 일 때, 주문번호와 1번 가맹점의 평점, 가맹점의 이름 , 매출액 , 가맹점번호를 출력하시오. 
       (단 , 평점은 소숫점 첫째짜리까지만 출력하시오 , or 반올림 또는 자르기 ) 

       select (select orderNumber from orders where orderNumber = 15) as orderNumber  , round(f.star, 2) 
       , f.franchiseName ,  t.totalSAL , f.franchiseNumber from franchise f , toSALES t
       where (select orderNumber from orders where orderNumber = 15) = 15
       and f.franchiseNumber = 1
       and f.franchiseNumber = t.franchiseNumber;
              
     
	--5  많이 배달 주문을 한 사람의 이름과 , 연락처 , 주소를 뽑고 가맹점의 번호, 가맹점이름을 출력하시오.

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