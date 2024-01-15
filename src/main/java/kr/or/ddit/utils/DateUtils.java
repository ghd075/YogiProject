package kr.or.ddit.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
	public static String getCurrentFormattedDate() {
        Date nowTime = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        return sf.format(nowTime);
    }
}
