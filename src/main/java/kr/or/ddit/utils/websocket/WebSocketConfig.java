package kr.or.ddit.utils.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

	@Autowired
	@Qualifier("chatHandler")
	private ChatHandler chatHandler;
	
	@Autowired
	@Qualifier("loginDetectHandler")
	private LoginDetectHandler loginDetectHandler;
	
	@Autowired
	@Qualifier("realTimeAlertHandler")
	private RealTimeAlertHandler realTimeAlertHandler;
	
	@Autowired
	@Qualifier("chatInOutHandler")
	private ChatInOutHandler chatInOutHandler;
	
	@Autowired
	@Qualifier("realTimeAlertHandlerChansVer")
	private RealTimeAlertHandlerChansVer realTimeAlertHandlerChansVer;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(chatHandler, "/chat").setAllowedOrigins("*");
		registry.addHandler(loginDetectHandler, "/logindetect").setAllowedOrigins("*");
		registry.addHandler(chatInOutHandler, "/chatinoutdetect").setAllowedOrigins("*");
		registry.addHandler(realTimeAlertHandler, "/alert").setAllowedOrigins("*");
		registry.addHandler(realTimeAlertHandlerChansVer, "/alertForChan").setAllowedOrigins("*");
	}
	
}
