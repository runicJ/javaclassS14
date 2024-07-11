package com.spring.javaclassS14.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
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
    public String main(Model model) throws IOException {
        String searchString = "알레르기";
        Connection conn = Jsoup.connect("https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=" + searchString + "&where=web&display=30");
        
        Document document = conn.get();
        
        ArrayList<String> titleVos = new ArrayList<>();
        ArrayList<String> urlVos = new ArrayList<>();
        ArrayList<String> imageVos = new ArrayList<>();
        ArrayList<String> broadcastVos = new ArrayList<>();
        ArrayList<String> infoVos = new ArrayList<>();
        
        Elements titleElements = document.select("a.news_tit");
        Elements imageElements = document.select("a.dsc_thumb img");
        Elements broadcastElements = document.select("div.dsc_wrap");
        Elements infoElements = document.select("span.info");
        
        int maxItems = 30; // 항상 30개의 뉴스 항목을 가져옴
        
        for (int i = 0; i < maxItems; i++) {
            if (i < titleElements.size()) {
                Element element = titleElements.get(i);
                titleVos.add(element.text());
                urlVos.add(element.attr("href"));
            } else {
                titleVos.add("");
                urlVos.add("");
            }
            
            if (i < imageElements.size()) {
                Element element = imageElements.get(i);
                imageVos.add(element.attr("src").toString().replace("src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" data-lazy", ""));
            } else {
                imageVos.add("");
            }
            
            if (i < broadcastElements.size()) {
                Element element = broadcastElements.get(i);
                broadcastVos.add(element.text());
            } else {
                broadcastVos.add("");
            }
            
            if (i < infoElements.size()) {
                Element element = infoElements.get(i);
                infoVos.add(element.text());
            } else {
                infoVos.add("");
            }
        }
        
        ArrayList<CrawlingVO> naverVos = new ArrayList<>();
        for (int i = 0; i < maxItems; i++) {
            CrawlingVO vo = new CrawlingVO();
            vo.setItem1(titleVos.get(i));
            vo.setItem2(imageVos.get(i));
            vo.setItem3(broadcastVos.get(i));
            vo.setItem4(infoVos.get(i));
            vo.setItemUrl(urlVos.get(i));
            naverVos.add(vo);
        }
        model.addAttribute("naverVos", naverVos);
        
        return "main/main";
    }
	
	/*
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) throws IOException {
		String searchString = "알레르기";
		Connection conn = Jsoup.connect("https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query="+searchString+"&where=web");
		
		Document document = conn.get();
		
		Elements selects = null;
		
		ArrayList<String> titleVos = new ArrayList<String>();
		ArrayList<String> urlVos = new ArrayList<String>();
		selects = document.select("a.news_tit");
		for(Element select : selects) {
			titleVos.add(select.html());
			urlVos.add(select.attr("href"));
		}
		
		ArrayList<String> imageVos = new ArrayList<String>();
		selects = document.select("a.dsc_thumb");
		for(Element select : selects) {
			imageVos.add(select.toString().replace("src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" data-lazy", ""));
		}
		
		ArrayList<String> broadcastVos = new ArrayList<String>();
		selects = document.select("div.dsc_wrap");
		for(Element select : selects) {
			broadcastVos.add(select.html());
		}
		
		ArrayList<String> infoVos = new ArrayList<String>();
		selects = document.select("span.info");
		for(Element select : selects) {
			infoVos.add(select.html());
		}
		
		ArrayList<CrawlingVO> naverVos = new ArrayList<CrawlingVO>();
		CrawlingVO vo = null;
		for(int i=0; i<imageVos.size(); i++) {
			vo = new CrawlingVO();
			vo.setItem1(titleVos.get(i));
			vo.setItem2(imageVos.get(i));
			vo.setItem3(broadcastVos.get(i));
			vo.setItem4(infoVos.get(i));
			vo.setItemUrl(urlVos.get(i));
			naverVos.add(vo);
		}
		model.addAttribute("naverVos",naverVos);
		
		return "main/main";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) throws IOException {
	    String searchString = "알레르기";
	    Connection conn = Jsoup.connect("https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=" + searchString + "&where=web");
	    
	    Document document = conn.get();
	    
	    Elements titles = document.select("a.news_tit");
	    Elements images = document.select("a.dsc_thumb img");
	    Elements desc = document.select("div.dsc_wrap");
	    Elements infos = document.select("span.info");
	    
	    ArrayList<CrawlingVO> naverVos = new ArrayList<CrawlingVO>();
	    
	    for (int i = 0; i < titles.size(); i++) {
	        CrawlingVO vo = new CrawlingVO();
	        Element titleElement = titles.get(i);
	        Element imageElement = i < images.size() ? images.get(i) : null;
	        Element descElement = i < desc.size() ? desc.get(i) : null;
	        Element infoElement = i < infos.size() ? infos.get(i) : null;
	        
	        vo.setItem1(titleElement.html());
	        vo.setItemUrl(titleElement.attr("href"));
	        
	        if (imageElement != null) {
	            vo.setItem2(imageElement.toString().replace("src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" data-lazy", ""));
	        }
	        
	        if (descElement != null) {
	            vo.setItem3(descElement.html());
	        }
	        
	        if (infoElement != null) {
	            vo.setItem4(infoElement.html());
	        }
	        
	        naverVos.add(vo);
	    }
	    
	    model.addAttribute("naverVos", naverVos);
	    
	    return "main/main";
	}
	*/
	
	@RequestMapping(value="/introduce/introduce", method=RequestMethod.GET)
	public String introduceGet() {
		return "main/introduce/introduce";
	}
	
	@RequestMapping(value="/introduce/purpose", method=RequestMethod.GET)
	public String purposeGet() {
		return "main/introduce/purpose";
	}
	
}
