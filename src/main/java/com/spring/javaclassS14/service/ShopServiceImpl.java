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
	public List<ShopVO> getCategoryList() {
		return shopDAO.getCategoryList();
	}

}
