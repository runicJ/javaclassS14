package com.spring.javaclassS14.controller;

import java.text.DateFormat;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS14.vo.CrawlingVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = {"/","/h","/index"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
//	@RequestMapping(value = "/main", method = RequestMethod.GET)
//	public String mainPost(HttpServletRequest request, Model model) {
//        List<CrawlingVO> vos = new ArrayList<>();
//        WebDriver driver = null;
//        
//	    try {
//	    	String realPath = request.getSession().getServletContext().getRealPath("/resources/crawling/");
//            System.setProperty("webdriver.chrome.driver", realPath + "chromedriver.exe");
//            
//            ChromeOptions options = new ChromeOptions();
//            options.addArguments("--headless"); // 헤드리스 모드 설정
//            options.addArguments("--disable-gpu");
//            options.addArguments("--no-sandbox");
//            options.addArguments("--disable-dev-shm-usage");
//            
//            driver = new ChromeDriver(options);
//            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
//
//            String baseUrl = "https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=알레르기";
//	        for (int page = 1; page <= 5; page++) {
//	            String url = baseUrl + "&start=" + ((page - 1) * 10 + 1); // 네이버는 페이지네이션을 start=11, 21 등으로 사용합니다.
//	            driver.get(url);
//	            
//	            // 페이지가 완전히 로드될 때까지 대기
//                wait.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("a.news_tit")));
//
//                // JavaScript를 사용하여 이미지가 로드될 때까지 대기
//                ((ChromeDriver) driver).executeScript("window.scrollTo(0, document.body.scrollHeight);");
//                Thread.sleep(2000); // 추가 대기
//                
//	            Document document = Jsoup.connect(url).get();
//	            Elements titleElements = document.select("a.news_tit");
//	            Elements imageElements = document.select("a.dsc_thumb img");
//	            Elements broadcastElements = document.select("a.dsc_wrap");
//	            Elements comElements = document.select("a.info.press");
//	            Elements infoElements = document.select("span.info");
//
//	            int maxItems = titleElements.size();
//
//	            for (int i = 0; i < maxItems; i++) {
//	                CrawlingVO vo = new CrawlingVO();
//
//	                if (i < titleElements.size()) {
//	                    Element element = titleElements.get(i);
//	                    vo.setItem1(element.text());
//	                    vo.setItemUrl(element.attr("href"));
//	                }
//	                
//                    if (i < imageElements.size()) {
//                        Element element = imageElements.get(i);
//                        String imgTag = element.outerHtml();
//                        vo.setItem2(imgTag.attr("data-lazy-src"));
//                        System.out.println("Image: " + vo.getItem2());
//                    } else {
//                        vo.setItem2(""); // 이미지가 없는 경우 빈 문자열 설정
//                        System.out.println("Image: None");
//                    }
//
//	                if (i < broadcastElements.size()) {
//	                    Element element = broadcastElements.get(i);
//	                    vo.setItem3(element.text());
//	                }
//
//	                if (i < comElements.size()) {
//	                    Element element = comElements.get(i);
//	                    vo.setItem4(element.text());
//	                }
//
//	                if (i < infoElements.size()) {
//	                    Element element = infoElements.get(i);
//	                    vo.setItem5(element.text());
//	                }
//
//	                vos.add(vo);
//	            }
//	        }
//	    } catch (Exception e) {
//	        e.printStackTrace();
//        } finally {
//            if (driver != null) {
//                driver.quit();
//            }
//        }
//        model.addAttribute("vos", vos);
//
//	    return "main/main";
//	}

//	@RequestMapping(value = "/main", method = RequestMethod.GET)
//    public String mainPost(HttpServletRequest request, Model model) {
//        List<CrawlingVO> vos = new ArrayList<>();
//        try {
//            String baseUrl = "https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=알레르기";
//            for (int page = 1; page <= 5; page++) { // 5페이지로 제한
//                String url = baseUrl + "&start=" + ((page - 1) * 10 + 1); // 페이지네이션을 위한 URL 구성
//                Document document = Jsoup.connect(url).get();
//                Elements titleElements = document.select("a.news_tit");
//                Elements imageElements = document.select("a.dsc_thumb img");
//                Elements broadcastElements = document.select("div.dsc_wrap");
//                Elements comElements = document.select("a.info.press");
//                Elements infoElements = document.select("span.info");
//
//                int maxItems = titleElements.size();
//
//                for (int i = 0; i < maxItems; i++) {
//                    CrawlingVO vo = new CrawlingVO();
//
//                    if (i < titleElements.size()) {
//                        Element element = titleElements.get(i);
//                        vo.setItem1(element.text());
//                        vo.setItemUrl(element.attr("href"));
//                        System.out.println("Title: " + vo.getItem1());
//                        System.out.println("URL: " + vo.getItemUrl());
//                    }
//
//                    if (document.select("a.dsc_thumb").isEmpty() || i >= imageElements.size() || !imageElements.get(i).hasAttr("data-lazysrc")) {
//                        vo.setItem2("");
//                    } else {
//                        Element element = imageElements.get(i);
//                        String imgSrc = element.attr("data-lazysrc");
//                        vo.setItem2(imgSrc);
//                        System.out.println("Image: " + vo.getItem2());
//                    }
//
//                    if (i < broadcastElements.size()) {
//                        Element element = broadcastElements.get(i);
//                        vo.setItem3(element.text());
//                        System.out.println("Broadcast: " + vo.getItem3());
//                    }
//
//                    if (i < comElements.size()) {
//                        Element element = comElements.get(i);
//                        vo.setItem4(element.text());
//                        System.out.println("Company: " + vo.getItem4());
//                    }
//
//                    if (i < infoElements.size()) {
//                        Element element = infoElements.get(i);
//                        vo.setItem5(element.text());
//                        System.out.println("Info: " + vo.getItem5());
//                    }
//
//                    vos.add(vo);
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        model.addAttribute("vos", vos);
//
//        return "main/main";
//    }
	
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String mainPost(HttpServletRequest request, Model model) {
        List<CrawlingVO> vos = new ArrayList<>();
        try {
            String baseUrl = "https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=알레르기";
            for (int page = 1; page <= 5; page++) {
                String url = baseUrl + "&start=" + ((page - 1) * 10 + 1);  // 네이버는 이렇게 페이지 구성함?
                Document document = Jsoup.connect(url).get();
                Elements newsElements = document.select("div.news_wrap.api_ani_send");

                for (Element newsElement : newsElements) {
                    CrawlingVO vo = new CrawlingVO();

                    Element titleElement = newsElement.selectFirst("a.news_tit");
                    if (titleElement != null) {
                        vo.setItem1(titleElement.text());
                        vo.setItemUrl1(titleElement.attr("href"));
                    }

                    Element imageElement = newsElement.selectFirst("a.dsc_thumb img");
                    if (imageElement != null && imageElement.hasAttr("data-lazysrc")) {
                        vo.setItem2(imageElement.attr("data-lazysrc"));
                    } 
                    else {
                        vo.setItem2("");
                    }

                    Element broadcastElement = newsElement.selectFirst("div.dsc_wrap");
                    if (broadcastElement != null) {
                        vo.setItem3(broadcastElement.text());
                    }

                    Element comElement = newsElement.selectFirst("a.info.press");
                    if (comElement != null) {
                        vo.setItem4(comElement.text());
                        vo.setItemUrl2(titleElement.attr("href"));
                    }

                    Element infoElement = newsElement.selectFirst("span.info");
                    if (infoElement != null) {
                        vo.setItem5(infoElement.text());
                    }

                    vos.add(vo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("vos", vos);

        return "main/main";
    }
    
	// 채팅창 띄우기
	@RequestMapping(value = "/community/chat/userChat", method = RequestMethod.GET)
		public String userChatGet() {
	    return "community/chat/userChat";
	}
}
