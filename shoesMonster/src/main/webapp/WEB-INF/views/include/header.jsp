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
<link href="../vendors/fullcalendar/dist/fullcalendar.min.css" rel="stylesheet">
<link href="../vendors/fullcalendar/dist/fullcalendar.print.css" rel="stylesheet" media="print">
<meta name="robots" content="noindex, nofollow">
<script defer="" referrerpolicy="origin" src="/cdn-cgi/zaraz/s.js?z=JTdCJTIyZXhlY3V0ZWQlMjIlM0ElNUIlNUQlMkMlMjJ0JTIyJTNBJTIyR2VudGVsZWxsYSUyMEFsZWxhISUyMCU3QyUyMCUyMiUyQyUyMnglMjIlM0EwLjEzMjM0Nzk1ODExNjgxMSUyQyUyMnclMjIlM0ExOTIwJTJDJTIyaCUyMiUzQTEwODAlMkMlMjJqJTIyJTNBOTM3JTJDJTIyZSUyMiUzQTE5MjAlMkMlMjJsJTIyJTNBJTIyaHR0cHMlM0ElMkYlMkZjb2xvcmxpYi5jb20lMkZwb2x5Z29uJTJGZ2VudGVsZWxsYSUyRmNhbGVuZGFyLmh0bWwlMjIlMkMlMjJyJTIyJTNBJTIyaHR0cHMlM0ElMkYlMkZjb2xvcmxpYi5jb20lMkZwb2x5Z29uJTJGZ2VudGVsZWxsYSUyRmluYm94Lmh0bWwlMjIlMkMlMjJrJTIyJTNBMjQlMkMlMjJuJTIyJTNBJTIyVVRGLTglMjIlMkMlMjJvJTIyJTNBLTU0MCUyQyUyMnElMjIlM0ElNUIlNUQlN0Q="></script>
<script nonce="54be8bd0-8917-46b7-a111-a56b308ae503">(function(w,d){!function(f,g,h,i){f[h]=f[h]||{};f[h].executed=[];f.zaraz={deferred:[],listeners:[]};f.zaraz.q=[];f.zaraz._f=function(j){return function(){var k=Array.prototype.slice.call(arguments);f.zaraz.q.push({m:j,a:k})}};for(const l of["track","set","debug"])f.zaraz[l]=f.zaraz._f(l);f.zaraz.init=()=>{var m=g.getElementsByTagName(i)[0],n=g.createElement(i),o=g.getElementsByTagName("title")[0];o&&(f[h].t=g.getElementsByTagName("title")[0].text);f[h].x=Math.random();f[h].w=f.screen.width;f[h].h=f.screen.height;f[h].j=f.innerHeight;f[h].e=f.innerWidth;f[h].l=f.location.href;f[h].r=g.referrer;f[h].k=f.screen.colorDepth;f[h].n=g.characterSet;f[h].o=(new Date).getTimezoneOffset();if(f.dataLayer)for(const s of Object.entries(Object.entries(dataLayer).reduce(((t,u)=>({...t[1],...u[1]})),{})))zaraz.set(s[0],s[1],{scope:"page"});f[h].q=[];for(;f.zaraz.q.length;){const v=f.zaraz.q.shift();f[h].q.push(v)}n.defer=!0;for(const w of[localStorage,sessionStorage])Object.keys(w||{}).filter((y=>y.startsWith("_zaraz_"))).forEach((x=>{try{f[h]["z_"+x.slice(7)]=JSON.parse(w.getItem(x))}catch{f[h]["z_"+x.slice(7)]=w.getItem(x)}}));n.referrerPolicy="origin";n.src="/cdn-cgi/zaraz/s.js?z="+btoa(encodeURIComponent(JSON.stringify(f[h])));m.parentNode.insertBefore(n,m)};["complete","interactive"].includes(g.readyState)?zaraz.init():f.addEventListener("DOMContentLoaded",zaraz.init)}(w,d,"zarazData","script");})(window,document);</script>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="../smmain/smMain" class="site_title" style="text-align: center; margin-top: 10%;">
							<img src="/resources/images/smlogo.png" width="200" height="100" style=" z-index: 999;   width: 170px;"> </i>
						</a>
					</div>
					
					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile clearfix" style="margin-top: 30%; margin-left: 15%;">
						<div class="profile_pic">
						
							<c:if test="${!empty id.file }">
								<img src="/imgDown?fileName=${id.file }" alt="..."
								class="img-circle profile_img">
							</c:if>
							
							<c:if test="${empty id.file }">
								<img src="../resources/images/person.png" alt="..."
								class="img-circle profile_img">
							</c:if>
								
								
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