# Shoes Monster
> 신발 생산 관리 MES 웹페이지 <br>
> http://c7d2301t2.itwillbs.com/smmain/smMain



## 1. 개발기간 & 참여인원

> 개발기간: 2023.06.08 ~ 2023.07.12 <br>
> 참여인원: 7명 

## 2. 프로젝트 소개
Shoes Monster는 신발 생산 공정에서 쓰일 것을 가정하고 만든 MES 프로젝트입니다.

## 3. 기술스택
### 개발환경
![eclipse](https://img.shields.io/badge/Spring-6DB33F?style=flat-square&logo=Spring&logoColor=white)
![Github](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=GitHub&logoColor=white)    

### 개발언어
![JAVA](https://img.shields.io/badge/JAVA-007396?style=flat-square&logo=java&logoColor=FFFFFF)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=FFFFFF)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=FFFFFF)

### 협업도구
![Slack](https://img.shields.io/badge/Discord-7289DA?style=flat-square&logo=Discord&logoColor=white)



## 4. 화면 구성 & 맡은 기능

### 📍작업흐름도
<img width="730" src="https://github.com/soRan0219/parkIT/assets/124494718/e0488b24-2d5c-45ed-a99d-0d53f111ea29"/>

### 📍메인 페이지 
<img width="730" src="https://github.com/soRan0219/parkIT/assets/124494718/0b71f01c-0b24-4093-9531-2e994d7c75ff"/>

### 📍공통  
- input 박스 클릭 시 팝업창 활성화
- 상세페이지 모달창, 현재 페이지 리스트 엑셀로 다운로드 등 

### 📍작업 지시 관리 
<img width="730" src="https://github.com/soRan0219/parkIT/assets/124494718/7305ec0f-a53c-4d74-a886-094060ebb4cb"/>
<img width="730" src="https://github.com/soRan0219/parkIT/assets/124494718/17624eaf-fdd2-4993-88ae-7996748fe3fb"/>

- 작업지시 '추가'시 1차공정 라인 중 사용 가능한 라인에 자동 배정
- 공정마감 버튼 클릭 시 공정마감
- 작업지시 '추가' 혹은 '수정'시 해당 품목의 소요량만큼 원자재 재고에서 차감
- 재고 부족 시 confirm 창 -> '확인' 클릭 시 발주 페이지로 이동

### 📍생산실적 관리 
<img width="730" src="https://github.com/soRan0219/parkIT/assets/124494718/028e638c-c866-490e-a573-802b8feaee02"/>

- input 박스 클릭 시 팝업창 활성화
- 작업지시코드 팝업창 활성화 시 지시상태가 '마감'인 작업지시만 보여줌 
- 생산실적 '추가'시 기본 현황은 '진행'
- 생산실적 '추가' 혹은 '수정'시 작업지시 수량과 양품수를 비교한 뒤 양품수가 지시수량보다 많거나 같을 때 현황 '마감'으로 변경
- '마감'으로 변경시 같은 작업지시코드를 가진 품목의 양품수를 더해 완제품 재고 증가 
