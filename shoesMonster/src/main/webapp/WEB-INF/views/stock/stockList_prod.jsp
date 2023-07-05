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
	
    <input type="button" value="원자재" class="btn btn-info" onclick="show1()"></input>
    <input type="button" value="완제품" class="btn btn-info" onclick="show2()"></input>
    
    
 <script type="text/javascript">

 function show1() {
		var table = document.getElementById("data-table");
		var rows = table.getElementsByTagName("tr");

		for (var i = 1; i < rows.length; i++) {
			var row = rows[i];
			var statusCell = row.cells[0];

			if (statusCell.innerText.trim() !== "원자재") {
				row.style.display = "none";
			} else {
				row.style.display = "";
			}
		}
	}

	function show2() {
		var table = document.getElementById("data-table1");
		var rows = table.getElementsByTagName("tr");

		for (var i = 1; i < rows.length; i++) {
			var row = rows[i];
			var statusCell = row.cells[0];

			if (statusCell.innerText.trim() !== "완제품") {
				row.style.display = "none";
			} else {
				row.style.display = "";
			}
		}
	}

	

</script>
  
	<hr>

<div id="data-table1">

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
 	
 	<c:forEach var="s" items="${stock_List}">
 	
	 	<c:if test="${s.warehouse.wh_dv  == '완제품'}">
		 	<tr>
		 		<th>${s.warehouse.wh_dv}</th>
		 		<th>${s.prod_code}</th>
		 		<td>${s.product.prod_name}</td>
		 		<td>${s.product.prod_color}</td>
		 		<td>${s.product.prod_size}</td>
		   		<td>${s.stock_count}</td>
		   		<td>${s.wh_code}</td>
		   		<td>${s.warehouse.emp_id}</td>
		   		<td><input type="button" onclick="stockPopup('${s.prod_code}')" value="수정"></td>
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


<div id="data-table2">

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
 	
 	<c:forEach var="s" items="${stock_List}">
 	
	 	<c:if test="${s.warehouse.wh_dv  == '원자재'}">
             <tr>
                 <th>${s.warehouse.wh_dv}</th>
                 <th>${s.raw_code}</th>
                 <td>${s.raw_mat.raw_name}</td>
                 <td>${s.raw_mat.raw_color}</td>
                 <td> </td>
                 <td>${s.stock_count}</td>
                 <td>${s.wh_code}</td>
                 <td>${s.warehouse.emp_id}</td>
                 <td><input type="button" onclick="stockPopup('${s.raw_code}')" value="수정"></td>
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



</div>




<div id="graph">
	<h1>Stock Graph</h1>
	<div id="wh_dv" style="width: 50%; height: 50%;"></div>
	<div id="wh_code" style="width: 50%; height: 50%;"></div>
</div>









<!-- /page content -->
<%@ include file="../include/footer.jsp"%>