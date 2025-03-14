package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.ProductQnaDAO;
import com.spring.javaclassS14.vo.ProductQnaVO;

@Service
public class ProductQnaServiceImpl implements ProductQnaService {

	@Autowired
	ProductQnaDAO qnaDAO;

	@Override
	public String getEmail(Integer userIdx) {
		return qnaDAO.getEmail(userIdx);
	}

	@Override
	public int getMaxIdx() {
		return qnaDAO.getCountIdx() == 0 ? 0 : qnaDAO.getMaxIdx();
	}

	@Override
	public void qnaInputOk(ProductQnaVO vo) {
		qnaDAO.qnaInputOk(vo);
	}

	@Override
	public List<ProductQnaVO> getQnaList(int startIndexNo, int pageSize) {
		return qnaDAO.getQnaList(startIndexNo, pageSize);
	}

	@Override
	public ProductQnaVO getQnaContent(int productQnaIdx) {
		return qnaDAO.getQnaContent(productQnaIdx);
	}

	@Override
	public void setQnaDelete(int productQnaIdx) {
		qnaDAO.setQnaDelete(productQnaIdx);
	}

	@Override
	public void setQnaContentUpdate(ProductQnaVO vo) {
		qnaDAO.setQnaContentUpdate(vo);
	}

	@Override
	public List<ProductQnaVO> getQnaIdxCheck(int productQnaIdx) {
		return qnaDAO.getQnaIdxCheck(productQnaIdx);
	}

	@Override
	public void setQnaCheckUpdate(int productQnaIdx, String qnaContent) {
		qnaDAO.setQnaCheckUpdate(productQnaIdx, qnaContent);
	}

	@Override
	public void qnaAdminInputOk(int productQnaIdx) {
		qnaDAO.qnaAdminInputOk(productQnaIdx);
	}

	@Override
	public void qnaAdminAnswerUpdateOk(int productQnaIdx) {
		qnaDAO.qnaAdminAnswerUpdateOk(productQnaIdx);
	}
}
