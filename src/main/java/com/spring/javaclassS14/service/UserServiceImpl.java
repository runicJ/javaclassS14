package com.spring.javaclassS14.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.UserDAO;
import com.spring.javaclassS14.vo.SaveMypageVO;
import com.spring.javaclassS14.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	AllProvide allProvide;
	
	@Override
	public UserVO getUserIdCheck(String userId) {
		return userDAO.getUserIdCheck(userId);
	}

	@Override
	public UserVO getUserNickCheck(String nickName) {
		return userDAO.getUserNickCheck(nickName);
	}
	
	@Override
	public UserVO getUserEmailCheck(String email) {
		return userDAO.getUserEmailCheck(email);
	}

	@Override
	public String fileUpload(MultipartFile fName, String userId, String userImage) {
		UUID uid = UUID.randomUUID();
		String sFileName = userId + "_" + uid.toString().substring(0,8) + "_" + fName.getOriginalFilename();
		
		try {
			allProvide.writeFile(fName, sFileName, "user");
			
			if(!userImage.equals("noImage.jpg")) allProvide.deleteFile(userImage, "user");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sFileName;
	}

	@Override
	public int setUserRegisterOk(UserVO vo) {
		return userDAO.setUserRegisterOk(vo);
	}

	@Override
	public UserVO getUserNickNameEmailCheck(String nickName, String email) {
		return userDAO.getUserNickNameEmailCheck(nickName, email);
	}

	@Override
	public void setKakaoUserInput(String userId, String pwd, String nickName, String email) {
		userDAO.setKakaoUserInput(userId, pwd, nickName, email);
		
	}

	@Override
	public void setUserPwdUpdate(String userId, String tempPwd) {
		userDAO.setUserPwdUpdate(userId, tempPwd);
	}

    @Override
    @Transactional
    public int setUserDelete(String userId, String deleteReason) {
        int res = userDAO.setUserDelete(userId, deleteReason);
        if (res != 0) {
            userDAO.insertDeletedUser(userId, deleteReason);
        }
        return res;
    }
    
//    @Override
//    @Transactional
//    public int deleteUserWithReason(String userId, String deleteReason) {
//        int updateResult = userDAO.setUserDelete(userId);
//        if (updateResult != 0) {
//            userDAO.insertDeletedUser(userId, deleteReason);
//        }
//        return updateResult;
//    }

    @Override
    public boolean isLoggedIn(String userId) {
        return userDAO.recentLog(userId) > 0;
    }

	@Override
	public void setUserLog(String userId, String hostIp) {
		if (!isLoggedIn(userId)) {
			userDAO.setUserLog(userId,hostIp);
			System.out.println("로그 기록중...");
		} else {
			System.out.println("이미 로그인 되었습니다.");
		}
	}

    @Override
    public void updateDeletedUser(String userId) {
        userDAO.updateDeletedUser(userId);
    }

    @Override
    public List<UserVO> getAllDeletedUsers() {
        return userDAO.getAllDeletedUsers();
    }

    @Override
    public void cancelUserDelete(String userId) {
        userDAO.cancelUserDelete(userId);
    }

	@Override
	public int updateUser(UserVO vo) {
		return userDAO.updateUser(vo);
	}

	@Override
	public SaveMypageVO getBookmarkList(String userId) {
		return userDAO.getBookmarkList(userId);
	}

	@Override
	public boolean checkUserBookmark(String userId, String partUrl) {
		return userDAO.checkUserBookmark(userId, partUrl);
	}

	@Override
	public void saveBookmarkToggle(String userId, String partUrl, boolean bookmark) {
		userDAO.saveBookmarkToggle(userId, partUrl, bookmark);
	}
}
