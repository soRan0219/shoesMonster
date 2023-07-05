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
	
	<input type="button" value="전체" class="btn btn-info" onclick="toggleDiv('all')"></input>
    <input type="button" value="원자재" class="btn btn-info" onclick="toggleDiv('raw')"></input>
    <input type="button" value="완제품" class="btn btn-info" onclick="toggleDiv('prod')"></input>
    <input type="button" value="한눈에보기" class="btn btn-info" onclick="toggleDiv('graph')"></input>
    
    
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
					<button type="submit" name="modify_Button" class="btn btn-info" value="${s.prod_code}">수정</button>
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
					<button type="submit" name="modify_Button" class="btn btn-info" value="${s.raw_code}">수정</button>
				</td>
		 	</tr>
	 	</c:if>
	 	
 	</c:forEach>
    </table>
    </form>
   
           		
<div>
    <c:if test="${count3 > 10 }">
		<c:if test="${bp.prev}">
		    <span><a class="btn btn-secondary" href="/stock/stockList?page=${bp.startPage - 1}&wh_code=${wh_code}">이전</a></span>
		</c:if>
		
		<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
		    <a class="btn btn-secondary" href="/stock/stockList?page=${idx }&wh_code=${wh_code}">${idx }</a>
		</c:forEach>
		
		<c:if test="${bp.next && bp.endPage > 0}">
		    <a class="btn btn-secondary" href="/stock/stockList?page=${bp.endPage + 1}&wh_code=${wh_code}">다음</a>
		</c:if>
	</c:if>
</div>

</div>


<div id="raw">

		<form action="" method="get">
			원자재 코드 <input type="text" name="raw_code" placeholder="원자재 코드를 입력하세요"> 
			원자재 명 <input type="text" name="raw_mat.raw_name" placeholder="원자재 명을 입력하세요"> 
			창고 코드 <input type="text" name="wh_code" placeholder="창고코드를 입력하세요">
			<button class="btn btn-info" type="submit">검색</button>
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
					<button type="submit" class="btn btn-info" name="modify_Button" value="${s.raw_code}">수정</button>
				</td>
		 	</tr>
	 	</c:if>
	 	
 	</c:forEach>
    </table>
    </form>
   
           		
<div>
    <c:if test="${count3 > 10 }">
		<c:if test="${bp.prev}">
		    <span><a class="btn btn-secondary" href="/stock/stockList?page=${bp.startPage - 1}&wh_code=${wh_code}&raw_code=${raw_code}&raw_mat.raw_name=${raw_mat.raw_name}">이전</a></span>
		</c:if>
		
		<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
		    <a class="btn btn-secondary" href="/stock/stockList?page=${idx }&wh_code=${wh_code}&raw_code=${raw_code}&raw_mat.raw_name=${raw_mat.raw_name}">${idx }</a>
		</c:forEach>
		
		<c:if test="${bp.next && bp.endPage > 0}">
		    <a class="btn btn-secondary" href="/stock/stockList?page=${bp.endPage + 1}&wh_code=${wh_code}&raw_code=${raw_code}&raw_mat.raw_name=${raw_mat.raw_name}">다음</a>
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
					<button type="submit" class="btn btn-info" name="modify_Button" value="${s.prod_code}">수정</button>
				</td>
		 	</tr>
	 	
	 	</c:if>
 	</c:forEach>
    </table>
    </form>
   
           		
<div>
    <c:if test="${count3 > 10 }">
		<c:if test="${bp.prev}">
		    <span><a class="btn btn-secondary" href="/stock/stockList?page=${bp.startPage - 1}&wh_code=${wh_code}&prod_code=${prod_code}&product.prod_name=${product.prod_name}">이전</a></span>
		</c:if>
		
		<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
		    <a class="btn btn-secondary" href="/stock/stockList?page=${idx }&wh_code=${wh_code}&prod_code=${prod_code}&product.prod_name=${product.prod_name}">${idx }</a>
		</c:forEach>
		
		<c:if test="${bp.next && bp.endPage > 0}">
		    <a class="btn btn-secondary" href="/stock/stockList?page=${bp.endPage + 1}&wh_code=${wh_code}&prod_code=${prod_code}&product.prod_name=${product.prod_name}">다음</a>
		</c:if>
	</c:if>
</div>

</div>

<div id="graph">
 <h1> Stock Graph </h1>
  <div id="wh_dv" style="width: 50%; height: 50%;"></div>
  <div id="wh_code" style="width: 50%; height: 50%;"></div>
  
  
  
  
  
  
</div>




</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>