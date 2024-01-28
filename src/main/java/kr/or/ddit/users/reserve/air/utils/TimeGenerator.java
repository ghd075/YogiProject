package kr.or.ddit.users.reserve.air.utils;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
/*
  [항공편 시간 관련 데이터 생성을 위한 util] 
*/
public class TimeGenerator {

	/*랜덤 출발시간 생성*/ 
	public static Date generateRandomTime(Random random) {
		Calendar cal = Calendar.getInstance();
		
		// 시간을 랜덤하게 설정 (시와 분)
        int hour = random.nextInt(24); // 0부터 23까지의 난수
        int minute = random.nextInt(60); // 0부터 59까지의 난수
        cal.set(Calendar.HOUR_OF_DAY, hour);
        cal.set(Calendar.MINUTE, minute);
		
		return cal.getTime();
	}
	
	
	/*도착시간 계산 = 출발시간 + 운항시간*/
	public static String getArriveTime(String duraionTime, String depTime) {
		
    	//출발시간 LocalDateTime로 세팅
        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyyMMddHHmm");
        LocalDateTime arriveTime = LocalDateTime.parse(depTime, format);
    	
    	//시 문자열로 추출 후 계산
    	String[] durArr = duraionTime.split(" ");
    	String durHour = durArr[0];
    	for(int i = 0; i < durHour.length(); i++) {
    		if(durHour.charAt(i) == '시') {
    		  arriveTime = 
    		    arriveTime.plusHours(Integer.parseInt(durHour.substring(0, i))); 
    			break;
    		}
    	}
    	//분 문자열로 추출 후 계산
    	String durMinute = durArr[1];
    	for(int i = 0; i < durMinute.length(); i++) {
    		if(durMinute.charAt(i) == '분') {
    			arriveTime = 
    			   arriveTime.plusMinutes(Integer.parseInt(durMinute.substring(0, i))); 
    			    break; 
    		}
    	}
    	return arriveTime.format(format);
    }
	
	/* 랜덤 운항시간 생성 */
	public static String generateDuration(String original) {
	  DateTimeFormatter format = DateTimeFormatter.ofPattern("H시간 m분");
	  LocalTime time = LocalTime.parse(original, format);	
	  
	  Random random = new Random();
      int ranMinutes = random.nextInt(26);
      
      int ran = (int)(Math.random() * 2);
      if(ran == 0) {
    	return time.plusMinutes(ranMinutes).format(format);
    	 
      }else if(ran == 1) {
    	return time.minusMinutes(ranMinutes).format(format);
      }
	  return null;
	}
	
	/*시분 날짜 포맷 리턴*/
	public static String formatTime(Date time) {
        SimpleDateFormat format = new SimpleDateFormat("HHmm");
        return format.format(time);
    }
	
	/* 평균운항시간 리턴(밀리초) */
	public static long getAveDurationMilli(String depDuration, String arrDuration) {
		return (convertToMilliseconds(depDuration) + convertToMilliseconds(arrDuration)) / 2;
	}
	
	/* 평균 및 총 운항시간 리턴(문자열) */
	public static String getAveDuration(long duraionMilli) {
		 long minutes = duraionMilli / (60 * 1000); 
    	 long hours = minutes / 60;        //시 계산
    	 minutes = minutes % 60;     //분 계산
    	 return hours+"시간 "+minutes+"분";
	}
	
	/* 시간을 나타내는 문자열을 밀리초 단위로 계산하여 리턴(시분) */
	private static long convertToMilliseconds(String timeString) {
		//시,분 추출
        int hours = Integer.parseInt(timeString.split("시")[0]);
        int minutes = Integer.parseInt(timeString.split(" ")[1].replace("분", ""));

        // 시간과 분을 밀리초로 변환하여 합산
        long hoursInMillis = hours * 60 * 60 * 1000;
        long minutesInMillis = minutes * 60 * 1000;
        return hoursInMillis + minutesInMillis;
    }
	
	/* 시간을 나타내는 문자열을 밀리초 단위로 계산하여 리턴(분) */
	public static long minuteToMilliseconds(String minutes) {
		int min = Integer.parseInt(minutes);
		long minutesInMillis = min * 60 * 1000;
		return minutesInMillis;
	}
	
	
	
	
	
	
	

}

























