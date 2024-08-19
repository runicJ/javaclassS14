<img src="https://capsule-render.vercel.app/api?type=waving&color=0:E34C26,10:DA5B0B,30:C6538C,75:3572A5,100:A371F7&height=100&section=header&text=&fontSize=0" width="100%"/>

<h2>Spring 프로젝트</h2>
<h4>괄호 안 쉼표 { , }</h4>
<hr>
> 알레르기 정보 + 알러지프리 제품 판매 사이트 제작<br>
> 기간: 2024.06.28. ~ 2024.08.05.<br>
> 인원: 1명

##### 사이트 링크 : 
##### PDF 다운로드 : 
<hr>
<h2>사용 기술 스택</h2>
<ul>
    <li>
      <img src="https://img.shields.io/badge/java-red?style=for-the-badge&logo=java&logoColor=white"> 
      <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white">
    </li>
    <li>
      <img src="https://img.shields.io/badge/apache tomcat-orange?style=for-the-badge&logo=apachetomcat&logoColor=white">
      <img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
      <img src="https://img.shields.io/badge/myBatis-black?style=for-the-badge&logo=myBatis&logoColor=white">
    <li>
      <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
      <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"> 
      <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> 
      <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white">
      <img src="https://img.shields.io/badge/bootstrap4-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white">
      <img src="https://img.shields.io/badge/fontawesome-339AF0?style=for-the-badge&logo=fontawesome&logoColor=white">
    </li>
    <li>
        Kakao API / CkEditor / 포트원 결제 모듈 / D3.js
    </li>
</ul>
5-1) <pre><code>{code}</code></pre> 이용
<pre>
<code>
def print_text():
    print("Hello Wolrd!!")
</code>
</pre>

5-1) "```" 을 이용
코드블럭코드("```") 시작점에 사용하는 언어를 선언하여 문법강조(Syntax highlighting)이 가능

```python
def print_text():
    print("Hello Wolrd!!")
```

def print_text():
    print("Hello Wolrd!!")

- 수평선 (Horizontal Rule)
각 기호를 3개 이상 입력
마크다운 문서를 미리보기로 출력할 때 페이지 나누기 용도로 많이 사용
* * *

***

*****

- - -

---------------------------------------

- 강조 (Emphasis)
*기울어진 글씨*
_기울어진 글씨_
**굵은 글씨**
__굵은 글씨__
~~취소선 글씨~~

8-1) 참조링크
[link keyword][id]
[id]: URL "Optional Title here"
Link: Google

- 링크걸기
<https://www.naver.com>
[네이버](www.naver.com)

8-2) 자동연결
일반적인 URL 혹은 이메일주소인 경우 적절한 형식으로 링크를 형성

* 외부링크: <http://example.com/>
* 이메일링크: <address@example.com>

- 이미지의 크기나 정렬은 html 문법을 이용
<img width="" height=""></img>를 이용하며, 정렬을 위해서는 추가적으로 <div align="center"> </div>  을 이용
width, height에 직접 사이즈를 지정하거나 비율(%)로 지정 할 수 있음
![Markdown Image](asset/images/test_image.jpg "Tooltip Message")
<img src="asset/images/test_image.jpg" width="450px" height="300px" title="px(픽셀) 크기 설정" alt="Markdown Image"></img><br/>
<div align="center">
  <img src="asset/images/test_image.jpg" width="20%">
</div>

10. 표 (Table)
10-1) 일반적인 표
테이블 안에 | 파이프 기호를 사용하려면 파이프 기호 대신에 &#124; 를 입력
|제목|&#124;내용&#124;|설명|
|------|---|---|
|테스트1|테스트2|테스트3|
|테스트1|테스트2|테스트3|
|테스트1|테스트2|테스트3|

10-2) 셀 정렬
: 문자로 정렬을 정의
|제목|내용|설명|
|:---|---:|:---:|
|왼쪽정렬|오른쪽정렬|중앙정렬|
|왼쪽정렬|오른쪽정렬|중앙정렬|
|왼쪽정렬|오른쪽정렬|중앙정렬|

10-3) 셀 확장
사이가 비어있으면 자동으로 확장
|제목|내용|설명|
|:---|:---:|---:|
||중앙에서확장||
|||오른쪽에서 확장|
|왼쪽에서확장||

10-4) 셀 강조
일반적인 text와 마찬가지로 * 와 ** 를 통해 이탤릭/강조를 표시할 수 있습니다. span tag를 사용하면 컬러도 표시 가능
|제목|내용|설명|
|---|---|---|
|테스트1|*강조1*|테스트3|
|테스트1|**강조2**|테스트3|
|테스트1|<span style="color:red">강조3</span>|테스트3|

11. 각주 (Footnote)
각주<sup>[1](#각주 이름)</sup>
<a name="각주 이름">1</a>: 각주에 대한 설명
각주[1](#각주 이름)

12. 접기 (Fold)
<details><summary>Click Me</summary>
Good!!
</details>    
Click Me

13. 이스케이프 (Backslash Escapes)
마크다운으로 글을 작성하다 보면 * 문자나 _ 문자 등을 사용하고 싶은 경우 \ 문자로 회피
강조는 \* 문자 혹은 \_ 문자를 사용

<details>
<summary>About Me
•	개발 환경: Windows
•	데이터베이스: MySQL 5.7
•	프로그래밍 언어 및 기술: Java, JavaScript, JSP, jQuery, HTML5, CSS
•	서버: Apache Tomcat 9.0
•	IDE: Eclipse 2023-06
•	Spring Framework: STS-4.14.1.RELEASE
</summary>

<span>
  <a href="https://www.instagram.com/6unoyunr/">
    <img src="https://img.shields.io/badge/Instagram-ff69b4?style=plastic&logo=Instagram&logoColor=white"/>
  </a>
</span>

<a href="https://github.com/runicJ/github-readme-stats">
    <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=runicJ&layout=donut&show_icons=true&theme=material-palenight&hide_border=true&bg_color=20232a&icon_color=58A6FF&text_color=fff&title_color=58A6FF&count_private=true&exclude_repo=Face-Transfer-Application" width=38% />
</a>    
<a href="https://github.com/runicJ/github-readme-stats">
  <img src="https://github-readme-stats.vercel.app/api?username=runicJ&show_icons=true&theme=material-palenight&hide_border=true&bg_color=20232a&icon_color=58A6FF&text_color=fff&title_color=58A6FF&count_private=true" width=56% />
</a>
<a href="https://github.com/runicJ/github-readme-activity-graph">
    <img src="https://github-readme-activity-graph.vercel.app/graph?username=runicJ&theme=react-dark&bg_color=20232a&hide_border=true&line=58A6FF&color=58A6FF" width=94%/>
</a>

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:E34C26,10:DA5B0B,30:C6538C,75:3572A5,100:A371F7&height=40&section=footer&text=&fontSize=0" width="100%"/>
