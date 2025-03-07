<img src="https://capsule-render.vercel.app/api?type=waving&color=0:E34C26,10:DA5B0B,30:C6538C,75:3572A5,100:A371F7&height=100&section=header&text=&fontSize=0" width="100%"/>

# Spring 프로젝트: 괄호 안 쉼표 { , }

### 프로젝트 개요
이 프로젝트는 **알레르기 정보를 공유하는 커뮤니티와 알러지프리 제품 판매 쇼핑몰**을 구현하기 위해 개발되었습니다.  
✔ 사용자는 **알레르기 관련 뉴스 및 정보**를 확인할 수 있으며, **맞춤형 제품**을 검색하고 구매할 수 있습니다.  
✔ **실시간 커뮤니티 및 병원 검색 기능**을 제공하여 사용자 간 정보 공유를 활성화합니다.  
✔ 관리자 페이지에서 **상품, 리뷰, 통계, 설문조사** 등 사이트 운영 기능을 지원합니다.  

<br>
> 알레르기 정보 제공 + 알러지프리 제품 판매 사이트 제작<br>
> 기간: 2024.06.28. ~ 2024.08.05.(약 1달) => 2025.03 ~ 수정 중<br>
> 인원: 1명

🚀 **사이트 링크**: 👉 [http://49.142.157.251:9090/javaclassS14/](http://49.142.157.251:9090/javaclassS14/)
<hr>

## 🛠 기술 스택

### 🔹 Backend
![Java](https://img.shields.io/badge/Java-007396?style=flat-square&logo=Java&logoColor=white)
![Spring](https://img.shields.io/badge/Spring-6DB33F?style=flat-square&logo=Spring&logoColor=white)

### 🔹 Frontend
![JSP](https://img.shields.io/badge/JSP-007396?style=flat-square&logo=java&logoColor=white)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black)

### 🔹 Database
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)

### 🔹 DevOps & Tools
![Maven](https://img.shields.io/badge/Maven-C71A36?style=flat-square&logo=apache-maven&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Tomcat-F8DC75?style=flat-square&logo=apache-tomcat&logoColor=black)

### 🔹 기타
![Kakao API](https://img.shields.io/badge/KakaoAPI-FFCD00?style=flat-square&logo=kakaotalk&logoColor=black)
![CkEditor](https://img.shields.io/badge/CkEditor-4285F4?style=flat-square&logo=google-chrome&logoColor=white)
![PortOne 결제](https://img.shields.io/badge/PortOne-007396?style=flat-square&logo=credit-card&logoColor=white)
![D3.js](https://img.shields.io/badge/D3.js-F9A03C?style=flat-square&logo=d3.js&logoColor=white)

<br>

## 🚀 주요 기능

### 👤 회원 관리
- **사용자 기능**: 회원 가입, 로그인, 로그아웃, 프로필 수정  
- **보안 강화**: 비밀번호 암호화(Bcrypt, SHA-256) 적용  
- **관리자 기능**: 회원 목록 조회 및 관리, 탈퇴 회원 승인 처리  

### 🛒 상품 및 리뷰 관리
- **상품 기능**: 필터 조회, 상세 정보 제공  
- **리뷰 시스템**: 댓글 및 대댓글 기능, 태그 기반 추천 시스템  
- **사용자 맞춤 기능**: 최근 본 제품 & 관심 제품 저장  

### 🌐 알레르기 정보 제공
- **알레르기 뉴스 크롤링**: 네이버, 구글, 네이처  
- **공공 API 연동**: 환경공단 API를 활용한 미세먼지 정보 제공  
- **사용자 커뮤니티**: 실시간 채팅방 제공  
- **의료 서비스**: 병원 검색 및 후기 작성  

### ❓ QnA 및 고객 지원
- **문의 시스템**: 사용자 QnA 등록 및 관리자 답변 기능  
- **마케팅 기능**: 접속이 오래된 회원에게 자동 쿠폰 발송  
- **위치 기반 서비스**: 지점별 지도 및 QR코드 정보 제공  

### 🔧 관리자 기능 (Admin Panel)
- **사이트 운영 관리**: 사용자 계정, 상품, 리뷰, 설문조사 등록  
- **데이터 분석**: 가입 목적 및 판매 그래프 시각화  
- **백업 및 유지보수**: 덤프 파일 관리  

### 📊 데이터 분석 및 로그 기록
- **사용자 활동 추적**: 로그인 및 구매 활동 로그 기록  
- **통계 시각화**: D3.js를 활용한 판매 및 방문 데이터 분석  
- **관리자 대시보드 제공**: 핵심 지표 한눈에 보기  

### 🔐 보안 및 접근 권한 설정
- **권한 관리**: 회원과 관리자의 접근 권한 차별화  
- **정책 준수**: 회원 정책 동의 전, 회원가입 진행 불가  
- **보안 강화**: 비밀번호 암호화 및 보안 정책 적용  

<hr>
<br>

## 📸 프로젝트 화면

### 🏠 홈 화면
알레르기 관련 뉴스와 인기 제품을 한눈에 볼 수 있는 메인 페이지입니다.  
![홈 화면](https://github.com/user-attachments/assets/ce97ccca-8b19-4f0b-a2ce-bde35912a754)

### 🛒 상품 목록
필터를 이용해 맞춤형 제품을 검색할 수 있습니다.  
![상품 목록](https://github.com/user-attachments/assets/ce0ef15c-a921-4b97-9f4e-92f678a6639b)

### 📊 관리자 대시보드
가입 목적 및 판매 데이터를 분석하여 시각화합니다.  
![관리자](https://github.com/user-attachments/assets/3c0ee7bf-2f4b-4f51-aff4-3eaea8ae205a)

### 🌐 관련 뉴스 크롤링
네이버, 구글, 네이처의 알레르기 관련 뉴스를 자동으로 가져옵니다.  
![뉴스기사](https://github.com/user-attachments/assets/454e3b16-2d54-42ad-af6c-6ae5ff6f99d9)

<br/>  

## 📝 LICENSE
이 프로젝트는 **MIT License**에 따라 배포됩니다. 자세한 내용은 [`LICENSE`](./LICENSE) 파일을 확인하세요.
<br>

<a href="https://github.com/runicJ/github-readme-stats">
    <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=runicJ&layout=donut&show_icons=true&theme=material-palenight&hide_border=true&bg_color=20232a&icon_color=58A6FF&text_color=fff&title_color=58A6FF&count_private=true&exclude_repo=Face-Transfer-Application" width=32% />
</a>    
<a href="https://github.com/runicJ/github-readme-stats">
  <img src="https://github-readme-stats.vercel.app/api?username=runicJ&show_icons=true&theme=material-palenight&hide_border=true&bg_color=20232a&icon_color=58A6FF&text_color=fff&title_color=58A6FF&count_private=true" width=48% />
</a>

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:E34C26,10:DA5B0B,30:C6538C,75:3572A5,100:A371F7&height=40&section=footer&text=&fontSize=0" width="100%"/>
