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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS14.vo.CrawlingVO;

@Controller
@RequestMapping("/news")
public class NewsController {
	
    private static final int MAX_ARTICLES = 100; // 최대 기사 수

    @RequestMapping(value = "/newsList", method = RequestMethod.GET)
    public String newsListGet(HttpServletRequest request, Model model) {
        List<CrawlingVO> vos = new ArrayList<>();
        List<CrawlingVO> nVos = new ArrayList<>();
        List<CrawlingVO> bVos = new ArrayList<>();

        try {
            vos = getNaverNews(1, 0);
            nVos = getNatureNews(1, 0);
            bVos = getBBCNews(1, 0);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("vos", vos);
        model.addAttribute("nVos", nVos);
        model.addAttribute("bVos", bVos);

        return "news/newsList";
    }

    @RequestMapping(value = "/loadMore", method = RequestMethod.GET)
    @ResponseBody
    public List<CrawlingVO> loadMore(@RequestParam("source") String source, @RequestParam("page") int page, @RequestParam("loadedCount") int loadedCount) {
        List<CrawlingVO> vos = new ArrayList<>();

        if (loadedCount >= MAX_ARTICLES) {
            return vos;
        }

        try {
            if ("naver".equals(source)) {
                vos = getNaverNews(page, loadedCount);
            } else if ("nature".equals(source)) {
                vos = getNatureNews(page, loadedCount);
            } else if ("bbc".equals(source)) {
                vos = getBBCNews(page, loadedCount);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vos;
    }

    private List<CrawlingVO> getNaverNews(int page, int loadedCount) throws Exception {
        List<CrawlingVO> vos = new ArrayList<>();
        String baseUrl = "https://search.naver.com/search.naver?where=news&ie=utf8&sm=nws_hty&query=알레르기";
        String url = baseUrl + "&start=" + ((page - 1) * 10 + 1);
        Document document = Jsoup.connect(url).get();
        Elements newsElements = document.select("div.news_wrap.api_ani_send");

        for (Element newsElement : newsElements) {
            if (vos.size() + loadedCount >= MAX_ARTICLES) break;

            CrawlingVO vo = new CrawlingVO();

            Element titleElement = newsElement.selectFirst("a.news_tit");
            if (titleElement != null) {
                vo.setItem1(titleElement.text());
                vo.setItemUrl1(titleElement.attr("href"));
            }

            Element imageElement = newsElement.selectFirst("a.dsc_thumb img");
            if (imageElement != null && imageElement.hasAttr("data-lazysrc")) {
                vo.setItem2(imageElement.attr("data-lazysrc"));
            } else {
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
        return vos;
    }

    private List<CrawlingVO> getNatureNews(int page, int loadedCount) throws Exception {
        List<CrawlingVO> nVos = new ArrayList<>();
        String baseUrl = "https://www.nature.com/search?q=allergy&date_range=last_year&order=relevance";
        String url = baseUrl + "&page=" + page;
        Document document = Jsoup.connect(url).get();
        Elements newsElements = document.select("article");

        for (Element newsElement : newsElements) {
            if (nVos.size() + loadedCount >= MAX_ARTICLES) break;

            CrawlingVO nVo = new CrawlingVO();

            Element titleElement = newsElement.selectFirst("a.c-card__link.u-link-inherit");
            if (titleElement != null) {
                nVo.setItem1(titleElement.text());
                nVo.setItemUrl1(titleElement.attr("href"));
            }

            Element imageElement = newsElement.selectFirst("picture source");
            if (imageElement != null && imageElement.hasAttr("srcset")) {
                nVo.setItem2(imageElement.attr("srcset"));
            } else {
                nVo.setItem2("");
            }

            Element broadcastElement = newsElement.selectFirst("div.c-card__summary.u-mb-16.u-hide-sm-max");
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
        return nVos;
    }

    private List<CrawlingVO> getBBCNews(int page, int loadedCount) throws Exception {
        List<CrawlingVO> bVos = new ArrayList<>();
        String baseUrl = "https://www.bbc.com/news/science_and_environment";
        String url = baseUrl + "?page=" + page;
        Document document = Jsoup.connect(url).get();
        Elements newsElements = document.select("div.gs-c-promo");

        for (Element newsElement : newsElements) {
            if (bVos.size() + loadedCount >= MAX_ARTICLES) break;

            CrawlingVO bVo = new CrawlingVO();

            Element titleElement = newsElement.selectFirst("h3.gs-c-promo-heading__title");
            if (titleElement != null) {
                bVo.setItem1(titleElement.text());
                Element linkElement = newsElement.selectFirst("a.gs-c-promo-heading");
                bVo.setItemUrl1("https://www.bbc.com" + linkElement.attr("href"));
            }

            Element imageElement = newsElement.selectFirst("img");
            if (imageElement != null) {
                bVo.setItem2(imageElement.attr("src"));
            } else {
                bVo.setItem2("");
            }

            Element timeElement = newsElement.selectFirst("time");
            if (timeElement != null) {
                bVo.setItem5(timeElement.attr("datetime"));
            }

            bVos.add(bVo);
        }
        return bVos;
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
	public String allergic3Get(HttpServletRequest request, Model model) {
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
	public String allergic2Get(HttpServletRequest request, Model model) {
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
