# Filoom 🎬

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=887272&height=180&text=Filoom&animation=fadeIn&fontColor=000000&fontSize=60" />
</div>

## 📋 프로젝트 소개
Filoom은 사용자에게 다양한 영화 정보를 제공하고, 소통하며, 예매할 수 있는 종합 영화 플랫폼입니다.

### 🎯 주요 기능
- 영화 정보 조회 및 검색
- 실시간 영화 예매
- 사용자 리뷰 및 커뮤니티
- 이벤트 및 공지사항
- 1:1 문의 서비스

## 🛠 기술 스택
### 개발 환경
- **언어**: Java 11, HTML5, CSS3, JavaScript
- **라이브러리**: jQuery, JSTL
- **프레임워크**: Spring Framework 5.3.14, MyBatis, Bootstrap
- **데이터베이스**: Oracle 11g EE
- **서버**: Apache Tomcat 9.0.94

### 개발 도구
- **IDE**: STS, Oracle SQL Developer, Visual Studio Code
- **설계 도구**: ERDCloud, Figma, draw.io
- **협업 도구**: Slack, GitHub

## 👥 프로젝트 정보
- **팀원**: 5명
- **기간**: 2024.12.05 ~ 2024.12.26 (21일)

## 📸 프로젝트 화면
### 메인 페이지
<img width="20%" src="/filoomMainPage.PNG"/>

### 예매 프로세스
<img width="20%" src="/selectMovie.PNG"/>
<img width="20%" src="/selectDate.PNG"/>
<img width="20%" src="/selectSeat.PNG"/>

### 결제 프로세스
<img width="20%" src="/pay.PNG"/>
<img width="20%" src="/paymentResult.PNG"/>

> [전체 UI 보고서 보기](https://www.canva.com/design/DAGXp-2z_r4/a0Nagt2UYwKxw7aBsm-xYw/edit?utm_content=DAGXp-2z_r4&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

## 📊 시스템 설계
### ERD
<img width="30%" src="/ERD.PNG"/>

### 시스템 다이어그램
<img width="30%" src="/diagram.PNG/">

## 👨‍💻 팀원별 담당 기능

### 김다훈
#### 회원 관리
- 로그인/로그아웃
- 회원가입 (이메일 본인인증)
- 아이디/비밀번호 찾기
- 마이페이지 관리
  - 개인정보 관리
  - 예매 내역
  - 좋아요 영화
  - 리뷰 관리
  - 쿠폰/이벤트 관리

### 정원섭
#### 영화 관리
- 영화 목록/검색
- 필터링 및 정렬
- 영화 상세 정보
- 리뷰 시스템
  - 리뷰 CRUD
  - 필터링

### 김형문, 박재우
#### 예매 시스템
- 영화 예매
- 결제 시스템 연동
- 예매 취소
- 예매 내역 관리

### 한혜원
#### 커뮤니티 관리
- 공지사항
- 이벤트 게시판
- 댓글 시스템
- 1:1 문의
