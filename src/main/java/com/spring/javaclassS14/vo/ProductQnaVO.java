package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class ProductQnaVO {
    private int productQnaIdx;
    private int userIdx;
    private int productIdx;  // 상품 ID 추가
    private String userId;   // 아이디 추가 (닉네임 없을 때 마스킹 처리 가능)
    private String nickName;
    private String email;
    private String qnaPwd;  // 필드명 변경
    private String qnaDate; // 필드명 변경
    private String qnaContent; // 필드명 변경
    private String qnaOpenFlag; // 공개 여부 추가 ('y' 또는 'n')
    private String answerFlag;  // 필드명 변경 ('y' 또는 'n')
    private String answerContent;  // 필드명 변경
    private String answerDate; // 답변 등록 날짜 추가
    private String deleteFlag; // 삭제 여부 추가 ('y' 또는 'n')

    private String diffTime; // 경과 시간 (필요하면 유지)
    
    // 닉네임이 없을 경우 아이디 일부 마스킹
    public String getDisplayUserName() {
        if (nickName != null && !nickName.isEmpty()) {
            return nickName;
        } else if (userId != null && !userId.isEmpty()) {
            return userId.substring(0, 3) + "***"; // 아이디 앞 3자리만 보이게 마스킹
        } else {
            return "익명"; // 닉네임과 아이디가 모두 없는 경우 기본값
        }
    }
}
