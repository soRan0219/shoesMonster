<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

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
	
	// 코드 자동 부여
	function whCodeNum(num, length) {
		let str = num.toString();
		while (str.length < length){
			str = '0' + str;
		}
		return str;
	}
	
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
    		
//    			if(isPop==="wh_code") {
//         		var rawCode = $(this).find('#rawCode').text();
//         		var prodCode = $(this).find('#prodCode').text();
        		
//         		$('#'+isPop, opener.document).val(whCode);
//         		$('#raw_code', opener.document).val(rawCode);
//         		$('#prod_code', opener.document).val(prodCode);


		   	if(isPop==="wh_code") {
        		var empCode = $(this).find('#empName').text();
//         		var prodCode = $(this).find('#prodCode').text();
        		
        		$('#'+isPop, opener.document).val(whCode);
        		$('#emp_name', opener.document).val(empCode);
//         		$('#prod_code', opener.document).val(prodCode);
        		
   			} else {
        		var whCode = $(this).find('#whCode').text();
        		
        		$('#'+isPop, opener.document).val(whCode);
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

	
	//============================ 버튼 구현 ====================================//	
	
	////////////////// 추가/////////////////////////
	$("#add").click(function () {
		
		$('#modify').attr("disabled", true);
		$('#delete').attr("disabled", true);
		
		//창고코드 부여
		let wCodeNum = Number($('table tr:last').find('td:nth-child(2)').text().substring(2));
		wCodeNum++;
		
		let whNum = whCodeNum(wCodeNum, 3);
		
		if($(this).hasClass('true')){
			
			var tbl = "<tr>";
			
			// 번호
			tbl += "<td>";
			tbl += "</td>";
			
			// 창고코드
			tbl += "<td>";
			tbl += "<input type='text' name='wh_code' id='wh_code' required value='";
			tbl += "WH" + whNum;
			tbl += "'>";
			tbl += "</td>";
			
			// 창고명
			tbl += "<td>";
			tbl += "<input type='text' name='wh_name' id='wh_name' required>";
			tbl += "</td>";
			
			// 창고유형
// 			tbl += "<td>";
// 			tbl += "<select name='wh_dv' id='wh_dv'onchange='whdv(this)'>";
// 			tbl += "<option>선택</option>";
// 			tbl += "<option value='완제품'>완제품</option>";
// 			tbl += "<option value='원자재'>원자재</option>";
// 			tbl += "</select>";
// 			tbl += "</td>";
			
// 			// 품번
// 			tbl += "<td>";
// 			tbl += "<input type='text' name='' id='Code' required>";
// // 			tbl += "<input type='text' name='raw_code' id='raw_code' required>";
// 			tbl += "</td>";
			
// // 			tbl += "<td>";
// // 			tbl += "<input type='text' name='raw_code' id='raw_code' required>";
// // 			tbl += "</td>";
			
// 			// 품명
// 			tbl += "<td>";
// 			tbl += "<input type='text' name='' id='Name'>";
// // 			tbl += "<input type='text' name='raw_name' id='raw_name'>";
// 			tbl += "</td>";
			
// // 			tbl += "<td>";
// // 			tbl += "<input type='text' name='raw_name' id='raw_name'>";
// // 			tbl += "</td>";
			
			// 지역
			tbl += "<td>";
			tbl += "<input type='text' name='wh_addr' id='wh_addr' required>";
			tbl += "</td>";
			
			// 전화번호
			tbl += "<td>";
			tbl += "<input type='text' name='wh_tel' id='wh_tel' required>";
			tbl += "</td>";
			
			// 사용여부
			tbl += "<td>";
			tbl += "<select name='wh_use' id='wh_use'>";
			tbl += "<option value='1'>Y</option>";
			tbl += "<option value='2'>N</option>";
			tbl += "</select>";
			tbl += "</td>";
			
			// 담당자
			tbl += "<td>";
			tbl += "<input type='hidden' name='emp_id' id='emp_id' required>";
			tbl += "<input type='text' name='emp_name' id='emp_name' required>";
			tbl += "</td>";
			
			// 비고
			tbl += "<td>";
			tbl += "<input type='text' name='wh_note' id='wh_note'>";
			tbl += "</td>";
			tbl += "</tr>";
			
			$('table').append(tbl);
			
			// 0630 추가
// 			$("#wh_dv").on("change", function () {
// 				if($("#wh_dv option:selected").val() === '완제품'){
// 					$('input[name="wh_dv"]').val('OR'+codeCreation());
// 				}else if($("#wh_dv option:selected").val() === '원자재'){
// 					$('input[name="wh_dv"]').val('CL'+codeCreation());
// 				}
// 			});
			

			
			//품번 검색 팝업(prod or raw)
// 			$('#Code').click(function() {
// 				var name = $('input#Code').attr("name");
// 				if (name == "prod_code") {
// 					openWindow("prod", "search_prod");
// 				} else if(name == "raw_code"){
// 					openWindow("raw", "search_raw");
// 				}
				
// 			}); //prodCode click

			// 등록자(사원) 검색
			$('#emp_name').click(function () {
// 				alert("검색클릭");
			
				openWindow("emp", "emp_name");
			}); // #emp_id click
			
		}// if
		
		// 저장 -> 저장
		$('#save').click(function () {
			
			var wh_code = $('#wh_code').val();
			var wh_name = $('#wh_name').val();
// 			var wh_dv = $('#wh_dv').val();
// 			var prod_code = $('#prod_code').val();
// 			var raw_code = $('#raw_code').val();
			/////
// 			var prod_name = $('#prod_name').val();
// 			var raw_name = $('#raw_name').val();
			var wh_addr = $('#wh_addr').val();
			var wh_tel = $('#wh_tel').val();
			var wh_use = $('#wh_use').val();
			var emp_id = $('#emp_id').val();
			var emp_name = $('#emp_name').val();
			var wh_note = $('#wh_note').val();
			
// 			if(wh_code == "" || wh_name == "" || wh_dv == "" || 
// 			  (prod_code == "" || raw_code == "" ) || wh_addr == "" || wh_tel == "" || wh_use == ""){
			if(wh_code == "" || wh_name == "" || 
			  emp_name == "" || wh_addr == "" || wh_tel == "" || wh_use == ""){
				alert("항목을 모두 입력하세요");
			}else{
				$('#fr').attr("action", "/performance/whadd");
				$('#fr').attr("method", "POST");
				$('#fr').submit();
			}
			
		}); // save
		
		// 취소버튼(=리셋)
		$('#cancle').click(function () {
			$('#fr').each(function () {
				this.reset();
			});
		}); // cancle click		
		
	});// add.click
	
	
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
				
				// 여기까지 지우기
				/////////////////////////////
						// 라인코드 저장
					let updateCode = $(this).find('#lineCode').text().trim();
					console.log(updateCode);
						
					var jsonData = {
						line_code : updateCode
					};
						
					console.log(jsonData);
						
					var self = $(this);
		
					$.ajax({
						url : "/performance/warehouse",
						type : "post",
						contentType : "application/json; charset=UTF-8",
						dataType : "json",
						data : JSON.stringify(jsonData),
						success : function(data) {
							// alert("*** 아작스 성공 ***");
		
						var preVOs = [
							data.wh_code,
							data.wh_name,
							data.wh_addr,
							data.wh_tel,
							data.wh_use,
							data.emp_id,
							data.emp.emp_name,
							data.wh_note,
							];
		
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
		
						//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
						self.find('td').each(function(idx,item) {
		
							if(idx > 0){
								inputCng($(this), "text", names[idx - 1], preVOs[idx - 1]);
									if(idx == 5 ){
										var dropDown = "<select id = 'wh_use' name = 'wh_use'>";
											dropDown += "<option value = '1'>Y</option>";
											dropDown += "<option value = '2'>N</option>";
											dropDown += "</select>";
											$(this).html(dropDown);
											$(this).find('option').each(function () {
												if(this.value == preVOs[idx - 1]){
													$(this).attr("selected", true);
												}
										
											});// this.find('option')
									
									}// if(idx==4)
							
							}//if(idx>0)
		
						}); // self.find(~~)
		
						// 등록자(사원) 검색
						$('#emp_name').click(function () {
						openWindow("emp", "emp_name");
						}); // #emp_id click
		
						},
						
						error : function(data) {
							alert("아작스 실패 ~~");
						}
					}); //ajax
				
				
				/////////////////////////////////////
				
// 				// 창고코드 저장
// 				let updateCode = $(this).find('#whCode').text().trim();
// 				console.log(updateCode);
				
// 				var jsonDate = {
// 						whCode : updateCode
// 				};
				
// 				var self = $(this);
// 				var names = [
// 						"wh_code",
// 						"wh_name",
// // 						"wh_dv",
// // 						"prod_code", //"raw_code"
// 						"wh_addr",
// 						"wh_tel",
// 						"wh_use",
// 						"emp_id",
// 						"emp_name",
// 						"wh_note"
// 					];
				
// 				// tr안 td 요소들 input으로 변경 후 기존 값 띄움
// 				self.find('td').each(function (idx, item) {
					
// 					if(idx > 0){
// 						inputCng($(this), "text", names[idx - 1], $(this).text());
						
						
// // 						if(idx == 3){
// // 							var dropDown = "<select id='wh_dv' name='wh_dv'>";
// // 							 	dropDown += "<option>완제품</option>";
// // 							 	dropDown += "<option>원자재</option>";
// // 							 	dropDown += "</select>";
							 	
// // 								$(this).html(dropDown);
// // 								$(this).find('option').each(function () {
// // 									if(this.value == $(this).text()){
// // 										$(this).attr("selected", true);
// // 									}
						
// // 								});// this.find('option')						
						
// // 						}//if(idx==3)
// 						if(idx == 5){
// 							var dropDown = "<select id='wh_use' name='wh_use'>";
// 							 	dropDown += "<option value='1'>Y</option>";
// 							 	dropDown += "<option value='2'>N</option>";
// 							 	dropDown += "</select>";
						 	
// 								$(this).html(dropDown);
// 								$(this).find('option').each(function () {
// 									if(this.value == $(this).text()){
// 										$(this).attr("selected", true);
// 									}
					
// 							});// this.find('option')	
							
// 						}//idx==5
// 						if(idx == 6){
// 							inputCng($(this), "hidden", names[idx - 1], $(this).text());
// 						}
// 					}// if
					
// 				});//self.find
				
// 				//품번 검색 팝업(prod)
// // 				$('#search_prod').click(function() {
// // 					openWindow("prod", "search_prod");
// // 				}); //prodCode click
				
// // 				//품번 검색 팝업(raw)
// // 				$('#search_raw').click(function() {
// // 					openWindow("raw", "search_raw");
// // 				}); //rawCode click

// 				// 등록자(사원) 검색
// 				$('#emp_name').click(function () {
// 					openWindow("emp", "emp_name");
// 				}); // #emp_id click
				
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
					
// 					$.ajax({
// 						url: "/performance/whdelete",
// 						type: "POST",
// 						data: {checked : checked},
// 						dataType: "text",
// 						success: function () {
// 							alert("에이잭스 예에~!~!");
// 							location.reload();
// 						},
// 						error: function () {
// 							alert("에이잭스 우우~!~!");
// 						}
// 					}); //ajax
					
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
//  		//품번 검색 팝업(prod) 
//  		$('#search_prod').click(function() { 
//  			openWindow("prod", "search_prod");
//  		}); //prodCode click 
		
//  		//품번 검색 팝업(raw) 
//  		$('#search_raw').click(function() { 
// 			openWindow("raw", "search_raw"); 
//  		}); //rawCode click 
		
		
				// 야ㅕ기까지 삭제
			// 등록자(사원) 검색
			$('#s_emp_name').click(function () {
				openWindow("emp", "emp_name");
			}); // #emp_id click
	
	}); // 제이쿼리
	
// 	// onchance
// 	function whdv(selectElement) {
// 		 var selectedValue = selectElement.value; // 선택된 옵션의 값
		 
// 		  var inputElement = document.getElementById("Code");
// 		  var inputElement2 = document.getElementById("Name");
// 		  var newName = "defaultName"; // 기본 이름
// 		  var newName2 = "defaultName"; // 기본 이름
		  
// 		  // 옵션 값에 따라 이름 변경
// 		  if (selectedValue === "완제품") {
// 		    newName = "prod_code";
// 		    newName2 = "prod_name";
// 		  } else if (selectedValue === "원자재") {
// 		    newName = "raw_code";
// 		    newName2 = "raw_name";
// 		  } 
		  
// 		  inputElement.name = newName; // input 태그의 name 값을 변경
// 		  inputElement2.name = newName2; // input 태그의 name 값을 변경
// 	};
	
	</script>


<!-- /////////////////////////////////////////////////////////////////////////////////// -->
<h2>창고관리</h2>

	<form method="get">
		<fieldset>
			<input type="hidden" name="input" id="input" value="${input }">
			
			<label>창고코드</label>
				<input type="text" name="wh_code"  placeholder="검색어를 입력해주세요">
			
<!-- 			<label>품번</label> 품번 팝업창 + 라디오버튼 완제품/원자재 구분 한번 더 -->
<!-- 					<input type="text" name="prod_code" id="search_prod" placeholder="prod"> -->
<!-- 					<input type="text" name="raw_code" id="search_raw" placeholder="raw"> -->
<!-- 			<br> -->
	
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

<form id="fr">
	<table border="1"> 
		<a>총 ${lwpm.totalCount } 건</a>
		<tr>
			<td>번호</td>
			<td>창고코드</td>
			<td>창고명</td>
<!-- 			<td>창고유형</td> -->
<!-- 			<td>품번</td> -->
<!-- 			<td>품명</td> -->
			<td>지역</td>
			<td>전화번호</td>
			<td>사용여부</td>
			<td type='hidden' style='display: none;'>담당자 코드</td>
			<td>담당자</td>
			<td>비고</td>
		</tr>
	  
		<c:forEach var="ww" items="${whList }" varStatus="i">
				<tr>	
					<td>${i.count }</td>
					<td id="whCode">${ww.wh_code}</td>
					<td>${ww.wh_name}</td>
<%-- 					<td>${ww.wh_dv}</td> --%>
					
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${ww.wh_dv == '원자재'}"> --%>
<%-- 							<td id="rawCode">${ww.raw_code }</td> --%>
<%-- 							<td>${ww.raw.raw_name }</td> --%>
<%-- 						</c:when> --%>
<%-- 						<c:when test="${ww.wh_dv == '완제품'}"> --%>
<%-- 							<td id="prodCode">${ww.prod_code }</td> --%>
<%-- 							<td>${ww.prod.prod_name }</td> --%>
<%-- 						</c:when> --%>
<%-- 					</c:choose> --%>
					
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
	<div>

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

	</div>
</div>

	

<!-- /////////////////////////////////////////////////////////////////////////////////// -->

<!-- /page content -->
<%@ include file="../include/footer.jsp"%>