<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="../resources/build/css/custom.css" rel="stylesheet">
<link href="smMain.css" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   
<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->
 
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
						width: 300,
						height: 400,
						padding: {
							top: 10,
							bottom: 10,
						},
						//차트 제목
						title: name + '별 생산실적 현황',
						titlePosition: 'out',
						titleTextStyle: {
							fontSize: 25,
							bold: true
						},
						//부제목
//						    subtitle:'오예',
						//차트옵션
						chartArea: {
							backgroundColor: '#F7F7F7',
//								top: '50%',
//								left: 100,
							width: '90%',
							height: '80%'
						},
						//배경색
						backgroundColor: '#F7F7F7',
						//차트 막대 색
						colors: ['#1ABB9C', 'rgb(173, 218, 209)', 'rgb(56, 170, 145)'],
						//줌인 뭐 이런 기능인데 적용 안되는듯
						explorer: {
//								axis: 'horizontal',
							actions: ['dragToZoom', 'rightClickToReset']
						},
						//폰트
						fontSize: 20,
						fontName: 'NexonLv2Gothic',
//							forcelFrame: true
						//가로축
						hAxis: {
							title: 'Hello',
							titleTextStyle: {
								color: '#000ccc',
								fontName: 'NexonLv2Gothic',
								fontSize: 23
							},
							textStyle: {
								color: '#0cc',
								fontName: 'NexonLv2Gothic',
								fontSize: 13
							},
							format: '#,###'
//								viewWindowMode: 'maximized'
						},
						//세로축
						vAxis: {
							title: 'World',
							titleTextStyle: {
								color: '#ccc000',
								fontName: 'NexonLv2Gothic',
								fontSize: 23
							},
							//세로축 선(=> 가로선)
							gridlines: {
//									color: 'red',
//									minSpacing: 2
							},
							textStyle: {
								color: '#c0c',
								fontName: 'NexonLv2Gothic',
								fontSize: 13
							},
							format: '#,###'
//								viewWindowMode: 'maximized'
						},
						//차트 범례 설정
						legend: {
							position: 'top',
							textStyle: {
								color: '#840F83',
								fontSize: 16,
								fontName: 'NexonLv2Gothic',
								bold: true,
								italic: true
							},
							alignment: 'center'
						},
						//차트에 표시되는 항목별 설정
//							series: {
//								0: { color: 'orange'}
//							}
//							bars: 'horizontal'  //가로차트 옵션
				};
				
				console.log(options);
				
				// Instantiate and draw our chart, passing in some options.
				var chart = new google.charts.Bar(document.getElementById(id));
				chart.draw(data, google.charts.Bar.convertOptions(options));
			} //drawChart()
			
		} //drawGoogleChart()
		

		
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
    </script>


<!-- page content -->
<div class="right_col" role="main">
	<!-- top tiles -->
	<div class="row" style="display: inline-block;">
		<div class="tile_count">
			<div class="col-md-2 col-sm-4  tile_stats_count">
				<span class="count_top"><i class="fa fa-user"></i> Total
					Users</span>
				<div class="count">2400</div>
				<span class="count_bottom"><i class="green">4% </i> From last
					Week</span>
			</div>
			<div class="col-md-2 col-sm-4  tile_stats_count">
				<span class="count_top"><i class="fa fa-clock-o"></i> Average
					Time</span>
				<div class="count">123.50</div>
				<span class="count_bottom"><i class="green"><i
						class="fa fa-sort-asc"></i>3% </i> From last Week</span>
			</div>
			<div class="col-md-2 col-sm-4  tile_stats_count">
				<span class="count_top"><i class="fa fa-user"></i> Total
					Males</span>
				<div class="count green">2,500</div>
				<span class="count_bottom"><i class="green"><i
						class="fa fa-sort-asc"></i>34% </i> From last Week</span>
			</div>
			<div class="col-md-2 col-sm-4  tile_stats_count">
				<span class="count_top"><i class="fa fa-user"></i> Total
					Females</span>
				<div class="count">4,567</div>
				<span class="count_bottom"><i class="red"><i
						class="fa fa-sort-desc"></i>12% </i> From last Week</span>
			</div>
			<div class="col-md-2 col-sm-4  tile_stats_count">
				<span class="count_top"><i class="fa fa-user"></i> Total
					Collections</span>
				<div class="count">2,315</div>
				<span class="count_bottom"><i class="green"><i
						class="fa fa-sort-asc"></i>34% </i> From last Week</span>
			</div>
			<div class="col-md-2 col-sm-4  tile_stats_count">
				<span class="count_top"><i class="fa fa-user"></i> Total
					Connections</span>
				<div class="count">7,325</div>
				<span class="count_bottom"><i class="green"><i
						class="fa fa-sort-asc"></i>34% </i> From last Week</span>
			</div>
		</div>
	</div>
	<!-- /top tiles -->

	<div class="row">
		<div class="col-md-12 col-sm-12 ">
			<div class="dashboard_graph">

				<div class="row x_title">
					<div class="col-md-6">
						<h3>
							Shoes Monster! <small>판매 실적 현황</small>
						</h3>
					</div>
					<div class="col-md-6">
						<div id="reportrange" class="pull-right"
							style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
							<i class="glyphicon glyphicon-calendar fa fa-calendar"></i> <span>December
								30, 2014 - January 28, 2015</span> <b class="caret"></b>
						</div>
					</div>
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
					<h2>창고별 재고 갯수 현황</h2>
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
					<h2>유형별 재고 갯수 현황</h2>
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


	<div class="row">
		<div class="col-md-4 col-sm-4 ">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						최근 HOT 뉴스 <small>정보</small>
					</h2>
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
					<div class="dashboard-widget-content">

						<ul class="list-unstyled timeline widget">
							<li>
								<div class="block">
									<div class="block_content">
										<h2 class="title">
											<a><b>빈지노 7년 만에 정규 앨범 2집 발매 !!</b></a>
										</h2>
										<div class="byline">
											<span>13 hours ago</span> by <a>정창원</a>
										</div>
										<p class="excerpt">빈지노는 어제(4일) 유튜브 힙합엘이 채널에 출연해 최근 발매한 정규 2집
											'노비츠키(NOWITZKI)'에 대한 다양한 이야기를 전했습니다. 이날 빈지노는 '노비츠키'에 대해 "늘
											그랬듯 전반적인 대주제는 인생인 것 같다. 군대 가기 전인 2017년부터 2022년까지 나한테 있었던 일들,
											내가 했던 생각들 그리고 어떤 날의 찰나들 총망라해 놓은 앨범이다"라고 설명했습니다. 빈지노는 "앨범 이름은
											사실 '스테파니'였다"며 지난해 8월 오랜 연애를 끝내고 부부의 연을 맺은 아내 스테파니 미초바를
											언급했습니다.</p>
									</div>
								</div>
							</li>
							<li>
								<div class="block">
									<div class="block_content">
										<h2 class="title">
											<a><b>HERE WE GO !! 김민재 독일 명문 바이에른 뮌헨 이적 임박</b></a>
										</h2>
										<div class="byline">
											<span>13 hours ago</span> by <a>정창원</a>
										</div>
										<p class="excerpt">유럽 이적시장 전문가 파브리시오 로마노는 16일(이하 한국시간) “뮌헨은 이번
											주 김민재에게 그들의 프로젝트를 제시했으며 이제 개인 조건에 대한 합의가 임박했다”라고 알렸다. 이어 “회담이
											빠르게 진행됐으며 김민재는 뮌헨에 설득됐다. 맨체스터 유나이티드의 김민재를 향한 관심은 여전하나, 결코
											이뤄지지 않았다. 바이아웃 조항은 오는 7월에 발동된다”라고 덧붙였다.</p>
									</div>
								</div>
							</li>
							<li>
								<div class="block">
									<div class="block_content">
										<h2 class="title">
											<a><b>속보! 정애령 결석</b></a>
										</h2>
										<div class="byline">
											<span>13 hours ago</span> by <a>정창원</a>
										</div>
										<p class="excerpt">
											7강의장 정모씨(28세)는 금일7/4일 결석을 해버렸다...
										</p>
									</div>
								</div>
							</li>
							<li>
								<div class="block">
									<div class="block_content">
										<h2 class="title">
											<a><b>7/5일 그 날이 왔다 !</b></a>
										</h2>
										<div class="byline">
											<span>13 hours ago</span> by <a>정창원</a>
										</div>
										<p class="excerpt">
											7월 5일 일 년에 한 번 뿐인 그날이 와버렸다 ..!
										</p>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>


		<div class="col-md-8 col-sm-8 ">



			<div class="row">

				<div class="col-md-12 col-sm-12 ">
					<div class="x_panel">
						<div class="x_title">
							<h2>
								거래처 <small>나라별 거래처 현황</small>
							</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
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
							<div class="dashboard-widget-content">
								<div class="col-md-4 hidden-small">
									<h2 class="line_30">72개국의 거래처 현황</h2>

									<table class="countries_list">
										<tbody>
											<tr>
												<td>미국</td>
												<td class="fs15 fw700 text-right">33%</td>
											</tr>
											<tr>
												<td>프랑스</td>
												<td class="fs15 fw700 text-right">27%</td>
											</tr>
											<tr>
												<td>독일</td>
												<td class="fs15 fw700 text-right">16%</td>
											</tr>
											<tr>
												<td>스페인</td>
												<td class="fs15 fw700 text-right">11%</td>
											</tr>
											<tr>
												<td>영국</td>
												<td class="fs15 fw700 text-right">10%</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div id="world-map-gdp" class="col-md-8 col-sm-12 "
									style="height: 230px;"></div>
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="row">


				<!-- Start to do list -->
				<div class="col-md-6 col-sm-6 ">
					<div class="x_panel">
						<div class="x_title">
							<h2>
								이번주 할 일 <small>간단히 보기</small>
							</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
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

							<div class="">
								<ul class="to_do">
									<li>
										<p>
											<input type="checkbox" class="flat"> 새로운 거래처 미팅
										</p>
									</li>
									<li>
										<p>
											<input type="checkbox" class="flat"> css 테이블 만들기
										</p>
									</li>
									<li>
										<p>
											<input type="checkbox" class="flat"> 서버 해결하기
										</p>
									</li>
									<li>
										<p>
											<input type="checkbox" class="flat"> 출고 페이지 마무리하기
										</p>
									</li>
									<li>
										<p>
											<input type="checkbox" class="flat"> 꾸덕한 초코케이크
										</p>
									</li>
									<li>
										<p>
											<input type="checkbox" class="flat"> 세부기능 마무리하기
										</p>
									</li>
									<li>
										<p>
											<input type="checkbox" class="flat"> 서성찬과 오붓한 식사데이트
										</p>
									</li>
									<li>
										<p>
											<input type="checkbox" class="flat"> 정애령 결석
										</p>
									</li>
									<li>
										<p>
											<input type="checkbox" class="flat"> 정창원 생일
										</p>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- End to do list -->

				<!-- start of weather widget -->
				<div class="col-md-6 col-sm-6 ">
					<div class="x_panel">
						<div class="x_title">
							<h2>
								날씨 <small>이번주</small>
							</h2>
							<ul class="nav navbar-right panel_toolbox">
								<li><a class="collapse-link"><i
										class="fa fa-chevron-up"></i></a></li>
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
							<div class="row">
								<div class="col-sm-12">
									<div class="temperature">
										<b>월</b>, 07:30 AM <span>F</span> <span><b>C</b></span>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-4">
									<div class="weather-icon">
										<canvas height="84" width="84" id="partly-cloudy-day"></canvas>
									</div>
								</div>
								<div class="col-sm-8">
									<div class="weather-text">
										<h2>
											부산 <br>
											<i>약간 흐림</i>
										</h2>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div class="weather-text pull-right">
									<h3 class="degrees">23</h3>
								</div>
							</div>

							<div class="clearfix"></div>

							<div class="row weather-days">
								<div class="col-sm-2">
									<div class="daily-weather">
										<h2 class="day">월</h2>
										<h3 class="degrees">25</h3>
										<canvas id="clear-day" width="32" height="32"></canvas>
										<h5>
											15 <i>km/h</i>
										</h5>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="daily-weather">
										<h2 class="day">화</h2>
										<h3 class="degrees">25</h3>
										<canvas height="32" width="32" id="rain"></canvas>
										<h5>
											12 <i>km/h</i>
										</h5>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="daily-weather">
										<h2 class="day">수</h2>
										<h3 class="degrees">27</h3>
										<canvas height="32" width="32" id="snow"></canvas>
										<h5>
											14 <i>km/h</i>
										</h5>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="daily-weather">
										<h2 class="day">목</h2>
										<h3 class="degrees">28</h3>
										<canvas height="32" width="32" id="sleet"></canvas>
										<h5>
											15 <i>km/h</i>
										</h5>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="daily-weather">
										<h2 class="day">금</h2>
										<h3 class="degrees">28</h3>
										<canvas height="32" width="32" id="wind"></canvas>
										<h5>
											11 <i>km/h</i>
										</h5>
									</div>
								</div>
								<div class="col-sm-2">
									<div class="daily-weather">
										<h2 class="day">토</h2>
										<h3 class="degrees">26</h3>
										<canvas height="32" width="32" id="cloudy"></canvas>
										<h5>
											10 <i>km/h</i>
										</h5>
									</div>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>

				</div>
				<!-- end of weather widget -->
			</div>
		</div>
	</div>
</div>
<!-- /page content -->


<%@ include file="../include/footer.jsp"%>