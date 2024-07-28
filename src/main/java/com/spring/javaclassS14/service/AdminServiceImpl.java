package com.spring.javaclassS14.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.AdminDAO;
import com.spring.javaclassS14.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

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
                case "normal":
                    adminDAO.updateUserStatus(userId, "on");
                    break;
                case "stop":
                    adminDAO.updateUserStatus(userId, "stop");
                    break;
                case "delete":
                    adminDAO.deleteUser(userId);
                    break;
            }
        }
    }
}
