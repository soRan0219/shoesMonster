<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="../resources/build/css/custom.css" rel="stylesheet">
<link href="smMain.css" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   <script type="text/javascript" src="../resources/main/fullcalendar.main.min.css"></script>
   <script type="text/javascript" src="../resources/main/fullcalendar.main.min.js"></script>
<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->
 
<!-- 달력 -->
 <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.min.js"></script>
<!-- 달력 -->
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
				
				drawGoogleChart("라인별", perLineArr, 'chart_line');
				drawGoogleChart("품목별", perProdArr, 'chart_prod');
				drawGoogleChart("금일", perDateArr, 'chart_date');
				
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
						width: 300,
						height: 400,
						padding: {
							top: 10,
							bottom: 10,
						},
						//차트 제목
						title: name + ' 생산실적 현황',
						titlePosition: 'out',
						titleTextStyle: {
							fontSize: 25,
							bold: true
						},
						//차트옵션
						chartArea: {
// 							backgroundColor: '#F7F7F7',
							backgroundColor: '#fff',

							width: '90%',
							height: '80%'
						},
						//배경색
// 						backgroundColor: '#F7F7F7',
						backgroundColor: '#fff',
						//차트 막대 색
						colors: ['#1ABB9C', 'rgb(173, 218, 209)', 'rgb(56, 170, 145)'],
						//줌인 뭐 이런 기능인데 적용 안되는듯
//							explorer: {
//								axis: 'horizontal',
//								actions: ['dragToZoom', 'rightClickToReset']
//							},
						//폰트
						fontSize: 20,
						fontName: 'NexonLv2Gothic',
						//가로축
						hAxis: {
							title: name,
							titleTextStyle: {
								color: 'gray',
								fontName: 'NexonLv2Gothic',
								fontSize: 15
							},
							textStyle: {
								color: '#000',
								fontName: 'NexonLv2Gothic',
								fontSize: 17
							},
							format: '#,###'
						},
						//세로축
						vAxis: {
							titleTextStyle: {
								fontSize: 20
							},
							//세로축 선(=> 가로선)
							gridlines: {
//									color: 'red',
//									minSpacing: 2
							},
							textStyle: {
								color: '#000',
								fontName: 'NexonLv2Gothic',
								fontSize: 13
							},
							format: '#,###'
						},
						//차트 범례 설정
						legend: {
							position: 'top',
							textStyle: {
								color: 'gray',
								fontSize: 13,
								fontName: 'NexonLv2Gothic',
								bold: true,
								italic: true
							},
							alignment: 'center'
						},
//						bars: 'horizontal'  //가로차트 옵션
				};
				
				console.log(options);
				
				// Instantiate and draw our chart, passing in some options.
				var chart = new google.charts.Bar(document.getElementById(id));
				chart.draw(data, google.charts.Bar.convertOptions(options));
			} //drawChart()
			
		} //drawGoogleChart()
		
		
		$('ul.tabs li').click(function() {
			var tab_id = $(this).attr('data-tab');
			
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
			
			$(this).addClass('current');
			$('#'+tab_id).addClass('current');
		});
		
	}); //jQuery
    
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    $(function(){
        
        let wh_dvArr = [ ['유형', '재고 갯수'] ];
        let wh_codeArr = [ ['창고종류', '재고갯수'] ];
        
      $.ajax({
         url: "/stock/stockGraph",
         type: "post",
          success: function(data){
              
              var wh_dv = data.wh_dv;
              var wh_code = data.wh_code;
             
              
              for(var i=0; i<wh_dv.length; i++) {
                  
            	  console.log(wh_dv[i].warehouse.wh_dv);
            	  
                var arr = [
                    wh_dv[i].warehouse.wh_dv,
                    wh_dv[i].stock_count,
                    
                ];
                wh_dvArr.push(arr);
            }
              console.log(wh_dvArr);
              for(var i=0; i<wh_code.length; i++) {
                  
            	  console.log(wh_code[i].wh_code);
            	  
                  var arr = [
                      wh_code[i].wh_code,
                      wh_code[i].stock_count,
                      
                  ];
                  wh_codeArr.push(arr);
              } 
              
              
              console.log("유형별: " + wh_dvArr);
              console.log("창고 코드별: " + wh_codeArr);
              
              drawGoogleChart("유형", wh_dvArr , 'wh_dv');
              drawGoogleChart("창고코드", wh_codeArr , 'wh_code');
              
          },error: function() {
            alert("실패실패실패");
        } //
      }); // ajax
        
      
      
      
   
      function drawGoogleChart(name, array, id) {
    
    
    
    google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      
      function drawChart() {
        var data = google.visualization.arrayToDataTable(array);

        var options = {
          title: '재고 갯수 현황',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById(id));
        chart.draw(data, options);
      } //drawChart
      
      } //drawGoogleChart
    }); // JQuery
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////

  
//       document.addEventListener('DOMContentLoaded', function() {
// 			  googleCalendarApiKey: 'AIzaSyBPa51EObVoBELfBVUs0dD0fIeVMi9mWiU';
//         var calendarEl = document.getElementById('calendar');
//         var calendar = new FullCalendar.Calendar(calendarEl, {
//           initialView: 'dayGridMonth',
//           headerToolbar: {
// 				left: 'prev,next today',
// 				center: 'title',
// 				right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
// 			  },
// 			  eventSources: [{
// 			  googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com' },
//         		{
// 				  className: '대한민국의 휴일' } ,// an option!
// 			  {color: 'red'
// 			  }	
// 			  ]
//         });
//         calendar.render();
//       });
  
    
    
    
    document.addEventListener('DOMContentLoaded', function() {
  	  googleCalendarApiKey: 'AIzaSyBPa51EObVoBELfBVUs0dD0fIeVMi9mWiU';
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
  initialView: 'dayGridMonth',
  headerToolbar: {
  		left: 'prev,next today',
  		center: 'title',
  		right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
  	  },
  	  eventSources: [{
  	  googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com' },
  		{
  		  className: '대한민국의 휴일' } ,// an option!
  	  {color: 'red'
  	  }	
  	  ]
  });
  calendar.render();
  });
    </script>


<!-- page content -->
<div class="right_col" role="main">

	
	<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	
	<!-- 애령 날씨 테스트중 ~ ~ -->
	<script type="text/javascript">
			
// 			var weatherIcon = {
// 				    '01': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas id="clear-day" width="84" height="84"></canvas></div></div></div></div></div></div>',
// 				    '02': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="partly-cloudy-day"></canvas></div></div></div></div></div></div>',
// 				    '03': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="cloudy"></canvas></div></div></div></div></div></div>',
// 				    '04': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="cloudy"></canvas></div></div></div></div></div></div>',
// 				    '09': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="sleet"></canvas></div></div></div></div></div></div>',
// 				    '10': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="rain"></canvas></div></div></div></div></div></div>',
// 				    '11': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="wind"></canvas></div></div></div></div></div></div>',
// 				    '13': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="snow"></canvas></div></div></div></div></div></div>',
// 				    '50': '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="cloudy"></canvas></div></div></div></div></div></div>'
// 				};
				

				var apiURI = "http://api.openweathermap.org/data/2.5/weather?q=" + 'busan' + "&appid=" + "aa7d2badb9c5e8ad659a0b018df246c1";
				
				$.ajax({
				    url: apiURI,
				    dataType: "json",
				    type: "GET",
				    async: "false",
				    success: function(resp) {

				        var $Icon = (resp.weather[0].icon).substr(0, 2);
				        var $weather_description = resp.weather[0].main;
				        var $Temp = Math.floor(resp.main.temp - 273.15) + 'º';
				        var $humidity = '습도&nbsp;&nbsp;&nbsp;&nbsp;' + resp.main.humidity + ' %';
				        var $wind = '바람&nbsp;&nbsp;&nbsp;&nbsp;' + resp.wind.speed + ' m/s';
				        var $city = '부산';
				        var $cloud = '구름&nbsp;&nbsp;&nbsp;&nbsp;' + resp.clouds.all + "%";
				        var $temp_min = '최저 온도&nbsp;&nbsp;&nbsp;&nbsp;' + Math.floor(resp.main.temp_min - 273.15) + 'º';
				        var $temp_max = '최고 온도&nbsp;&nbsp;&nbsp;&nbsp;' + Math.floor(resp.main.temp_max - 273.15) + 'º';
				        
// 				        $('.result').append(weatherIcon[$Icon]);
// 				        $('.result').append($Icon);
				        alert("Icon : " + $Icon);
				        $('.weather_description').prepend($weather_description);
				        $('.current_temp').prepend($Temp);
				        $('.humidity').prepend($humidity);
				        $('.wind').prepend($wind);
				        $('.city').append($city);
				        $('.cloud').append($cloud);
				        $('.temp_min').append($temp_min);
				        $('.temp_max').append($temp_max);
				        
				var value = $Icon;
				if (value === '04') {
				    var innerHTML = '<div class="col-md-6 col-sm-6"><div class="x_panel"><div class="x_content"><div class="row weather-days"><div class="col-sm-2"><div class="daily-weather"><canvas height="84" width="84" id="cloudy"></canvas></div></div></div></div></div></div>';
				    $('.result').append(innerHTML);
				}
				
				    }
				});
				
				

		</script>
	
	
	<div style="background-color : rgb(255, 255, 255); padding : 40px; color : #66b3ff; width : 400px; height : 200px; top: 40px;">

    <div style="float : right; margin : 10px 5px; font-size : 11pt">
            <div class="temp_min"></div>
            <div class="temp_max"></div>
            <div class="humidity"></div>
            <div class="wind"></div>
            <div class="cloud"></div>
    </div>
    <div style="float : right; margin : -10px 5px; padding: 15px;">
        <div class="current_temp" style="font-size : 25pt"></div>
        <div class="weather_description" name="weather_description" id="weather_description" style="font-size : 20pt"></div>
        <div class="city" style="font-size : 13pt"></div>
    </div>
    
	</div>
	
	
	   	<div class="result" style="z-index: 999;">
	   	</div>
	
    
	
	<!-- 날씨 테스트 - 끝 -->
	


	<div class="row">
		<div class="col-md-12 col-sm-12 ">
			<div class="dashboard_graph">

				<div class="row x_title">
				</div>

				<div> <!--  class="col-md-9 col-sm-9 " -->
						<span id="chart_prod" style="width:300px;display:inline-block; margin-right: 2em;"></span>
						<span id="chart_date" style="width:300px;display:inline-block;"></span>
						<span id="chart_line" style="width:300px;display:inline-block;"></span> <!--  class="tab-content current" -->
						
				</div>
				

				<div class="clearfix"></div>
			</div>
		</div>

	</div>
	<br />

	<div class="row">
		<div class="col-md-4 col-sm-4 ">
			<div class="x_panel tile fixed_height_320">
				<div class="x_title">
					<h2>휴가</h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false"><i
								class="fa fa-wrench"></i></a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
								<a class="dropdown-item" href="#">Settings 1</a> <a
									class="dropdown-item" href="#">Settings 2</a>
							</div></li>
						<li><a class="close-link"><i class="fa fa-close"></i></a></li>
					</ul>
					<div class="clearfix"></div>
				</div>
			<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////  -->	
<!-- 				<div id="chart_line" class="tab-content current"></div> -->
<!-- 				<div id="chart_prod"  class="tab-content"></div> -->
<!-- 				<div id="chart_date"  class="tab-content"></div> -->
			</div>
		</div>

		<div class="col-md-4 col-sm-4 ">
			<div class="x_panel tile fixed_height_320 overflow_hidden">
				<div class="x_title">
					<h2>창고별 재고 현황</h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false"><i
								class="fa fa-wrench"></i></a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
								<a class="dropdown-item" href="#">Settings 1</a> <a
									class="dropdown-item" href="#">Settings 2</a>
							</div></li>
						<li><a class="close-link"><i class="fa fa-close"></i></a></li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div id="graph">
					<span id="wh_code" style="width: 50px; height: 50px;"></span>
				</div>
			</div>
		</div>


		<div class="col-md-4 col-sm-4 ">
			<div class="x_panel tile fixed_height_320">
				<div class="x_title">
					<h2>유형별 재고 개수 현황</h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false"><i
								class="fa fa-wrench"></i></a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
								<a class="dropdown-item" href="#">Settings 1</a> <a
									class="dropdown-item" href="#">Settings 2</a>
							</div></li>
						<li><a class="close-link"><i class="fa fa-close"></i></a></li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">


					<div id="graph">
						<span id="wh_dv" style="width: 50px; height: 50px;"></span>
					</div>


				</div>
			</div>
		</div>

	</div>

	<iframe src="https://calendar.google.com/calendar/embed?height=600&wkst=1&bgcolor=%23ffffff&ctz=Asia%2FSeoul&src=NTFiOGJjMjU5ODU1M2IzMzg5ZmY0MzAwMDA1ZmJjM2FmYTUyZjBmYTU4MjU0M2VmMmZjY2EwNGRjMmRjZjc5OUBncm91cC5jYWxlbmRhci5nb29nbGUuY29t&src=a28uc291dGhfa29yZWEjaG9saWRheUBncm91cC52LmNhbGVuZGFyLmdvb2dsZS5jb20&color=%23009688&color=%230B8043" style="border:solid 1px #777" width="800" height="600" frameborder="0" scrolling="no"></iframe>
	<!-- /page content -->
<!-- 달력  -->
<!-- <div id='calendar	' style="width: 70%  ; height: 70%;"></div> -->
<script type="text/javascript">

</script>
<!-- 달력  -->


</div>



<%@ include file="../include/footer.jsp"%>