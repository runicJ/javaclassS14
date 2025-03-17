package com.spring.javaclassS14.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.http.HttpHeaders;
import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.UserDAO;
import com.spring.javaclassS14.vo.DeliveryAddressVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	AllProvide allProvide;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public UserVO getUserIdCheck(String userId) {
		return userDAO.getUserIdCheck(userId);
	}

	@Override
	public UserVO getUserNickCheck(String nickName) {
		return userDAO.getUserNickCheck(nickName);
	}
	
	@Override
	public UserVO getUserCheck(String name, String email) {
		return userDAO.getUserCheck(name, email);
	}

	@Override
	public String fileUpload(MultipartFile fName, String userId, String userImage) {
		UUID uid = UUID.randomUUID();
		String sFileName = userId + "_" + uid.toString().substring(0,8) + "_" + fName.getOriginalFilename();
		
		try {
			allProvide.writeFile(fName, sFileName, "user");
			
			if(!userImage.equals("noImage.png")) allProvide.deleteFile(userImage, "user");
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
	public void setUserPwdUpdate(String userId, String tempPwd) {
		userDAO.setUserPwdUpdate(userId, tempPwd);
	}

    @Override
    @Transactional
    public int setUserDelete(int userIdx, String deleteReason) {
        int res = userDAO.setUserDelete(userIdx, deleteReason);
        if (res != 0) {
            userDAO.insertDeletedUser(userIdx, deleteReason);
        }
        return res;
    }


	@Override
	public void setUserLog(Integer userIdx, String hostIp) {
		if (!isLoggedIn(userIdx)) {
			userDAO.setUserLog(userIdx, hostIp);
			System.out.println("로그 기록중...");
		} else {
			System.out.println("이미 로그인 되었습니다.");
		}
	}
	
	@Override
	public boolean isLoggedIn(Integer userIdx) {
		if (userIdx == null) {
			return false;
		}
		return userDAO.recentLog(userIdx) > 0;
	}

    @Override
    public void updateDeletedUser(String userId) {
        userDAO.updateDeletedUser(userId);
    }

    @Override
    public void cancelUserDelete(String userId) {
        userDAO.cancelUserDelete(userId);
    }

	@Override
	public int setUserUpdate(UserVO vo) {
		return userDAO.setUserUpdate(vo);
	}
	
	@Override
	public int setUpdateUser(UserVO vo) {
		return userDAO.setUpdateUser(vo);
	}

	@Override
	public int getUserEmailCheck(String email) {
		return userDAO.getUserEmailCheck(email);
	}

	@Override
	public List<OrderVO> getRecentOrders(Integer userIdx) {
		return userDAO.getRecentOrders(userIdx);
	}

	@Override
	public List<SaveInterestVO> getLikedProducts(Integer userIdx) {
		return userDAO.getLikedProducts(userIdx);
	}

	@Override
	public List<Map<String, Object>> getRecentViewProduct(Integer userIdx) {
        return userDAO.getRecentViewProduct(userIdx);
	}

	@Override
	public Integer getUserCouponCnt(Integer userIdx) {
        return userDAO.getUserCouponCnt(userIdx);
	}

	@Override
	public Integer getUserPointCnt(Integer userIdx) {
        return userDAO.getUserPointCnt(userIdx);
	}

	@Override
	public Integer getLikedCnt(Integer userIdx) {
		return userDAO.getLikedCnt(userIdx);
	}

	@Override
	public List<DeliveryAddressVO> getUserDeliveryAddresses(int userIdx) {
		return userDAO.getUserDeliveryAddresses(userIdx);
	}

	// 배송지 추가
	@Override
	public boolean addAddress(DeliveryAddressVO addressVO) {
		// user 기존 배송지 갯수
		int count = userDAO.countUserAddresses(addressVO.getUserIdx());
		if(count >= 3) {
			return false;
		}
		
		// 대표 배송지 설정 시 기존 대표 주소 해제
		if("Y".equals(addressVO.getDefaultAddress())) {
			userDAO.resetDefaultAddress(addressVO.getUserIdx());
		}
		
		// 새 배송지 저장
		return userDAO.insertAddress(addressVO);
	}

    // 배송지 삭제
    @Override
    public boolean deleteAddress(int addressId) {
    	Integer userIdx = userDAO.getUserIdxByAddressId(addressId);
        
        if (userIdx == null) {
            return false;
        }

        boolean success = userDAO.deleteAddress(addressId);

        // 대표 배송지가 삭제되면 남은 주소 중 하나를 대표로 설정
        if (success) {
            List<DeliveryAddressVO> addresses = userDAO.getUserAddresses(userIdx);
            if (!addresses.isEmpty()) {
            	userDAO.setDefaultAddress(addresses.get(0).getDeliveryAddressIdx());
            }
        }

        return success;
    }

	@Override
	public boolean setDefaultAddress(int addressId) {
		int userIdx = userDAO.getUserIdxByAddressId(addressId);
		
		// 기존 대표 배송지 해제
		userDAO.resetDefaultAddress(userIdx);
		
		// 새로운 대표 배송지 설정
		return userDAO.setDefaultAddress(addressId);
	}

	@Override
	public List<Map<String, Object>> getUserActivity(int userIdx) {
		return userDAO.getUserActivity(userIdx);
	}

    private final String CLIENT_ID = "b4dd9b87941b50219dc501c361ef9bdd"; // 카카오 REST API 키
    private final String REDIRECT_URI = "http://localhost:9090/javaclassS14/users/userKakaoLogin";

    // 카카오 로그인 처리 (기존 회원 조회 또는 신규 회원 가입)
    @Override
    @Transactional
    public UserVO handleKakaoLogin(String code, HttpSession session) {
        String accessToken = getAccessToken(code); // 1️⃣ accessToken 요청
        UserVO kakaoUser = getUserInfo(accessToken); // 2️⃣ 사용자 정보 요청

        if (kakaoUser == null) {
            throw new RuntimeException("카카오 사용자 정보를 가져오지 못했습니다.");
        }

        // 3 기존 회원 확인
        UserVO existingUser = userDAO.getUserNickNameEmailCheck(kakaoUser.getNickName(), kakaoUser.getEmail());

        if (existingUser == null) {
            // 신규 회원 가입 처리
            String userId = kakaoUser.getEmail().split("@")[0];

            if (userDAO.getUserIdCheck(userId) != null) {
                throw new RuntimeException("이미 사용 중인 아이디입니다.");
            }

            // 임시 비밀번호 생성
            String tempPwd = UUID.randomUUID().toString().substring(0, 8);
            session.setAttribute("sImsiPwd", tempPwd);

            // 기본 등급 설정
            double userLevel = 3.0;

            // 신규 회원 저장
            userDAO.setKakaoUserInput(userId, tempPwd, kakaoUser.getNickName(), kakaoUser.getEmail(), kakaoUser.getTel(), userLevel);
            try {
                allProvide.mailSend(kakaoUser.getEmail(), "임시 비밀번호 발급", tempPwd);
            } catch (MessagingException e) {
                e.printStackTrace();
            }

            // 새로 가입한 회원 정보 가져오기
            existingUser = userDAO.getUserIdCheck(userId);
            session.setAttribute("sLogin", "OK");
        }

        // 로그인 세션 설정
        session.setAttribute("sUid", existingUser.getUserId());
        session.setAttribute("sNickName", existingUser.getNickName());
        session.setAttribute("sLevel", existingUser.getLevel());

        return existingUser;
    }

    // 카카오 API에서 accessToken 요청 (🔹 private 메서드)
    private String getAccessToken(String code) {
        String requestUrl = "https://kauth.kakao.com/oauth/token";

        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", CLIENT_ID);
        params.add("redirect_uri", REDIRECT_URI);
        params.add("code", code);

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
        ResponseEntity<String> response = restTemplate.postForEntity(requestUrl, request, String.class);

        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("카카오 토큰 요청 실패: " + response.getStatusCode());
        }

        JSONObject jsonObject = new JSONObject(response.getBody());

        if (!jsonObject.has("access_token")) {
            throw new RuntimeException("카카오 토큰 응답에 access_token 없음: " + response.getBody());
        }

        return jsonObject.getString("access_token");
    }

    // accessToken을 이용해 카카오 사용자 정보 요청 (🔹 private 메서드)
    private UserVO getUserInfo(String accessToken) {
        String requestUrl = "https://kapi.kakao.com/v2/user/me";

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        headers.set("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<String> request = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.postForEntity(requestUrl, request, String.class);

        if (!response.getStatusCode().is2xxSuccessful()) {
            throw new RuntimeException("카카오 사용자 정보 요청 실패: " + response.getStatusCode());
        }

        JSONObject jsonObject = new JSONObject(response.getBody());

        if (!jsonObject.has("kakao_account")) {
            throw new RuntimeException("카카오 응답에 kakao_account 정보 없음: " + response.getBody());
        }

        JSONObject kakaoAccount = jsonObject.getJSONObject("kakao_account");

        UserVO user = new UserVO();
        user.setUserId(kakaoAccount.getString("email").split("@")[0]);
        user.setNickName(kakaoAccount.getJSONObject("profile").getString("nickname"));
        user.setEmail(kakaoAccount.getString("email"));

        // 전화번호 가져오기 (동의 필요)
        if (kakaoAccount.has("phone_number")) {
            user.setTel(kakaoAccount.getString("phone_number"));
        } else {
            user.setTel(""); // 기본값 설정
        }
        
        return user;
    }

	@Override
    public UserVO handleNaverLogin(String naverId, String email, String nickname) {
        // 1 이메일을 기준으로 기존 회원 조회
        UserVO existingUser = userDAO.getUserByEmail(email);

        if (existingUser == null) {
            // 2 신규 회원 가입
            UserVO newUser = new UserVO();
            newUser.setUserId(naverId);  // 네이버 ID를 userId로 저장
            newUser.setEmail(email);
            newUser.setNickName(nickname);
            newUser.setUserPwd(passwordEncoder.encode(UUID.randomUUID().toString().substring(0, 8))); // 임시 비밀번호 설정
            newUser.setUserStatus("active"); // 회원 상태

            userDAO.insertUser(newUser);
            return newUser;
        } else {
            // 3️ 기존 회원이라면 기존 정보 반환
            return existingUser;
        }
    }
}
