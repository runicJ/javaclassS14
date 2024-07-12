package com.spring.javaclassS14.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS14.vo.CrawlingVO;

@Controller
@RequestMapping("/news")
public class NewsController {
	
	@Autowired
	//NewsService newsService;
	
	// 크롤링 연습(jsoup)
	@RequestMapping(value = "/crawling", method = RequestMethod.GET)
	public String crawlingGet() {
		return "research/crawling";
	}
	
	// 크롤링연습 처리(jsoup) - 네이버 검색어를 이용한 검색처리
	@ResponseBody
	@RequestMapping(value = "/crawling", method = RequestMethod.POST)
	public ArrayList<String> crawlingPost(String search, String searchSelector) throws IOException {
		Connection conn = Jsoup.connect(search);
		
		Document document = conn.get();
		
		// 하나만 넘긴다고 가정
		Elements selects = document.select(searchSelector);
		
		ArrayList<String> vos = new ArrayList<String>();
		
		int i = 0;
		for(Element select : selects) {
			i++;
			System.out.println(i + " : " + select.html());
			vos.add(i + " : " + select.html().replace("data-lazy", ""));
		}
		
		return vos;
	}
	
	// 크롤링 연습(jsoup) 처리
	@ResponseBody
	@RequestMapping(value = "/crawling/jsoup3", method = RequestMethod.POST)
	public ArrayList<CrawlingVO> jsoup3Post() throws IOException {
		Connection conn = Jsoup.connect("https://entertain.daum.net/");
		
		Document document = conn.get();
		
		Elements selects = null;
		
		ArrayList<String> titleVos = new ArrayList<String>();
		selects = document.select("ul.list_news a.link_txt");
		for(Element select : selects) {
			titleVos.add(select.html());
		}
		
		ArrayList<String> imageVos = new ArrayList<String>();
		selects = document.select("ul.list_news a.link_thumb");
		for(Element select : selects) {
			imageVos.add(select.html().replace("data-onshow-",""));
		}
		
		ArrayList<String> broadcastVos = new ArrayList<String>();
		selects = document.select("ul.list_news span.info_thumb");
		for(Element select : selects) {
			broadcastVos.add(select.html());
		}
		
		ArrayList<CrawlingVO> vos = new ArrayList<CrawlingVO>();
		CrawlingVO vo = null;
		for(int i=0; i<broadcastVos.size(); i++) {
			vo = new CrawlingVO();
			vo.setItem1(titleVos.get(i));
			vo.setItem2(imageVos.get(i));
			vo.setItem3(broadcastVos.get(i));
			vos.add(vo);
		}
		
		return vos;
	}
	
}
