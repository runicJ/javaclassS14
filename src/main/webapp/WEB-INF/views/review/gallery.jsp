<!DOCTYPE html>
<html lang="en">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.png">

    <title>Photo Graphy</title>
   
    <link href="css/navmenu-reveal.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/component.css" />
    <link href="css/lightbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javaScript" src="js/modernizr.min.js"></script>
	<style>
		html,
		body {
		    height: 100%;
		}
		
		.carousel,
		.item,
		.active {
		    height: 100%;
		}
		
		.carousel-inner {
		    height: 100%;
		}
		
		/* Background images are set within the HTML using inline CSS, not here */
		
		.fill {
		    width: 100%;
		    height: 100%;
		    background-position: center;
		    -webkit-background-size: cover;
		    -moz-background-size: cover;
		    background-size: cover;
		    -o-background-size: cover;
		}
		
		footer {
		    margin: 50px 0;
		}
		@media (max-width: 1090px){
		    div.canvas {
		      /*margin-top: -50px !important;*/
		      height: 110% !important;
		    }
		    .carousel, .item, .active {
		  height: 110% !important;
		  margin-top: -50px !important;
		}
		}
		/* Fade transition for carousel items */
		.carousel .item {
		    -webkit-transition: opacity 3s; 
		    -moz-transition: opacity 3s; 
		    -ms-transition: opacity 3s; 
		    -o-transition: opacity 3s; 
		    transition: opacity 3s;
		    transition:.6s;
		}
		.carousel .active.left {
		    left:0;opacity:0;z-index:2;
		}
		.carousel .next {
		    left:0;opacity:1;z-index:1;
		}
				
	
		/* ----------------------------------------------------
		  Gallery
		------------------------------------------------------- */
		
		/* ---- grid ---- */
		
		.grid {
		  /* background: #DDD; */
		  max-width: 1200px;
		}
		/* clear fix */
		
		.grid:after {
		  content: '';
		  display: block;
		  clear: both;
		}
		/* ---- .grid-item ---- */
		
		.grid-item {
		  float: left;
		  width: 100px;
		  height: 100px;
		  background: #0D8;
		  border: 2px solid white;
		  border-color: white;
		}
		
		.grid-item--width2 {
		  width: 200px;
		}
		
		.grid-item--height2 {
		  height: 200px;
		}


		#filter-all{
			transition:0s;
		}
		
		
		#header{
			background-color: #3f8dbf;
			float: left;
			width: 100%;
			height: 50px;
			color: rgba(255,255,255,1);
			line-height: 50px;
		}
		#header a {
			color: rgba(255,255,255,1);
			text-decoration: none;
			display: block;
			font-size: 15px;
		}
		#header-left{
			float: left;
			height: 50px;
		}
		#header-left:hover #header-left-icon{
			background-color: #3F8DBF;
		}
		#header-left:hover #header-left-text{
			background-color: #599BC8;
		}
		#header-left-icon{
			float: left;
			height: 50px;
			width: 50px;
			text-align: center;
			background-color: #35759F;
			-webkit-transition: background 0.5s;
			-moz-transition: background 0.5s;
			-o-transition: background 0.5s;
			transition: background 0.5s;
		}
		#header-left-icon a {
			font-size: 25px;
		}
		
		#header-left-text{
			float: left;
			height: 50px;
				-webkit-transition: background 0.5s;
			-moz-transition: background 0.5s;
			-o-transition: background 0.5s;
			transition: background 0.5s;
		}
		#header-left-text a {
			padding-left: 20px;
			padding-right: 20px;
		}
		#header-right{
			float: right;
			height: 50px;
		}
		#header-right:hover #header-right-icon{
			background-color: #3F8DBF;
			}
		#header-right:hover #header-right-text{
			background-color: #599BC8;
			}
		#header-right-icon{
			float: right;
			height: 50px;
			width: 50px;
			text-align: center;
			background-color: #35759F;
			-webkit-transition: background 0.5s;
			-moz-transition: background 0.5s;
			-o-transition: background 0.5s;
			transition: background 0.5s;
		}
		#header-right-text{
			float: right;
			height: 50px;
			-webkit-transition: background 0.5s;
			-moz-transition: background 0.5s;
			-o-transition: background 0.5s;
			transition: background 0.5s;
		}
		#header-right-text a {
			padding-right: 20px;
			padding-left: 20px;
		}
		#gallery{
			float: left;
			width: 100%;
		}
		#gallery-header{
			height: 100px;
			width: 100%;
			float: left;
		}
		#gallery-header-center{
			height: 100px;
			width: 950px;
			margin-right: auto;
			margin-left: auto;
		}
		#gallery-header-center-left{
			float: left;
			height: 35px;
			line-height: 35px;
			margin-top: 32px;
		}
		#gallery-header-center-left-icon{
			float: left;
			height: 35px;
			width: 35px;
			background-color: rgba(63,141,191,1);
			color: rgba(255,255,255,1);
			text-align: center;
			font-size: 20px;
			-webkit-transition: background 0.5s;
			-moz-transition: background 0.5s;
			-o-transition: background 0.5s;
			transition: background 0.5s;
		}
		#gallery-header-center-left-icon:hover {
			background-color: rgba(63,141,191,0.5);
			cursor: pointer;
		}
		#gallery-header-center-left-title{
			float: left;
			height: 35px;
			font-size: 25px;
			color: #888888;
			margin-left: 20px;
		}
		#gallery-header-center-right{
			float: right;
			height: 35px;
			margin-top: 32px;
			line-height: 35px;
		}
		.gallery-header-center-right-links {
			color: #888888;
			float: left;
			height: 35px;
			padding-right: 20px;
			padding-left: 20px;
			margin-left: 20px;
			font-size: 16px;
			font-weight: 400;
			-webkit-transition: background 0.5s;
			-moz-transition: background 0.5s;
			-o-transition: background 0.5s;
			transition: background 0.5s;
		}
		.gallery-header-center-right-links:hover {
			background-color: rgba(63,141,191,1);
			color: rgba(255,255,255,1);
			cursor: pointer;
		}
		.gallery-header-center-right-links-current {
			color: #FFFFFF;
			background-color: rgba(127, 142, 152, 1);
		}
		.gallery-header-center-right-links-current:hover {
			background-color: rgba(165, 182, 193, 0.5);
		}
		#gallery-content{
			float: left;
			width: 100%;
		}
		.gallery-content-center-normal {
			width: 100%;
			margin-right: auto;
			margin-left: auto;
		}
		
		#gallery-content-center img {
			width: 100%;
			margin-bottom: 30px;
			/*-webkit-transition: all 0.5s;
			-moz-transition: all 0.5s;
			-o-transition: all 0.5s;
			transition: all 0.5s;*/
			/*margin-left: 10px;*/
		}
		.gallery-content-center-full {
			/* float: left; */
			/* width: 100%; */
			width: 950px;
			margin: 0 auto;
		}
		@media (max-width: 1199px ){
			.gallery-content-center-full {
				width: 100%;
				margin: 0 auto;
		}
		#gallery-header-center {
		    width: 100%;
		    margin-bottom: 80px;
		}
		}
		
		@media (max-width: 400px){
			.blog-post img.featured {
			    width: 66% !important;
			}
		}
	</style>
  </head>

  <body>
  <div class="bar">
    <button type="button" class="navbar-toggle" data-toggle="offcanvas" data-recalc="false" data-target=".navmenu" data-canvas=".canvas">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
    </button>
  </div>
    <div class="navmenu navmenu-default navmenu-fixed-left">
      <ul class="nav navmenu-nav">
        <li><a href="index.html">Home</a></li>
        <li><a href="works.html">Works</a></li>
        <li><a href="gallery.html">Gallery</a></li>
        <li><a href="blog.html">Blog</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
      <a class="navmenu-brand" href="#"><img src="img/logo.png" width="160"></a>
     <div class="social">
        <a href="#"><i class="fa fa-twitter"></i></a>
        <a href="#"><i class="fa fa-facebook"></i></a>
        <a href="#"><i class="fa fa-instagram"></i></a>
        <a href="#"><i class="fa fa-pinterest-p"></i></a>
        <a href="#"><i class="fa fa-google-plus"></i></a>
        <a href="#"><i class="fa fa-skype"></i></a>
      </div>
      <div class="copyright-text">©Copyright <a href="https://themewagon.com/"> ThemeWagon</a> 2015 </div>
    </div>

    <div class="canvas gallery"><br>
        <h1 class="blog-post-title text-center">Gallery of Images</h1>
        <span class="title-divider"></span>
        </section>
            <section id="photostack-3" class="photostack">
                <div>
                    <figure>
                        <a href="img/a.jpg"  data-lightbox="studio2" class="photostack-img"><img src="img/a1.jpg" alt="img05"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Speed Racer</h2>
                            <div class="photostack-back">
                                <p>Here he comes Here comes Speed Racer. He's a demon on wheels. Wouldn't you like to get away? Sometimes you want to go where everybody knows <span>the</span> your name. And they're always glad you came! </p>
                            </div>
                        </figcaption>
                    </figure>
                    <figure>
                        <a href="img/b.jpg"  data-lightbox="studio2" class="photostack-img"><img src="img/b1.jpg" alt="img02"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Happy Days</h2>
                            <div class="photostack-back">
                                <p>These Happy Days are yours and mine Happy Days. It's a beautiful day in this neighborhood a beautiful day for a neighbor. Would you be mine?</p>
                            </div>
                        </figcaption>
                    </figure>
                    <figure>
                        <a href="img/c.jpg"  data-lightbox="studio2" class="photostack-img"><img src="img/c1.jpg" alt="img03"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Beautywood</h2>
                            <div class="photostack-back">
                                <p>It's a neighborly day in this beautywood a neighborly day for a beauty. Would you be mine? Could you be mine. Now the world don't move to the beat of just one drum.</p>
                            </div>
                        </figcaption>
                    </figure>
                    <figure>
                       <a href="img/d.jpg"  data-lightbox="studio2" class="photostack-img"><img src="img/d1.jpg" alt="img01"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Serenity Beach</h2>
                            <div class="photostack-back">
                                <p>I have never been to a place so serene in my entire life before. Swimming in clear waters opened my mind to nature and reminded me of my and <span>eveybody</span> everybody else's mortality.</p>
                            </div>
                        </figcaption>
                    </figure>
                    <figure>
                        <a href="img/e.jpg"  data-lightbox="studio2" class="photostack-img"><img src="img/e1.jpg" alt="img04"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Heaven of time</h2>
                            <div class="photostack-back">
                                <p>What might be right for you may not be right for some. And we know Flipper lives in a world full of wonder flying there-under under the sea.</p>
                            </div>
                        </figcaption>
                    </figure>
                    <figure>
                        <a href="img/f.jpg"  data-lightbox="studio2" class="photostack-img"><img src="img/f1.jpg" alt="img06"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Forever this</h2>
                            <div class="photostack-back">
                                <p>Fish don't fry in the kitchen and beans don't burn on the grill. Took a whole lotta tryin' just to get up that hill. Baby if you've ever wondered - wondered whatever became of me. </p>
                            </div>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/7.jpg" alt="img07"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Lovely Green</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/8.jpg" alt="img08"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Wonderful</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/9.jpg" alt="img09"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Love Addict</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/10.jpg" alt="img10"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Friendship</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/11.jpg" alt="img11"/></a>
                        <figcaption>
                            <h2 class="photostack-title">White Nights</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/12.jpg" alt="img12"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Serendipity</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/13.jpg" alt="img13"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Pure Soul</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/14.jpg" alt="img14"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Winds of Peace</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/15.jpg" alt="img15"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Shades of blue</h2>
                        </figcaption>
                    </figure>
                    <figure data-dummy>
                        <a href="#" class="photostack-img"><img src="img/16.jpg" alt="img16"/></a>
                        <figcaption>
                            <h2 class="photostack-title">Lightness</h2>
                        </figcaption>
                    </figure>
                </div>
            </section>
        </div>
    <script>
	    $(document).ready(function () {
	
			// init Isotope
			var $grid = $('#gallery-content-center').isotope({
			  // options
			});
			// filter items on button click
			$('.gallery-header-center-right-links').on( 'click', function() {
			  
			  $(".gallery-header-center-right-links").removeClass("gallery-header-center-right-links-current");
			  $(this).addClass("gallery-header-center-right-links-current");
			
			  var filterValue = $(this).attr('data-filter');
			  $grid.isotope({ filter: filterValue });
			});
		
		});
	    
	    $(document).ready(function(){

            new Photostack( document.getElementById( 'photostack-3' ), {
                callback : function( item ) {
                    //console.log(item)
                }
            } );
	
		});
    </script>
    

    <script type="text/javascript" src="js/isotope.js"></script>
    <script src="js/classie.js"></script>
    <script src="js/photostack.js"></script>
    <script src="js/lightbox.js"></script>
  </body>
</html>
