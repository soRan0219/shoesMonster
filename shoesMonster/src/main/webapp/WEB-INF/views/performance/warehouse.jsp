<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="../resources/build/css/custom.css" rel="stylesheet">

<style type="text/css">
.selected {
	background-color: #ccc;
}
</style>

<!-- page content -->
<div class="right_col" role="main">

<script type="text/javascript">

	//input으로 바꾸기 
	function inputCng(obj, type, name, value) {
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
		obj.html(inputBox);
	} //inputCng
	
	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";
	
	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/performance/whsearch?type=" + search + "&input=" + inputId;
		var popup = window.open(url, "", popupOpt);
	} //openWindow()

	// 팝업으로 열었을 때
	function popUp() {
		var queryString = window.location.search;
		var urlParams = new URLSearchParams(queryString);
		var isPop = urlParams.get("input");
		
		if(isPop==="null") {
			isPop = null;
		}
		
		$('#pagination a').each(function(){
			
	   		var prHref = $(this).attr("href");
	   			
				var newHref = prHref + "&input=" + isPop;
				$(this).attr("href", newHref);
				
		}); //페이징 요소	
	
	
	$('#input').val(isPop);
	
	if(isPop!=null && isPop!="") {
		
    	$('#add').hide();
    	$('#modify').hide();
    	$('#delete').hide();
    	$('#save').hide();
    	
   		$('table tr:not(:first-child)').click(function(){
   			
   			$(this).css('background', '#ccc');
    		
		   	if(isPop==="wh_code") {
        		var empCode = $(this).find('#empName').text();
        		
        		$('#'+isPop, opener.document).val(whCode);
        		$('#emp_name', opener.document).val(empCode);

        		var whCode = $(this).find('#whCode').text();
        		var whName = $(this).find('#whName').text();
        		
        		var number = isPop.match(/\d+/);
     			$('#'+isPop, opener.document).val(whCode);
     			if(number !=null){
     			$('#wh_name'+number, opener.document).val(whName);
     			} else {
     			$('#wh_name', opener.document).val(whName);
     			}
        		
   			} else {
        		var whCode = $(this).find('#whCode').text();
        		var whName = $(this).find('#whName').text();
        		
        		var number = isPop.match(/\d+/);
     			$('#'+isPop, opener.document).val(whCode);
     			if(number !=null){
     			$('#wh_name'+number, opener.document).val(whName);
     			} else {
     			$('#wh_name', opener.document).val(whName);
     			}
   			}
    		
    		window.close();
    	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
    		
     		
		} //if 
		
		else {
			console.log("팝업아님");
	} //if(팝업으로 열었을 때)
		
} //popUp()




//===========검색==========================
	
	// 제이쿼리
	$(function () {
		
	popUp();
	
	
	//테이블 항목들 인덱스 부여
// 	$('table tr').each(function(index){
// 		var num = "<c:out value='${lwpm.startPage}'/>";
// 		var num2 = "<c:out value='${pvo.pageSize}'/>";
// 		$(this).find('td:second').text(((num-1)*num2) + index);
// 	});
	
// 	var pageSize = "<c:out value='${pvo.pageSize}'/>"; // 한 페이지당 보여줄 항목 개수
// var currentPage = "<c:out value='${pvo.page}'/>"; // 현재 페이지 번호 (변경 가능)

// $('table tr').each(function(index){
//   var pageNumber = currentPage - 1;
//   var itemNumber = (pageNumber * pageSize) + index + 1;
//   $(this).find('td:eq(0)').text(itemNumber);
// });

	
	//============================ 버튼 구현 ====================================//	
	//추가//////////////////////////////////////////////////
	
	// 추가 시 필요한 변수들
    var counter = 0;
    var codeNum = 0;
   	var whCode = 0;
		
       	$('#add').click(function () {
			
        	event.preventDefault();
        	$('#modify').attr("disabled", true);
			$('#delete').attr("disabled", true);       		
       		
			$.ajax({
				url: "/performance/whCode",
				method: "GET",
	 			dataType: "text",
	 			success: function (data) {
	 				 // Ajax 요청 안에서 데이터를 받아와서 변수에 할당 및 후속 작업 수행	 				
	 				codeNum = data;
	 				 console.log("Ajax 내부에서의 codeNum:", codeNum); // Ajax 내부에서의 codeNum: [받아온 데이터]
			
					// 변수에 할당된 데이터를 기반으로 추가 작업 수행
 				    someFunction(codeNum);
	 			
	 			}//success
			
			})//ajax
			
			function someFunction(data) {
// 				alert("someFunction");
				 codeNum = data; // 외부에서의 codeNum: [받아온 데이터]
// 				 alert("codeNum"+codeNum);
				 var num = parseInt(codeNum.substring(2)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
// 				 alert("num : "+num);
				 var paddedNum = padNumber(num, codeNum.length - 2); // 숫자를 패딩하여 길이 유지
	             whCode = codeNum.charAt(0)+ codeNum.charAt(1) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
	             if ($('#add').hasClass('true')) {
	             addRow();
	          	$('#add').removeClass('true');
	             }
	             counter++;
			} // someFunction(data)
			 
			function padNumber(number, length) {
// 				alert("padNum");
                var paddedNumber = number.toString();
                while (paddedNumber.length < length) {
                    paddedNumber = "0" + paddedNumber;
                }
                return paddedNumber;
        } // padNumber(number, length)
        
        	// 저장 -> 저장
			$('#save').click(function () {
				
				var wh_code = $('#wh_code').val();
				var wh_name = $('#wh_name').val();
				var wh_addr = $('#wh_addr').val();
				var wh_tel = $('#wh_tel').val();
				var wh_use = $('#wh_use').val();
				var emp_id = $('#emp_id').val();
				var emp_name = $('#emp_name').val();
				var wh_note = $('#wh_note').val();
				
				if(wh_code == "" || wh_name == "" || 
				  emp_id == "" || wh_addr == "" || wh_tel == "" || wh_use == ""){
					alert("항목을 모두 입력하세요");
				}else{
					$('#fr').attr("action", "/performance/whadd");
					$('#fr').attr("method", "POST");
					$('#fr').submit();
				}
				
			}); // save
        
	});//add.click
		
        // 추가 버튼 클릭 시 row 생성
        function addRow() {
        	
			var row = "<tr>";
			
			// 번호
			row += "<td>";
			row += "</td>";
			
			// 창고코드
			row += "<td>";
			row += "<input type='text' name='wh_code' id='wh_code' required value='"+whCode+"'>";
			row += "</td>";
			
			// 창고명
			row += "<td>";
			row += "<input type='text' name='wh_name' id='wh_name' required>";
			row += "</td>";
			
			// 지역
			row += "<td>";
			row += "<input type='text' name='wh_addr' id='wh_addr' required>";
			row += "</td>";
			
			// 전화번호
			row += "<td>";
			row += "<input type='text' name='wh_tel' id='wh_tel' required>";
			row += "</td>";
			
			// 사용여부
			row += "<td>";
			row += "<select name='wh_use' id='wh_use'>";
			row += "<option value='1'>Y</option>";
			row += "<option value='2'>N</option>";
			row += "</select>";
			row += "</td>";
			
			// 담당자
			row += "<td>";
			row += "<input type='hidden' name='emp_id' id='emp_id' required>";
			row += "<input type='text' name='emp_name' id='emp_name' required>";
			row += "</td>";
			
			// 비고
			row += "<td>";
			row += "<input type='text' name='wh_note' id='wh_note'>";
			row += "</td>";
			row += "</tr>";
			
            $('#whTable').append(row);

    		// 등록자(사원) 검색
    		$('#emp_name').click(function () {
//     			alert("등록자검색");
    			openWindow("emp", "emp_name");
    		}); // #emp_id click
		
		} // addRow()
            

			
			// 취소버튼(=리셋)
			$('#cancle').click(function () {
				$('#fr').each(function () {
					this.reset();
				});
			}); // cancle click	

			
			
			
	////수정//////////////////////////////////////////////////
	var isExecuted = false;
	
	$('#modify').click(function () {
		
		$('#add').attr("disabled", true);
		$('#delete').attr("disabled", true);
		
		// 행 하나 선택시
		$('table tr:not(:first-child)').click(function () {
			
			// 하나씩 선택 가능
			if(!isExecuted){
				isExecuted = true;
				
				$(this).addClass('selected');
				
				// 창고코드 저장
				let updateCode = $(this).find('#whCode').text().trim();
				console.log(updateCode);
				
// 				var jsonDate = {
// 						whCode : updateCode
// 				};
				
				var self = $(this);
				
				var names = [
						"wh_code",
						"wh_name",
						"wh_addr",
						"wh_tel",
						"wh_use",
						"emp_id",
						"emp_name",
						"wh_note"
					];
				
				// tr안 td 요소들 input으로 변경 후 기존 값 띄움
				self.find('td').each(function (idx, item) {
					
					if(idx > 0){
						inputCng($(this), "text", names[idx - 1], $(this).text());
						
						if(idx == 5){
							
							var origin = $(this).find("input").val();
						
							var dropDown = "<select id='wh_use' name='wh_use'>";
							 	dropDown += "<option value='1'>Y</option>";
							 	dropDown += "<option value='2'>N</option>";
							 	dropDown += "</select>";
						 	
								$(this).html(dropDown);
								
								$(this).find('option').each(function () {
									if(origin == $(this).text()){
										$(this).attr("selected", true);
									}
					
							});// this.find('option')	
							
						}//idx==5
						if(idx == 6){
							inputCng($(this), "hidden", names[idx - 1], $(this).text());
						}
					}// if
					
				});//self.find

				// 등록자(사원) 검색
				$('#emp_name').click(function () {
					openWindow("emp", "emp_name");
				}); // #emp_id click
				
				////////////////////////////////////////////////////
				
				// 저장 -> 수정완료
				$('#save').click(function () {
					
					$('#fr').attr("action", "/performance/whmodify");
					$('#fr').attr("method", "POST");
					$('#fr').submit();
					
				});//save				
///////////////////////////////////////////////////////////////////				
			}// if(!isExecuted)
			
			// 취소 -> 리셋
			$('#cancle').click(function () {
				$('#fr').each(function () {
					this.reset();
				});
				
			}); // cancle			
			
		}); // table.click
		
	}); //modify.click
	
	
	////삭제/////////////////////////////////////////////////////////
	$('#delete').click(function () {

		$('#add').attr("disabled", true);
		$('#modify').attr("disabled", true);
		
		if($(this).hasClass('true')){
			
			// 열: 체크박스 행: 라인코드
			$('table tr').each(function () {
				var code = $(this).find('td:nth-child(2)').text();
				
				var tbl = "<input type='checkbox' name='selected' value='";
				tbl += code;
				tbl += "'>";
				
				$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
				$(this).find('td:first').html(tbl);
				
			});//table.each
			
			// 전체선택
			$('#selectAll').click(function () {
				var checkAll = $(this).is(":checked");
				
				if(checkAll){
					$('input:checkbox').prop('checked', true);
				}else{
					$('input:checkbox').prop('checked', false);
				}
			}); 
			
			// 저장 -> 삭제
			$('#save').click(function () {
				
				var checked = [];
				
				$('input[name=selected]:checked').each(function () {
					checked.push($(this).val());
				});
				
				if(checked.length > 0){
					
					if(confirm("선택한 항목을 삭제하시겠습니까?")){
						
						$.ajax({
	 						url: "/performance/whdelete",
	 						type: "POST",
	 						data: {checked : checked},
	 						dataType: "text",	
	 						success: function () {
								alert("삭제가 완료되었습니다");
								location.reload();
							},
							error: function () {
								alert("삭제 중 오류가 발생했습니다");
							}
						});//ajax
					}else{
						alert("삭제가 취소되었습니다");
					}// if(confirm)
					
					
				}// 체크OOO
				else{
					alert("선택된 항목이 없음");					
				}// 체크XXX
				
			});//save
			
			$(this).removeClass('true');
		}// if
		
		// 취소 -> 리셋
		$('#cancle').click(function () {
			$('input:checkbox').prop('checked', false);
		});
		
	});//delete
	
	
	
	//============================ 검색 =========================================//
		
		
				// 야ㅕ기까지 삭제
			// 등록자(사원) 검색
			$('#s_emp_name').click(function () {
				openWindow("emp", "emp_name");
			}); // #emp_id click
	
	}); // 제이쿼리
	
	
	
	
	
	</script>


<!-- /////////////////////////////////////////////////////////////////////////////////// -->
<h2>창고관리</h2>

	<form method="get">
		<fieldset>
			<input type="hidden" name="input" id="input" value="${input }">
			
			<label>창고코드</label>
				<input type="text" name="wh_code"  placeholder="검색어를 입력해주세요">
			
			<label>지역</label>
				<input type="text" name="wh_addr"  placeholder="검색어를 입력해주세요">
			
			<br>
			
			<label>사용여부</label>
<!-- 				<select name="wh_use" > -->
<!-- 					<option selected value="3">전 체</option> -->
<!-- 					<option value="1">Y</option> -->
<!-- 					<option value="2">N</option> -->
<!-- 				</select> -->
			
				<input type="radio" name="wh_use" value="3" checked>전 체
				<input type="radio" name="wh_use" value="1">Y
				<input type="radio" name="wh_use" value="2">N
				
			<label>담당자</label>
				<input type="hidden" id="s_emp_id" name="emp_id">
				<input type="text" id="s_emp_name" name="emp_name" placeholder="검색어를 입력해주세요">
				
			<input type="submit" value="검색">
		</fieldset>
	</form>
<!-- /////////////////////////////////////////////////////////////////////////////////// -->
	
	<button id="add" class="true">추가</button>
	<button id="modify" >수정</button>
	<button id="delete" class="true">삭제</button>
	<button type="reset" id="cancle" >취소</button>
	<button type="submit" id="save">저장</button>
	<button onclick="location.reload()">새로고침</button>

<!-- //////////////////////////////////////////////////////////////////////// -->
<!-- <div class="col-md-12 col-sm-12"> -->
<!-- <div class="x_panel"> -->
<!-- <div class="x_content"> -->
<!-- <div class="row"> -->
<!-- <div class="col-sm-12"> -->
<!-- <div class="card-box table-responsive"> -->
<!-- <div class="table-responsive"> -->

<form id="fr">
	<table border="1" id="whTable" 
	class="table table-striped jambo_table bulk_action"
	style="width:100%" role="grid" aria-describedby="datatable-fixed-header_info"> 
		<a>총 ${lwpm.totalCount } 건</a>
<!-- 		<thead> 안되면 지우삼 -->
		<tr class="headings">
			<td>번호</td>
			<td>창고코드</td>
			<td>창고명</td>
			<td>지역</td>
			<td>전화번호</td>
			<td>사용여부</td>
			<td type='hidden' style='display: none;'>담당자 코드</td>
			<td>담당자</td>
			<td>비고</td>
		</tr>
<!-- 	  	</thead> -->
	  
		<c:forEach var="ww" items="${whList }" varStatus="i">
				<tr>	
					<td>${i.count }</td>
<!-- 					<td></td> -->
					<td id="whCode">${ww.wh_code}</td>
					<td id="whName">${ww.wh_name}</td>
					<td>${ww.wh_addr}</td>
					<td>${ww.wh_tel}</td>
				
					<c:choose>	
						<c:when test="${ww.wh_use == 1}">
							<td>Y</td>
						</c:when>
						<c:when test="${ww.wh_use == 2}">
							<td>N</td>
						</c:when>
					</c:choose>
					<td type='hidden' style='display: none;'>${ww.emp_id }</td>
					<td id="">${ww.emp.emp_name}</td>
					<td>${ww.wh_note}</td>
				</tr>
			</c:forEach>
		</table>
	</form>


<!-- </div>col-sm-12 -->



<!-- /////////////////////////////////////////////////////////////////////////////////// -->
	
	<div id="pagination">
		<c:if test="${lwpm.prev  }"> 
			<a href="/performance/warehouse?page=${lwpm.startPage-1 }&wh_code=${wvo.wh_code}&wh_addr=${wvo.wh_addr }&wh_use=${wvo.wh_use}&emp_id=${wvo.emp_id}">이 전</a>
		</c:if>
		
		<c:forEach var="page" begin="${lwpm.startPage }" end="${lwpm.endPage }" step="1">
			<a href="/performance/warehouse?page=${page }&wh_code=${wvo.wh_code}&wh_addr=${wvo.wh_addr }&wh_use=${wvo.wh_use}&emp_id=${wvo.emp_id}">${page }</a>
		</c:forEach>
		
		<c:if test="${lwpm.next }">
			<a href="/performance/warehouse?page=${lwpm.endPage+1 }&wh_code=${wvo.wh_code}&wh_addr=${wvo.wh_addr }&wh_use=${wvo.wh_use}&emp_id=${wvo.emp_id}">다 음</a>
		</c:if>

<!-- 	</div>id="pagination"  -->
	

<!-- </div>card-box table-responsive	 -->
	
<!-- </div>row	 -->
<!-- </div>x_content -->
<!-- </div> x_panel		 -->
<!-- </div>class="col-md-12 col-sm-12" -->

<!-- /////////////////////////////////////////////////////////////////////////////////// -->

<!-- /page content -->
<%@ include file="../include/footer.jsp"%>