package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.IntroDAO;
import com.spring.javaclassS14.vo.BranchVO;

@Service
public class IntroServiceImpl implements IntroService {

	@Autowired
	IntroDAO introDAO;

	@Override
	public List<BranchVO> getBranchList() {
		return introDAO.getBranchList();
	}
	
}
