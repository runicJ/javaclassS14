package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS14.vo.CrawlingVO;

@Controller
@RequestMapping("/news")
public class NewsController {
	
	@RequestMapping(value = "/newsList", method = RequestMethod.GET)
	public String newsListGet(HttpServletRequest request, Model model) {
        List<CrawlingVO> vos = new ArrayList<>();
        try {
            String baseUrl = "https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=알레르기";
            for (int page = 1; page <= 10; page++) {
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
        
        List<CrawlingVO> nVos = new ArrayList<>();
        try {
        	 String baseUrl = "https://www.nature.com/search?q=allergy&date_range=last_year&order=relevance";
             for (int page = 1; page <= 2; page++) {
                 String url = baseUrl + "&page=" + page;
                 Document document = Jsoup.connect(url).get();
                 Elements newsElements = document.select("article");
        		
        		for (Element newsElement : newsElements) {
        			CrawlingVO nVo = new CrawlingVO();
        			
        			Element titleElement = newsElement.selectFirst("a.c-card__link.u-link-inherit");
        			if (titleElement != null) {
        				nVo.setItem1(titleElement.text());
        				nVo.setItemUrl1(titleElement.attr("href"));
        			}
        			
        			Element imageElement = newsElement.selectFirst("picture source");
        			if (imageElement != null && imageElement.hasAttr("srcset")) {
        				nVo.setItem2(imageElement.attr("srcset"));
        			} 
        			else {
        				nVo.setItem2("");
        			}
        			
        			Element broadcastElement = newsElement.selectFirst("div.c-card__summary u-mb-16 u-hide-sm-max");
        			if (broadcastElement != null) {
        				nVo.setItem3(broadcastElement.text());
        			}
        			
        			Element comElement = newsElement.selectFirst("div.c-meta__item.c-meta__item--block-at-lg.u-text-bold");
        			if (comElement != null) {
        				nVo.setItem4(comElement.text());
        			}
        			
        			Element infoElement = newsElement.selectFirst("time.c-meta__item.c-meta__item--block-at-lg");
        			if (infoElement != null) {
        				nVo.setItem5(infoElement.attr("datetime"));
        			}
        			
        			nVos.add(nVo);
        		}
        	}
        } catch (Exception e) {
        	e.printStackTrace();
        }
        model.addAttribute("nVos", nVos);
        
        List<CrawlingVO> gVos = new ArrayList<>();
        try {
        	String baseUrl = "https://scholar.google.com/scholar?as_ylo=2023&q=allergy&hl=ko&as_sdt=0,5&as_vis=1";
        	for (int page = 1; page <= 3; page++) {
        		String url = baseUrl + "&page=" + page;
        		Document document = Jsoup.connect(url).get();
        		Elements newsElements = document.select("div.gs_md_wnw.gs_md_ds.gs_md_wmw");
        		
        		for (Element newsElement : newsElements) {
        			CrawlingVO gVo = new CrawlingVO();
        			
        			Element titleElement = newsElement.selectFirst("h3.gs_rt a");
        			if (titleElement != null) {
        				gVo.setItem1(titleElement.text());
        				gVo.setItemUrl1(titleElement.attr("href"));
        				System.out.println("vo.setItem1 : " + gVo.getItem1());
        				System.out.println("vo.setItemUrl1 : " + gVo.getItemUrl1());
        			}
        			
        			Element broadcastElement = newsElement.selectFirst("div.gs_rs");
        			if (broadcastElement != null) {
        				gVo.setItem2(broadcastElement.text());
        				System.out.println("vo.getItem2 : " + gVo.getItem2());
        			}
        			
        			Element comElement = newsElement.selectFirst("div.gs_a");
        			if (comElement != null) {
        				gVo.setItem3(comElement.text());
        				System.out.println("vo.getItem3 : " + gVo.getItem3());
        			}
        			
        			Element infoElement = newsElement.selectFirst("div.gs_fl.gs_flb a");
        			if (infoElement != null) {
        				gVo.setItem4(infoElement.text());
        				System.out.println("vo.getItem4 : " + gVo.getItem4());
        			}
        			
        			gVos.add(gVo);
        		}
        	}
        } catch (Exception e) {
        	e.printStackTrace();
        }
        model.addAttribute("gVos", gVos);
        
		return "news/newsList";
	}
	
	@RequestMapping(value = "/allergic1", method = RequestMethod.GET)
	public String allergic1Get(HttpServletRequest request, Model model) {
		CrawlingVO vo = new CrawlingVO();
		
		try {
			String url = "https://www.thermofisher.com/diagnostic-education/hcp/us/ko/allergy/respiratory-allergies/allergic-rhinitis-diagnosis-treatment.html";
			Document document = Jsoup.connect(url).get();

			Element imageElement = document.selectFirst("img.full-hero-img.desktop-hero");
			if(imageElement != null) {
				vo.setItem1(imageElement.attr("src"));
			}

			Element titleElement = document.selectFirst("div.text-cmp h1 b");
			if(titleElement != null) {
				vo.setItem2(titleElement.text());
			}
			
			Element contentElement = document.selectFirst("#text-1822732708");
			if(contentElement != null) {
				vo.setItem3(contentElement.text());
			}
			
			Element chartElement = document.selectFirst("div.well-cmp.aem-GridColumn--default--none.aem-GridColumn--mobile--none.aem-GridColumn.aem-GridColumn--offset--default--0.aem-GridColumn--default--4.aem-GridColumn--mobile--12.aem-GridColumn--offset--mobile--0");
			if(chartElement != null) {
				vo.setItem4(chartElement.text());
			}
			
			Element SymptomElement = document.selectFirst("div#text-1337636130");
			if(SymptomElement != null) {
				vo.setItem5(SymptomElement.text());
			}
			
			model.addAttribute("vo", vo);
		} catch (Exception e) {
            e.printStackTrace();
        }
        
		return "news/allergic1";
	}
	
	@RequestMapping(value = "/allergic3", method = RequestMethod.GET)
	public String allergic2Get(HttpServletRequest request, Model model) {
		CrawlingVO vo = new CrawlingVO();
		
		try {
			String url = "https://www.thermofisher.com/diagnostic-education/hcp/us/ko/allergy/atopic-dermatitis-diagnosis-treatment.html";
			Document document = Jsoup.connect(url).get();

			Element imageElement = document.selectFirst("img.full-hero-img.desktop-hero");
			if(imageElement != null) {
				vo.setItem1(imageElement.attr("src"));
			}

			Element titleElement = document.selectFirst("div.text-cmp h1 b");
			if(titleElement != null) {
				vo.setItem2(titleElement.text());
			}
			
			Element contentElement = document.selectFirst("#text-1798408017");
			if(contentElement != null) {
				vo.setItem3(contentElement.text());
			}
			
			Element chartElement = document.selectFirst("div.aem-Grid.aem-Grid--12.aem-Grid--default--12.aem-Grid--mobile--12");
			if(chartElement != null) {
				vo.setItem4(chartElement.text());
			}
			
			Element SymptomElement = document.selectFirst("div#text-143352666");
			if(SymptomElement != null) {
				vo.setItem5(SymptomElement.text());
			}
			
			model.addAttribute("vo", vo);
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		return "news/allergic3";
	}
	
	@RequestMapping(value = "/allergic2", method = RequestMethod.GET)
	public String allergic3Get(HttpServletRequest request, Model model) {
		CrawlingVO vo = new CrawlingVO();
		
		try {
			String url = "https://www.thermofisher.com/allergy/kr/ko/allergy-types-symptoms/food-allergies.html";
			Document document = Jsoup.connect(url).get();

            Element imageElement = document.selectFirst("div.html5-video-cmp-container.controls-enabled video");
            if (imageElement != null && imageElement.hasAttr("data-src")) {
                vo.setItem2(imageElement.attr("data-src"));
            } 
            else {
                vo.setItem2("");
            }
            
			Element titleElement = document.selectFirst("h1.h2.d-inline-block");
			if(titleElement != null) {
				vo.setItem2(titleElement.text());
			}
			
			Element contentElement = document.selectFirst("div#overview.cmp-text");
			if(contentElement != null) {
				vo.setItem3(contentElement.text());
			}
			
			Element faqElement = document.selectFirst("div#faq-1227464191");
			if(faqElement != null) {
				vo.setItem4(faqElement.text());
			}
			
			model.addAttribute("vo", vo);
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		return "news/allergic2";
	}
	
	@RequestMapping(value = "/allergic4", method = RequestMethod.GET)
	public String allergic4Get(HttpServletRequest request, Model model) {
		CrawlingVO vo = new CrawlingVO();
		
		try {
			String url = "https://www.thermofisher.com/diagnostic-education/hcp/us/ko/allergy/respiratory-allergies/allergic-rhinitis-diagnosis-treatment.html";
			Document document = Jsoup.connect(url).get();

			Element imageElement = document.selectFirst("img.full-hero-img.desktop-hero");
			if(imageElement != null) {
				vo.setItem1(imageElement.attr("src"));
			}

			Element titleElement = document.selectFirst("div.text-cmp h1 b");
			if(titleElement != null) {
				vo.setItem2(titleElement.text());
			}
			
			Element contentElement = document.selectFirst("#text-1822732708");
			if(contentElement != null) {
				vo.setItem3(contentElement.text());
			}
			
			Element chartElement = document.selectFirst("div.well-cmp.aem-GridColumn--default--none.aem-GridColumn--mobile--none.aem-GridColumn.aem-GridColumn--offset--default--0.aem-GridColumn--default--4.aem-GridColumn--mobile--12.aem-GridColumn--offset--mobile--0");
			if(chartElement != null) {
				vo.setItem4(chartElement.text());
			}
			
			Element SymptomElement = document.selectFirst("div#text-1337636130");
			if(SymptomElement != null) {
				vo.setItem5(SymptomElement.text());
			}
			
			model.addAttribute("vo", vo);
		} catch (Exception e) {
            e.printStackTrace();
        }
		
		return "news/allergic4";
	}
	
}
