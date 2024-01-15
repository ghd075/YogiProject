package kr.or.ddit;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	// 랜딩 페이지
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	// 랜딩 페이지 리다이렉트
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String index() {
		return "user/index";
	}
	
	// 개인정보처리방침 페이지
	@RequestMapping(value = "/personalInfo.do", method = RequestMethod.GET)
	public String personalInfo() {
		return "user/personalInfo";
	}
	
	// 영상정보처리기기 운영관리 방침 페이지
	@RequestMapping(value = "/imageInfo.do", method = RequestMethod.GET)
	public String imageInfo() {
		return "user/imageInfo";
	}
	
}
