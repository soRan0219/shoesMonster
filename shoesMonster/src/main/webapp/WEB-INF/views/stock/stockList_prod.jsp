<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession" %>
    
<%@ include file="../include/header.jsp"%>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/smmain/smMain" />
</c:if>

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->

<script type="text/javascript">
	
	function stockPopup(code) {
		window.open("stockPopup?code=" + code, "재고 상세", "width=600, height=300, left=200, top=150, location=no");
	}
	
</script>

<!-- page content -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
     
    
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
  
    

<div class="right_col" role="main">

	<h1 style="margin-left: 1%;"> 재고 관리 </h1>
	
	<div style="margin-left: 1%;">
	    <a href="/stock/stockList_raw" ><input type="button" value="원자재" class="B B-info" ></input></a>
	    <a href="/stock/stockList_prod"><input type="button" value="완제품" class="B B-info" ></input></a>
    </div>
    
    <hr>
    
    <div style="margin-left: 1%;">  
	    <form action="" method="get">
	 		완제품 코드 : <input type="text" name="prod_code" placeholder="완제품 코드를 입력하세요">
		   	완제품 품명 : <input type="text" name="product.prod_name" placeholder="품명을 입력하세요">
		   	창고 코드 : <input type="text" name="wh_code" placeholder="창고 코드를 입력하세요"> 
		   	<input type="submit" class="B B-info" value="검색"></input>
	  	</form>
  	</div>
	
	<hr>

	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
			<form id="fr" method="post">
			
				<div class="x_title">
					<h2>완제품 목록<small>총 ${bp.totalCount } 건</small></h2>
					
						<div class="clearfix"></div>
				</div>	
					
				<div style="overflow-x: auto;">
				<table id="data-table" border="1" class="table table-striped jambo_table bulk_action" style="text-align:center;">
					<thead> 
					    <tr>
					 		<th>유형</th>
					 		<th>제품 코드</th>
					 		<th>제품명</th>
					 		<th>색상</th>
					 		<th>사이즈</th>
					 		<th>재고 수량</th>
					 		<th>창고 코드</th>
					 		<th>담당자</th>
					 		<th>수정 버튼</th>
					 	</tr>
				 	</thead>
					<c:forEach var="s" items="${stock_ListP}">
					 	<tr>
					 		<th>${s.warehouse.wh_dv}</th>
					 		<td>${s.prod_code}</td>
					 		<td>${s.product.prod_name}</td>
					 		<td>${s.product.prod_color}</td>
					 		<td>${s.product.prod_size}</td>
					   		<td style="color: ${s.stock_count <= 50 ? 'red' : 'inherit'}">${s.stock_count}</td>
					   		<td>${s.wh_code}</td>
					   		<td>${s.warehouse.emp_id}</td>
					   		<c:if test = "${sessionScope.id.emp_department eq '물류팀' or sessionScope.id.emp_department eq '관리자'}">
					   			<td><input type="button" class="B B-info" onclick="stockPopup('${s.prod_code}')" value="수정"></td>
				   			</c:if>
					 	</tr>
					</c:forEach>
				</table>
			</div>
		</form>
	</div>
</div>     
           		
<!-- ㅇㅇㅇㅇㅇ -->
	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
		    <c:if test="${countP3 > 0 }">
			    <li class="paginate_button previous disabled">
					<c:if test="${bp.prev}">
					    <span><a href="/stock/stockList_prod?page=${bp.startPage - 1}&prod_code=${svo.prod_code }&product.prod_name=${svo.prod_code }&wh_code=${svo.wh_code}">이전</a></span>
					</c:if>
				</li>
				<li class="paginate_button previous disabled">
					<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
					    <a href="/stock/stockList_prod?page=${idx }&prod_code=${svo.prod_code }&product.prod_name=${svo.prod_code }&wh_code=${svo.wh_code}">${idx }</a>
					</c:forEach>
				</li>
				<li class="paginate_button previous disabled">
					<c:if test="${bp.next && bp.endPage > 0}">
					    <a href="/stock/stockList_prod?page=${bp.endPage + 1}&prod_code=${svo.prod_code }&product.prod_name=${svo.prod_code }&wh_code=${svo.wh_code}">다음</a>
					</c:if>
				</li>
			</c:if>
		</ul>
  <!-- ㅇㅇㅇㅇㅇ -->  
	</div>
</div>

<!-- /page content -->
<%@ include file="../include/footer.jsp"%>