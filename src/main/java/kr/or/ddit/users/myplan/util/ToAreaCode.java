package kr.or.ddit.users.myplan.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.core.io.ClassPathResource;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.translate.*;

public class ToAreaCode {
	
	// 정규식 패턴으로 도시인지 판별
    public static final Pattern SIDO_PATTERN = Pattern.compile("(?<sido>" + "[가-힣]+도|"
            + "([가-힣]+(?:특별시|광역시|자치시|자치도))|"
            + "(충북|충남|경북|경남|전북|전남|강원|경기|제주)|" + "(서울|부산|대구|대전|광주|인천|울산|세종)시?" + ")", Pattern.MULTILINE);

    // 지역코드/시구군코드 타입 추출
    public static String checkRegionCodeType(String input) {
        Matcher sidoMatcher = SIDO_PATTERN.matcher(input);

        if (sidoMatcher.matches()) {
            return "areaType";
        } else {
            return "sigogunType";
        }
    }
    
    // 영문이름 -> 한글 변환기
    public static String englishToTranslation(String text) throws Exception {
    	
    	// 특정 단어 사전 정의
        HashMap<String, String> dictionary = new HashMap<>();
        dictionary.put("Pohang", "포항");
        dictionary.put("JEONJU", "전주");

        // 입력된 텍스트가 단어 사전에 있는 경우, 미리 정의된 번역으로 대체
        for (Map.Entry<String, String> entry : dictionary.entrySet()) {
            if (text.equalsIgnoreCase(entry.getKey())) {
                return entry.getValue();
            }
        }

        // 단어 사전에 없는 경우, Google Translation API를 사용하여 번역
        ClassPathResource resource = new ClassPathResource("json/translateapi.json");
        
        GoogleCredentials credentials = GoogleCredentials.fromStream(resource.getInputStream());
        
        Translate translate = TranslateOptions.newBuilder().setCredentials(credentials).build().getService();
        
        Translation translation = translate.translate(text, Translate.TranslateOption.targetLanguage("ko"));

        String chageText = translation.getTranslatedText();
        
        return chageText;
    }
}


