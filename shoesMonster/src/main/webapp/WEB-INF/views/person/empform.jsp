<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script type="text/javascript">


//제이쿼리
$(function() {
	
	
	// ============== 버튼 ==============
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
			tbl += "  <input type='text' name='emp_id' id='emp_id' readonly>";
			tbl += " </td>";
			// 비밀번호
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_pw' id='emp_pw' required>";
			tbl += " </td>";
			// 사원명
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_name' id='emp_name' required>";
			tbl += " </td>";
			// 부서
			tbl += " <td>";
			tbl += "  <select name='emp_department' id='emp_department'>";
			tbl += "   <option value='부서'>부서</option>";
			tbl += "   <option value='영업팀'>영업팀</option>";
			tbl += "   <option value='생산팀'>생산팀</option>";
			tbl += "   <option value='인사팀'>인사팀</option>";
			tbl += "  </select>"
			tbl += " </td>";
			// 직책
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_position' id='emp_position' required>";
			tbl += " </td>";
			// 이메일
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_email' id='emp_email' required>";
			tbl += " </td>";
			// 전화번호
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_phone' id='emp_phone' required>";
			tbl += " </td>";
			// 입사일자
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_hiredate' id='emp_hiredate' required>";
			tbl += " </td>";
			// 재직구분
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_work' id='emp_work' required>";
			tbl += " </td>";
			tbl += "</tr>";

			$('table').append(tbl);

			$("#emp_department").on("change", function(){
	            if($("#emp_department option:selected").val() === '영업팀' ){
	                $('input[name="emp_id"]').val(codeCreation());
	                $('input[name="emp_work"]').val('재직'); // 추가함
	            } else if($("#emp_department option:selected").val() === '생산팀' ){
	                $('input[name="emp_id"]').val(codeCreation());
	                $('input[name="emp_work"]').val('재직'); // 추가함
	            } else if($("#emp_department option:selected").val() === '인사팀' ){
	                $('input[name="emp_id"]').val(codeCreation());
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
			alert('저장버튼 누름');
			
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
				alert("항목을 모두 입력하세요");
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
				
// 				$.ajax({
// 					url : "/workorder/detail",
// 					type : "post",
// 					contentType : "application/json; charset=UTF-8",
// 					dataType : "json",
// 					data : JSON.stringify(jsonData),
// 					success : function(data) {
// 						// alert("*** 아작스 성공 ***");

// 						var preVOs = [
// 								data.work_code,
// 								data.line_code,
// 								data.order_code,
// 								data.prod_code,
// 								data.work_state,
// 								data.work_date,
// 								data.work_qt
// 							];
				
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
						inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
						if (idx == 3) {
							var dropDown = "<select id='emp_department' name='emp_department'>";
							dropDown += "<option value='전체'>전체</option>";
							dropDown += "<option value='영업팀'>영업팀</option>";
							dropDown += "<option value='생산팀'>생산팀</option>";
							dropDown += "<option value='인사팀'>인사팀</option>";
							dropDown += "</select>";
							$(this).html(dropDown);
							$(this).find('option').each(function() {
								if (this.value == $(this).text()) {
									$(this).attr("selected",true);
								}
							}); //option이 emp_department와 일치하면 선택된 상태로
						} //사원부서 - select
						
						//지시수량 제외하고 readonly 속성 부여
						$(this).find("input").each(function(){
							if($(this).attr("name") != "emp_work") {
								$(this).attr("readonly", true);
							}
						}); //readonly
						
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
			
				// td 요소 중 첫번째 열 체크박스로 바꾸고 해당 행의 거래처코드 저장
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
						checked.push($(this).val());
					});
		
					if (checked.length > 0) {
		
						$.ajax({
							url : "/person/deleteEmp",
							type : "post",
							data : {checked : checked},
							dataType : "text",
							success : function() {
								alert("삭제 완료");
								location.reload();
							},
							error : function() {
								alert("삭제 실패");
							}
						}); //ajax
					} //체크된거 있을대
					else {
						alert("선택된 항목이 없습니다.");
					} //체크된거 없을때
				}); //save
				
				$(this).removeClass('true');
			} //if(삭제 버튼 true class 있으면)

			//취소 -> 리셋
			$('#cancelEmp').click(function() {
				$('input:checkbox').prop('checked', false);
			});
		}); //delete click
	
	}); //jquery

</script>


<!-- page content -->
<div class="right_col" role="main">
	<div style="margin: 5% 12% 0% 12%;">
		<div style="text-align-last: right;">
			<button id="addEmp" class="true">추가</button>
			<button id="modifyEmp">수정</button>
			<button id="deleteEmp" class="true">삭제</button>
			<button type="reset" id="cancelEmp">취소</button>
			<button type="submit" id="saveEmp">저장</button>
			<button onclick="location.href='/person/empform?emp_id=${emp_id}'">새로고침</button>
		</div>
		<div>
			<h1>상세보기</h1>
			<form id = "fr">
				<table border="1" style="width: 100%">
					<tr>
						<th>사원번호</th>
						<th>비밀번호</th>
						<th>이름</th>
						<th>부서</th>
						<th>직책</th>
						<th>이메일</th>
					</tr>
					<tr>
						<td>${vo.emp_id}</td>
						<td>${vo.emp_pw}</td>
						<td>${vo.emp_name}</td>
						<td>${vo.emp_department}</td>
						<td>${vo.emp_position}</td>
						<td>${vo.emp_email}</td>
					</tr>
					<tr>
						<th>입사일자</th>
						<th>재직구분</th>
						<th>내선번호</th>
						<th>연락처</th>
						<th>생년월일</th>
						<th>성별</th>
					</tr>
					<tr>
						<td>${vo.emp_hiredate}</td>
						<td>${vo.emp_work}</td>
						<td>${vo.emp_tel}</td>
						<td>${vo.emp_phone}</td>
						<td>${vo.emp_birth}</td>
						<td>${vo.emp_gender}</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

