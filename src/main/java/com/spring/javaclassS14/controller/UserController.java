package com.spring.javaclassS14.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.SaveMypageVO;
import com.spring.javaclassS14.vo.UserVO;

@Controller
@RequestMapping("/users")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	AllProvide allProvide;
	
	// 아이디 중복확인 / 찾기
	@ResponseBody
	@RequestMapping(value="/uidCheck", method=RequestMethod.GET)
	public String uidCheckGet(String userId) {
		UserVO vo = userService.getUserIdCheck(userId);
		return vo != null ? "1" : "0";
	}
	
	// 닉네임 중복확인 / 찾기
	@ResponseBody
	@RequestMapping(value="/nickCheck", method=RequestMethod.GET)
	public String nickCheckGet(String nickName) {
		UserVO vo = userService.getUserNickCheck(nickName);
		return vo != null ? "1" : "0";
	}
	
	// 이메일 중복확인 / 찾기
	@ResponseBody
	@RequestMapping(value="/emailCheck", method=RequestMethod.GET)
	public String emailCheckGet(String email, HttpSession session) throws MessagingException {
	    UserVO vo = userService.getUserEmailCheck(email);
//	    if(vo != null) return "1";
//	    else {
	        // 이메일 인증 코드 생성 및 세션에 저장
	        UUID uuid = UUID.randomUUID();
	        String emailKey = uuid.toString().substring(0, 6);
	        session.setAttribute("sEmailKey", emailKey);

	        // 이메일로 인증 코드 전송
	        allProvide.mailSend(email, "이메일 인증 코드", "인증 코드: " + emailKey);
	        return "0";
//	    }
	}
	
	// 이메일 인증코드 확인하기
	@ResponseBody
	@RequestMapping(value = "/confirmCodeCheck", method = RequestMethod.GET)
	public String emailConfirmCheckGet(String checkKey, HttpSession session) {
		String emailKey = (String) session.getAttribute("sEmailKey");
		return checkKey.equals(emailKey) ? "1" : "0";
	}
	
	@RequestMapping(value = "/userPolicy", method = RequestMethod.GET)
	public String userPolicyGet() {
		return "users/userPolicy";
	}
	
	// 약관동의(세션 저장)
	@RequestMapping(value="/userPolicy", method=RequestMethod.POST)
	public String userPolicyPost(HttpSession session,
	                             @RequestParam(name="agreeRequired", defaultValue="false") boolean agreeRequired,
	                             @RequestParam(name="agreeOptional", defaultValue="false") boolean agreeOptional) {
	    if (!agreeRequired) {
	        return "redirect:/users/userPolicy?error=required";
	    }

	    session.setAttribute("agreeRequired", agreeRequired);
	    session.setAttribute("agreeOptional", agreeOptional);
	    return "redirect:/users/userRegister";
	}
	
	// 회원가입 페이지로 이동
	@RequestMapping(value="/userRegister", method=RequestMethod.GET)
	public String userRegisterGet(Model model, HttpSession session) {
	    Boolean agreeRequired = (Boolean) session.getAttribute("agreeRequired");

	    if (agreeRequired == null || !agreeRequired) {
	    	return "redirect:/msg/agreeRequiredNo";
	    }

	    Boolean agreeOptional = (Boolean) session.getAttribute("agreeOptional");
	    model.addAttribute("agreeOptional", agreeOptional);

	    return "users/userRegister";
	}
	
	// 회원가입 처리
	@RequestMapping(value="/userRegister", method=RequestMethod.POST)
	public String userRegisterPost(UserVO vo, MultipartFile fName, HttpSession session) {
		if(userService.getUserIdCheck(vo.getUserId()) != null) return "redirect:/msg/uidCheckNo";
		if(userService.getUserNickCheck(vo.getNickName()) != null) return "redirect:/msg/nickCheckNo";
		//if(userService.getUserEmailCheck(vo.getEmail()) != null) return "redirect:/msg/emailCheckNo";

		vo.setUserPwd(passwordEncoder.encode(vo.getUserPwd()));
		
		if(!fName.getOriginalFilename().equals("")) vo.setUserImage(userService.fileUpload(fName, vo.getUserId(), ""));
		else vo.setUserImage("noImage.jpg");
		
		// 선택 약관 동의 정보 설정
        boolean agreeOptional = (boolean) session.getAttribute("agreeOptional");
        String policyFlag = (agreeOptional ? "y" : "n");
        vo.setPolicyFlag(policyFlag);
		
		int res = userService.setUserRegisterOk(vo);
		
        if (res != 0) {
            session.removeAttribute("agreeRequired");
            session.removeAttribute("agreeOptional");
            return "redirect:/msg/userRegisterOk";
        } else {
            return "redirect:/msg/userRegisterNo";
        }
	}
	
	// 로그인 페이지로 이동(쿠키에 아이디 저장)
	@RequestMapping(value="/userLogin", method=RequestMethod.GET)
	public String userLoginGet(HttpServletRequest request) {
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cUid")) {
					request.setAttribute("userId", cookies[i].getValue());
					break;
				}
			}
		}
		return "users/userLogin";
	}
	
	// 로그인 처리
	@RequestMapping(value="/userLogin", method=RequestMethod.POST)
	public String userLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(name="userId", defaultValue = "admin", required = false) String userId,
			@RequestParam(name="userPwd", defaultValue = "1234", required = false) String userPwd,
			@RequestParam(name="idSave", defaultValue="off", required = false) String idSave
		) {
		UserVO vo = userService.getUserIdCheck(userId);
		
		if(vo != null && passwordEncoder.matches(userPwd, vo.getUserPwd())) {
	        // 탈퇴 요청 상태 확인
	        if (vo.isDeleteRequested()) {
	            // 탈퇴 요청 해제
	            userService.cancelUserDelete(vo.getUserId());
	        }
			
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자(대가)";
			else if(vo.getLevel() == 0.5) strLevel = "귀한분";
			else if(vo.getLevel() == 1) strLevel = "전문가";
			else if(vo.getLevel() == 2) strLevel = "숙련자";
			else if(vo.getLevel() == 3) strLevel = "지식인";
			
			session.setAttribute("sUid", userId);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			session.setAttribute("sImage", vo.getUserImage());
			
			if(idSave.equals("on")) {
				Cookie cookieUid = new Cookie("cUid", userId);
				cookieUid.setPath("/");
				cookieUid.setMaxAge(60*60*24*7);
				response.addCookie(cookieUid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cUid")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			// 회원 로그
			String hostIp = request.getRemoteAddr();
			userService.setUserLog(userId, hostIp);
			
			return "redirect:/msg/userLoginOk?uid="+userId;
		}
		else {
			return "redirect:/msg/userLoginNo";
		}
	}
	
	//카카오 로그인
	@RequestMapping(value = "/userKakaoLogin", method = RequestMethod.GET)
	public String kakaoLoginGet(String nickName , String email, String accessToken,
			HttpServletRequest request,
			HttpSession session
		) throws MessagingException {
		
		// 카카오 로그아웃을 위한 카카오앱키를 세션에 저장시켜둔다.
		session.setAttribute("sAccessToken", accessToken);
		
		// 카카오 로그인한 회원인 경우에는 우리 회원인지를 조사한다.(넘어온 이메일을 @를 기준으로 아이디와 분리해서 기존 memeber2테이블의 아이디와 비교한다.)
		UserVO vo = userService.getUserNickNameEmailCheck(nickName, email);
		
		// 현재 카카오로그인에의한 우리회원이 아니였다면, 자동으로 우리회원에 가입처리한다.
		// 필수입력:아이디, 닉네임, 이메일, 성명(닉네임으로 대체), 비밀번호(임시비밀번호 발급처리)
		String newMember = "NO"; // 신규회원인지에 대한 정의(신규회원:OK, 기존회원:NO)
		if(vo == null) {
			// 아이디 결정하기
			String userId = email.substring(0, email.indexOf("@"));
			
			// 만약에 기존에 같은 아이디가 존재한다면 가입처리 불가...
			UserVO vo2 = userService.getUserIdCheck(userId);
			if(vo2 != null) return "redirect:/msg/uidSameSearch";
			
			// 비밀번호(임시비밀번호 발급처리)
			UUID uuid = UUID.randomUUID();
			String pwd = uuid.toString().substring(0,8);
			session.setAttribute("sImsiPwd", pwd);
			
			// 새로 발급된 비밀번호를 암호화 시켜서 db에 저장처리한다.(카카오 로그인한 신입회원은 바로 정회원으로 등업 시켜준다.)
			userService.setKakaoUserInput(userId, passwordEncoder.encode(pwd), nickName, email);
			
			// 새로 발급받은 임시비밀번호를 메일로 전송한다.
			allProvide.mailSend(email, "임시 비밀번호를 발급하였습니다.", pwd);
			
			// 새로 가입처리된 회원의 정보를 다시 vo에 담아준다.
			vo = userService.getUserIdCheck(userId);
			
			// 비밀번호를 새로 발급처리했을때 sLogin세션을 발생시켜주고, memberMain창에 비밀번호 변경메세지를 지속적으로 뿌려준다.
			session.setAttribute("sLogin", "OK");
			
			newMember = "OK";
		}
		
		// 로그인 인증완료시 처리할 부분(1.세션, 3.기타 설정값....)
		// 1.세션처리
		String strLevel = "";
		if(vo.getLevel() == 0) strLevel = "관리자";
		else if(vo.getLevel() == 0.5) strLevel = "귀한분";
		else if(vo.getLevel() == 1) strLevel = "전문가";
		else if(vo.getLevel() == 2) strLevel = "숙련자";
		else if(vo.getLevel() == 3) strLevel = "지식인";
		
		session.setAttribute("sUid", vo.getUserId());
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("strLevel", strLevel);
		
		// 로그인 완료후 모든 처리가 끝나면 필요한 메세지처리후 memberMain으로 보낸다.
		if(newMember.equals("NO")) return "redirect:/msg/userLoginOk?uid="+vo.getUserId();
		else return "redirect:/msg/userLoginNewOk?uid="+vo.getUserId();
	}
	
	// 로그아웃 처리
	@RequestMapping(value="/userLogout", method=RequestMethod.GET)
	public String userLogoutGet(HttpSession session) {
		String uid = (String) session.getAttribute("sUid");
		session.invalidate();
		
		return "redirect:/msg/userLogout?uid="+uid;
	}
	
	// 아이디 찾기 팝업 띄우기
	@RequestMapping(value="/userFindId", method=RequestMethod.GET)
	public String userFindIdGet() {
		return "users/userFindId";
	}
	
    // 아이디 찾기
    @ResponseBody
    @RequestMapping(value="/userFindId", method=RequestMethod.POST)
    //@RequestMapping(value="/userFindId")
    public Map<String, String> userFindIdPost(String name, String email) {
        Map<String, String> resMap = new HashMap<>();
        UserVO vo = userService.getUserEmailCheck(email);
        if(vo != null && vo.getName().equals(name)) {
            resMap.put("res", "1");
            resMap.put("userId", vo.getUserId());
            resMap.put("createDate", vo.getCreateDate().toString().substring(0,10));
        }
        else {
            resMap.put("res", "0");
        }
        return resMap;
    }
	
	// 비밀번호 찾기 팝업 띄우기
	@RequestMapping(value="/userFindPw", method=RequestMethod.GET)
	public String userFindPwGet() {
		return "users/userFindPw";
	}
	
	// 이메일로 임시 비밀번호 발급
	@ResponseBody
	@RequestMapping(value = "/userTempPwd", method = RequestMethod.POST)
	public String userTempPwdPost(String userId, String email, HttpSession session) throws MessagingException {
		UserVO vo = userService.getUserIdCheck(userId);
		if(vo != null && vo.getEmail().equals(email)) {
			// 정보 확인 후 정보가 맞으면 임시 비밀번호를 발급 받아서 메일로 전송 처리한다.
			UUID uuid = UUID.randomUUID();  // 다른방법 6월 23일에 (월요일)
			String tempPwd = uuid.toString().substring(0,8);
			
			userService.setUserPwdUpdate(userId, passwordEncoder.encode(tempPwd));
			
			String today = LocalDateTime.now().toString().substring(0,10) + " " + LocalDateTime.now().toString().substring(11,19);
			// 발급받은 비밀번호를 메일로 전송처리한다.
			String title = vo.getName() + "님 '괄호안쉼표'에서 '"+ today +"'에 임시 비밀번호를 발급받으셨습니다.\n 본인이 아니실 경우 빠른 문의 부탁드립니다.";
			String mailFlag = "임시 비밀번호 : " + tempPwd;
			String res = allProvide.mailSend(email, title, mailFlag);
			
			session.setAttribute("sLogin", "OK");  // 새비밀번호 왔을때만 세션이 생성 -> 다 끝나고 세션 지워버림
			
			if(res == "1") return "1";
		}
		return "0";
	}
	
	// 회원정보 페이지로 이동
	@RequestMapping(value="/userMain", method=RequestMethod.GET)
	public String userMainGet() {
		return "users/userMain";
	}
	
	// 회원정보 수정 폼 띄우기
	@RequestMapping(value="/userUpdate", method=RequestMethod.GET)
	public String userUpdateGet(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sUid");
		UserVO vo = userService.getUserIdCheck(userId);
		
		model.addAttribute("vo", vo);
		
		return "users/userUpdate";
	}
	
	// 회원정보 수정 처리
	@RequestMapping(value="/userUpdate", method=RequestMethod.POST)
	public String userUpdatePost(UserVO vo, MultipartFile fName, HttpSession session,
	        @RequestParam(value="pwdNew", required=false) String pwdNew,
            @RequestParam(value="pwdNewCheck", required=false) String pwdNewCheck,
            @RequestParam(value="nameNew", required=false) String nameNew,
            @RequestParam(value="nickNameNew", required=false) String nickNameNew,
            @RequestParam("policyFlag") String policyFlag) {
		
	    // 세션에서 사용자 아이디를 가져옵니다.
	    String userId = (String) session.getAttribute("sUid");
	    UserVO voBasic = userService.getUserIdCheck(userId);
	    
	    // 닉네임 체크
	    String nickName = (String) session.getAttribute("sNickName");
	    if (nickNameNew != null && !nickNameNew.isEmpty()) {
		    if(userService.getUserNickCheck(nickNameNew) != null && !nickName.equals(nickNameNew)) {
		        return "redirect:/msg/nickCheckNo";
		    }
		    else vo.setNickName(nickNameNew);
	    }
	    else vo.setNickName(null);
	    

	    // 비밀번호 체크
	    if (!passwordEncoder.matches(vo.getUserPwd(), voBasic.getUserPwd())) {
	        return "redirect:/msg/pwdCheckNo";
	    }

	    // 새로운 비밀번호가 있으면 업데이트
	    if (pwdNew != null && !pwdNew.isEmpty()) {
	        if (!pwdNew.equals(pwdNewCheck)) {
	            return "redirect:/msg/pwdNewCheckNo";
	        }
	        vo.setUserPwd(passwordEncoder.encode(pwdNew));
	    } 
	    else {
	        vo.setUserPwd(null); // 기존 비밀번호 유지
	    }
	    
	    if (nameNew != null && !nameNew.isEmpty()) {
	    	vo.setName(nameNew);
	    } else {
	    	vo.setName(null);
	    }
		
		if(fName.getOriginalFilename() != null && !fName.getOriginalFilename().equals("")) {
			vo.setUserImage(userService.fileUpload(fName, vo.getUserId(), vo.getUserImage()));
		}
		
	    vo.setPolicyFlag(policyFlag);

		int res = userService.setUserUpdate(vo);
		if(res != 0) {
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sImage", vo.getUserImage());
			return "redirect:/msg/userUpdateOk";
		}
		else return "redirect:/msg/userUpdateNo";
	}
	
	// 회원탈퇴 페이지로 이동
	@RequestMapping(value="/userDelete", method=RequestMethod.GET)
	public String userDeleteGet(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sUid");
		UserVO vo = userService.getUserIdCheck(userId);
		
		model.addAttribute("vo", vo);
		
		return "users/userDelete";
	}
	
	// 회원탈퇴 신청
	@RequestMapping(value="/userDelete", method=RequestMethod.POST)
	public String userDeletePost(HttpSession session, @RequestParam("deleteReason") String deleteReason) {
	    String userId = (String) session.getAttribute("sUid");
	    int res = userService.setUserDelete(userId, deleteReason);
		
		return res != 0 ? "redirect:/msg/userDeleteOk" : "redirect:/msg/userDeleteNo";
	}

	// 회원탈퇴 신청
	@RequestMapping(value="/updateDeletedUsers", method=RequestMethod.GET)
	public String updateDeletedUsersGet() {
	    List<UserVO> deletedUsers = userService.getAllDeletedUsers();
	    for (UserVO user : deletedUsers) {
	        userService.updateDeletedUser(user.getUserId());
	    }
	    return "redirect:/msg/updateDeletedUsersOk";
	}
	
	// 회원 배송지 리스트
	@RequestMapping(value="/userAddress", method=RequestMethod.GET)
	public String userAddressGet() {
		return "users/userAddress";
	}
	
	// 회원 북마크 리스트
	@RequestMapping(value="/userBookmarkList", method=RequestMethod.GET)
	public String userBookmarkListGet(HttpSession session, Model model) {
	    String userId = (String) session.getAttribute("sUid");
		SaveMypageVO vo = userService.getBookmarkList(userId);
		model.addAttribute("vo", vo);
		return "users/userBookmarkList";
	}
	
	// 북마크 등록
	@RequestMapping(value="/saveBookmarkToggle", method=RequestMethod.POST)
	public String saveBookmarkInputPost(HttpSession session, String partUrl) {
		String userId = (String) session.getAttribute("sUid");
		
		boolean bookmarkExist = userService.checkUserBookmark(userId, partUrl);
		int res = 0;
        if (!bookmarkExist) {
        	userService.saveBookmarkToggle(userId, partUrl, true);
        	res = 1;
        } 
        else {
        	userService.saveBookmarkToggle(userId, partUrl, false);
        }
		
		return res + "";
	}
}
