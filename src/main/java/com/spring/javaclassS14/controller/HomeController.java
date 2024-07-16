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
        
		try {
			String url = "https://www.thermofisher.com/diagnostic-education/hcp/us/ko/allergy/respiratory-allergies/allergic-rhinitis-diagnosis-treatment.html";
			Document document = Jsoup.connect(url).get();
			List<CrawlingVO> vos1 = new ArrayList<>();
			CrawlingVO vo1 = new CrawlingVO();

			Element imageElement = document.selectFirst("img.full-hero-img.desktop-hero");
			if(imageElement != null) {
				vo1.setItem1(imageElement.attr("src"));
			}

			Element titleElement = document.selectFirst("div.text-cmp h1 b");
			if(titleElement != null) {
				vo1.setItem2(titleElement.text());
			}
			
			Element contentElement = document.selectFirst("#text-1822732708");
			if(contentElement != null) {
				vo1.setItem3(contentElement.text());
			}
			
			vos1.add(vo1);
			model.addAttribute("vos1", vos1);
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		try {
			String url = "https://www.thermofisher.com/diagnostic-education/hcp/us/ko/allergy/food-allergies-diagnosis-treatment.html";
			Document document = Jsoup.connect(url).get();
			List<CrawlingVO> vos2 = new ArrayList<>();
			CrawlingVO vo2 = new CrawlingVO();
			
			Element imageElement = document.selectFirst("img.full-hero-img.desktop-hero");
			if(imageElement != null) {
				vo2.setItem1(imageElement.attr("src"));
			}
			
			Element titleElement = document.selectFirst("div.text-cmp h1 b");
			if(titleElement != null) {
				vo2.setItem2(titleElement.text());
			}
			
			Element contentElement = document.selectFirst("#text-1355993154");
			if(contentElement != null) {
				vo2.setItem3(contentElement.text());
			}
			
			vos2.add(vo2);
			model.addAttribute("vos2", vos2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			String url = "https://www.thermofisher.com/diagnostic-education/hcp/us/ko/allergy/atopic-dermatitis-diagnosis-treatment.html";
			Document document = Jsoup.connect(url).get();
			List<CrawlingVO> vos3 = new ArrayList<>();
			CrawlingVO vo3 = new CrawlingVO();
			
			Element imageElement = document.selectFirst("img.full-hero-img.desktop-hero");
			if(imageElement != null) {
				vo3.setItem1(imageElement.attr("src"));
			}
			
			Element titleElement = document.selectFirst("div.text-cmp h1 b");
			if(titleElement != null) {
				vo3.setItem2(titleElement.text());
			}
			
			Element contentElement = document.selectFirst("#text-1798408017");
			if(contentElement != null) {
				vo3.setItem3(contentElement.text());
			}
			
			vos3.add(vo3);
			model.addAttribute("vos3", vos3);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			String url = "https://www.thermofisher.com/diagnostic-education/hcp/us/ko/allergy/respiratory-allergies/indoor-allergies-diagnosis-treatment.html";
			Document document = Jsoup.connect(url).get();
			List<CrawlingVO> vos4 = new ArrayList<>();
			CrawlingVO vo4 = new CrawlingVO();
			
			Element imageElement = document.selectFirst("img.full-hero-img.desktop-hero");
			if(imageElement != null) {
				vo4.setItem1(imageElement.attr("src"));
			}
			
			Element titleElement = document.selectFirst("div.text-cmp h1 b");
			if(titleElement != null) {
				vo4.setItem2(titleElement.text());
			}
			
			Element contentElement = document.selectFirst("#text-980197978");
			if(contentElement != null) {
				vo4.setItem3(contentElement.text());
			}
			
			vos4.add(vo4);
			model.addAttribute("vos4", vos4);
		} catch (Exception e) {
			e.printStackTrace();
		}

        return "main/main";
    }
    
	// 유저 채팅창 띄우기
	@RequestMapping(value = "/community/chat/userChat", method = RequestMethod.GET)
		public String userChatGet() {
	    return "community/chat/userChat";
	}
	
	// 검색하기
	@RequestMapping(value = "/search/searchList", method = RequestMethod.GET)
	public String searchListGet() {
		return "search/searchList";
	}
}
