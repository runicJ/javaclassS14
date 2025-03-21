package com.spring.javaclassS14.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.ShopDAO;
import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.ReviewVO;
import com.spring.javaclassS14.vo.ShopVO;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	ShopDAO shopDAO;
	
	@Autowired
	AllProvide allProvide;
	
	@Override
	public List<ShopVO> getCategoryTop() {
		return shopDAO.getCategoryTop();
	}

	@Override
	public List<ShopVO> getCategoryMid() {
		return shopDAO.getCategoryMid();
	}

	@Override
	public ShopVO getCategoryTopHas(String productTopName) {
		return shopDAO.getCategoryTopHas(productTopName);
	}

	@Override
	public int setCategoryTopInput(String productTopName) {
		return shopDAO.setCategoryTopInput(productTopName);
	}
	
	@Override
	public List<ShopVO> getMidInTopHas(int productTopIdx) {
		return shopDAO.getMidInTopHas(productTopIdx);
	}

	@Override
	public ShopVO getCategoryMidHas(String productMidName) {
		return shopDAO.getCategoryMidHas(productMidName);
	}

	@Override
	public int setCategoryTopDelete(int productTopIdx) {
		return shopDAO.setCategoryTopDelete(productTopIdx);
	}

	@Override
	public int setCategoryMidInput(int productTopIdx, String productMidName) {
		return shopDAO.setCategoryMidInput(productTopIdx, productMidName);
	}
	
	@Override
	public ShopVO getProductInMidHas(int productMidIdx) {
		return shopDAO.getProductInMidHas(productMidIdx);
	}

	@Override
	public int setCategoryMidDelete(int productMidIdx) {
		return shopDAO.setCategoryMidDelete(productMidIdx);
	}

	@Override
	public List<ShopVO> getCategoryMidName(String categoryMainCode) {
		return shopDAO.getCategoryMidName(categoryMainCode);
	}

	@Override
	public int imgCheckProductInput(MultipartFile file, ShopVO vo) {
	    int res = 0;
	    // 메인 이미지 업로드 작업처리
	    try {
	      String originalFilename = file.getOriginalFilename();
	      if(originalFilename != null && originalFilename != "") {
	        // 상품 메인사진 업로드시 파일명 중복을 피하기 위한 처리(파일명 변경하기)
	      	String saveFileName = allProvide.saveFileName(originalFilename);
	        
	        // 메인 이미지파일을 서버 파일시스템에 업로드 처리하는 메소드 호출
	      	allProvide.writeFile(file, saveFileName, "shop/product");
	        vo.setProductThumb(saveFileName);		// 업로드된 메인이미지의 실제로 저장된 파일명을 vo에 저장시켜준다.
	      }
	      else {
	        return res;
	      }
	    } catch (IOException e) {
	      e.printStackTrace();
	    }
	    // ckeditor에서 올린 이미지파일을 'ckeditor'에서 'dbShop/product'폴더로 복사한다.
	    //             0         1         2         3         4         5
	    //             012345678901234567890123456789012345678901234567890
	    // <img alt="" src="/javaclassS14/data/ckeditor/211229124318_4.jpg"
	    // <img alt="" src="/javaclassS14/data/dbShop/product/211229124318_4.jpg"

	    // ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 'ckeditor'폴더에서 'dbShop/product'폴더로 복사작업처리 시켜준다.
	    String content = vo.getContent();
	    //System.out.println("content : " + content);
	    if(content.indexOf("src=\"/") == -1) return 0;    // content박스의 내용중 그림이 없으면 돌려보낸다.

	    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	    String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");

	    int position = 33;
	    String nextImg = content.substring(content.indexOf("src=\"/") + position);
	    boolean sw = true;

	    while(sw) {
	      String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
	      String copyFilePath = "";
	      String oriFilePath = uploadPath + "ckeditor/" + imgFile;

	      copyFilePath = uploadPath + "shop/product/" + imgFile;

	      allProvide.fileCopyCheck(oriFilePath, copyFilePath);

	      if(nextImg.indexOf("src=\"/") == -1) sw = false;
	      else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
	    }
	    
	    vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/shop/product/"));

	    // 고유번호 idx값 만들기(상품코드 만들때 필요함)
	    int maxIdx = 1;
	    ShopVO maxVo = shopDAO.getProductMaxIdx();
	    if(maxVo != null) maxIdx = maxVo.getProductIdx() + 1;
	    
	    vo.setProductIdx(maxIdx);
	    vo.setProductCode(vo.getProductTopIdx()+"_"+vo.getProductMidIdx()+"_"+maxIdx);	// 상품코드 만들기
	    res = shopDAO.setProductInput(vo);	// vo안의 내용물을 모두 채운후 DB에 저장시킨다.
	    return res;
	}

	@Override
	public ShopVO getProduct(int productIdx) {
		return shopDAO.getProduct(productIdx);
	}

	@Override
	public List<ShopVO> getAllOption(int productIdx) {
		return shopDAO.getAllOption(productIdx);
	}

	@Override
	public ShopVO getProductNameOne(String productName) {
		return shopDAO.getProductNameOne(productName);
	}

	@Override
	public ShopVO getProductNameOneVO(ShopVO imsiVO) {
		return shopDAO.getProductNameOneVO(imsiVO);
	}

	@Override
	public List<ShopVO> getProductName(int productTopIdx, int productMidIdx) {
		return shopDAO.getProductName(productTopIdx, productMidIdx);
	}

	@Override
	public ShopVO getProductInfo(int productIdx) {
		return shopDAO.getProductInfo(productIdx);
	}

	@Override
	public List<ShopVO> getOptionList(int productIdx) {
		return shopDAO.getOptionList(productIdx);
	}

	@Override
	public int getOptionSame(int optionGroupIdx, String optionName) {
		return shopDAO.getOptionSame(optionGroupIdx, optionName);
	}

	@Override
	public int setOptionInput(int optionGroupIdx, String optionName, int addPrice) {
		return shopDAO.setOptionInput(optionGroupIdx,optionName,addPrice);
	}

    @Transactional
    public boolean productOptionGroup(int productIdx, String[] groupNames) {
        for (String optionGroupName : groupNames) {
            int count = shopDAO.getOptionGroupSame(productIdx, optionGroupName);
            if (count != 0) {
                return false;
            }
            shopDAO.setOptionGroupInput(productIdx, optionGroupName);
        }
        return true;
    }

	@Override
	public List<ShopVO> getOptionGroup(int productIdx) {
		return shopDAO.getOptionGroup(productIdx);
	}

	@Override
	public int setoptionGroupDelete(int optionGroupIdx) {
		return shopDAO.setoptionGroupDelete(optionGroupIdx);
	}

	@Override
	public int setOptionDelete(int optionIdx) {
		return shopDAO.setOptionDelete(optionIdx);
	}

	@Override
	public int getOptionHas(int optionGroupIdx) {
		return shopDAO.getOptionHas(optionGroupIdx);
	}

	@Override
	public List<ShopVO> getNewProduct() {
		return shopDAO.getNewProduct();
	}

	@Override
	public int setShopCartUpdate(CartVO vo) {
		return shopDAO.setShopCartUpdate(vo);
	}

	@Override
	public int setShopCartInput(CartVO vo) {
		return shopDAO.setShopCartInput(vo);
	}

	@Override
	public List<ShopVO> getProductTopMidList() {
		return shopDAO.getProductTopMidList();
	}

    @Override
    public List<CartVO> getProductCart(Integer userIdx) {
        return shopDAO.getProductCart(userIdx);
    }

    @Override
    public CartItem getCartProductOptionSearch(int productIdx, int optionIdx, Integer userIdx) {
        return shopDAO.getCartProductOptionSearch(productIdx, optionIdx, userIdx);
    }

    @Override
    public int addCart(CartVO cartVO) {
        int result = 0;
        for (CartItem item : cartVO.getItems()) {
            // 로그 추가
            System.out.println("Adding Cart Item: " + item.getProductIdx() + ", Option: " + item.getOptionIdx());
            
            // productIdx 존재 여부 확인
            if (shopDAO.checkProductExists(item.getProductIdx()) == 0) {
                throw new RuntimeException("Invalid productIdx: " + item.getProductIdx());
            }
            result += shopDAO.addCart(cartVO.getUserIdx(), item);
        }
        return result;
    }
    
    @Override
    public int updateCart(CartItem cartItem, Integer userIdx) {
        return shopDAO.updateCart(userIdx, cartItem);
    }
    
    @Override
    public int setProductCartDelete(int cartIdx) {
        return shopDAO.setProductCartDelete(cartIdx);
    }

	@Override
	public int getUserCartCnt(Integer userIdx) {
	    if (userIdx == null) {
	        return 0;
	    }
	    return shopDAO.getUserCartCnt(userIdx);
	}

	@Override
	public List<ReviewVO> getAllReview(int productIdx) {
        return shopDAO.getAllReview(productIdx);
	}

	@Override
	public void setCartDeleteAll(int orderProductIdx) {
        shopDAO.setCartDeleteAll(orderProductIdx);
	}

	@Override
	public ReviewVO getProductParentReviewCheck(int productIdx) {
        return shopDAO.getProductParentReviewCheck(productIdx);
	}

	@Override
	public int setProductReviewInput(ReviewVO reviewVO) {
        return shopDAO.setProductReviewInput(reviewVO);
	}

	@Override
	public void setReviewOrderUpdate(int productIdx, int re_order) {
        shopDAO.setReviewOrderUpdate(productIdx, re_order);
	}

	@Override
	public List<ShopVO> getRelatedProducts(List<String> tags) {
		return shopDAO.getRelatedProducts(tags);
	}

	@Override
	public int setProductReviewDelete(int reviewIdx) {
		return shopDAO.setProductReviewDelete(reviewIdx);
	}

	@Override
	public int imgCheckNoticeInput(MultipartFile file, CsworkVO csworkVO) {

	    int res = 0;

	    // ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 'ckeditor'폴더에서 'notice'폴더로 복사작업처리 시켜준다.
	    String content = csworkVO.getContent();
	    //System.out.println("content : " + content);
	    if(content.indexOf("src=\"/") == -1) return 0;    // content박스의 내용중 그림이 없으면 돌려보낸다.

	    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	    String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");

	    int position = 33;
	    String nextImg = content.substring(content.indexOf("src=\"/") + position);
	    boolean sw = true;

	    while(sw) {
	      String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
	      String copyFilePath = "";
	      String oriFilePath = uploadPath + "ckeditor/" + imgFile;

	      copyFilePath = uploadPath + "notice/" + imgFile;

	      allProvide.fileCopyCheck(oriFilePath, copyFilePath);

	      if(nextImg.indexOf("src=\"/") == -1) sw = false;
	      else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
	    }
	    
	    csworkVO.setContent(csworkVO.getContent().replace("/data/ckeditor/", "/data/notice/"));
	    
	    res = shopDAO.setNoticeInput(csworkVO);	// vo안의 내용물을 모두 채운후 DB에 저장시킨다.
	    return res;

	}

	@Override
    public List<ShopVO> getProductList(String part, String sort, String keyword, String productPrice, int minPrice, int maxPrice, int averageRating, int startIndexNo, int pageSize) {
	    return shopDAO.getProductList(part, sort, keyword, productPrice, minPrice, maxPrice, averageRating, startIndexNo, pageSize);
	}

	@Override
    public boolean canRecordProductView(Integer userIdx, int productIdx) {
        int count = shopDAO.countProductViewsByUserAndDate(userIdx, new Date());
        return count < 10;  // 하루 조회 횟수 10번 제한
    }


	@Override
	public void recordProductView(Integer userIdx, int productIdx) {
	   shopDAO.recordProductView(userIdx, productIdx);
	}

    @Override
    public List<String> getTags() {
        return shopDAO.getAllTags();
    }

    @Override
    public String getTagsAsText() {
        List<String> tags = getTags();
        return String.join("#", tags);
    }

	@Override
	public List<String> getTopTags() {
        return shopDAO.getTopTags();

	}

	@Override
	public List<String> getTopPickTags() {
		return shopDAO.getTopPickTags();
	}

	@Override
	public List<ShopVO> getLikedProducts(int userIdx) {
		return shopDAO.getLikedProducts(userIdx);
	}

	@Override
	public int removeLike(int userIdx, int productIdx) {
		return shopDAO.removeLike(userIdx, productIdx);
	}

	@Override
	public CartVO getCartItem(int cartIdx, int productIdx, Integer userIdx) {
	    return shopDAO.getCartItem(cartIdx, productIdx, userIdx);
	}

	@Override
	public void updateCartQuantity(int cartIdx, int productIdx, int quantity, int totalPrice, Integer userIdx) {
		shopDAO.updateCartQuantity(cartIdx, productIdx, quantity, totalPrice, userIdx);
	}
}
