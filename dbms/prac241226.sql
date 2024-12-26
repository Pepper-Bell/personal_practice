-- 계정명 : test01
-- 비밀번호 : 1234

-- 계정 만들고 a1~a4 테이블 등록 후 문제 풀기

--환경설정!
--먼저 sqlplus로 오라클 접속
--sys as sysdba 로 최고계정에 접속 (새로운 계정을 생성하고 권한을 부여하기 위함)
--create user test01 identified by 1234; test01계정명에 비밀번호 1234로해서 계정 생성하기
--grant create session, create table, create view, resource to test01; test01 계정이 세션에 접근, 테이블 생성, 뷰 생성, 리소스(객체, 데이터) 권한을 부여
--conn test01/1234; test01 계정으로 접속
--@하고 a1-4 파일 가져와서 넣어주기
--디비버에서 test01 계정으로 연결하고 테이블 확인하기

/* 1. JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 조회 */
SELECT j.JOB_TITLE 직무, e.email 이메일, e.last_name 성, e.first_name 이름
FROM JOBS j JOIN EMPLOYEES e ON j.JOB_ID = e.JOB_ID;

/* 2. EMPLOYEES 테이블에서 HIREDATE가 2003~2004년까지인 사원의 정보와 부서명 검색 */
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME 사원명, d.DEPARTMENT_NAME 부서명
FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
WHERE e.HIRE_DATE BETWEEN TO_DATE(20030101) AND TO_DATE(20041231); 

SELECT e.FIRST_NAME || ' ' || e.LAST_NAME 사원명, d.DEPARTMENT_NAME 부서명
FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND e.HIRE_DATE BETWEEN '2003-01-01' AND '2004-12-31'; 

/* 3. EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색 */
SELECT d.DNAME , d.LOC 
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE e.ENAME LIKE '%L%';

SELECT d.DNAME , d.LOC 
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO AND e.ENAME LIKE '%L%';

/* 4. SCHEDULE 테이블에서 경기 일정이 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회 */
SELECT s2.*
FROM SCHEDULE s JOIN STADIUM s2 ON s.STADIUM_ID = s2.STADIUM_ID 
WHERE s.SCHE_DATE BETWEEN 20120501 AND 20120502;

/* 5. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */
/* 위 문제를 JOIN없이 풀기
 * (A,B) IN (C, D) : A = C AND B = D */
SELECT * FROM PLAYER p 
WHERE (TEAM_ID, HEIGHT) IN (SELECT TEAM_ID, MAX(HEIGHT) FROM PLAYER p2 GROUP BY TEAM_ID);

/* 6. EMP 테이블의 SAL을 이용, SALGRAED 테이블을 참고하여 모든 사원의 정보를 GRADE를 포함하여 조회 */
SELECT * FROM EMP e ; --전체 테이블 조회

SELECT *
FROM EMP e JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL;


/* 7. EMP 테이블에서 각 사원의 매니저 이름 조회 */
SELECT e.ENAME 사원, e2.ename 매니저
FROM EMP e 
JOIN(
	SELECT EMPNO, ENAME 
	FROM EMP
)e2 ON e.MGR = e2.empno;


/* 8. 축구 선수들 중에서 각 팀 별로 키가 가장 큰 선수들의 전체 정보 조회 */
SELECT *
FROM (SELECT team_id, MAX(height) height FROM PLAYER  GROUP BY team_id)p1
JOIN PLAYER p2 ON p1.team_id = p2.TEAM_ID AND p1.height = p2.HEIGHT ;