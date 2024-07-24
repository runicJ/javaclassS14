package com.spring.javaclassS14.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.service.IntroService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.CrawlingVO;
import com.spring.javaclassS14.vo.SaveMypageVO;
import com.spring.javaclassS14.vo.ShopVO;

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
		
        List<ShopVO> categoryTopVOS = shopService.getCategoryTop();
        model.addAttribute("categoryTopVOS", categoryTopVOS);
        
		List<ShopVO> productTopMidVOS = shopService.getProductTopMidList();
		model.addAttribute("productTopMidVOS", productTopMidVOS);
		
		return "home";
	}
	
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");  // 서버로 들어오는 거니까 request는 안해도 됨, 이건 내보내는 것
		response.setContentType("text/html; charset=utf-8");  // 응답 객체에 인코딩을 다시 해주는게 좋음
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");  // 파일명을 주기에 마지막 /
		String oFileName = upload.getOriginalFilename();
		
		// 파일명 중복방지를 위한 이름 설정하기(날짜로 분류처리...)
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;  // 경로명엔 _ 비추, 파일명엔 _, $ 사용
		
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(upload.getBytes());  // out => 보내는 거
		
		PrintWriter out = response.getWriter();  // 웹 화면으로 불러옴
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;  // ctp는 jsp에서 쓰는 것이므로 여기선 이렇게 씀  // ""resources/data/cheditof/" 이렇게 써도 됨
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");  // (xml이나) json 형식으로 출력 {ckeditor의 변수명(예약어)-키값 : 내가 지정한 파일명(따당)}, 업로드(1) 숫자는 "" 안줘도 됨
		
		out.flush();
		fos.close();
	}
	
	@Autowired
	IntroService introService;
	
	@Autowired
	ShopService shopService;
	
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
		
        List<SaveMypageVO> topNewsVOS = introService.findTopNews(3); // 상위 3개의 기사 가져오기
        model.addAttribute("topNewsVOS", topNewsVOS);

        List<ShopVO> productVOS = shopService.getNewProduct();
        model.addAttribute("productVOS", productVOS);

        List<ShopVO> categoryTopVOS = shopService.getCategoryTop();
        model.addAttribute("categoryTopVOS", categoryTopVOS);
        
		List<ShopVO> productTopMidVOS = shopService.getProductTopMidList();
		model.addAttribute("productTopMidVOS", productTopMidVOS);
        
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
