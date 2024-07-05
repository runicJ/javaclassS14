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
		Connection conn = Jsoup.connect("https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query="+searchString+"&where=web");
		
		Document document = conn.get();
		
		Elements selects = null;
		
		ArrayList<String> titleVos = new ArrayList<String>();
		selects = document.select("a.news_tit");
		for(Element select : selects) {
			System.out.println("select1 : " + select);
			titleVos.add(select.html());
		}
		
		ArrayList<String> imageVos = new ArrayList<String>();
		selects = document.select("a.dsc_thumb img");
		for(Element select : selects) {
			System.out.println("select2 : " + select);
			imageVos.add(select.toString().replace("src=\"data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7\" data-lazy", ""));
		}
		
		ArrayList<String> broadcastVos = new ArrayList<String>();
		selects = document.select("div.dsc_wrap");
		for(Element select : selects) {
			System.out.println("select3 : " + select);
			broadcastVos.add(select.html());
		}
		
		ArrayList<String> infoVos = new ArrayList<String>();
		selects = document.select("span.info");
		for(Element select : selects) {
			System.out.println("select4 : " + select);
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
			naverVos.add(vo);
		}
		model.addAttribute("naverVos",naverVos);
		
		return "main/main";
	}
	
}
