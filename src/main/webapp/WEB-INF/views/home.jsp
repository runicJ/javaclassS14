<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css" integrity="sha256-DBYdrj7BxKM3slMeqBVWX2otx7x4eqoHRJCsSDJ0Nxw=" crossorigin="anonymous"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.2.6/gsap.min.js"></script>
    <link rel="stylesheet" href="${ctp}/images/home/style.css" />
  </head>

  <body>

    <div id="all">
  <div id="preloader">
    <div class="p">Dodo</div>
</div>
<div id="breaker"></div>

      <div class="cursor scale"></div>
      <div class="cursor-two  scale"></div>
      <!-- HOME -->
      <div id="home">
    
        <div class="navigation">
        
          <div class="logo home-link fade-down">
           <a href="${ctp}/main">홈페이지 입장하기</a>
          </div>
        
          <div class="navigation-links">
            <ul>
              <li class="links about-link fade-down"><a href="${ctp}/users/userLogin">
              	<span>더 많은 정보를 원하시나요? <br>미리 로그인 하세요.</span>
              </a></li>
              <li class="links contact-link fade-down"><a href="${ctp}/users/userResister">
              	<span>우리와 함께 정보를 공유해요. <br>더 맑은 내일을 살아가요.</span>
              </a></li>
            </ul>
          </div>
        
        </div>
        
              <div class="slider">
                <div class="container-fluid">
                  <div class="row">
                    <div class="col-md-12 p-0">
                      <div class="swiper-container parallax-slider">
                        <div class="swiper-wrapper">
                          <div class="swiper-slide">
                            <div class="img-container one">
                              <div class="slide-text opacity">
                                <a href="#0" class="project-link marine-project-link">MARINE 
                                  <div class="view-project">CLICK TO VIEW PROJECT</div>
                               </a>
                              </div>
                            </div>
                          </div>
                          <div class="swiper-slide">
                            <div class="img-container two">
                              <div class="slide-text opacity">
                                <a href="#0" class="project-link forest-project-link">FOREST
                                  <div class="view-project">CLICK TO VIEW PROJECT</div>
                                </a>
                              </div>
                            </div>
                          </div>
                          <div class="swiper-slide">
                            <div class="img-container three">
                              <div class="slide-text opacity">
                                <a href="#0" class="project-link wildlife-project-link">wildlife
                                  <div class="view-project">CLICK TO VIEW PROJECT</div>

                                </a>
                              </div>
                            </div>
                          </div>
                          <div class="swiper-slide">
                            <div class="img-container four">
                              <div class="slide-text opacity">
                                <a href="#0" class="project-link city-project-link">CITY
                                  <div class="view-project">CLICK TO VIEW PROJECT</div>

                                </a>
                              </div>
                            </div>
                          </div>
                        </div>
                        
                        <!-- slider controls -->
                        <div class="slider-controls fade-up-two">
                          <div class="control">
                            <div class="swiper-nav-ctrl prev-ctrl">
                              <img src="images/prev.png" alt="prev" class="slider-control-image">
                            </div>
                          </div>
                          <div class="swiper-pagination-container">
                            <div class="control">
                              <div class="swiper-pagination"></div>
                            </div>
                          </div>
                          <div class="control">
                            <div class="swiper-nav-ctrl next-ctrl">
                              <img src="images/next.png" alt="next" class="slider-control-image">
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="scroll-icon fade-up">
                <i class="gg-mouse"></i>
              </div>
              <div class="social-media-links">
                <ul>
                  <li class="fade-up"> <a href="#">FB</a> </li>
                  <li class="fade-up"> <a href="#">IN</a> </li>
                  <li class="fade-up"><a href="#">TW</a> </li>
                </ul>
              </div>
            </div>
      <!-- HOME -->


      <!-- ABOUT -->
<div id="about">
<div id="about-color"></div>
<div class="navigation navigation-about">
        
  <div class="logo home-link about-opacity">
   <a href="#"> JAMES TYLER</a>
  </div>

  <div class="navigation-links about-opacity">
   <div class="navigation-close hover about-close">
     <div class="navigation-close-line"></div>
     <div class="navigation-close-line"></div>
   </div>
  </div>

</div>
  <div class="about-content">
  <div class="container-fluid m-0 p-0">
    <div class="row">
    <div class="col-0 col-md-0 col-lg-6 col-sm-0 col-xs-0 p-0 m-0">
      <div class="about-img ">
      </div>
    </div>
   <div class="col-12 col-md-12 col-lg-6 col-sm-12 col-xs-12 p-0 m-0">
     <div class="about-text">
       <div class="about-text-container about-opacity">
       <div class="about-text-header">
			Hi , I'm a 22 y/o Canadian photographer,
			graduated in 2009
       </div>
       <div class="about-text-paragraph">
         Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ex debitis, nisi minima tempore repudiandae. 
       </div>
       <div class="about-text-paragraph">
        similique quis quos, reiciendis dignissimos doloremque sequi eius esse qui. A iste blanditiis fugiat necessitatibus voluptatibus.
      </div>
       <div class="about-text-button">
         <button class="contact-link-about contact-button hover">Contact Me</button>
       </div>
     </div>
    </div>
   </div>
  </div>
    </div>
  <div class="social-media-links about-opacity">
    <ul>
      <li> <a href="#">FB</a> </li>
      <li> <a href="#">IN</a> </li>
      <li> <a href="#">TW</a> </li>
    </ul>
  </div>
</div>
</div>
      <!-- ABOUT -->

      <!-- PROJECTS -->
      <div id="projects">

        <!-- MARINE PROJECT -->
        <div class="project marine-project">
          <div class="navigation navigation-project">
                
            <div class="logo home-link about-opacity">
             <a href="#"> JAMES TYLER</a>
            </div>
          
            <div class="navigation-links about-opacity">
             <div class="navigation-close hover marine-close">
               <div class="navigation-close-line"></div>
               <div class="navigation-close-line"></div>
             </div>
            </div>
          
          </div>
          <div class="col-12 p-0 m-0">
         <div class="slideshow-container">
           <div class="slides">
             <img src="images/header-image-one.webp" alt="marine-image">
           </div>
           <div class="slides">
            <img src="images/marine-image-three.webp" alt="marine-image">
          </div>
           <div class="slides">
             <img src="images/marine-image-six.webp" alt="marine-image">
           </div>
           <div class="slides">
             <img src="images/marine-image-five.webp" alt="marine-image">
           </div>
           <div class="slides">
             <img src="images/marine-image-two.webp" alt="marine-image">
           </div>
         </div>
        
         </div>
         <div class="controls">
          <button id ="prev" class="hover"><img src="images/prev.png" alt="" class="imgs"></button>
          <button id ="next" class="hover"><img src="images/next.png" alt="" class="imgs"></button>
        </div>
        <div class="project-name">
          MARINE
        </div>
        <div class="social-media-links opacity">
          <ul>
            <li> <a href="#">FB</a> </li>
            <li> <a href="#">IN</a> </li>
            <li> <a href="#">TW</a> </li>
          </ul>
        </div>
        </div>
<!-- MARINE PROJECT -->

<!-- FOREST PROJECT -->
<div class="project forest-project">
  <div class="navigation navigation-project">
        
    <div class="logo home-link about-opacity">
     <a href="#"> JAMES TYLER</a>
    </div>
  
    <div class="navigation-links about-opacity">
     <div class="navigation-close hover forest-close">
       <div class="navigation-close-line"></div>
       <div class="navigation-close-line"></div>
     </div>
    </div>
  
  </div>
  <div class="col-12 p-0 m-0">
 <div class="slideshow">
   <div class="forest-slides">
     <img src="images/header-image-two.webp" alt="marine-image">
   </div>
   <div class="forest-slides">
     <img src="images/forest-image-two.webp" alt="marine-image">
   </div>
   <div class="forest-slides">
     <img src="images/forest-image-three.webp" alt="marine-image">
   </div>
   <div class="forest-slides">
     <img src="images/forest-image-five.webp" alt="marine-image">
   </div>
   <div class="forest-slides">
     <img src="images/forest-image-six.webp" alt="marine-image">
   </div>
 </div>

 </div>
 <div class="controls">
  <button id ="forest-prev" class="hover"><img src="images/prev.png" alt="prev" class="imgs"></button>
  <button id ="forest-next" class="hover"><img src="images/next.png" alt="next" class="imgs"></button>
</div>
<div class="project-name">
  FOREST
</div>
<div class="social-media-links opacity">
  <ul>
    <li> <a href="#">FB</a> </li>
    <li> <a href="#">IN</a> </li>
    <li> <a href="#">TW</a> </li>
  </ul>
</div>
      </div>
<!-- FOREST PROJECT -->

<!-- wildlife PROJECT -->
<div class="project wildlife-project">
  <div class="navigation navigation-project">
        
    <div class="logo home-link about-opacity">
     <a href="#"> JAMES TYLER</a>
    </div>
  
    <div class="navigation-links about-opacity">
     <div class="navigation-close hover wildlife-close">
       <div class="navigation-close-line"></div>
       <div class="navigation-close-line"></div>
     </div>
    </div>
  
  </div>
  <div class="col-12 p-0 m-0">
 <div class="slideshow">
   <div class="wildlife-slides">
     <img src="images/header-image-three.webp" alt="marine-image">
   </div>
   <div class="wildlife-slides">
     <img src="images/wildlife-image-two.webp" alt="marine-image">
   </div>
   <div class="wildlife-slides">
     <img src="images/wildlife-image-three.webp" alt="marine-image">
   </div>
   <div class="wildlife-slides">
     <img src="images/wildlife-image-four.webp" alt="marine-image">
   </div>
   <div class="wildlife-slides">
     <img src="images/wildlife-image-five.webp" alt="marine-image">
   </div>
   <div class="wildlife-slides">
     <img src="images/wildlife-image-six.webp" alt="marine-image">
   </div>
 </div>

 </div>
 <div class="controls">
  <button id ="wildlife-prev" class="hover"><img src="images/prev.png" alt="prev" class="imgs"></button>
  <button id ="wildlife-next" class="hover"><img src="images/next.png" alt="next" class="imgs"></button>
</div>
<div class="project-name">
  wildlife
</div>
<div class="social-media-links opacity">
  <ul>
    <li> <a href="#">FB</a> </li>
    <li> <a href="#">IN</a> </li>
    <li> <a href="#">TW</a> </li>
  </ul>
</div>
      </div>
<!-- wildlife PROJECT -->

<!-- wildlife PROJECT -->
<div class="project city-project">
  <div class="navigation navigation-project">
        
    <div class="logo home-link about-opacity">
     <a href="#"> JAMES TYLER</a>
    </div>
  
    <div class="navigation-links about-opacity">
     <div class="navigation-close hover city-close">
       <div class="navigation-close-line"></div>
       <div class="navigation-close-line"></div>
     </div>
    </div>
  
  </div>
  <div class="col-12 p-0 m-0">
 <div class="slideshow">
   <div class="city-slides">
     <img src="images/header-image-four.webp" alt="city-image">
   </div>
   <div class="city-slides">
    <img src="images/city-two.webp" alt="city-image">
  </div>
   <div class="city-slides">
     <img src="images/city-image-three.webp" alt="city-image">
   </div>
   <div class="city-slides">
     <img src="images/city-image-four.webp" alt="city-image">
   </div>
   <div class="city-slides">
     <img src="images/city-image-five.webp" alt="city-image">
   </div>
 </div>

 </div>
 <div class="controls">
  <button id ="city-prev" class="hover"><img src="images/prev.png" alt="prev" class="imgs"></button>
  <button id ="city-next" class="hover"><img src="images/next.png" alt="next" class="imgs"></button>
</div>
<div class="project-name">
  CITY
</div>
<div class="social-media-links opacity">
  <ul>
    <li> <a href="#">FB</a> </li>
    <li> <a href="#">IN</a> </li>
    <li> <a href="#">TW</a> </li>
  </ul>
</div>
      </div>
<!-- CITY PROJECT -->


      <!-- PROJECTS -->
    </div>

<!--CONTACT PAGE-->
<div id="contact">
  <div class="navigation navigation-contact">
        
    <div class="logo home-link contact-opacity">
     <a href="#">JAMES TYLER</a>
    </div>
  
    <div class="navigation-links contact-opacity">
     <div class="navigation-close hover contact-close">
       <div class="navigation-close-line"></div>
       <div class="navigation-close-line"></div>
     </div>
    </div>
  
  </div>
  <div class="contact-header contact-opacity">
    getting in touch is easy.
  </div>
<div class="container-fluid">
  <div class="row p-0 m-0">
  
      <div class="col-12 col-md-12 col-lg-12 col-sm-12 col-xs-12 p-0 m-0">
        <div class="form contact-opacity" autocomplete="false">
          <form  id ="myForm" action="mail.php">
            <div class="input-line">
              <input id="name" type="text" placeholder="name" class="input-same-line">
              <input id="email" type="email" placeholder="email" class="input-same-line">
            </div>
            <div class="input-line-column">
              <input id="subject" type="text" placeholder="subject">
              <textarea name="textarea" id="body" class="textarea" placeholder="message"></textarea>
            </div>
           <button type="button" id="submit" class="hover">Send</button>
          </form>
        </div>
        </div>
</div>

</div>
</div>

<!--CONTACT PAGE-->



    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js" integrity="sha256-4sETKhh3aSyi6NRiA+qunPaTawqSMDQca/xLWu27Hg4=" crossorigin="anonymous"></script>
    <script src="${ctp}/js/home/jquery.min.js"></script>
    <script src="${ctp}/js/home/bez.js"></script>
    <script src="${ctp}/js/home/pace.js"></script>
    <script src="${ctp}/js/home/index.js"></script>
    <script>
       $(function(){
    //marine-slideshow
    var slide_index = 1;  
    displaySlides(slide_index);  
    function nextSlide() {  
        displaySlides(slide_index++);  
    }  
    function prevslide() {  
      displaySlides(slide_index--);   
    }  
    function displaySlides() {  
        var i;  
        var slides = document.getElementsByClassName("slides");  
        if (slide_index > slides.length ) { slide_index = 1 } 
        if (slide_index < 1) { slide_index = slides.length }  
        for (i = 0; i < slides.length; i++) {  
            slides[i].style.opacity = 0;  
           
        }  
        slides[slide_index - 1].style.opacity = 1;  
         
      }
      var next = document.getElementById('next');
      next.addEventListener('click',nextSlide);

      var prev = document.getElementById('prev');
      prev.addEventListener('click',prevslide);
  })

  //forest slideshow

  $(function(){
    var slide_index = 1;  
    displaySlides(slide_index);  
    function nextSlide() {  
        displaySlides(slide_index++);  
    }  
    function prevslide() {  
      displaySlides(slide_index--);   
    }  
    function displaySlides() {  
        var i;  
        var slides = document.getElementsByClassName("forest-slides");  
        if (slide_index > slides.length ) { slide_index = 1 } 
        if (slide_index < 1) { slide_index = slides.length }  
        for (i = 0; i < slides.length; i++) {  
            slides[i].style.opacity = 0;  
           
        }  
        slides[slide_index - 1].style.opacity = 1;  
         
      }
      var next = document.getElementById('forest-next');
      next.addEventListener('click',nextSlide);

      var prev = document.getElementById('forest-prev');
      prev.addEventListener('click',prevslide);
  })
  
  //wildlife slideshow

  $(function(){
    var slide_index = 1;  
    displaySlides(slide_index);  
    function nextSlide() {  
        displaySlides(slide_index++);  
    }  
    function prevslide() {  
      displaySlides(slide_index--);   
    }  
    function displaySlides() {  
        var i;  
        var slides = document.getElementsByClassName("wildlife-slides");  
        if (slide_index > slides.length ) { slide_index = 1 } 
        if (slide_index < 1) { slide_index = slides.length }  
        for (i = 0; i < slides.length; i++) {  
            slides[i].style.opacity = 0;  
           
        }  
        slides[slide_index - 1].style.opacity = 1;  
         
      }
      var next = document.getElementById('wildlife-next');
      next.addEventListener('click',nextSlide);

      var prev = document.getElementById('wildlife-prev');
      prev.addEventListener('click',prevslide);
  })


    //city slideshow

    $(function(){
      var slide_index = 1;  
      displaySlides(slide_index);  
      function nextSlide() {  
          displaySlides(slide_index++);  
      }  
      function prevslide() {  
        displaySlides(slide_index--);   
      }  
      function displaySlides() {  
          var i;  
          var slides = document.getElementsByClassName("city-slides");  
          if (slide_index > slides.length ) { slide_index = 1 } 
          if (slide_index < 1) { slide_index = slides.length }  
          for (i = 0; i < slides.length; i++) {  
              slides[i].style.opacity = 0;  
             
          }  
          slides[slide_index - 1].style.opacity = 1;  
           
        }
        var next = document.getElementById('city-next');
        next.addEventListener('click',nextSlide);
  
        var prev = document.getElementById('city-prev');
        prev.addEventListener('click',prevslide);

      
    })

    </script>

    
  </body>
</html>