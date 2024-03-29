package kr.or.ddit.utils;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
// 컨트롤러에서 응답을 줄 때 이 공용 응답 클래스를 꼭 활용
public class RestResponse<T> {
	
	public static <T> ResponseEntity<T> success(T body) {
		return ResponseEntity.status(HttpStatus.OK).body(body);
	}

	public static <T> ResponseEntity<T> created(T body) {
		return ResponseEntity.status(HttpStatus.CREATED).body(body);
	}

	public static <T> ResponseEntity<T> notFound(T body) {
		return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body);
	}

	public static <T> ResponseEntity<T> badRequest(T body) {
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(body);
	}

	public static <T> ResponseEntity<T> forbidden(T body) {
		return ResponseEntity.status(HttpStatus.FORBIDDEN).body(body);
	}
}
