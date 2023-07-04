<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<link href="../resources/build/css/custom.css" rel="stylesheet">

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

				<div class="col-md-9 col-sm-9 ">
					<div id="chart_plot_01" class="demo-placeholder"></div>
				</div>
				<div class="col-md-3 col-sm-3  bg-white">
					<div class="x_title">
						<h2>수주 현황</h2>
						<div class="clearfix"></div>
					</div>

					<div class="col-md-12 col-sm-12 ">
						<div>
							<p>NIKE X SUPREME</p>
							<div class="">
								<div class="progress progress_sm" style="width: 76%;">
									<div class="progress-bar bg-green" role="progressbar"
										data-transitiongoal="80"></div>
								</div>
							</div>
						</div>
						<div>
							<p>NIKE</p>
							<div class="">
								<div class="progress progress_sm" style="width: 76%;">
									<div class="progress-bar bg-green" role="progressbar"
										data-transitiongoal="60"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-sm-12 ">
						<div>
							<p>PRADA X SUPREME</p>
							<div class="">
								<div class="progress progress_sm" style="width: 76%;">
									<div class="progress-bar bg-green" role="progressbar"
										data-transitiongoal="40"></div>
								</div>
							</div>
						</div>
						<div>
							<p>SALOMON</p>
							<div class="">
								<div class="progress progress_sm" style="width: 76%;">
									<div class="progress-bar bg-green" role="progressbar"
										data-transitiongoal="50"></div>
								</div>
							</div>
						</div>
					</div>

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
				<div class="x_content">
					<h4> 지각(휴가) 횟수 </h4>
					<div class="widget_summary">
						<div class="w_left w_25">
							<span>이도희</span>
						</div>
						<div class="w_center w_55">
							<div class="progress">
								<div class="progress-bar bg-green" role="progressbar"
									aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
									style="width: 66%;">
									<span class="sr-only">60% Complete</span>
								</div>
							</div>
						</div>
						<div class="w_right w_20">
							<span>28회</span>
						</div>
						<div class="clearfix"></div>
					</div>

					<div class="widget_summary">
						<div class="w_left w_25">
							<span>박언효</span>
						</div>
						<div class="w_center w_55">
							<div class="progress">
								<div class="progress-bar bg-green" role="progressbar"
									aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
									style="width: 45%;">
									<span class="sr-only">60% Complete</span>
								</div>
							</div>
						</div>
						<div class="w_right w_20">
							<span>14회</span>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="widget_summary">
						<div class="w_left w_25">
							<span>윤선길</span>
						</div>
						<div class="w_center w_55">
							<div class="progress">
								<div class="progress-bar bg-green" role="progressbar"
									aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
									style="width: 25%;">
									<span class="sr-only">60% Complete</span>
								</div>
							</div>
						</div>
						<div class="w_right w_20">
							<span>8회</span>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="widget_summary">
						<div class="w_left w_25">
							<span>류혜림</span>
						</div>
						<div class="w_center w_55">
							<div class="progress">
								<div class="progress-bar bg-green" role="progressbar"
									aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
									style="width: 5%;">
									<span class="sr-only">60% Complete</span>
								</div>
							</div>
						</div>
						<div class="w_right w_20">
							<span>3회</span>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="widget_summary">
						<div class="w_left w_25">
							<span>정애령</span>
						</div>
						<div class="w_center w_55">
							<div class="progress">
								<div class="progress-bar bg-green" role="progressbar"
									aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
									style="width: 2%;">
									<span class="sr-only">60% Complete</span>
								</div>
							</div>
						</div>
						<div class="w_right w_20">
							<span>1회</span>
						</div>
						<div class="clearfix"></div>
					</div>

				</div>
			</div>
		</div>

		<div class="col-md-4 col-sm-4 ">
			<div class="x_panel tile fixed_height_320 overflow_hidden">
				<div class="x_title">
					<h2>판 매 왕</h2>
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
					<table class="" style="width: 100%">
						<tr>
							<th style="width: 37%;">
								<p>Top 5</p>
							</th>
							<th>
								<div class="col-lg-7 col-md-7 col-sm-7 ">
									<p class="">Device</p>
								</div>
								<div class="col-lg-5 col-md-5 col-sm-5 ">
									<p class="">Progress</p>
								</div>
							</th>
						</tr>
						<tr>
							<td>
								<canvas class="canvasDoughnut" height="140" width="140"
									style="margin: 15px 10px 10px 0"></canvas>
							</td>
							<td>
								<table class="tile_info">
									<tr>
										<td>
											<p>
												<i class="fa fa-square blue"></i>정창원
											</p>
										</td>
										<td>30회</td>
									</tr>
									<tr>
										<td>
											<p>
												<i class="fa fa-square green"></i>류혜림
											</p>
										</td>
										<td>10회</td>
									</tr>
									<tr>
										<td>
											<p>
												<i class="fa fa-square purple"></i>정애령
											</p>
										</td>
										<td>20회</td>
									</tr>
									<tr>
										<td>
											<p>
												<i class="fa fa-square aero"></i>윤선길
											</p>
										</td>
										<td>15회</td>
									</tr>
									<tr>
										<td>
											<p>
												<i class="fa fa-square red"></i>윤소란
											</p>
										</td>
										<td>28회</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>


		<div class="col-md-4 col-sm-4 ">
			<div class="x_panel tile fixed_height_320">
				<div class="x_title">
					<h2>Quick Settings</h2>
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
						<ul class="quick-list">
							<li><i class="fa fa-calendar-o"></i><a href="#">Settings</a>
							</li>
							<li><i class="fa fa-bars"></i><a href="#">Subscription</a></li>
							<li><i class="fa fa-bar-chart"></i><a href="#">Auto
									Renewal</a></li>
							<li><i class="fa fa-line-chart"></i><a href="#">Achievements</a>
							</li>
							<li><i class="fa fa-bar-chart"></i><a href="#">Auto
									Renewal</a></li>
							<li><i class="fa fa-line-chart"></i><a href="#">Achievements</a>
							</li>
							<li><i class="fa fa-area-chart"></i><a href="#">Logout</a></li>
						</ul>

						<div class="sidebar-widget">
							<h4>Profile Completion</h4>
							<canvas width="150" height="80" id="chart_gauge_01" class=""
								style="width: 160px; height: 100px;"></canvas>
							<div class="goal-wrapper">
								<span id="gauge-text" class="gauge-value pull-left">0</span> <span
									class="gauge-value pull-left">%</span> <span id="goal-text"
									class="goal-value pull-right">100%</span>
							</div>
						</div>
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
											<a>빈지노 7년 만에 정규 앨범 2집 발매 !!</a>
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
											<a>HERE WE GO !! 김민재 독일 명문 바이에른 뮌헨 이적 임박</a>
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
											<a>7/5일 그 날이 왔다 !</a>
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