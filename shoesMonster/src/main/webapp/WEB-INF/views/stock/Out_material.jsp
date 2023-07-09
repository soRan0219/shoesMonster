<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="javax.servlet.http.HttpSession" %>
    
<%@ include file="../include/header.jsp"%>
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

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
	function checkStock(orderCount, stockCount) {
	    if (orderCount > stockCount) {
// 	        alert("재고 수량이 부족합니다. 물량을 확인해 주세요.");
     	Swal.fire({
			title: "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>" + "재고 수량이 부족합니다 \n 물량을 확인해 주세요"+ "</div>",
			icon: 'warning',
			width: '300px',
		})
			return false;
	    } 
	}
</script>
	
<!-- page content -->
<div class="right_col" role="main">
	
	<h1 style="margin-left: 1%;"> 출고 관리 </h1>
	
	
	<!-- 버튼 제어 -->	
	<div style="margin-left: 1%;">
<!--		<input type="button" value="전체" class="B B-info" onclick="showAll()"></input> -->
<!--	    <input type="button" value="미출고" class="B B-info" onclick="show1()" id="noMat"></input> -->
<!--	    <input type="button" value="출고완료" class="B B-info" onclick="show2()" id="yesMat"></input> -->
	</div>
	
	<script>
	    var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
	
	    if (team === "자재팀" || team === "관리자") {
	        document.getElementById("noMat").disabled = false;
	        document.getElementById("yesMat").disabled = false;
	    } else {
	        document.getElementById("noMat").hidden = true;
	        document.getElementById("yesMat").hidden = true;
	    }
	</script>
	<!-- 버튼 제어 -->
	
	
	
<script>
    function show1() {
        var table = document.getElementById("data-table");
        var rows = table.getElementsByTagName("tr");

        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var statusCell = row.cells[10];

            if (statusCell.innerText.trim() !== "미출고") {
                row.style.display = "none";
            } else {
                row.style.display = "";
            }
        }
    }
    
    function show2() {
        var table = document.getElementById("data-table");
        var rows = table.getElementsByTagName("tr");

        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            var statusCell = row.cells[10];

            if (statusCell.innerText.trim() !== "출고완료") {
                row.style.display = "none";
            } else {
                row.style.display = "";
            }
        }
    }
    
    function showAll() {
        var table = document.getElementById("data-table");
        var rows = table.getElementsByTagName("tr");

        for (var i = 1; i < rows.length; i++) {
            var row = rows[i];
            row.style.display = "";
        }
    }

</script>	
	<hr>

	<form method="get" style="margin-left: 1%;">
		<fieldset>
			<button type="submit" value="" class="B B-info" name="orders.out_YN">전체</button>
	        <input type="submit" value="미출고" class="B B-info" name="orders.out_YN" ></input> 
	        <input type="submit" value="출고완료" class="B B-info" name="orders.out_YN" ></input> 
		
       		<label>출고 번호:</label>
        	<input type="text" name="out_num" value="" placeholder="출고 번호를 입력하세요.">
        	<label>품명:</label>
        	<input type="text" name="prod.prod_name" value="" placeholder="품명을 입력하세요.">
        	<label>거래처명:</label>
        	<input type="text" name="clients.client_actname" value="" placeholder="거래처명을 입력하세요."> 
        	<input type="submit" class="btn btn-info" value="검색">
		</fieldset>
	</form>

  <!-- ///////////////////////////////////////////////목록 템플릿  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ -->
    
    <div class="col-md-12 col-sm-12">
		<div class="x_panel">
			<div class="x_title">
				<h2>
					출고 목록 <small>총 ${count4}건</small>
				</h2>
				
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<div class="table-responsive">
					<form action="" method="post">
						<table class="table table-striped jambo_table bulk_action" id="data-table">
							<thead>
								<tr class="headings">
									<th class="column-title">출고 번호</th>
									<th class="column-title">수주번호</th>
									<th class="column-title">거래처명</th>
									<th class="column-title">거래처코드</th>
									<th class="column-title">제품 코드</th>
									<th class="column-title">제품 이름</th>
									<th class="column-title">주문 수량</th>
									<th class="column-title">재고 수량</th>
									<th class="column-title">납품가</th>
									<th class="column-title">납품예정일</th>
									<th class="column-title">출고 날짜</th>
									<th class="column-title">담당자</th>
									<th class="column-title">출고 여부</th>
									<th class="column-title">출고 처리</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${count4 > 0}">
								<c:forEach var="out" items="${out_List }">
									<tr class="even pointer">
										<td class=" ">${out.out_num}</td>
										<td class=" ">${out.orders.order_code}</td>
										<td class=" ">${out.clients.client_actname}</td>
										<td class=" ">${out.orders.client_code}</td>
										<td class=" ">${out.prod.prod_code}</td>
										<td class=" ">${out.prod.prod_name}</td>
										<td class=" ">${out.orders.order_count}</td>
										<td class=" " style="color: ${out.stock.stock_count <= 20 ? 'red' : 'inherit'}">${out.stock.stock_count}</td>
										<td class=" "><fmt:formatNumber value=" ${out.prod.prod_price}" />원</td>
										<td class=" ">${out.orders.order_deliveryDate}</td>
										<td class=" ">${out.out_date}</td>
										<td class=" ">${out.o_emp_id}</td>
										<td class=" ">${out.orders.out_YN}</td>
										<td class=" ">
											<c:if test = "${sessionScope.id.emp_department eq '물류팀' or sessionScope.id.emp_department eq '관리자'}">
												<c:if test="${out.out_num == null}">
													<button type="submit" name="out_Button" value="${out.orders.order_code},${out.orders.order_count},${out.prod.prod_code}" class="B B-info" id="matYN" onclick="return checkStock(${out.orders.order_count}, ${out.stock.stock_count})">출고 처리</button>
												</c:if>
											</c:if>
										</td>
									</tr>
								</c:forEach>
								</c:if>
							</tbody>
						</table>
						<div style="text-align: center;">
							<c:if test="${count4 == 0}">
								해당되는 항목이 없습니다.
							</c:if>
						</div>
					</form>
					
					<!-- 엑셀 - 시작 -->
	<button id="excelDownload">엑셀 다운로드</button>
	
	<script type="text/javascript">
	function getToday() {
		var date = new Date();
		
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		
		return year + "-" + month + "-" + day;
	} //getToday()
	
	
        //엑셀
        const excelDownload = document.querySelector('#excelDownload');
        
        document.addEventListener('DOMContentLoaded', ()=> {
            excelDownload.addEventListener('click', exportExcel);
        });
        
        function exportExcel() {
            //1. workbook 생성
            var wb = XLSX.utils.book_new();
            
            //2. 시트 만들기
            var newWorksheet = excelHandler.getWorksheet();
            
            //3. workbook에 새로 만든 워크시트에 이름을 주고 붙이기
            XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
            
            //4. 엑셀 파일 만들기
            var wbout = XLSX.write(wb, {bookType:'xlsx', type:'binary'});
            
            //5. 엑셀 파일 내보내기
            saveAs(new Blob([s2ab(wbout)], {type:"application/octet-stream"}), excelHandler.getExcelFileName());
            
        } //exportExcel()
        
        var excelHandler = {
            getExcelFileName : function() {
                return 'performanceList'+getToday()+'.xlsx'; //파일명
            },
            getSheetName : function() {
                return 'Performance Sheet'; //시트명
            },
            getExcelData : function() {
                return document.getElementById('data-table'); //table id
            },
            getWorksheet : function() {
                return XLSX.utils.table_to_sheet(this.getExcelData());
            }
        } //excelHandler
        
        function s2ab(s) {
            var buf = new ArrayBuffer(s.length);  // s -> arrayBuffer
            var view = new Uint8Array(buf);  
            for(var i=0; i<s.length; i++) {
                view[i] = s.charCodeAt(i) & 0xFF;
            }
            return buf;
        } //s2ab(s)
    </script>
    <!-- 엑셀 - 끝 -->
					
				</div>
			</div>
		</div>
      
 	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
           <c:if test="${count4 > 0 }">
	           <li class="paginate_button previous disabled">
			        <c:if test="${bp.prev}">
			            <a href="/stock/Out_material?page=${bp.startPage - 1}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}&orders.out_YN=${rvo.orders.out_YN}">이전</a>
			        </c:if>
			   </li>
	           <li class="paginate_button previous disabled">
					<c:forEach begin="${bp.startPage}" end="${bp.endPage}" step="1" var="idx">
					   <a chref="/stock/Out_material?page=${idx}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}&orders.out_YN=${rvo.orders.out_YN}">${idx}</a>
					</c:forEach>
			   </li>
	           <li class="paginate_button previous disabled">
		       		<c:if test="${bp.next && bp.endPage > 0}">
		            	<a class="btn btn-secondary" href="/stock/Out_material?page=${bp.endPage + 1}&out_num=${param.out_num}&prod.prod_name=${rvo.prod.prod_name}&clients.client_actname=${rvo.clients.client_actname}&orders.out_YN=${rvo.orders.out_YN}">다음</a>
		       		</c:if>
		       	</li>
			</c:if>
		</ul>
	</div>  
</div>   
      
</div>
    
    
    <!-- //////////////////////////////////목록 템플릿  /////////////////////////////////////// -->



<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


