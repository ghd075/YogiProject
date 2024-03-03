package kr.or.ddit.users.mypage.vo;
import lombok.Data;

@Data
public class PayHistoryVO {

    private int mgNo;
    private String memId;
    private int plNo;
    private String airReserveno;
    private String ticketType;
    private String flightCode;
    private int airPersonnum;
    private int ticketTotalprice;
    private String airlineName;
    private String flightDepairport;
    private String flightDeptime;
    private String flightArrairport;
    private String flightArrtime;
    private String plTitle;
    private String airPayday;
    
    private String airlineLogo;
    

}
