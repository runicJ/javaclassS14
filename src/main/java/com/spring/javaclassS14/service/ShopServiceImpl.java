package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.ShopDAO;
import com.spring.javaclassS14.vo.ShopVO;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	ShopDAO shopDAO;

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

}
