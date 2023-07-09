<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../include/header.jsp"%>

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

<!-- 폰트 -->
<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<!--FileSaver [savaAs 함수 이용] -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<style type="text/css">

body {
	font-family: 'NexonLv2Gothic';
}
</style>
<!-- 폰트 -->

<!-- page content -->
<div class="right_col" role="main">

	<h1 style="margin-left: 1%;">입고 관리</h1>

	<!-- 버튼 제어 -->
<!-- 	<div style="margin-left: 1%;"> -->
<!-- 		<input type="button" value="전체" class="B B-info" onclick="showAll()"></input> -->
<!-- 		<input type="button" value="미입고" class="B B-info" onclick="show1()" ></input>  -->
<!-- 		<input type="button" value="입고완료" class="B B-info" onclick="show2()" ></input> -->
<!-- 	</div> -->
	
	<script>
	    var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
	
	    if (team === "물류팀" || team === "관리자") {
	        document.getElementById("inMatN").disabled = false;
	        document.getElementById("inMatY").disabled = false;
	    } else {
	        document.getElementById("inMatN").hidden = true;
	        document.getElementById("inMatY").hidden = true;
	    }
	</script>
	<!-- 버튼 제어 -->

	<script>
		function show1() {
			var table = document.getElementById("data-table");
			var rows = table.getElementsByTagName("tr");

			for (var i = 1; i < rows.length; i++) {
				var row = rows[i];
				var statusCell = row.cells[13];

				if (statusCell.innerText.trim() !== "미입고") {
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
				var statusCell = row.cells[13];

				if (statusCell.innerText.trim() !== "입고완료") {
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
		
		function go(raw_name,raw_order_count) {
			alert("품명("+raw_name+")이 "+raw_order_count+"개 입고 처리가 되었습니다.");
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	</script>



<!-- //////////////////////////////////////////////////////////////////////// -->
<!-- page content -->
	
<!-- 	<h2 style="margin-left: 1%;">재고관리</h2> -->

<div style="margin: 1% 0 1% 1%;">

	<form action="" method="get">
		<button type="submit" value="" class="B B-info" name="in_YN">전체</button>
		<input type="submit" value="미입고" class="B B-info" name="in_YN" ></input> 
        <input type="submit" value="입고완료" class="B B-info" name="in_YN" ></input> 
		<hr>
		<label>품명</label> <input type="text" name="rawMaterial.raw_name" placeholder="품명을 입력해주세요">
		<label>입고 번호</label> <input type="text" name="in_mat.in_num" placeholder="입고 번호를 입력해주세요">
		<label>거래처명</label> <input type="text" name="clients.client_actname" placeholder="거래처명을 입력해주세요">
		<input type="submit" class="B B-info" value="검색">
		
	</form>
</div>

<!-- 	<hr> -->

	<!--//////////////////////////////////////////// 테이블 템플릿 ////////////////////////////////////////////////////// -->

	<div class="col-md-12 col-sm-12  ">
		<div class="x_panel">
			<div class="x_title">
				<h2>
					입고 목록 <small>총 ${count1}건</small>
				</h2>
			
				<div class="clearfix"></div>
			</div>
			<div class="x_content">
				<div class="table-responsive">
					<form action="" method="post" id="fr">
						<table class="table table-striped jambo_table bulk_action"
							id="data-table">
							<thead>
								<tr class="headings">
									
									<th class="column-title">입고 번호</th>
									<th class="column-title">발주 번호</th>
									<th class="column-title">입고 창고</th>
									<th class="column-title">거래처명</th>
									<th class="column-title">품번</th>
									<th class="column-title">품명</th>
									<th class="column-title">색상</th>
									<th class="column-title">발주 수량</th>
									<th class="column-title">재고 수량</th>
									<th class="column-title">단가</th>
									<th class="column-title">총액</th>
									<th class="column-title">입고일</th>
									<th class="column-title">입고 담당자</th>
									<th class="column-title">입고 확인</th>
									<th class="column-title">입고 버튼</th>
									<th class="bulk-actions" colspan="7"><a class="antoo"
										style="color: #fff; font-weight: 500;">Bulk Actions ( <span
											class="action-cnt"> </span> ) <i class="fa fa-chevron-down"></i></a>
									</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${count1 > 0}">
								<c:forEach var="rvo" items="${ro_List }">
									<tr class="even pointer">
										<td class=" ">${rvo.in_mat.in_num }</td>
										<td class=" ">${rvo.raw_order_num }</td>
										<td class=" ">${rvo.rawMaterial.wh_code }</td>
										<td class=" ">${rvo.clients.client_actname }</td>
										<td class=" ">${rvo.raw_code }</td>
										<td class=" ">${rvo.rawMaterial.raw_name }</td>
										<td class=" ">${rvo.rawMaterial.raw_color }</td>
										<td class=" ">${rvo.raw_order_count}</td>
										<td class=" " style="color: ${rvo.stock.stock_count <= 20 ? 'red' : 'inherit'}">${rvo.stock.stock_count != null ? rvo.stock.stock_count : 0}</td>
										<td class=" "><fmt:formatNumber value=" ${rvo.rawMaterial.raw_price}" />원</td>
										<td class=" "><fmt:formatNumber value=" ${rvo.rawMaterial.raw_price*rvo.raw_order_count}" />원</td>
										<td class=" ">${rvo.in_mat.in_date }</td>
										<td class=" ">${rvo.in_mat.i_emp_id }</td>
<%-- 										<td class="a-right a-right ">${rvo.in_mat.in_YN eq null ? '미입고' : rvo.in_mat.in_YN}</td> --%>
										<td class="a-right a-right ">${rvo.in_YN}</td>
										<td class=" ">
										<c:if test = "${sessionScope.id.emp_department eq '물류팀' or sessionScope.id.emp_department eq '관리자'}">
											<c:if test="${rvo.in_mat.in_num == null}">
												<button type="submit" name="in_Button" onclick="go('${rvo.rawMaterial.raw_name }','${rvo.raw_order_count}')" class="B B-info" value="${rvo.raw_order_num},${rvo.raw_code},${rvo.raw_order_count},${rvo.rawMaterial.wh_code }">입고 처리</button>
											</c:if>
										</c:if>
										</td>
									</tr>
									
								</c:forEach>
								</c:if>
							</tbody>
						</table>
						<div style="text-align: center;">
							<c:if test="${count1 == 0}">
								해당되는 항목이 없습니다.
							</c:if>
						</div>
						
					</form>
					<br>

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
<!-- //////////////////////////////////////////////////////////////////////// -->	
	
	
</div>
</div>
<!-- //////////////////////////////////////////////////////////////////////// -->	
	
	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
            <c:if test="${count1 > 0 }">
			<li class="paginate_button previous disabled">
                <c:if test="${bp.prev}">
                    <span><a href="/stock/In_material?page=${bp.startPage -1}&in_mat.in_num=${rvo.in_mat.in_num}&in_YN=${rvo.in_YN}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">Previous</a></span>
                </c:if>
            </li>
			<li class="paginate_button previous disabled">
                <c:forEach var="i" begin="${bp.startPage}" end="${bp.endPage}"
                    step="1">
                    <a href="/stock/In_material?page=${i }&in_mat.in_num=${rvo.in_mat.in_num}&in_YN=${rvo.in_YN}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">${i }</a>
                </c:forEach>
			</li>
			<li class="paginate_button previous disabled">
                <c:if test="${bp.next && bp.endPage > 0}">
                    <a href="/stock/In_material?page=${bp.endPage + 1}&in_mat.in_num=${rvo.in_mat.in_num}&in_YN=${rvo.in_YN}&rawMaterial.raw_name=${rvo.rawMaterial.raw_name}&clients.client_actname=${rvo.clients.client_actname}">Next</a>
                </c:if>
            </li>
            </c:if>
         </ul>
      </div>
      
      
      
  </div>
	
	
	
	
	
</div>

	<!--//////////////////////////////////////////// 테이블 템플릿 ////////////////////////////////////////////////////// -->


<!-- /page content -->
<%@ include file="../include/footer.jsp"%>


