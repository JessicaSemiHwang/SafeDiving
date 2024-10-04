$(document).ready(function() {
    // 사용자 위치를 가져옵니다.
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var lat = position.coords.latitude; // 위도
            var lon = position.coords.longitude; // 경도
            
			{ timeout: 10000 } // 10초 동안 응답을 기다림
			
            // AJAX 요청을 통해 날씨 정보를 가져옵니다.
            $.ajax({
                url: "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&lang=kr&units=metric&appid=c4928b2492c4da6b731e61c22c981bd3",
                type: "GET",
                dataType: "json",
                success: function(data) {
                    console.log(data); // 전체 응답 확인
                    let api_data = "";
                    $.each(data.weather, function(key, value) {
                        api_data += "<tr>";
                        api_data += "<td><img src='http://openweathermap.org/img/wn/" + value.icon + "@2x.png' alt='" + value.description + "' /></td>"; // 아이콘 이미지
                        api_data += "<td style='display: flex; align-items: center; justify-content: center; height: 100px; border: none;'>" + value.main + "<br>" + value.description + "</td>"; // main + description
                        api_data += "</tr>";
                    });
					// main 데이터 추가
					api_data += "<tr>";
					api_data += "<td colspan='2'>온도: " + data.main.temp + "°C</td>";
					api_data += "</tr>";
					api_data += "<tr>";
					api_data += "<td colspan='2'>체감 온도: " + data.main.feels_like + "°C</td>";
					api_data += "</tr>";
					api_data += "<tr>";
					api_data += "<td colspan='2'>최저 온도: " + data.main.temp_min + "°C</td>";
					api_data += "</tr>";
					api_data += "<tr>";
					api_data += "<td colspan='2'>최고 온도: " + data.main.temp_max + "°C</td>";
					api_data += "</tr>";
					api_data += "<tr>";
					api_data += "<td colspan='2'>기압: " + data.main.pressure + " hPa</td>";
					api_data += "</tr>";
					api_data += "<tr>";
					api_data += "<td colspan='2'>습도: " + data.main.humidity + "%</td>";
					api_data += "</tr>";
                    // 페이지에 데이터 붙이기
                    $('#openWeather tbody').append(api_data);
                },
                error: function(error) {
                    console.error("Error fetching weather data:", error);
                }
            });
        }, function() {
            alert("위치 정보를 가져오는 데 실패했습니다.");
        });
    } else {
        alert("이 브라우저는 Geolocation을 지원하지 않습니다.");
    }
});
