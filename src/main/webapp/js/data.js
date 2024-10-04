$(document).ready(function(){
    // 모든 관측소 코드 리스트 (ObsCode 목록)
    let obsCodeList = [
        "TW_0088", "TW_0077", "TW_0089", "TW_0095", "TW_0074", "TW_0072", 
        "TW_0091", "KG_0025", "TW_0069", "KG_0024", "TW_0085", "TW_0094", 
        "TW_0087", "TW_0086", "TW_0079", "TW_0081", "TW_0093", "TW_0090", 
        "TW_0083", "TW_0078", "TW_0080", "KG_0101", "KG_0102", "TW_0076", 
        "TW_0092", "KG_0021", "KG_0028", "TW_0075", "TW_0082", "TW_0084", 
        "TW_0070", "HB_0002", "HB_0001", "HB_0009", "HB_0008", "HB_0007", 
        "HB_0003", "TW_0062"
    ];

    // 페이지 로딩 시 모든 관측소 데이터를 불러오기
    loadAllSeaData();

    // 검색 버튼 클릭 시 동작
    $('#searchButton').click(function() {
        // 드롭다운에서 선택된 값 가져오기
        let obsCode = $('#obsCodeSelect').val();
        let selectedText = $('#obsCodeSelect option:selected').text(); // 선택된 드롭다운의 텍스트

        // 선택한 지역명을 제목에 표시
        $('#obsCodeHeader').text(selectedText + " 구역 해양정보");

        // AJAX 요청 URL에 선택된 obsCode 반영
        let url = "https://www.khoa.go.kr/api/oceangrid/buObsRecent/search.do?ServiceKey=dMUbuvbKV138mrP3hdqoRA==&ObsCode=" + obsCode + "&ResultType=json";

        // 선택된 관측소 데이터만 로드
        loadSeaData(url, true);
    });

    // 모든 관측소 데이터를 불러오는 함수
    function loadAllSeaData() {
        // 테이블 초기화 (이전 검색 결과 삭제)
        $('#sea_table').find("tr:gt(0)").remove();

        // 모든 관측소에 대해 AJAX 요청
        obsCodeList.forEach(function(obsCode) {
            let url = "https://www.khoa.go.kr/api/oceangrid/buObsRecent/search.do?ServiceKey=dMUbuvbKV138mrP3hdqoRA==&ObsCode=" + obsCode + "&ResultType=json";
            loadSeaData(url, false); // 개별 관측소 데이터 추가
        });
    }

    // 데이터를 불러오는 함수
    function loadSeaData(url, clearTable) {
        $.ajax({
            url: url,
            type: "GET",
            dataType: "json",

            // 요청이 성공시 할 일 처리
            success: function(data) {
                //console.log(data); // 데이터 구조 확인
                //console.log(typeof data); // 데이터 타입 확인

                let api_data = "";

                if (clearTable) {
                    // 테이블 초기화 (선택된 검색 결과만 보여줄 경우)
                    $('#sea_table').find("tr:gt(0)").remove();
                }

                // result.data가 배열이 아닌 객체이므로 각 필드를 직접 접근
                let value = data.result.data;
                let meta = data.result.meta;
				
				// 위험도 평가 결과 얻기
				let riskLevel = evaluateRisk(value);

				// 위험도에 따른 클래스 설정
				let riskClass = '';
				if (riskLevel === "보통") {
				    riskClass = 'normal';
				} else if (riskLevel === "주의") {
				    riskClass = 'warning';
				} else if (riskLevel === "위험") {
				    riskClass = 'danger';
				}
			
				
                api_data += "<tr>";
                api_data += "<td>" + value.record_time + "</td>"; // 관찰 시간
                api_data += "<td>" + meta.obs_post_name + "</td>"; // 지역
                api_data += "<td>" + value.water_temp + "</td>"; // 수온
                api_data += "<td>" + value.air_temp + "</td>"; // 기온
                api_data += "<td>" + value.air_pres + "</td>"; // 기압
                api_data += "<td>" + value.wind_dir + "</td>"; // 풍향
                api_data += "<td>" + value.wind_speed + "</td>"; // 풍속
                api_data += "<td>" + value.current_dir + "</td>"; // 유향
                api_data += "<td>" + value.current_speed + "</td>"; // 유속
                api_data += "<td>" + value.wave_height + "</td>"; // 파고
				api_data += "<td class='" + riskClass + "'>" + riskLevel + "</td>"; // 위험도 추가
                api_data += "</tr>";

                // 테이블에 데이터 추가
                $('#sea_table').append(api_data);
            },
            error: function(xhr, status, error) {
                console.error("에러 발생: " + error);
            }
        });
    }
	// 위험도 평가 함수
	    function evaluateRisk(data) {
	        let waterTemp = data.water_temp; // 수온
	        let windSpeed = data.wind_speed; // 풍속
	        let currentSpeed = data.current_speed; // 유속
	        let waveHeight = data.wave_height; // 파고

	        // 위험도 평가
	        let riskLevel = "보통"; // 기본 위험도
	        let hasWarning = false; // 경고 상태 플래그
	        let hasDanger = false; // 위험 상태 플래그

	        // 수온 평가
	        if (waterTemp <= 15) {
	            hasDanger = true;
	        } else if (waterTemp > 15 && waterTemp <= 20) {
	            hasWarning = true;
	        }

	        // 풍속 평가
	        if (windSpeed > 10) {
	            hasDanger = true;
	        } else if (windSpeed >= 5 && windSpeed <= 10) {
	            hasWarning = true;
	        }

	        // 유속 평가
	        if (currentSpeed > 50) {
	            hasDanger = true;
	        } else if (currentSpeed >= 30 && currentSpeed <= 50) {
	            hasWarning = true;
	        }

	        // 파고 평가
	        if (waveHeight > 1.5) {
	            hasDanger = true;
	        } else if (waveHeight >= 0.5 && waveHeight <= 1.5) {
	            hasWarning = true;
	        }

	        // 최종 위험도 결정
	        if (hasDanger) {
	            riskLevel = "위험";
	        } else if (hasWarning) {
	            riskLevel = "주의";
	        }

	        return riskLevel;
	    }
}); // end of document

		/*success:function(data){
		    console.log(data); // 데이터 구조를 확인
		    console.log(typeof data); // 데이터 타입 확인

		    let api_data = "";

		    // 데이터 배열 접근 !! 배열은 each로 받을 수 있음 !!
		    $.each(data.result.data, function(index, value){
		        api_data += "<tr>";
		        api_data += "<td>" + (index) + "</td>"; // No (번호)
		        api_data += "<td>" + value.record_time + "</td>"; // 관찰 시간
		        api_data += "<td>" + value.water_temp + "</td>"; // 수온
		        api_data += "<td>" + value.air_temp + "</td>"; // 기온
		        api_data += "<td>" + value.air_pres + "</td>"; // 기압
		        api_data += "<td>" + value.wind_dir + "</td>"; // 풍향
		        api_data += "<td>" + value.wind_speed + "</td>"; // 풍속
		        api_data += "<td>" + value.current_direct + "</td>"; // 유향
		        api_data += "<td>" + value.current_speed + "</td>"; // 유속
		        api_data += "<td>" + value.wave_height + "</td>"; // 파고
		        api_data += "</tr>";
		    });

		    // 테이블에 데이터 추가
		    $('#sea_table').append(api_data);
		}*/
		
		
	