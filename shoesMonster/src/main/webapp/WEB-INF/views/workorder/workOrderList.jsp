<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>슈몬 작업지시</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style type="text/css">
	.selected {
		background-color: #ccc;
	}
</style>

<script type="text/javascript">
	
	
	//========================= 함수, 상수 ==================================//
	
	//오늘 날짜 yyyy-mm-dd
	function getToday() {
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		
		return year + "-" + month + "-" + day;
	} //getToday()
	
	//input으로 바꾸기 
	function inputCng(obj, type, name, value) {
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
		obj.html(inputBox);
	} //inputCng
	
	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";
	
	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/workorder/search?type="+search+"&input="+inputId;
		var popup = window.open(url, "", popupOpt);
		
		popup.onload = function() {
			popup.postMessage({inputId:inputId}, '*');
		};
	} //openWindow()
	
	//이벤트리스너 - 팝업 호출하는 input 아이디 저장
// 	window.addEventListener('message', function(event){
// 		var data = event.data;
// 		var inputId = data.inputId;
// 		var value = data.value;
		
// 		$('#'+inputId).val(value);
// 	});
	
	
	
	// 팝업으로 열었을 때
	function popUp() {
		var queryString = window.location.search;
		var urlParams = new URLSearchParams(queryString);
		
		var isPop = urlParams.get("input");
		
			
		$('#pagination a').each(function(){
			
	   		var prHref = $(this).attr("href");
	   			
   			var newHref = prHref + "&input=" + isPop;
   			$(this).attr("href", newHref);
				
		}); //페이징 요소	
				
   			
    	if(isPop) {
// 	       	alert(event);
        	
        	$('#add').hide();
        	$('#modify').hide();
        	$('#delete').hide();
        	$('#save').hide();
        	
       		$('table tr:not(:first-child)').click(function(){
       			$(this).css('background', '#ccc');
        			
        		var workCode = $(this).find('#workCode').text();
        			
        		$('#'+isPop, opener.document).val(workCode);
        			
        		window.close();
        	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
        		
         		
   		} else {
    		alert("팝업아님");
    	} //if(팝업으로 열었을 때)
    		
	} //popUp()
	
	
	
	
	var currentPage = 1;
	var pageSize = 3;
	
	function changePage(page) {
		currentPage = page;
		search();
	} //changePage()
	
	
	
	function renderPagination(pageInfo) {
		var totalPages = Math.ceil(pageInfo.totalCount / pageInfo.lwPageVO.pageSize);
		
		var pageHTML = "";
		
// 		if(pageInfo.prev) {
// 			pageHTML += "<a href='#' onclick='changePage(" + (pageInfo.startPage-1) + ")'" + ⏪ + "</a>";
// 		}
		
		for(var i=1; i<=totalPages; i++) {
			pageHTML += "<a href='#' onclick='changePage(" + i + ")'>" + i + "</a>";
		}
		
		$('#pagination').html(pageHTML);
		
	} //renderPagination()
	
	
	
	function search() {
		
		let searchList = {
				line_code:$('#search_line').val(),
				from_date:$('#search_fromDate').val(),
				to_date:$('#search_toDate').val(),
				work_state:$('#search_state:checked').val(),
				prod_code:$('#search_prod').val(),
				page:currentPage,
				pageSize:pageSize
		};
		
		
		$.ajax({
			url:"/workorder/search",
			type: "post",
			contentType: "application/json; charset=UTF-8",
			dataType: "json",
			data: JSON.stringify(searchList),
			success: function(data) {
			
				var map = data;
				var list = map[Object.keys(map)[0]];
				var pageInfo = map.pm;
				
// 				alert(list.length);
// 				alert(pageInfo.lwPageVO.pageSize);
			
				//data => List 객체
				if(list.length != 0) {
					//검색 결과 있을 때
					for(var i=0; i<list.length; i++) {
						console.log(list[i].work_code);
					
						//th 밑에 있던 줄 모두 제거하고 검색결과 append
						var tbl = "<tr>";
						tbl += " <td>" + (i+1) + "</td>";
						tbl += " <td id='workCode'>" + list[i].work_code + "</td>";
						tbl += " <td>" + list[i].line_code + "</td>";
						tbl += " <td>" + list[i].prod_code + "</td>";
						tbl += " <td>" + list[i].order_code + "</td>";
						tbl += " <td>" + list[i].work_state + "</td>";
						tbl += " <td>" + list[i].work_date + "</td>";
						tbl += " <td>" + list[i].work_qt + "</td>";
						tbl += "</tr>";
					
						if(i==0) {
							$('table tr:gt(0)').remove();
							$('table').append(tbl);
						} else {
							$('table').append(tbl);
						}
					
					} //for
					
					popUp();
					
						
				} else {
					//검색 결과 없을 때
					$('#body').html("검색 결과가 없습니다.");
				} //if(검색결과 있없)
				
				renderPagination(pageInfo);
				
			},
			error: function() {
				alert("조회 실패~~");
			}
		}); //ajax
	} //search()
	
	
	
	//========================= 함수, 상수 ==================================//
	
	
	
	$(function() {
		
		//테이블 항목들 인덱스 부여
		$('table tr').each(function(index){
			$(this).find('td:first').text(index);
		});

// 		let popVal;
		popUp();
		
		
		//============================ 버튼 구현 ====================================//
		
		/////////////// 추가 /////////////////////////////////////
		$('#add').click(function() {
			
			$('#modify').attr("disabled", true);
			$('#delete').attr("disabled", true);
			
			//작업지시코드 부여(임시로 그냥 1 증가로 해놓음)
			let wCodeNum = Number($('table tr:last').find('td:nth-child(2)').text().substring(2));
			wCodeNum++;
			
			let today = getToday();
			
			if($(this).hasClass('true')) {
				
				var tbl = "<tr>";
				// 번호
				tbl += " <td>"; 
				tbl += " </td>";
				// 작업지시코드
				tbl += " <td>";
				tbl += "  <input type='text' name='work_code' id='work_code' readonly value='";
				tbl += "WO" + wCodeNum;
				tbl += "'>";
				tbl += " </td>";
				// 라인코드
				tbl += " <td>";
				tbl += "  <input type='text' name='line_code' id='line_code' required>";
				tbl += " </td>";
				// 품번
				tbl += " <td>";
				tbl += "  <input type='text' name='prod_code' id='prod_code' required>";
				tbl += " </td>";
				// 수주코드
				tbl += " <td>";
				tbl += "  <input type='text' name='order_code' id='order_code' required>";
				tbl += " </td>";
				// 지시상태
				tbl += " <td>";
				tbl += "  <select name='work_state' id='work_state'>";
				tbl += "   <option>지시</option>";
				tbl += "   <option>진행</option>";
				tbl += "   <option>마감</option>";
				tbl += "  </select>"
				tbl += " </td>";
				// 지시일
				tbl += " <td>";
				tbl += "  <input type='text' name='work_date' id='work_date' readonly value='";
				tbl += today;
				tbl += "'>";
				tbl += " </td>";
				// 지시수량
				tbl += " <td>";
				tbl += "  <input type='text' name='work_qt' id='work_qt' required>";
				tbl += " </td>";
				tbl += "</tr>";
				
				$('table').append(tbl);
				
				//라인코드 검색
				$('#line_code').click(function(){
					openWindow("line", "line_code");
				}); //lineCode click
				
				//품번 검색 
				$('#prod_code').click(function(){
					openWindow("prod", "prod_code");
				}); //prodCode click
				
				//수주코드 검색
				$('#order_code').click(function(){
					openWindow("order", "order_code");
				}); //orderCode click
			
				$(this).removeClass('true');
			} //true 클래스 있을 때
			
			// 저장 -> form 제출하고 저장함
			$('#save').click(function(){
				
				var line_code = $('#line_code').val();
				var prod_code = $('#prod_code').val();
				var order_code = $('#order_code').val();
				var work_state = $('#work_state').val();
				var work_qt = $('#work_qt').val();
				
				if(line_code=="" || prod_code=="" || order_code=="" || work_state=="" || work_qt=="") {
					alert("항목을 모두 입력하세요");
				} else {
					$('#fr').attr("action", "/workorder/add");
					$('#fr').attr("method", "post");
					$('#fr').submit();
					
				}
				
				
			}); //save
			
			//취소버튼 -> 리셋
			$('#cancle').click(function(){
				$('#fr').each(function(){
					this.reset();
				});
			}); //cacle click
			
		}); //add click
		
		
		
		
		
		/////////////// 수정 //////////////////////////////
		//수정버튼 클릭
		$('#modify').click(function(){
			
			$('#add').attr("disabled", true);
			$('#delete').attr("disabled", true);
				
			//행 하나 클릭했을 때	
			$('table tr:not(:first-child)').one('click', function(){
				
				//하나씩만 선택 가능 - 하나 누르고 다른거 눌렀을 때 색 바뀜,,
				$('table tr.selected').removeClass('selected');
				$(this).addClass('selected');
				
				//작업지시 코드 저장
				let updateCode = $(this).find('#workCode').text().trim();
				console.log(updateCode);
				
				var jsonData = {work_code:updateCode};
				
				var self = $(this);
			
				$.ajax({
					url: "/workorder/detail",
					type: "post",
					contentType: "application/json; charset=UTF-8",
					dataType: "json",
					data: JSON.stringify(jsonData),
					success: function(data) {
// 						alert("*** 아작스 성공 ***");
						
						var preVOs = [
							data.work_code,
							data.line_code,
							data.prod_code,
							data.order_code,
							data.work_state,
							data.work_date,
							data.work_qt,
						];
						
						var names = [
							"work_code",
							"line_code",
							"prod_code",
							"order_code",
							"work_state",
							"work_date",
							"work_qt",
						];
						
						//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
						self.find('td').each(function(idx, item) {
							
							if(idx > 0) {
								inputCng($(this), "text", names[idx-1], preVOs[idx-1]);
								if(idx == 5) {
									var dropDown = "<select id='work_state' name='work_state'>";
									dropDown += "<option value='지시'>지시</option>";
									dropDown += "<option value='진행'>진행</option>";
									dropDown += "<option value='마감'>마감</option>";
									dropDown += "</select>";
									$(this).html(dropDown);
									$(this).find('option').each(function(){
										if(this.value == preVOs[idx-1]) {
											$(this).attr("selected", true);
										}
									}); //option이 work_state와 일치하면 선택된 상태로
								} //지시상태 - select
							} //라인코드부터 다 수정 가능하게
							
						}); // self.find(~~)
						
				
						//라인코드 검색
						$('#line_code').click(function(){
							openWindow("line", "line_code");
						}); //lineCode click
						
						//품번 검색 
						$('#prod_code').click(function(){
							openWindow("prod", "prod_code");
						}); //prodCode click
						
						//수주코드 검색
						$('#order_code').click(function(){
							openWindow("order", "order_code");
						}); //orderCode click
						
// 						self.removeClass('true');
						
					},
					error: function(data) {
						alert("아작스 실패 ~~");
					}
				}); //ajax
				
				
				//저장버튼 -> form 제출
				$('#save').click(function(){
					
					$('#fr').attr("action", "/workorder/modify");
					$('#fr').attr("method", "post");
					$('#fr').submit();
					
				}); //save
				
				//취소버튼 -> 리셋
				$('#cancle').click(function(){
					$('#fr').each(function(){
						this.reset();
					});
				}); //cancle click
				
				self.off('click');
				
			}); //tr click
			
		}); //modify click
		
		
		
		
		
		/////////////// 삭제 //////////////////////////////
		$('#delete').click(function(){
			
			$('#add').attr("disabled", true);
			$('#modify').attr("disabled", true);
			
			// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 작업 지시 코드 저장
			$('table tr').each(function(){
				var code = $(this).find('td:nth-child(2)').text();
				
				var tbl = "<input type='checkbox' name='selected' value='";
				tbl += code;
				tbl += "'>";
				
				$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
				$(this).find('td:first').html(tbl);
			});
			
			$('#selectAll').click(function() {
				var checkAll = $(this).is(":checked");
				
				if(checkAll) {
					$('input:checkbox').prop('checked', true);
				} else {
					$('input:checkbox').prop('checked', false);
				}
			});
			
			
			//저장 -> 삭제
			$('#save').click(function() {
				
				var checked = [];
				
				$('input[name=selected]:checked').each(function(){
					checked.push($(this).val());
				});
				
// 				alert(checked);
				
				if(checked.length > 0) {
					
					$.ajax({
						url: "/workorder/delete",
						type: "post",
						data: {checked:checked},
						dataType: "text",
						success: function() {
							alert("*** 아작스 성공 ***");
							location.reload();
						},
						error: function() {
							alert("아작스실패~~");
						}
					}); //ajax
					
				} //체크된거 있을대
				else {
					alert("선택된 글이 없습니다.");
				} //체크된거 없을때
				
			}); //save
			
			//취소 -> 리셋
			$('#cancle').click(function(){
				$('input:checkbox').prop('checked', false);
			});
			
		}); //delete click
		
		
		//============================ 버튼 구현 ====================================//
		
		
		
		
		//============================ 검색 =========================================//
		
		
		
		//라인코드 검색 팝업
		$('#search_line').click(function(){
			openWindow("line", "search_line");
		}); //lineCode click
		
		//품번 검색 팝업
		$('#search_prod').click(function(){
			openWindow("prod", "search_prod");
		}); //prodCode click
		
		//지시일자 이날부터
		$('#search_fromDate').datepicker({
			showOn:'both',
			buttonImage:'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
			buttonImageOnly:'true',
			changeMonth:'true',
			changeYear:'true',
			nextText:'다음달',
			prevText:'이전달',
			showButtonPanel:'true',
			currentText:'오늘',
			closeText:'닫기',
			dateFormat:'yy-mm-dd',
			dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
// 			minDate:,
// 			maxDate:+30,
			onSelect: function(date, inst) {
				$('#search_toDate').datepicker('option', 'minDate', $(this).datepicker('getDate'));
			}
		});
		//이날까지
		$('#search_toDate').datepicker({
			showOn:'both',
			buttonImage:'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
			buttonImageOnly:'true',
			changeMonth:'true',
			changeYear:'true',
			nextText:'다음달',
			prevText:'이전달',
			showButtonPanel:'true',
			currentText:'오늘',
			closeText:'닫기',
			dateFormat:'yy-mm-dd',
			dayNames:['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
// 			maxDate:+30
		});
		
		
		
		
		
		
		
		
		
		
		
		//조회버튼
		$('#search').click(function(){
			
			$('#add').attr("disabled", true);
			
			search();
			
			
		}); //search click
		
		
		//============================ 검색 =========================================//
		
		
		
	}) //jQuery
	
</script>

</head>
<body>
	<h1> /workorder/workOrderList.jsp </h1>
	
	<div>
		<fieldset>
			라인코드: <input type="text" name="search_line" id="search_line"> 
			지시일자: <input type="text" name="search_fromDate" id="search_fromDate"> ~ 
					  <input type="text" name="search_toDate" id="search_toDate"> 
			<br>
			지시상태: <input type="radio" name="search_state" id="search_state" value="지시"> 지시 
					  <input type="radio" name="search_state" id="search_state" value="진행"> 진행 
					  <input type="radio" name="search_state" id="search_state" value="마감"> 마감 
					  <input type="radio" name="search_state" id="search_state" value="전체"> 전체 
			품번: <input type="text" name="search_prod" id="search_prod">
			<br>
			<button id="search">조회</button> 
		</fieldset>
	</div>
	
	<br><br><br>
	
	<button id="add" class="true">추가</button>
	<button id="modify">수정</button>
	<button id="delete">삭제</button>
	<button type="reset" id="cancle">취소</button>
	<button type="submit" id="save">저장</button>
	
	<div id="body">
		<form id="fr">
			<table border="1">
				<tr>
					<th>번호</th>
					<th>작업지시코드</th>
					<th>라인코드</th>
					<th>품번</th>
					<th>수주코드</th>
					<th>지시상태</th>
					<th>지시일</th>
					<th>지시수량</th>
				</tr>
				<c:forEach var="w" items="${workList }">
					<tr>
						<td></td>
						<td id="workCode">${w.work_code }</td>
						<td>${w.line_code }</td>
						<td>${w.prod_code }</td>
						<td>${w.order_code }</td>
						<td>${w.work_state }</td>
						<td>${w.work_date }</td>
						<td>${w.work_qt }</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	</div>
	
	
	<div id="pagination">
		<c:if test="${pm.prev }">
			<a href="/workorder/workOrderList?page=${pm.startPage - 1 }"> ⏪ </a>
		</c:if>
		
		<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }" step="1">
			<a href="/workorder/workOrderList?page=${page }">${page }</a>
		</c:forEach>
		
		<c:if test="${pm.next }">
			<a href="/workorder/workOrderList?page=${pm.endPage + 1 }"> ⏩ </a>
		</c:if>
	</div>
	
	<div id="details">
	
	</div>
	
</body>
</html>