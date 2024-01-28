package kr.or.ddit.users.reserve.air.controller;

import java.util.HashSet;
import java.util.Set;

public class Test2 {

	//Q.1~10000까지의 서로다른 자료를 1000개 추출
	
	/*
	  2020년도 모든 회원별 거래금액을 조회
	  1.오라클sql join방식
	  2.표준(ANSI)sql join방식
	  3.sub query
    */
	
	public static void main(String[] args) {
		
		
		Set<Integer> set = new HashSet<Integer>();
	    while(set.size() < 1000) {
	    	set.add((int) ((Math.random() * 10000) + 1));
	    }	
	    System.out.println(set);
	    System.out.println("size : "+set.size());
	}
	
	
	
	
}
























