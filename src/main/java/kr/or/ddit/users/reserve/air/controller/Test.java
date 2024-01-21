package kr.or.ddit.users.reserve.air.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Test {

	public static void main(String[] args) {
		 // 입력 문자열
        String timeString1 = "1시간 59분";
        String timeString2 = "1시간 31분";

        // 문자열을 밀리초로 변환하여 더하기
        long totalMilliseconds = convertToMilliseconds(timeString1) + convertToMilliseconds(timeString2);
        //long totalMilliseconds = convertToMilliseconds(timeString1);

        // 밀리초를 다시 문자열로 변환
        String resultTimeString = convertToTimeString(totalMilliseconds);

        // 결과 출력
        System.out.println("두 시간을 더한 결과: " + resultTimeString);
	}
	
	 // 문자열을 밀리초로 변환
    private static long convertToMilliseconds(String timeString) {
        int hours = extractHours(timeString);
        int minutes = extractMinutes(timeString);
        System.out.println("hours : "+hours);
        System.out.println("minutes : "+minutes);

        // 시간과 분을 밀리초로 변환하여 합산
        long hoursInMillis = hours * 60 * 60 * 1000;
        System.out.println("시간 : "+hoursInMillis);
        long minutesInMillis = minutes * 60 * 1000;
        System.out.println("분 : "+minutesInMillis);
        System.out.println("밀리초 더한값 : "+(hoursInMillis + minutesInMillis));
        return hoursInMillis + minutesInMillis;
    }

    // 밀리초를 문자열로 변환
    private static String convertToTimeString(long milliseconds) {
    	 long minutes = milliseconds / (60 * 1000); 
    	 long hours = minutes / 60;        //시 계산
    	 minutes = minutes % 60;     //분 계산
    	 return hours+"시간 "+minutes+"분";
    }

    // 문자열에서 시간 추출
    private static int extractHours(String timeString) {
        return Integer.parseInt(timeString.split("시")[0]);
    }

    // 문자열에서 분 추출
    private static int extractMinutes(String timeString) {
        return Integer.parseInt(timeString.split(" ")[1].replace("분", ""));
    }
}
