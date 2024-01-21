package kr.or.ddit.users.reserve.air.utils.api;

import java.util.List;

/* 항공 API데이터를 받는 VO */
public class AirApiVO {
	private Response response;

	public Response getResponse() {
		return response;
	}

	public void setResponse(Response response) {
		this.response = response;
	}

	@Override
	public String toString() {
		return "AirApiVO [response=" + response + "]";
	}
}

class Response{
	private Header header;
	private Body body;
	
	public Header getHeader() {
		return header;
	}
	
	public void setHeader(Header header) {
		this.header = header;
	}
	
	public Body getBody() {
		return body;
	}
	
	public void setBody(Body body) {
		this.body = body;
	}
	
	@Override
	public String toString() {
		return "Response [header=" + header + ", body=" + body + "]";
	}
}

class Header{
	private String resultCode;
	private String resultMsg;
	
	public String getResultCode() {
		return resultCode;
	}
	
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	
	public String getResultMsg() {
		return resultMsg;
	}
	
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	
	@Override
	public String toString() {
		return "Header [resultCode=" + resultCode + ", resultMsg=" + resultMsg + "]";
	}
}

class Body{
	private Items items;
	private int numOfRows;
	private int pageNo;
	private int totalCount;
	
	public Items getItems() {
		return items;
	}
	
	public void setItems(Items items) {
		this.items = items;
	}
	
	public int getNumOfRows() {
		return numOfRows;
	}
	
	public void setNumOfRows(int numOfRows) {
		this.numOfRows = numOfRows;
	}
	
	public int getPageNo() {
		return pageNo;
	}
	
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	@Override
	public String toString() {
		return "Body [items=" + items + ", numOfRows=" + numOfRows + ", pageNo=" + pageNo + ", totalCount=" + totalCount
				+ "]";
	}
}

class Items{
	private List<Data> item;

	public List<Data> getItem() {
		return item;
	}

	public void setItem(List<Data> item) {
		this.item = item;
	}

	@Override
	public String toString() {
		return "Items [item=" + item + "]";
	}
}

class Data{
	private String airlineNm;
	private String arrAirportNm;
	private String arrPlandTime;
	private String depAirportNm;
	private String depPlandTime;
	private int economyCharge;
	private int prestigeCharge;
	private String vihicleId;
	
	public String getAirlineNm() {
		return airlineNm;
	}
	
	public void setAirlineNm(String airlineNm) {
		this.airlineNm = airlineNm;
	}
	
	public String getArrAirportNm() {
		return arrAirportNm;
	}
	
	public void setArrAirportNm(String arrAirportNm) {
		this.arrAirportNm = arrAirportNm;
	}
	
	public String getArrPlandTime() {
		return arrPlandTime;
	}
	
	public void setArrPlandTime(String arrPlandTime) {
		this.arrPlandTime = arrPlandTime;
	}
	
	public String getDepAirportNm() {
		return depAirportNm;
	}
	
	public void setDepAirportNm(String depAirportNm) {
		this.depAirportNm = depAirportNm;
	}
	
	public String getDepPlandTime() {
		return depPlandTime;
	}
	
	public void setDepPlandTime(String depPlandTime) {
		this.depPlandTime = depPlandTime;
	}
	
	public int getEconomyCharge() {
		return economyCharge;
	}
	
	public void setEconomyCharge(int economyCharge) {
		this.economyCharge = economyCharge;
	}
	
	public int getPrestigeCharge() {
		return prestigeCharge;
	}
	
	public void setPrestigeCharge(int prestigeCharge) {
		this.prestigeCharge = prestigeCharge;
	}
	
	public String getVihicleId() {
		return vihicleId;
	}
	
	public void setVihicleId(String vihicleId) {
		this.vihicleId = vihicleId;
	}
	
	@Override
	public String toString() {
		return "Data [airlineNm=" + airlineNm + ", arrAirportNm=" + arrAirportNm + ", arrPlandTime=" + arrPlandTime
				+ ", depAirportNm=" + depAirportNm + ", depPlandTime=" + depPlandTime + ", economyCharge="
				+ economyCharge + ", prestigeCharge=" + prestigeCharge + ", vihicleId=" + vihicleId + "]";
	}
}



























