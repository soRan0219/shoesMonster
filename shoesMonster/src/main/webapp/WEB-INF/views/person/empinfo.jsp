<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ include file="../include/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

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

.selected {
	background-color: #ccc;
}
</style>
<!-- 폰트 -->

<script type="text/javascript">

// 팝업 창 조절
function popupEmp(data) {
	var cw = screen.availWidth;
	var ch = screen.availHeight;
	var emp_id = data;
	
	sw = 1024;
	sh = 768;
	
	mw = (cw-sw) / 2;
	mh = (ch-sh) / 2;
	
	window.open('/person/empform?emp_id=' + emp_id, 'popup', 'width=' + sw +
		', height=' + sh + ',left=' + mw + ',top='+ mh +
		',toolbar=no, location=no, directories=no, status=no, menubar=no, resizable=no, scrollbars=no, copyhistory=no');
}


//날짜 + 시간 + 분 + 초 ==> 코드
var count = 0;
function codeCreation() {
	Date.prototype.getYearYY = function(){
		 var a = this.getYear();
		 return a >= 100 ? a-100 : a;
		}
    var date = new Date();
    var YY_year = date.getYearYY();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);
    var second = ("0" + date.getSeconds()).slice(-2);
    
    var code = YY_year + month + day;
    
	count++;
    return code;
}

function codeSecond() {
	
	var date = new Date();
	var second = ("0" + date.getSeconds()).slice(-2);
	
	var scode = second
	
	return scode;
}

//input으로 바꾸기 
function inputCng(obj, type, name, value) {
	var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
	obj.html(inputBox);
} //inputCng


// 혦넣
//팝업으로 열었을 때
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
			
	if(isPop) {
    	
    	$('#addEmp').hide();
    	$('#modifyEmp').hide();
    	$('#deleteEmp').hide();
    	$('#saveEmp').hide();
    	$('#cancleEmp').hide();
    	
   		$('table tr:not(:first-child)').click(function(){
   			
   			$(this).css('background', '#ccc');
    			
    		var empCode = $(this).find('#empCode').text();
    		var empName = $(this).find('#empName').text(); // 230702 넣 지울거면 주석지워도됨! 혹시나!
    			
    		$('#emp_id', opener.document).val(empCode);
    		$('#emp_name', opener.document).val(empName); // 230702 넣 지울거면 주석지워도됨!
    		
    		$('#s_emp_id', opener.document).val(empCode);
    		$('#s_emp_name', opener.document).val(empName);
    		
    		window.close();
    	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
    		
		} else {
			console.log("팝업아님");
	} //if(팝업으로 열었을 때)
		
} //popUp() 여기까지 혦넣

 


//제이쿼리
$(function() {
	
	// ============== 버튼 ==============
	
	//테이블 항목들 인덱스 부여
	$('table tr').each(function(index){
			var num = "<c:out value='${pvo.page}'/>";
			var num2 = "<c:out value='${pvo.pageSize}'/>";
			$(this).find('td:first').text(((num-1)*num2) + index);
	});
	
	// 혦넣
	popUp();
      	

	// ------------ 추가 ------------
	$('#addEmp').click(function() {
		$('#modifyEmp').attr("disabled", true);
		$('#deleteEmp').attr("disabled", true);
		
		if ($(this).hasClass('true')) {
			
			var tbl = "<tr>";
			// 번호
			tbl += " <td>";
			tbl += " </td>";
			// 사원번호
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_id' id='emp_id' readonly class='input-fielda'>";
			tbl += " </td>";
			// 비밀번호
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_pw' id='emp_pw' required class='input-fielda'>";
			tbl += " </td>";
			// 사원명
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_name' id='emp_name' required class='input-fielda'>";
			tbl += " </td>";
			// 부서
			tbl += " <td>";
			tbl += "  <select name='emp_department' id='emp_department' class='input-fielda'>";
			tbl += "   <option value='부서'>부서</option>";
			tbl += "   <option value='영업팀'>영업팀</option>";
			tbl += "   <option value='생산팀'>생산팀</option>";
			tbl += "   <option value='인사팀'>인사팀</option>";
			tbl += "   <option value='자재팀'>자재팀</option>";
			tbl += "   <option value='물류팀'>물류팀</option>";
			tbl += "  </select>"
			tbl += " </td>";
			// 직책
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_position' id='emp_position' required class='input-fielda'>";
			tbl += " </td>";
			// 이메일
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_email' id='emp_email' required class='input-fielda'>";
			tbl += " </td>";
			// 전화번호
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_phone' id='emp_phone' required class='input-fielda'>";
			tbl += " </td>";
			// 입사일자
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_hiredate' id='emp_hiredate' required class='input-fielda'>";
			tbl += " </td>";
			// 재직구분
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_work' id='emp_work' required class='input-fielda'>";
			tbl += " </td>";
			tbl += "</tr>";

			$('table').append(tbl);

			$("#emp_department").on("change", function(){
	            if($("#emp_department option:selected").val() === '영업팀' ){
	                $('input[name="emp_id"]').val(codeCreation()+1+codeSecond());
	                $('input[name="emp_work"]').val('재직'); // 추가함
	            } else if($("#emp_department option:selected").val() === '생산팀' ){
	                $('input[name="emp_id"]').val(codeCreation()+2+codeSecond());
	                $('input[name="emp_work"]').val('재직'); // 추가함
	            } else if($("#emp_department option:selected").val() === '인사팀' ){
	                $('input[name="emp_id"]').val(codeCreation()+3+codeSecond());
	                $('input[name="emp_work"]').val('재직'); // 추가함
	            } else if($("#emp_department option:selected").val() === '자재팀' ){
	                $('input[name="emp_id"]').val(codeCreation()+4+codeSecond());
	                $('input[name="emp_work"]').val('재직'); // 추가함
	            } else if($("#emp_department option:selected").val() === '물류팀' ){
	                $('input[name="emp_id"]').val(codeCreation()+5+codeSecond());
	                $('input[name="emp_work"]').val('재직'); // 추가함
	            }
	        });
			
			//입사일자 달력
			$('#emp_hiredate').datepicker({
// 				showOn:'both',
// 				buttonImage:'http://jqueryui.com/resources/demos/datepicker/images/calendar.gif',
// 				buttonImageOnly:'true',
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
			});
			
			$(this).removeClass('true');
		} //true 클래스 있을 때
		
		// 저장 -> form 제출하고 저장함
		$('#saveEmp').click(function() {
// 			alert('저장버튼 누름');
			
			var emp_id = $('#emp_id').val();
			var emp_pw = $('#emp_pw').val();
			var emp_name = $('#emp_name').val();
			var emp_department = $('#emp_department').val();
			var emp_position = $('#emp_position').val();
			var emp_email = $('#emp_email').val();
			var emp_phone = $('#emp_phone').val();
			var emp_hiredate = $('#emp_hiredate').val();
			var emp_work = $('#emp_work').val();
			
			if (emp_pw == "" || emp_name == "" || emp_department == "" || emp_position == "" || emp_email == "" || emp_phone == "" || emp_hiredate == "" || emp_work == "") {
			Swal.fire({
					title: "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
					icon: 'info',
					width: '300px',
				})
			} else {
				$('#fr').attr("action", "/person/addEmp");
				$('#fr').attr("method", "post");
				$('#fr').submit();
			}
		}); //save
		
		//취소버튼 -> 리셋
		$('#cancleEmp').click(function() {
			$('#fr').each(function() {
				this.reset();
			});
		}); //cacle click
	}); //add click

	
	var isExecuted = false	
	// ------------- 수정 ------------------
	$('#modifyEmp').click(function() {
		$('#addEmp').attr("disabled", true);
		$('#deleteEmp').attr("disabled", true);

		//행 하나 클릭했을 때	
		$('table tr:not(:first-child)').click(function() {

			//하나씩만 선택 가능
			if(!isExecuted) {
				isExecuted = true;
				
				$(this).addClass('selected');
				//사원 아이디 저장
				let updateCode = $(this).find('#empid').text().trim();
				console.log(updateCode);
				
				var jsonData = {
					emp_id : updateCode
				};
				
				var self = $(this);
				
				var names = [
						"emp_id",
						"emp_pw",
						"emp_name",
						"emp_department",
						"emp_position",
						"emp_email",
						"emp_phone",
						"emp_hiredate",
						"emp_work" ];
				
				//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
				self.find('td').each(function(idx,item) {
					if (idx > 0) {
						inputCng($(this),"text",names[idx - 1], $(this).text());
						if (idx == 4) {
							var dropDown = "<select id='emp_department' name='emp_department'>";
							dropDown += "<option value='전체'>전체</option>";
							dropDown += "<option value='영업팀'>영업팀</option>";
							dropDown += "<option value='생산팀'>생산팀</option>";
							dropDown += "<option value='인사팀'>인사팀</option>";
							dropDown += "<option value='자재팀'>자재팀</option>";
							dropDown += "<option value='물류팀'>물류팀</option>";
							dropDown += "</select>";
							$(this).html(dropDown);
							$(this).find('option').each(function() {
								if (this.value == $(this).text()) {
									$(this).attr("selected",true);
								}
							}); //option이 emp_department와 일치하면 선택된 상태로
						} //사원부서 - select
					} //사원 아이디부터 다 수정 가능하게
				}); // self.find(~~)
				

				//저장버튼 -> form 제출
				$('#saveEmp').click(function() {

					$('#fr').attr("action","/person/modifyEmp");
					$('#fr').attr("method","post");
					$('#fr').submit();
				}); //save
			} //하나씩만 선택 가능
				
			//취소버튼 -> 리셋
			$('#cancleEmp').click(function() {
				$('#fr').each(function() {
					this.reset();
				});
			}); //cancle click
		}); //tr click
	}); //modify click
	
	
	// --------------- 삭제 -----------------------
		$('#deleteEmp').click(function() {

			$('#addEmp').attr("disabled", true);
			$('#modifyEmp').attr("disabled", true);

			if($(this).hasClass('true')) {
			
				// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 사원 코드 저장
				$('table tr').each(function() {
					var code = $(this).find('td:nth-child(2)').text();
	
					var tbl = "<input type='checkbox' name='selected' value='";
					tbl += code;
					tbl += "'>";
					
					$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
					$(this).find('td:first').html(tbl);
				});
			
				//전체선택
				$('#selectAll').click(function() {
					var checkAll = $(this).is(":checked");
		
					if (checkAll) {
						$('input:checkbox').prop('checked', true);
					} else {
						$('input:checkbox').prop('checked', false);
					}
				});

				// 저장 -> 삭제
				$('#saveEmp').click(function() {
					var checked = [];
		
					$('input[name=selected]:checked').each(function() {
						console.log("check => " + $(this).val());
						checked.push($(this).val());
					});
					
// 					if(confirm("총 " + checked.length + "행 선택\n정말 삭제하시겠습니까?")) {
		
						if (checked.length > 0) {
			
							Swal.fire({
								  title: "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
										  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
								  icon: 'info', // 아이콘! 느낌표 색? 표시?
								  showDenyButton: true,
								  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
								  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
								  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//		 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
								  width : '300px', // alert창 크기 조절
								  
								}).then((result) => {
							
							 /* confirm => 예 눌렀을 때  */
							  if (result.isConfirmed) {
							
							$.ajax({
								url : "/person/deleteEmp",
								type : "post",
								data : {checked : checked},
								dataType : "text",
								success : function() {
									Swal.fire({
										  title: "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
										  icon: 'success',
										  width : '300px',
										}).then((result) => {
										  if (result.isConfirmed) {
										    location.reload();
										  }
										});
								},
								error : function() {
									Swal.fire({
										title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
										icon : 'question',
										width: '300px',
										});
								}
							}); //ajax
							  } else if (result.isDenied) {
									Swal.fire({
									title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
									icon : 'error',
									width: '300px',
									});
						}// if(confirm)
					});	
						} //체크된거 있을대
						else {
							Swal.fire({
								title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
								icon : 'warning',
								width: '300px',
								});
						} //체크된거 없을때
					
				}); //save
				
				$(this).removeClass('true');
			} //if(삭제 버튼 true class 있으면)

			//취소 -> 리셋
			$('#cancleEmp').click(function() {
				$('input:checkbox').prop('checked', false);
			});
		}); //delete click
		
		
	
}); //jquery
</script>
<style>

#titlebg {
	background: #2A3F54;
	color: white;
}

.table-wrapper {
    overflow-x: auto; /* 테이블 직접 조절 */
    overflow-y: hidden;
}
.table-wrapper table {
    width: 100%; /* 테이블 직접 조절 */
    white-space: nowrap; 
    text-align: center;
}

.input-fielda {
    width: 100px; /* 원하는 입력란의 너비로 설정 */
}
.input-fieldb {
    width: 125px; /* 원하는 입력란의 너비로 설정 */
}
.input-fieldc {
    width: 150px; /* 원하는 입력란의 너비로 설정 */
}

</style>

<%-- ${sessionScope.id.emp_department } --%>

<!-- page content -->
<div class="right_col" role="main">

	<h1 style="margin-left: 1%;">사원 관리</h1>
	
		<div style="margin-left: 1%;">
			<form id="searchForm" method="get">
	       		<input type="hidden" name="input" id="input" value="${input }">
	       		<input type="hidden" name="pageSize" id="pageSize" value="${pm.clientPageVO.pageSize }">
	       		사원번호
	        	<input type="text" name="search_emp_id" id="search_emp_id">
	        	사원명
	        	<input type="text" name="search_emp_name" id="search_emp_name">
	        	부서
	       		<select name="search_emp_department">           
					<option selected value="전체">전체</option>    
				    <option value="영업팀">영업팀</option>    
				    <option value="생산팀">생산팀</option>
				    <option value="인사팀">인사팀</option>
				    <option value="자재팀">자재팀</option>
				    <option value="물류팀">물류팀</option>
				</select>
				<input type="submit" class="B B-info" value="조회"> 
			</form>
		</div>
		
		<div class="col-md-12 col-sm-12 ">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						사원 관리 <small> 총 ${pm.totalCount } 명 </small>
					</h2>
					
					<div style="float: left;  margin-top: 1.5px;">
						<c:if test="${empty param.input }">
							<button onclick="location.href='/person/empinfo'" class="B2 B2-info">↻</button>
						</c:if>
						<c:if test="${!empty param.input }">
							<button onclick="location.href='/person/empinfo?input=${param.input }'" class="B2 B2-info">↻</button>
						</c:if>
					</div>
					
					<div  class="nav navbar-right panel_toolbox">
						<button id="addEmp" class="true B B-info">추가</button>
						<!-- <button id="modifyEmp">수정</button> -->
						<button id="deleteEmp" class="true B B-info">삭제</button>
						<button type="reset" id="cancleEmp" class="B B-info">취소</button>
						<button type="submit" id="saveEmp" class="B B-info">저장</button>
					</div>
				
					<!-- 버튼 제어 -->
					<script>
						//권한 설정
						var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
						
						if (team === "인사팀" || team === "관리자") {
						    document.getElementById("addEmp").disabled = false;
						    // document.getElementById("modifyEmp").disabled = false;
						    document.getElementById("deleteEmp").disabled = false;
						    document.getElementById("cancleEmp").disabled = false;
						    document.getElementById("saveEmp").disabled = false;
						    document.querySelector("[onclick^='location.href']").disabled = false;
						} else {
						    document.getElementById("addEmp").hidden = true;
						    // document.getElementById("modifyEmp").hidden = true;
						    document.getElementById("deleteEmp").hidden = true;
						    document.getElementById("cancleEmp").hidden = true;
						    document.getElementById("saveEmp").hidden = true;
						    document.querySelector("[onclick^='location.href']").hidden = true;
						}
					</script>
					<!-- 버튼 제어 -->
				
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<div class="table-responsive">
						<div class="table-wrapper" >
							<form id = "fr">
								<table class="table table-striped jambo_table bulk_action" style="text-align:center">
									<thead>
										<tr class="headings">
											<th></th>
											<th>사원번호</th>
											<th>비밀번호</th>
											<th>사원명</th>
											<th>부서</th>
											<th>직책</th>
											<th>이메일</th>
											<th>전화번호</th>
											<th>입사일자</th>
											<th>재직구분</th>
											<th></th>
										</tr>
									</thead>
									<c:forEach var="vo" items="${empList }">
										<c:if test="${vo.emp_department == '전체' || vo.emp_department == '영업팀' || vo.emp_department == '생산팀' || vo.emp_department == '인사팀' || vo.emp_department == '자재팀' || vo.emp_department == '물류팀'}">
											<tr>
												<td></td>
												<td id="empCode">${vo.emp_id}</td> <!-- 혦넣 -->
												<td>${vo.emp_pw}</td> 
												<td id="empName">${vo.emp_name}</td> <!-- 혦넣 -->
												<td>${vo.emp_department}</td>
												<td>${vo.emp_position}</td>
												<td>${vo.emp_email}</td>
												<td>${vo.emp_phone}</td>
												<td>${vo.emp_hiredate}</td>
												<td>${vo.emp_work}</td>
												<td>
													<input type="button" class="B B-info" value="상세보기" onclick="popupEmp(${vo.emp_id})"/>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 페이징 -->
		<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
			<ul class="pagination">
				<li class="paginate_button previous disabled">
					<c:if test="${pm.prev }">
						<a href="/person/empinfo?page=${pm.startPage - 1 }&search_emp_id=${search.search_emp_id}&search_emp_name=${search.search_emp_name}&search_emp_department=${search.search_emp_department}"> Previous </a>
					</c:if>
				</li>
				<li>
					<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }"	step="1">
						<a href="/person/empinfo?page=${page }&search_emp_id=${search.search_emp_id}&search_emp_name=${search.search_emp_name}&search_emp_department=${search.search_emp_department}">${page }</a>
					</c:forEach>
				</li>
				<li>
					<c:if test="${pm.next }">
						<a href="/person/empinfo?page=${pm.endPage + 1 }&search_emp_id=${search.search_emp_id}&search_emp_name=${search.search_emp_name}&search_emp_department=${search.search_emp_department}"> Next </a>
					</c:if>
				</li>
			</ul>
		</div> 
		<!-- 페이징 -->
		
	<!-- 상세보기 모달창 -->
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">사원 상세</h4>
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 상세보기 모달창 -->
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

