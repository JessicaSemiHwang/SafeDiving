<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.json.*" %> <!-- JSON 처리 라이브러리 사용 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./include/header.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>안전한 다이빙을 위하여</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="./js/data.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<link href="<c:url value='./css/safeDivingConditionCss.css'/>" rel="stylesheet"/>
		
	</head>

	
	<body>
	
	    <h2 style="text-align:center; padding:50px 0">다이빙 위험도 평가 기준</h2>
	
	    <div class="section">
	        <p>다이빙 시 중요한 요소들은 수온, 기온, 기압, 풍향, 풍속, 유향, 유속, 파고 등 다양한 물리적 환경 요인입니다. 이러한 변수들이 특정한 수치를 넘어설 경우, 다이버에게 위험할 수 있으며, 안전하게 다이빙을 하기 위한 조건들은 다이빙 경험 수준, 장비, 체력에 따라 달라집니다. 하지만 일반적인 기준을 통해 위험 수준을 평가할 수 있는 방법은 있습니다.</p>
	    </div>
	
	    <div class="section">
	        <h4>1. 수온 (°C)</h4>
	        <div class="criteria normal">
	            <strong>보통:</strong> 20°C 이상 (편안한 수온)
	        </div>
	        <div class="criteria caution">
	            <strong>주의:</strong> 15°C - 20°C (차갑지만 장비를 착용하면 다이빙 가능)
	        </div>
	        <div class="criteria danger">
	            <strong>위험:</strong> 15°C 이하 (저체온증 위험)
	        </div>
	    </div>
	
	    <div class="section">
	        <h4>2. 기온 (°C)</h4>
	        <div class="criteria normal">
	            <strong>보통:</strong> 18°C 이상 (적정 기온)
	        </div>
	        <div class="criteria caution">
	            <strong>주의:</strong> 10°C - 18°C (추위 대비 필요)
	        </div>
	        <div class="criteria danger">
	            <strong>위험:</strong> 10°C 이하 (저체온증 위험 증가)
	        </div>
	    </div>
	
	    <div class="section">
	        <h4>3. 기압 (hPa)</h4>
	        <div class="criteria normal">
	            <strong>보통:</strong> 1000 - 1015 hPa (정상적인 기압 범위)
	        </div>
	        <div class="criteria caution">
	            <strong>주의:</strong> 1015 hPa 이상 또는 985 hPa 이하 (높은 기압, 낮은 기압 주의)
	        </div>
	        <div class="criteria danger">
	            <strong>위험:</strong> 970 hPa 이하 (기상 악화, 저기압 가능성)
	        </div>
	    </div>
	
	    <div class="section">
	        <h4>4. 풍향 (deg)</h4>
	        <p>풍향 자체보다는 풍속과 결합하여 위험도를 평가해야 합니다. 바람의 방향은 큰 영향을 주지 않지만, 바람이 세게 불 경우 조류에 영향을 미칠 수 있습니다.</p>
	    </div>
	
	    <div class="section">
	        <h4>5. 풍속 (m/s)</h4>
	        <div class="criteria normal">
	            <strong>보통:</strong> 0 - 5 m/s (잔잔한 바람)
	        </div>
	        <div class="criteria caution">
	            <strong>주의:</strong> 5 - 10 m/s (바람이 강해짐, 파도 발생 가능성)
	        </div>
	        <div class="criteria danger">
	            <strong>위험:</strong> 10 m/s 이상 (높은 파도, 다이빙 위험)
	        </div>
	    </div>
	
	    <div class="section">
	        <h4>6. 유향 (deg)</h4>
	        <p>유향은 다이버의 위치 유지에 영향을 줍니다. 유향만으로는 위험을 평가하기 어렵지만 유속과 함께 보면 안전도를 평가할 수 있습니다.</p>
	    </div>
	
	    <div class="section">
	        <h4>7. 유속 (cm/s)</h4>
	        <div class="criteria normal">
	            <strong>보통:</strong> 0 - 30 cm/s (안전한 유속)
	        </div>
	        <div class="criteria caution">
	            <strong>주의:</strong> 30 - 50 cm/s (조류가 느껴짐, 주의 필요)
	        </div>
	        <div class="criteria danger">
	            <strong>위험:</strong> 50 cm/s 이상 (강한 조류, 다이빙 위험)
	        </div>
	    </div>
	
	    <div class="section">
	        <h4>8. 파고 (m)</h4>
	        <div class="criteria normal">
	            <strong>보통:</strong> 0 - 0.5 m (잔잔한 파도)
	        </div>
	        <div class="criteria caution">
	            <strong>주의:</strong> 0.5 - 1.5 m (파도가 조금 강함, 주의 필요)
	        </div>
	        <div class="criteria danger">
	            <strong>위험:</strong> 1.5 m 이상 (높은 파도, 다이빙 위험)
	        </div>
	    </div>
	
	    <div class="section">
	        <h4>종합적으로 위험도 평가 예시</h4>
	        <div class="criteria normal">
	            <strong>보통:</strong> 수온 20°C 이상, 풍속 5m/s 이하, 유속 30cm/s 이하, 파고 0.5m 이하
	        </div>
	        <div class="criteria caution">
	            <strong>주의:</strong> 수온 15°C - 20°C, 풍속 5 - 10m/s, 유속 30 - 50cm/s, 파고 0.5 - 1.5m
	        </div>
	        <div class="criteria danger">
	            <strong>위험:</strong> 수온 15°C 이하, 풍속 10m/s 이상, 유속 50cm/s 이상, 파고 1.5m 이상
	        </div>
	        <br>
	        <hr>
	        <br>
	        <p><b>이 기준은 다이버의 안전을 위한 참고용이며, 실제 다이빙 환경에서는 추가적인 변수와 개인의 경험, 장비 등을 고려해야 합니다.</b></p>
	    </div>
	
	</body>

</html>

<%@ include file="./include/footer.jsp" %>