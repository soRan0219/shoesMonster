<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%@ include file="../include/header.jsp"%>

<!-- <script>
    function updateStockCount() {
        var newStockCountInput = document.getElementById("new_stock_count");
        var newStockCount = newStockCountInput.value;

        var stockCountElement = document.getElementById("stock_count");
        stockCountElement.innerText = newStockCount;

        newStockCountInput.value = "";
    }
</script> -->

<!-- page content -->
   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['eonhyo',33],
          ['changwon',30],
          ['soran',29],
          ['aeryong',28],
          ['seongil',27],
          ['hyerim',26],
          ['dohee',25]
        ]);

        var options = {
          title: 'Group2 Age',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>
    
  
    

<div class="right_col" role="main">

	<h1> 재고 관리 </h1>
	
	<input type="button" value="전체" onclick="toggleDiv('all')"></input>
    <input type="button" value="원자재" onclick="toggleDiv('raw')"></input>
    <input type="button" value="완제품" onclick="toggleDiv('prod')"></input>
    <input type="button" value="한눈에보기" onclick="toggleDiv('graph')"></input>
    
    
 <script type="text/javascript">

function toggleDiv(divId) {
    var allDiv = document.getElementById("all");
    var rawDiv = document.getElementById("raw");
    var prodDiv = document.getElementById("prod");
    var graphDiv = document.getElementById("graph");
    
    if(divId === "all"){
   	 allDiv.style.display = "block";
   	rawDiv.style.display = "none";
   	prodDiv.style.display = "none";
   	graphDiv.style.display = "none";
  
   	
    } else if(divId === "raw"){
   
   	 allDiv.style.display = "none";
   	 rawDiv.style.display = "block";
   	 prodDiv.style.display = "none";
   	 graphDiv.style.display = "none";
   	 
    	} else if(divId === "prod"){
    		   
   	   	 allDiv.style.display = "none";
   	   	 rawDiv.style.display = "none";
   	 	 prodDiv.style.display = "block";
   	     graphDiv.style.display = "none";
   	     
   	    	}else if(divId === "graph"){
     		   
   	   	   	 allDiv.style.display = "none";
   	   	   	 rawDiv.style.display = "none";
   	   	 	 prodDiv.style.display = "none";
   	   	     graphDiv.style.display = "block";
   	   	    	}
   
    }

	window.onload = function() {
		var allDiv = document.getElementById("all");
		var rawDiv = document.getElementById("raw");
		var prodDiv = document.getElementById("prod");
		var graphDiv = document.getElementById("graph");
		 
		allDiv.style.display = "block";
		prodDiv.style.display = "none";
		rawDiv.style.display = "none";
		 graphDiv.style.display = "none";
		
				
	};

</script>
  
	<hr>


<!-- 		<form action="" method="get"> -->
<!-- 			제품코드 <input type="text" name="prod_code" placeholder="제품코드를 입력하세요">  -->
<!-- 			제품명 <input type="text" name="product.prod_name" placeholder="제품명을 입력하세요">  -->
<!-- 			창고 코드 <input type="text" name="wh_code" placeholder="창고코드를 입력하세요"> -->
<!-- 			<button type="submit">검색</button> -->
<!-- 		</form> -->

<div id="all">

	<form action="" method="post">
	<table id="data-table" border="1">
    <tr>
 		<th>유형</th>
 		<th>제품 코드</th>
 		<th>제품명</th>
 		<th>색상</th>
 		<th>사이즈</th>
 		<th>재고 수량</th>
 		<th>실제 수량</th>
 		<th>창고 코드</th>
 		<th>담당자</th>
 		<th>수정 버튼</th>
 	</tr>
 	
 	<c:forEach var="s" items="${stock_List}">
 	
	 	<c:if test="${s.warehouse.wh_dv  == '완제품'}">
		 	<tr>
		 		<th>${s.warehouse.wh_dv}</th>
		 		<th>${s.prod_code}</th>
		 		<td>${s.product.prod_name}</td>
		 		<td>${s.product.prod_color}</td>
		 		<td>${s.product.prod_size}</td>
		   		<td>${s.stock_count}</td>
                <td><input type="text" id="new_stock_count" name="new_stock_count"></td>
		   		<td>${s.wh_code}</td>
		   		<td>${s.warehouse.emp_id}</td>
		   		<td>
					<button type="submit" name="modify_Button" value="${s.prod_code}">수정</button>
				</td>
		 	</tr>
	 	</c:if>
	 	<c:if test="${s.warehouse.wh_dv  == '원자재'}">
		 	<tr>
		 		<th>${s.warehouse.wh_dv}</th>
		 		<th>${s.raw_code}</th>
		 		<td>${s.raw_mat.raw_name}</td>
		 		<td>${s.raw_mat.raw_color}</td>
		 		<td></td>
		   		<td>${s.stock_count}</td>
                <td><input type="text" id="new_stock_count" name="new_stock_count"></td>
		   		<td>${s.wh_code}</td>
		   		<td>${s.warehouse.emp_id}</td>
				<td>
					<button type="submit" name="modify_Button" value="${s.raw_code}">수정</button>
				</td>
		 	</tr>
	 	</c:if>
	 	
 	</c:forEach>
    </table>
    </form>
   
           		
<div>
    <c:if test="${count3 > 10 }">
		<c:if test="${bp.prev}">
		    <span><a href="/stock/stockList?page=${bp.startPage - 1}&wh_code=${wh_code}">이전</a></span>
		</c:if>
		
		<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
		    <a href="/stock/stockList?page=${idx }&wh_code=${wh_code}">${idx }</a>
		</c:forEach>
		
		<c:if test="${bp.next && bp.endPage > 0}">
		    <a href="/stock/stockList?page=${bp.endPage + 1}&wh_code=${wh_code}">다음</a>
		</c:if>
	</c:if>
</div>

</div>


<div id="raw">

		<form action="" method="get">
			원자재 코드 <input type="text" name="raw_code" placeholder="원자재 코드를 입력하세요"> 
			원자재 명 <input type="text" name="raw_mat.raw_name" placeholder="원자재 명을 입력하세요"> 
			창고 코드 <input type="text" name="wh_code" placeholder="창고코드를 입력하세요">
			<button type="submit">검색</button>
		</form>

	<form action="" method="post">
	<table  border="1">
    <tr>
 		<th>유형</th>
 		<th>원자재 코드</th>
 		<th>원자재 명</th>
 		<th>색상</th>
 		<th>사이즈</th>
 		<th>재고 수량</th>
 		<th>실제 수량</th>
 		<th>창고 코드</th>
 		<th>담당자</th>
 		<th>수정 버튼</th>
 	</tr>
 	
 	<c:forEach var="s" items="${stock_List}">
 	 <c:if test="${s.warehouse.wh_dv == '원자재'}">
		 	<tr>
		 		<th>${s.warehouse.wh_dv }</th>
		 		<th>${s.raw_code}</th>
		 		<td>${s.raw_mat.raw_name}</td>
		 		<td>${s.raw_mat.raw_color}</td>
		 		<td></td>
		   		<td>${s.stock_count}</td>
                <td><input type="text" id="new_stock_count" name="new_stock_count"></td>
		   		<td>${s.wh_code}</td>
		   		<td>${s.warehouse.emp_id}</td>
				<td>
					<button type="submit" name="modify_Button" value="${s.raw_code}">수정</button>
				</td>
		 	</tr>
	 	</c:if>
	 	
 	</c:forEach>
    </table>
    </form>
   
           		
<div>
    <c:if test="${count3 > 10 }">
		<c:if test="${bp.prev}">
		    <span><a href="/stock/stockList?page=${bp.startPage - 1}&wh_code=${wh_code}&raw_code=${raw_code}&raw_mat.raw_name=${raw_mat.raw_name}">이전</a></span>
		</c:if>
		
		<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
		    <a href="/stock/stockList?page=${idx }&wh_code=${wh_code}&raw_code=${raw_code}&raw_mat.raw_name=${raw_mat.raw_name}">${idx }</a>
		</c:forEach>
		
		<c:if test="${bp.next && bp.endPage > 0}">
		    <a href="/stock/stockList?page=${bp.endPage + 1}&wh_code=${wh_code}&raw_code=${raw_code}&raw_mat.raw_name=${raw_mat.raw_name}">다음</a>
		</c:if>
	</c:if>
</div>

</div>

<div id="prod">

 		 <form action="" method="get">
			완제품코드 <input type="text" name="prod_code" placeholder="완제품 코드를 입력하세요"> 
			완제품 명 <input type="text" name="product.prod_name" placeholder="완제품 명을 입력하세요"> 
			창고 코드 <input type="text" name="wh_code" placeholder="창고코드를 입력하세요">
			<button type="submit">검색</button>
		</form>
		
	<form action="" method="post">
	<table  border="1">
    <tr>
 		<th>유형</th>
 		<th>완제품 코드</th>
 		<th>완제품 명</th>
 		<th>색상</th>
 		<th>사이즈</th>
 		<th>재고 수량</th>
 		<th>실제 수량</th>
 		<th>창고 코드</th>
 		<th>담당자</th>
 		<th>수정 버튼</th>
 	</tr>
 	
 	<c:forEach var="s" items="${stock_List}">
 	 <c:if test="${s.warehouse.wh_dv == '완제품'}">
	 	
	 	
		 	<tr>
		 		<th>${s.warehouse.wh_dv}</th>
		 		<th>${s.prod_code}</th>
		 		<td>${s.product.prod_name}</td>
		 		<td>${s.product.prod_color}</td>
		 		<td>${s.product.prod_size}</td>
		   		<td>${s.stock_count}</td>
                <td><input type="text" id="new_stock_count" name="new_stock_count"></td>
		   		<td>${s.wh_code}</td>
		   		<td>${s.warehouse.emp_id}</td>
		   		<td>
					<button type="submit" name="modify_Button" value="${s.prod_code}">수정</button>
				</td>
		 	</tr>
	 	
	 	</c:if>
 	</c:forEach>
    </table>
    </form>
   
           		
<div>
    <c:if test="${count3 > 10 }">
		<c:if test="${bp.prev}">
		    <span><a href="/stock/stockList?page=${bp.startPage - 1}&wh_code=${wh_code}&prod_code=${prod_code}&product.prod_name=${product.prod_name}">이전</a></span>
		</c:if>
		
		<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
		    <a href="/stock/stockList?page=${idx }&wh_code=${wh_code}&prod_code=${prod_code}&product.prod_name=${product.prod_name}">${idx }</a>
		</c:forEach>
		
		<c:if test="${bp.next && bp.endPage > 0}">
		    <a href="/stock/stockList?page=${bp.endPage + 1}&wh_code=${wh_code}&prod_code=${prod_code}&product.prod_name=${product.prod_name}">다음</a>
		</c:if>
	</c:if>
</div>

</div>

<div id="graph">
 <h1> Group2 Age  </h1>
  <div id="piechart_3d" style="width: 900px; height: 500px;"></div>
  <div id="piechart_3d2" style="width: 900px; height: 500px;"></div>
</div>



	bp.startPage : ${bp.startPage } <br>
    bp.endPage : ${bp.endPage } <br>
    param : ${param } <br>

</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>