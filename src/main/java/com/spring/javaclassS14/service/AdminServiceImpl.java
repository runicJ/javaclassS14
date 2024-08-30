package com.spring.javaclassS14.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.AdminDAO;
import com.spring.javaclassS14.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	AllProvide allProvide;
	
	public List<UserVO> getUserList(int startIndexNo, int pageSize, String keyword, String sortOption) {
        Map<String, Object> paramMap = prepareSortOption(keyword, sortOption, startIndexNo, pageSize);
        return adminDAO.getUserList(paramMap);
    }

    private Map<String, Object> prepareSortOption(String keyword, String sortOption, int startIndexNo, int pageSize) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("startIndexNo", startIndexNo);
        paramMap.put("pageSize", pageSize);

        try {
            Double numericSortOption = Double.valueOf(sortOption);
            paramMap.put("numericOption", numericSortOption);
        } catch (NumberFormatException e) {
            paramMap.put("stringOption", sortOption);
        }
        // sortOption을 orderBy로 설정
        String orderBy = "";
        switch (sortOption) {
            case "name":
                orderBy = "name";
                break;
            case "level":
                orderBy = "level";
                break;
            case "createDate":
                orderBy = "createDate DESC";
                break;
            case "userStatus":
                orderBy = "userStatus";
                break;
            default:
                orderBy = "userIdx";
                break;
        }
        paramMap.put("orderBy", orderBy);

        return paramMap;
    }

	@Override
	public ArrayList<UserVO> getDeleteUserList(int startIndexNo, int pageSize) {
		return adminDAO.getDeleteUserList(startIndexNo, pageSize);
	}

	@Override
	public int getDeleteUser(String delFlag, String userId) {
		return adminDAO.getDeleteUser(delFlag, userId);
	}

	@Override
	public List<UserVO> getUserRegisterWay() {
		return adminDAO.getUserRegisterWay();
	}

    @Override
    public void allAction(String action, List<String> users) {
        for (String userId : users) {
            switch (action) {
                case "정상":
                    adminDAO.updateUserStatus(userId, "on");
                    break;
                case "정지":
                    adminDAO.updateUserStatus(userId, "stop");
                    break;
                case "삭제":
                    adminDAO.deleteUser(userId);
                    break;
            }
        }
    }

	@Override
	public int getDeleteExUser() {
		return adminDAO.getDeleteExUser();
	}

	@Override
	public int getRecentUser() {
		return adminDAO.getRecentUser();
	}

	@Override
	public int getDeleteResUser() {
		return adminDAO.getDeleteResUser();
	}

	@Override
	public int getOrderCnt() {
		return adminDAO.getOrderStatusCnt("주문");
	}

	@Override
	public int getShipCnt() {
		return adminDAO.getOrderStatusCnt("배송");
	}

	@Override
	public int getQnaCnt() {
		return adminDAO.getQnaCnt("all");
	}

	@Override
	public int getQnaGuestCnt() {
		return adminDAO.getQnaCnt("");
	}

	@Override
	public int getQnaUserCnt() {
		return adminDAO.getQnaCnt("null");
	}

	@Override
	public int getProductQnaCnt() {
		return adminDAO.getProductQnaCnt();
	}
	
	@Override
    public List<Map<String, Object>> getWeeklySales() {
        return adminDAO.getWeeklySales();
    }
	
	@Override
    public List<Map<String, Object>> getDailySales() {
        return adminDAO.getDailySales();
    }
	
	@Override
    public List<UserVO> getMailUser() {
    	return adminDAO.getMailUser();
    }
	
	@Override
	public boolean sendCouponToUser(String userId) {
        // 사용자 이메일 가져오기
        UserVO user = adminDAO.getUserById(userId);
        if (user == null) {
            return false;  // 유저가 없을 경우 실패
        }

        // UUID로 쿠폰 코드 생성
        String couponCode = UUID.randomUUID().toString().replace("-", "").substring(0, 12).toUpperCase();

        // 메일 발송에 사용할 기본 메시지 설정
        String email = user.getEmail();
        String title = "귀하를 위한 특별 쿠폰 코드";
        String content = "안녕하세요,\n\n아래는 귀하를 위한 특별 쿠폰 코드입니다.";

        try {
            allProvide.mailSend(email, title, content);
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;  // 메일 발송 실패 시
        }

        return true;  // 성공적으로 메일 발송 완료
    }
}
