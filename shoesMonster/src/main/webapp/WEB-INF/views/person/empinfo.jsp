<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style type="text/css">
.selected {
	background-color: #ccc;
}
</style>

<script type="text/javascript">
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
    	
    	$('#empAdd').hide();
    	$('#empModify').hide();
    	$('#empDelete').hide();
    	$('#empSave').hide();
    	
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
	
	// 혦넣
	popUp();
	
	//테이블 항목들 인덱스 부여
	$('table tr').each(function(index) {
		$(this).find('td:first').text(index);
	});
	
	//날짜 + 시간 + 분 + 초 ==> 코드
    function codeCreation() {
    	Date.prototype.getYearYY = function(){
    		 var a = this.getYear();
    		 return a >= 100 ? a-100 : a;
   		}
        var date = new Date();
        var YY_year = date.getYearYY();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);
        var time = ("0" + date.getHours()).slice(-2);
        var minute = ("0" + date.getMinutes()).slice(-2);
        var second = ("0" + date.getSeconds()).slice(-2);

        return YY_year + month + minute + second;
    }

	//추가 버튼
	$('#empAdd').click(function() {
		$('#empModify').attr("disabled", true);
		$('#empDelete').attr("disabled", true);
		
		if ($(this).hasClass('true')) {
			
			var tbl = "<tr>";
			// 번호
			tbl += " <td>";
			tbl += " </td>";
			// 사원번호
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_id' id='emp_id' readonly>";
			tbl += " </td>";
			// 사원명
			tbl += " <td>";
			tbl += "  <input type='text' name='emp_name' id='emp_name' required>";
			tbl += " </td>";
			// 부서
			tbl += " <td>";
			tbl += "  <select name='emp_department' id='emp_department'>";
			tbl += "   <option>부서</option>";
			tbl += "   <option>영업팀</option>";
			tbl += "   <option>생산팀</option>";
			tbl += "   <option>인사팀</option>";
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
	                $('input[name="emp_id"]').val('SA'+codeCreation());
	            } else if($("#emp_department option:selected").val() === '생산팀' ){
	                $('input[name="emp_id"]').val('PD'+codeCreation());
	            } else if($("#emp_department option:selected").val() === '인사팀' ){
	                $('input[name="emp_id"]').val('HR'+codeCreation());
	            }
	        });
			
			$(this).removeClass('true');
		} //true 클래스 있을 때
		
		// 저장 -> form 제출하고 저장함
		$('#empSave').click(function() {
			
			var emp_name = $('#emp_name').val();
			var emp_department = $('#emp_department').val();
			var emp_position = $('#emp_position').val();
			var emp_email = $('#emp_email').val();
			var emp_phone = $('#emp_phone').val();
			var emp_hiredate = $('#emp_hiredate').val();
			var emp_work = $('#emp_work').val();

			if (emp_name == "" || emp_department == "" || emp_position == "" || emp_email == "" || emp_phone == "" || emp_emp_work == "" || emp_emp_work == "") {
				alert("항목을 모두 입력하세요");
			} else {
				$('#fr').attr("action", "/person/empAdd");
				$('#fr').attr("method", "post");
				$('#fr').submit();
			}
		}); //save
		
		//취소버튼 -> 리셋
		$('#empCancle').click(function() {
			$('#fr').each(function() {
				this.reset();
			});
		}); //cacle click
	}); //add click
	
	//수정
	var isExecuted = false	
	
	$('#empModify').click(function() {

		$('#empAdd').attr("disabled", true);
		$('#empDelete').attr("disabled", true);

		//행 하나 클릭했을 때	
		$('table tr:not(:first-child)').click(function() {

			//하나씩만 선택 가능
			if(!isExecuted) {
				isExecuted = true;
				
				$(this).addClass('selected');
				//사원 아이디 저장
				let updateCode = $(this).find('#empId').text().trim();
				console.log(updateCode);
				
				var jsonData = {
						eno_id : updateCode
					};
				
				var self = $(this);
				
				var names = [
						"emp_id",
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
					} //사원 아이디부터 다 수정 가능하게
				}); // self.find(~~)

				//저장버튼 -> form 제출
				$('#empSave').click(function() {

					$('#fr').attr("action","/person/empModify");
					$('#fr').attr("method","post");
					$('#fr').submit();
				}); //save
			} //하나씩만 선택 가능
				
			//취소버튼 -> 리셋
			$('#empCancle').click(function() {
				$('#fr').each(function() {
					this.reset();
				});
			}); //cancle click
		}); //tr click
	}); //modify click
	
	//삭제
	$('#empDelete').click(function() {

		$('#empAdd').attr("disabled", true);
		$('#empModify').attr("disabled", true);

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
			$('#empSave').click(function() {
	
				var checked = [];
	
				$('input[name=selected]:checked').each(function() {
					checked.push($(this).val());
				});
	
				if (checked.length > 0) {
	
					$.ajax({
						url : "/person/empDelete",
						type : "post",
						data : {checked : checked},
						dataType : "text",
						success : function() {
							alert("*** 아작스 성공 ***");
							location.reload();
						},
						error : function() {
							alert("아작스실패~~");
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
		$('#cancel').click(function() {
			$('input:checkbox').prop('checked', false);
		});
	}); //delete click

}); //jquery
</script>

<!-- page content -->
<div class="right_col" role="main">
	<div style="margin: 5% 0% 0% 12%; width: 88%;">
		<h1>사원 관리</h1>
		<form id="searchForm" method="get">
       		<input type="hidden" name="input" id="input" value="${input }">
       		<input type="hidden" name="pageSize" id="pageSize" value="${pm.clientPageVO.pageSize }">
       		사원번호
        	<input type="text" name="search_empid" id="search_empid">
        	사원명
        	<input type="text" name="search_empname" id="search_empname">
        	부서
       		<select name="search_empdepartment">           
				<option selected value="전체">전체</option>    
			    <option value="영업팀">영업팀</option>    
			    <option value="생산팀">생산팀</option>
			    <option value="인사팀">인사팀</option>
			</select>
			<input type="submit" value="조회"> 
		</form>
	</div>
	
	<div style="margin: 5% 12% 0% 12%;">
		<div style="text-align-last: right;">
			총 ${pm.totalCount } 건
			<input type="button" value="추가" id="empAdd" class="true">
			<input type="button" value="수정" id="empModify">
			<input type="button" value="삭제" id="empDelete" class="true">
			<input type="button" value="취소" id="empCancel">
			<input type="button" value="저장" id="empSave">
		</div>
		<div>
			<h6>사원</h6>
			<form id = "fr">
				<table border="1" id="employeesTable" style="width: 100%">
				<colgroup>
				    <col style="width: 25px">
				    <col style="width: 100px">
				    <col style="width: 75px">
				    <col style="width: 50px">
				    <col style="width: 50px">
				    <col style="width: 150px">
				    <col style="width: 150px">
				    <col style="width: 100px">
				    <col style="width: 75px">
				    <col style="width: 75px">
				</colgroup>
					<tr>
						<th></th>
						<th>사원번호</th>
						<th>사원명</th>
						<th>부서</th>
						<th>직책</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>입사일자</th>
						<th>재직구분</th>
						<th></th>
					</tr>
					<c:forEach var="vo" items="${empList }">
						<c:if test="${vo.emp_department == '전체' || vo.emp_department == '영업팀' || vo.emp_department == '생산팀' || vo.emp_department == '인사팀'}">
						<tr>
							<td></td>
							<td id="empCode">${vo.emp_id}</td> <!-- 혦넣 -->
							<td id="empName">${vo.emp_name}</td> <!-- 혦넣 -->
							<td>${vo.emp_department}</td>
							<td>${vo.emp_position}</td>
							<td>${vo.emp_email}</td>
							<td>${vo.emp_phone}</td>
							<td>${vo.emp_hiredate}</td>
							<td>${vo.emp_work}</td>
							<td>
								<button class="details" data-id="${emp_id }">상세보기</button>
							</td>
						</tr>
						</c:if>
					</c:forEach>
				</table>
			</form>
		</div>
		
		<!-- 페이징 -->
		<div id="pagination"
			style="display: block; text-align: center; width: 50%; margin: 0% 25% 0% 25%">
			<c:if test="${pm.prev }">
				<a href="/person/empinfo?page=${pm.startPage - 1 }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}"> 이전 </a>
			</c:if>

			<c:forEach var="page" begin="${pm.startPage }" end="${pm.endPage }"	step="1">
				<a href="/person/empinfo?page=${page }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}">${page }</a>
			</c:forEach>

			<c:if test="${pm.next }">
				<a href="/person/empinfo?page=${pm.endPage + 1 }&search_empid=${search.search_empid}&search_empname=${search.search_empname}&search_empdepartment=${search.search_empdepartment}"> 다음 </a>
			</c:if>
		</div>
		<!-- 페이징 -->
	</div>
	
	<div id="details"></div>
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>

