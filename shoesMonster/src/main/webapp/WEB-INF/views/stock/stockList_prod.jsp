<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%@ include file="../include/header.jsp"%>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
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

	<h1> 재고 관리 </h1>
	
    <a href="/stock/stockList_raw"><input type="button" value="원자재" class="btn btn-info" ></input></a>
    <a href="/stock/stockList_prod"><input type="button" value="완제품" class="btn btn-info" ></input></a>
    
    
    <form action="" method="get">
 		완제품 코드 <input type="text" name="prod_code" placeholder="완제품 코드를 입력하세요">
	   	완제품 품명<input type="text" name="product.prod_name" placeholder="품명을 입력하세요">
	   	창고 코드 <input type="text" name="wh_code" placeholder="창고 코드를 입력하세요"> 
	   	<input type="submit" class="btn btn-info" value="검색"></input>
  </form>
	



	<form action="" method="post">
	<table id="data-table" border="1">
	
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
 	
 	<c:forEach var="s" items="${stock_ListP}">
 	
	 	
		 	<tr>
		 		<th>${s.warehouse.wh_dv}</th>
		 		<th>${s.prod_code}</th>
		 		<td>${s.product.prod_name}</td>
		 		<td>${s.product.prod_color}</td>
		 		<td>${s.product.prod_size}</td>
		   		<td style="color: ${s.stock_count <= 20 ? 'red' : 'inherit'}">${s.stock_count}</td>
		   		<td>${s.wh_code}</td>
		   		<td>${s.warehouse.emp_id}</td>
		   		<c:if test = "${sessionScope.id.emp_department eq '물류팀' or sessionScope.id.emp_department eq '관리자'}">
		   			<td><input type="button" onclick="stockPopup('${s.prod_code}')" value="수정"></td>
	   			</c:if>
		 	</tr>
	 	
	 	
	 </c:forEach>

   </table>
   </form>
       
           		
<div>
    <c:if test="${countP3 > 10 }">
		<c:if test="${bp.prev}">
		    <span><a class="btn btn-secondary" href="/stock/stockList_prod?page=${bp.startPage - 1}&prod_code=${svo.prod_code }&product.prod_name=${svo.prod_code }&wh_code=${svo.wh_code}">이전</a></span>
		</c:if>
		
		<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
		    <a class="btn btn-secondary" href="/stock/stockList_prod?page=${idx }&prod_code=${svo.prod_code }&product.prod_name=${svo.prod_code }&wh_code=${svo.wh_code}">${idx }</a>
		</c:forEach>
		
		<c:if test="${bp.next && bp.endPage > 0}">
		    <a class="btn btn-secondary" href="/stock/stockList_prod?page=${bp.endPage + 1}&prod_code=${svo.prod_code }&product.prod_name=${svo.prod_code }&wh_code=${svo.wh_code}">다음</a>
		</c:if>
	</c:if>
</div>


</div>











<div id="graph">
	<h1>Stock Graph</h1>
	<span id="wh_code" style="width: 10%; height: 10%;"></span>
<!-- 	<span id="wh_dv" style="width: 10%; height: 10%;"></span> -->
</div>









<!-- /page content -->
<%@ include file="../include/footer.jsp"%>