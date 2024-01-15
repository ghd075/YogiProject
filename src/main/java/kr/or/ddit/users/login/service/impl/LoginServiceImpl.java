package kr.or.ddit.users.login.service.impl;

import java.io.File;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.LoginMapper;
import kr.or.ddit.users.login.service.LoginService;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.utils.ServiceResult;

@Service
public class LoginServiceImpl implements LoginService {

	@Inject
	private LoginMapper loginMapper;
	
	@Override
	public ServiceResult idCheck(String memId) {
		ServiceResult result = null;
		
		MemberVO memberVO = loginMapper.idCheck(memId);
		if(memberVO != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		
		return result;
	}

	@Override
	public ServiceResult emailCheck(String memEmail) {
		ServiceResult result = null;
		
		MemberVO memberVO = loginMapper.emailCheck(memEmail);
		if(memberVO != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		
		return result;
	}
	
	@Transactional
	@Override
	public ServiceResult signup(HttpServletRequest req, MemberVO memberVO) {
		ServiceResult result = null;
		
		// 회원가입 시, 프로필 이미지로 파일 업로드 할 서버 경로 지정
		String uploadPath = req.getServletContext().getRealPath("/resources/profile");
		File file = new File(uploadPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		
		String profileImg = ""; // 회원정보에 추가될 프로필 이미지 경로
		try {
			// 넘겨받은 회원정보에서 파일 데이터 가져오기
			MultipartFile profileImgFile = memberVO.getImgFile();
			
			// 넘겨받은 파일 데이터가 존재할 때
			if(profileImgFile.getOriginalFilename() != null && !profileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 생성
				fileName += "_" + profileImgFile.getOriginalFilename(); // UUID_원본파일명으로 생성
				uploadPath += "/" + fileName; // /resources/profile/UUID_원본파일명
				
				profileImgFile.transferTo(new File(uploadPath)); // 해당 위치에 파일 복사
				profileImg = "/resources/profile/" + fileName; // 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
			}
			
			memberVO.setMemProfileimg(profileImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int status = loginMapper.signup(memberVO);
		
		if(status > 0) { // 등록 성공
			result = ServiceResult.OK;
		}else { // 등록 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public MemberVO findId(Map<String, String> map) {
		MemberVO member = loginMapper.findId(map);
		return member;
	}

	@Override
	public MemberVO findPw(Map<String, String> map) {
		MemberVO member = loginMapper.findPw(map);
		return member;
	}

	@Override
	public MemberVO loginCheck(MemberVO memberVO) {
		return loginMapper.loginCheck(memberVO);
	}

}
