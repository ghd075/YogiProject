package kr.or.ddit.api.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class TouritemsVO {
	private String contentId;
	private String areaCode;
	private String sigunguCode;
	private String tourCate;
	private String contenttypeId;
	private String firstImage;
	private String latitude;
	private String longitude;
	private String address;
	private String tel;
    private String title;
    private String zipcode;
    
	public TouritemsVO(String contentId, String areaCode, String sigunguCode, String tourCate, String contenttypeId,
			String firstImage, String latitude, String longitude, String address, String tel, String title,
			String zipcode) {
		super();
		this.contentId = contentId;
		this.areaCode = areaCode;
		this.sigunguCode = sigunguCode;
		this.tourCate = tourCate;
		this.contenttypeId = contenttypeId;
		this.firstImage = firstImage;
		this.latitude = latitude;
		this.longitude = longitude;
		this.address = address;
		this.tel = tel;
		this.title = title;
		this.zipcode = zipcode;
	}
	
	/**
     * 조인 용도
     */
    private long sp_day;
    private long sp_id;
    private long p_id;
    
}

