<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.json.*" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./include/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>해양관측정보</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="./js/data.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<link href="<c:url value='./css/dataListCss.css'/>" rel="stylesheet"/>
	</head>

	<body>
	
		<div class="container">
			<h2 id="obsCodeHeader" style="text-align:center; padding:50px 0">구역 해양정보</h2>			
			
			<!-- 드롭다운 검색 -->
			<div class="searchContainer">
			<select id="obsCodeSelect">
				<option value="TW_0088">감천항</option>
				<option value="TW_0077">경인항</option>
				<option value="TW_0089">경포대해수욕장</option>
				<option value="TW_0095">고래불해수욕장</option>
				<option value="TW_0074">광양항</option>
				<option value="TW_0072">군산항</option>
				<option value="TW_0091">낙산해수욕장</option>
				<option value="KG_0025">남해동부</option>
				<option value="TW_0069">대천해수욕장</option>
				<option value="KG_0024">대한해협</option>
				<option value="TW_0085">마산항</option>
				<option value="TW_0094">망상해수욕장</option>
				<option value="TW_0087">부산항</option>
				<option value="TW_0086">부산항신항</option>
				<option value="TW_0079">상왕등도</option>
				<option value="TW_0081">생일도</option>
				<option value="TW_0093">속초해수욕장</option>
				<option value="TW_0090">송정해수욕장</option>
				<option value="TW_0083">여수항</option>
				<option value="TW_0078">완도항</option>
				<option value="TW_0080">우이도</option>
				<option value="KG_0101">울릉도북동</option>
				<option value="KG_0102">울릉도북서</option>
				<option value="TW_0076">인천항</option>
				<option value="TW_0092">임랑해수욕장</option>
				<option value="KG_0021">제주남부</option>
				<option value="KG_0028">제주해협</option>
				<option value="TW_0075">중문해수욕장</option>
				<option value="TW_0082">태안항</option>
				<option value="TW_0084">통영항</option>
				<option value="TW_0070">평택당진항</option>
				<option value="HB_0002">한수원_고리</option>
				<option value="HB_0001">한수원_기장</option>
				<option value="HB_0009">한수원_나곡</option>
				<option value="HB_0008">한수원_덕천</option>
				<option value="HB_0007">한수원_온양</option>
				<option value="HB_0003">한수원_진하</option>
				<option value="TW_0062">해운대해수욕장</option>
			</select>
			
			<button id="searchButton">검색</button>
			</div>
			<p id="caption">원하는 지역을 선택하고 검색버튼을 누르세요</p>
			
			<table class="table" id="sea_table">
				<thead>
					<tr>
						<th>관측시간(Time)</th>
						<th>지역(Area)</th>
						<th>수온(°C)</th>
						<th>기온(°C)</th>
						<th>기압(hPa)</th>
						<th>풍향(deg)</th>
						<th>풍속(m/s)</th>
						<th>유향(deg)</th>
						<th>유속(cm/s)</th>
						<th>파고(m)</th>
						<th>조심신호등</th>

					</tr>
				</thead>
				<tbody></tbody>
			</table>		
			<p id="caption">출처 : 해양관측부이 최신데이터 제공 API</p>
		</div>
	</body>
</html>
<%@ include file="./include/footer.jsp" %>