package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.ProductQnaVO;

public interface ProductQnaDAO {


	// 사용자 이메일 가져오기
	public String getEmail(@Param("userIdx") int userIdx);

	// QnA 개수 조회
	public int getCountIdx();

	// QnA의 최대 productQnaIdx 조회
	public int getMaxIdx();

	// QnA 질문/답변 입력
	public void qnaInputOk(@Param("vo") ProductQnaVO vo);
	
	// 전체 레코드 개수 조회
	public int totRecCnt();

	// QnA 목록 조회
	public List<ProductQnaVO> getQnaList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	// 특정 QnA 조회
	public ProductQnaVO getQnaContent(@Param("productQnaIdx") int productQnaIdx);

	// 특정 QnA 삭제
	public void setQnaDelete(@Param("productQnaIdx") int productQnaIdx);

	// QnA 내용 수정
	public void setQnaContentUpdate(@Param("vo") ProductQnaVO vo);

	// 특정 QnA의 답변 여부 확인
	public List<ProductQnaVO> getQnaIdxCheck(@Param("productQnaIdx") int productQnaIdx);

	// 삭제된 QnA 업데이트 (내용 변경)
	public void setQnaCheckUpdate(@Param("productQnaIdx") int productQnaIdx, @Param("qnaContent") String qnaContent);

	// 관리자 QnA 입력 처리
	public void qnaAdminInputOk(@Param("productQnaIdx") int productQnaIdx);

	// 관리자 QnA 답변 완료 처리
	public void qnaAdminAnswerUpdateOk(@Param("productQnaIdx") int productQnaIdx);

}
