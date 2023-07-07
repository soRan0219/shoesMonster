<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/favicon.ico" type="image/ico" />

<title>Shoes Monster!</title>

<!-- Bootstrap -->
<link href="../resources/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link href="../resources/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="../resources/vendors/nprogress/nprogress.css" rel="stylesheet">
<!-- iCheck -->
<link href="../resources/vendors/iCheck/skins/flat/green.css" rel="stylesheet">

<!-- bootstrap-progressbar -->
<link
	href="../resources/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css"
	rel="stylesheet">
<!-- JQVMap -->
<link href="../resources/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet" />
<!-- bootstrap-daterangepicker -->
<link href="../resources/vendors/bootstrap-daterangepicker/daterangepicker.css"
	rel="stylesheet">

<!-- Custom Theme Style -->
<link href="../resources/build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="../smmain/smMain" class="site_title" style="text-align: center; margin-top: 10%;">
							<img src="/resources/images/smlogo.png" width="200" height="100"> </i>
						</a>
					</div>
					
					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile clearfix" style="margin-top: 30%; margin-left: 15%;">
						<div class="profile_pic">
							<img src="/imgDown?fileName=${id.file }" alt="..."
								class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>${id.emp_position }</span>
							<h2>${id.emp_name }</h2>
						</div>
					</div>
					<!-- /menu profile quick info -->

					<!-- sidebar menu -->
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<ul class="nav side-menu">
								<li><a><i class="fa fa-home"></i> 기준정보 관리 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="../performance/requirement">소요량 관리</a></li>
										<li><a href="../performance/product">품목 관리</a></li>
										<li><a href="../performance/rawMaterial">원자재 관리</a></li>
									</ul></li>
								<li><a><i class="fa fa-desktop"></i> 생산 관리 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="../performance/line">라인 관리</a></li>
										<li><a href="../workorder/workOrderList">작업지시 관리</a></li>
										<li><a href="../performance/performList">생산실적 관리</a></li>
										<li><a href="../performance/performStatus">생산실적 현황</a></li>
									</ul></li>
								<li><a><i class="fa fa-table"></i> 자재 관리 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="../stock/stockList_raw">재고 관리</a></li>
										<li><a href="../stock/In_material">입고 관리</a></li>
										<li><a href="../stock/Out_material">출고 관리</a></li>
										<li><a href="../performance/warehouse">창고 관리</a></li>
									</ul></li>
								<li><a><i class="fa fa-bar-chart-o"></i> 인사 관리 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="../person/empinfo">사원 관리</a></li>
										<li><a href="../person/Clients">거래처 관리</a></li>
									</ul></li>
								<li><a><i class="fa fa-edit"></i> 영업 관리 <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="../person/orderStatus">수주 관리</a></li>
										<li><a href="../stock/raw_order">발주 관리</a></li>
									</ul></li>
							</ul>
						</div>
					</div>
					<!-- /sidebar menu -->
					
					<!-- /menu footer buttons -->
					<div class="sidebar-footer hidden-small">
						<a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">
							<span class="glyphicon glyphicon-off" aria-hidden="true"></span>
						</a>
						<form action="/smmain/smLogout" method="get">
							<button type="submit" value="logout" class="dropdown-item">
								<i class="fa fa-sign-out pull-right"></i> 로그아웃
							</button>
						</form>
					</div>
				<!-- /menu footer buttons -->
				</div>
			</div>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<div class="nav toggle">
						<a id="menu_toggle"><i class="fa fa-bars"></i></a> 
					</div>
					<nav class="nav navbar-nav">
						<ul class=" navbar-right">
							<li class="nav-item dropdown open" style="padding-left: 15px;">
<!-- 								<a href="javascript:;" class="user-profile dropdown-toggle" -->
<!-- 								aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown" -->
<!-- 								aria-expanded="false"> <img src="/resources/images/churub.jpg" alt="">홍길동</a> -->
								<div class="dropdown-menu dropdown-usermenu pull-right">
								</div>
							</li>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->