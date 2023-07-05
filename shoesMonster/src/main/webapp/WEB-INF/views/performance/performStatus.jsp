<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		
		//unix시간 -> 날짜형식 변환
		function getDate(unixTime) {
			var date = new Date(unixTime);
			
			var year = date.getFullYear();
			var month = ("0" + (1 + date.getMonth())).slice(-2);
			var day = ("0" + date.getDate()).slice(-2);
			
			return year + "-" + month + "-" + day;
		} //getDate()
	
		$(function(){
			
			let perLineArr = [ ['라인명', '생산수량', '양품', '불량'] ];
			let perProdArr = [ ['품목명', '생산수량', '양품', '불량'] ];
			let perDateArr = [ ['생산일자', '생산수량', '양품', '불량'] ];
			
			$.ajax({
				url: "/performance/status",
				type: "post",
				success: function(data) {
					var line = data.perLine;
					var prod = data.perProd;
					var date = data.perDate;
					
					for(var i=0; i<line.length; i++) {
						var arr = [
							line[i].workOrder.line_code,
							line[i].perform_qt,
							line[i].perform_fair,
							line[i].perform_defect
						];
						perLineArr.push(arr);
					}
					for(var i=0; i<prod.length; i++) {
						var arr = [
							prod[i].prod_code,
							prod[i].perform_qt,
							prod[i].perform_fair,
							prod[i].perform_defect
						];
						perProdArr.push(arr);
					}
					for(var i=0; i<date.length; i++) {
						var arr = [
							getDate(date[i].perform_date),
							date[i].perform_qt,
							date[i].perform_fair,
							date[i].perform_defect
						];
						perDateArr.push(arr);
					}
					
					console.log("라인별: " + perLineArr);
					console.log("품목별: " + perProdArr);
					console.log("일자별: " + perDateArr);
					
					drawGoogleChart("라인", perLineArr, 'chart_line');
					drawGoogleChart("품목", perProdArr, 'chart_prod');
					drawGoogleChart("생산일자", perDateArr, 'chart_date');
					
				},
				error: function() {
					alert("실패실패실패");
				}
			}); //ajax
			
			function drawGoogleChart(name, array, id) {
				
				// Load the Vis ualization API and the piechart package.
				google.charts.load('current', {'packages':['bar']});
				
				// Set a callback to run when the Google Visualization API is loaded.
				google.charts.setOnLoadCallback(drawChart);
				
				// Callback that creates and populates a data table, 
				// instantiates the pie chart, passes in the data and draws it.
				function drawChart() {
					
					// Create the data table.
					var data = new google.visualization.arrayToDataTable(array);
					
					// Set chart options
					var options = {
							chart: {
								title: name + '별 생산실적 현황',
						        subtitle:'오예'
							},
							bars: 'horizontal'  //Required for Material Bar Charts
					};
					
					// Instantiate and draw our chart, passing in some options.
					var chart = new google.charts.Bar(document.getElementById(id));
					chart.draw(data, google.charts.Bar.convertOptions(options));
				} //drawChart()
				
			} //drawGoogleChart()
			
			$('#chart_line').show();
			$('#chart_prod').hide();
			$('#chart_date').hide();
			
			$('#lineBtn').click(function() {
				$('#chart_line').show();
				$('#chart_prod').hide();
				$('#chart_date').hide();
			});
			$('#prodBtn').click(function() {
				$('#chart_prod').show();
				$('#chart_line').hide();
				$('#chart_date').hide();
			});
			$('#dateBtn').click(function() {
				$('#chart_date').show();
				$('#chart_line').hide();
				$('#chart_prod').hide();
			});
			
			
		}); //jQuery
	</script>
	
<!-- page content -->
<div class="right_col" role="main">
	<h1> 생산실적 현황</h1>
	
	<button id="lineBtn">라인별 생산현황</button>
	<button id="prodBtn">품목별 생산현황</button>
	<button id="dateBtn">일자별 생산현황</button>
	
	<div id="chart_line" style="width: 900px; height: 500px;"></div>
	<div id="chart_prod" style="width: 900px; height: 500px;"></div>
	<div id="chart_date" style="width: 900px; height: 500px;"></div>
	
	
</div>
<!-- /page content -->

<%@ include file="../include/footer.jsp"%>