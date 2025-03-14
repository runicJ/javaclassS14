package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.ProductQnaVO;

public interface ProductQnaService {

	// 사용자 이메일 가져오기
	public String getEmail(Integer userIdx);

	// QnA의 최대 productQnaIdx 조회
	public int getMaxIdx();

	// QnA 질문/답변 입력
	public void qnaInputOk(ProductQnaVO vo);

	// QnA 목록 조회
	public List<ProductQnaVO> getQnaList(int startIndexNo, int pageSize);

	// 특정 QnA 조회
	public ProductQnaVO getQnaContent(int productQnaIdx);

	// 특정 QnA 삭제
	public void setQnaDelete(int productQnaIdx);

	// QnA 내용 수정
	public void setQnaContentUpdate(ProductQnaVO vo);

	// 특정 QnA의 답변 여부 확인
	public List<ProductQnaVO> getQnaIdxCheck(int productQnaIdx);

	// 삭제된 QnA 업데이트 (내용 변경)
	public void setQnaCheckUpdate(int productQnaIdx, String qnaContent);

	// 관리자 QnA 입력 처리
	public void qnaAdminInputOk(int productQnaIdx);

	// 관리자 QnA 답변 완료 처리
	public void qnaAdminAnswerUpdateOk(int productQnaIdx);
}
