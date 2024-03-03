package kr.or.ddit.users.myplan.controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping("/html2canvas")
public class Html2CanvasProxy {

	@Autowired
    ServletContext servletContext;  // ServletContext를 주입받습니다.
	
	@RequestMapping(value = "/proxy.json", method = RequestMethod.GET)
	@ResponseBody
	public byte[] html2canvasProxy(HttpServletRequest req) {
		byte[] data = null;
		try {
			URL url = new URL(URLDecoder.decode(req.getParameter("url"), java.nio.charset.StandardCharsets.UTF_8.toString()));
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");

			log.info("connection.getInputStream() : {}", connection.getInputStream());
			
			if(connection.getResponseCode() == 200) {
				data = IOUtils.toByteArray(connection.getInputStream());
			} else if(connection.getResponseCode() == 400) {
				
			} else {
				log.info("responseCode : " + connection.getResponseCode());
				// 이미지가 없을 때 기본 이미지를 반환하도록 수정
				InputStream in = servletContext.getResourceAsStream("/resources/images/testimg/noimg.png");  // ServletContext를 사용해서 파일을 불러옵니다.
                data = IOUtils.toByteArray(in);
			}
		} catch (MalformedURLException e) {
			data = "wrong URL".getBytes(java.nio.charset.StandardCharsets.UTF_8);
		} catch(Exception e) {
			log.equals(e);
		}
		
		return data;
			
	}
}
