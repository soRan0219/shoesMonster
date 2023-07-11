<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%@ include file="../include/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- sweetalert -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<link href="https://webfontworld.github.io/NexonLv2Gothic/NexonLv2Gothic.css" rel="stylesheet">

<link rel="stylesheet" href="/resources/forTest/sm.css"> <!-- 버튼css -->

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
	
	div:where(.swal2-container) button:where(.swal2-styled).swal2-deny{
	background-color: #868e96;
	}

	/* 셀렉트 옵션을 가로로 나열하여 버튼으로 꾸미기 위한 스타일 */
	.custom-select1 {
 		display: flex; 
		width: 25%;
		height: 25%;
		font-size: 13px; 
		line-height: 20px;
		background-color: transparent;
		border-style: none;
		padding: -1px;
	}

	.custom-select1 select {
		display: none;
	}

	.custom-select1 button {
		flex: 1;
		border-radius: 4px;
		padding: 5px 15px;
		font-size: 15px;
		font-weight: 500;
		border: none;
		border-style: none;
		cursor: pointer;
		outline: none;
		color: #73879C;
		transition: background-color 0.3s;
	}
	
 	.custom-select1 button:hover { 
 		background-color: #e0e0e0; 
 	} 

</style>

<script type="text/javascript">
	//========================= 함수, 상수 ==================================//
	
	// 오늘 날짜 yyyy-mm-dd
	function getToday() {
		var date = new Date();
		var year = date.getFullYear();
		var month = ("0" + (1+date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		
		return year+"-"+month+"-"+day;
	}//getToday()

// 	// 코드 자동 부여
// 	function lineCodeNum(num, length) {
// 		let str = num.toString();
// 		while (str.length < length){
// 			str = '0' + str;
// 		}
// 		return str;
// 	}
	
	// input으로 바꾸기
	function inputCng(obj, type, name, value) {
		var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
		obj.html(inputBox);
	}// inputCng
	
	//팝업창 옵션
	const popupOpt = "top=60,left=140,width=600,height=600";

	//검색 팝업
	function openWindow(search, inputId) {
		var url = "/performance/lineEmpSearch?type=" + search + "&input=" + inputId;
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
				
		if(isPop) {
	    	
	    	$('#add').hide();
	    	$('#modify').hide();
	    	$('#delete').hide();
	    	$('#save').hide();
	    	
	   		$('table tr:not(:first-child)').click(function(){
	   			
	   			$(this).css('background', '#ccc');
	    			
	    		var lineCode = $(this).find('#lineCode').text();
	    			
	    		$('#'+isPop, opener.document).val(lineCode);
	    			
	    		window.close();
	    	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
	    		
	     		
			} else {
				console.log("팝업아님");
		} //if(팝업으로 열었을 때)
			
	} //popUp()
	
	//========================= 함수, 상수 ==================================//
	
	// 제이쿼리
	$(function() {
		popUp();
	
		//테이블 항목들 인덱스 부여
		$('table tr').each(function(index){
			var num = "<c:out value='${vo.page}'/>";
			var num2 = "<c:out value='${vo.pageSize}'/>";
			if(index > 0){
				$(this).find('td:first').text(((num-1)*num2) + index-1);
			}
		});
		
	//============================ 버튼 구현 ====================================//	
		////수정//////////////////////////////////////////////////
	var isExecuted = false;
	
	$('#modify').click(function () {
		
		event.preventDefault();
		
		$('#add').attr("disabled", true);
		$('#delete').attr("disabled", true);
				
			//행 하나 클릭했을 때	
			$('table tr:not(:first-child)').click(function() {

				//하나씩만 선택 가능
				if(!isExecuted) {
					isExecuted = true;
						
					$(this).addClass('selected');
					
					// 라인코드 저장
					let updateCode = $(this).find('#lineCode').text().trim();
					console.log(updateCode);
						
					var jsonData = {
						line_code : updateCode
					};
						
					console.log(jsonData);
						
					var self = $(this);
		
					$.ajax({
						url : "/performance/line",
						type : "post",
						contentType : "application/json; charset=UTF-8",
						dataType : "json",
						data : JSON.stringify(jsonData),
						success : function(data) {
							// alert("*** 아작스 성공 ***");
		
						var preVOs = [
							data.line_place,
							data.line_code,
							data.line_name,
							data.line_use,
							data.emp_id,
							data.emp.emp_name,
							data.insert_date,
							data.line_note, 
							];
		
						var names = [
							"line_place",
							"line_code",
							"line_name",
							"line_use",
							"emp_id",
							"emp_name",
							"insert_date",
							"line_note"
							];
		
						//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
						self.find('td').each(function(idx,item) {
		
							if(idx > 0){
								inputCng($(this), "text", names[idx - 1], preVOs[idx - 1]);
									if(idx == 4 ){
										var dropDown = "<select id = 'line_use' name = 'line_use'>";
											dropDown += "<option value = '1'>Y</option>";
											dropDown += "<option value = '2'>N</option>";
											dropDown += "</select>";
											
											$(this).html(dropDown);
											
											$(this).html(dropDown);
											$(this).find('option').each(function () {
												if(this.value == preVOs[idx - 1]){
													$(this).attr("selected", true);
												}
										
											});// this.find('option')
									
									}// if(idx==4)
							
									if(idx == 1 ){
										var dropDown = " <select name='line_place' id='line_place'>";
											dropDown += " <option value='1차공정'>1차공정</option>";
											dropDown += " <option value='2차공정'>2차공정</option>";
											dropDown += " <option value='3차공정'>3차공정</option>";
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
// 							alert("아작스 실패 ~~");
						}
					}); //ajax
				
				// 저장 -> 수정완료
				$('#save').click(function () {
					
					var line_place = $('#line_place').val();
		 			var line_code = $('#line_code').val();
		 			var line_name = $('#line_name').val();
		 			var line_use = $('#line_use').val();
		 			var emp_id = $('#emp_id').val();
		 			var emp_name = $('#emp_name').val();//
		 			var line_note = $('#line_note').val();
					
		 			if(line_code == "" || line_name == "" || line_place == "" || line_use == ""
						|| emp_id == ""){
//	 				alert("항목을 모두 입력하세요");
					Swal.fire({
							title: "<div style='color:##495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
							icon: 'info',
							width: '300px',
						})	
		 			
		 			}else{
						$('#fr').attr("action", "/performance/linemodify"); 
						$('#fr').attr("method", "POST");
						$('#fr').submit();
				}
					
				});//save
					
			}// if(!isExecuted)
				
			// 취소 -> 리셋
			$('#cancle').click(function () {
				$('#fr').each(function () {
					this.reset();
				});
				
			}); // cancle
			
		}); // table .click
		
	});// modify.click
	 

	//추가//////////////////////////////////////////////////
	// 추가 시 필요한 변수들
    var counter = 0;
    var codeNum = 0;
   	var lineCode = 0;
		
		// 오늘날짜 -> 등록일
		let today = getToday();
   	
       	$('#add').click(function () {
			
        	event.preventDefault();
        	
        	$('#modify').attr("disabled", true);
			$('#delete').attr("disabled", true);       		
			
// 			$.ajax({
// 				url: "/performance/lineCode",
// 				method: "GET",
// 	 			dataType: "text",
// 	 			success: function (data) {
// 	 				 // Ajax 요청 안에서 데이터를 받아와서 변수에 할당 및 후속 작업 수행	 				
// // 	 				codeNum = data;
// // 	 				 console.log("Ajax 내부에서의 codeNum:", codeNum); // Ajax 내부에서의 codeNum: [받아온 데이터]
			
// 					// 변수에 할당된 데이터를 기반으로 추가 작업 수행
// //  				    someFunction(codeNum);
	 			
// 	 			}//success
			
// 			})//ajax
			
// 			function someFunction(data) {
// 				alert("someFunction");
// 				 codeNum = data; // 외부에서의 codeNum: [받아온 데이터]
// // 				 alert("codeNum"+codeNum);
// 				 var num = parseInt(codeNum.substring(1)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
// // 				 alert("num : "+num);
// 				 var paddedNum = padNumber(num, codeNum.length - 1); // 숫자를 패딩하여 길이 유지
// 				 lineCode = codeNum.charAt(0) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
	             
// 				 if ($('#add').hasClass('true')) {
// 	             addRow();
// 	          	$('#add').removeClass('true');
// 	             }
// 	             counter++;

// 				codeNum = data;
				
// 				alert("codeNum"+codeNum);
				
// 				var prefix = "";
				
// 			    if (codeNum === "1차공정") {
// 			        prefix = "L1";
// 			    } else if (codeNum === "2차공정") {
// 			        prefix = "L2";
// 			    } else if (codeNum === "3차공정") {
// 			        prefix = "L3";
// 			    }
			    
// 				 var num = parseInt(codeNum.substring(1)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
// 				 alert("num : "+num);
//  				 var paddedNum = padNumber(num, codeNum.length - 1); // 숫자를 패딩하여 길이 유지
//  				 lineCode = prefix+codeNum.charAt(0) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
			 	             
			    
// 			    var num = counter + 1; // 1 증가
// 			    var paddedNum = padNumber(num, 2); // 숫자를 패딩하여 길이 유지 (총 2자리)
// 			    var lineCode = prefix + paddedNum; // 접두사와 패딩된 숫자를 결합하여 완전한 코드 생성
			    
			    if ($('#add').hasClass('true')) {
			        addRow();
			        $('#add').removeClass('true');
			    }
			    // 라인코드 부여 0708
			   
			    var selectedOption = '1차공정';
			    getLineCode();
			    
			    $('#line_place').on('change', function() {
			        selectedOption = $(this).val(); // 선택된 옵션의 값 가져오기
// 			       if(selectedOption == null || selectedOption === ''){
// 			    	   selectedOption = '1차공정';
// 			       }
// 			        alert(selectedOption); // 선택된 옵션 값으로 someFunction 호출
					getLineCode();
			    });
			    
			    
			   
			    function getLineCode (){
			    	var liplace = {line_place : selectedOption};
				    $.ajax({
						url: "/performance/lineCode",
						method: "POST",
						contentType : "application/json; charset=UTF-8",
			 			data: JSON.stringify(liplace),
			 			success: function (data) {
// 							alert(data);
							
							 
			 				 var num = parseInt(data.substring(1)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
// 			 				 alert("num : "+num);
			  				 var paddedNum = padNumber(num, data.length - 1); // 숫자를 패딩하여 길이 유지
			  				 lineCode = data.charAt(0) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
						   	         
							
							$('#line_code').val(lineCode);
							
						}//success
			        });//ajax
				}

// 			    counter++;
// 			} // someFunction(data)
			
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
				
				var line_place = $('#line_place').val();
	 			var line_code = $('#line_code').val();
	 			var line_name = $('#line_name').val();
	 			var line_use = $('#line_use').val();
	 			var emp_id = $('#emp_id').val();
	 			var emp_name = $('#emp_name').val();//
	 			var line_note = $('#line_note').val();
				
	 			if(line_code == "" || line_name == "" || line_place == "" || line_use == ""
					|| emp_id == ""){
// 				alert("항목을 모두 입력하세요");
				Swal.fire({
						title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "항목을 모두 입력하세요"+ "</div>",
						icon: 'info',
						width: '300px',
					})	
	 			
	 			}else{
						$('#fr').attr("action", "/performance/lineadd"); 
						$('#fr').attr("method", "POST");
						$('#fr').submit();
					}
			}); // save
        
	});//add.click
		
        // 추가 버튼 클릭 시 row 생성
        function addRow() {
        	
			var row = "<tr>";
			
			// 번호
			row += "<td style='width: 75px'>";
			row += "</td>";
			
			// 공정
			row += " <td>";
			row += " <select name='line_place' id='line_place'>";
			row += " <option value='1차공정' selected>1차공정</option>";
			row += " <option value='2차공정'>2차공정</option>";
			row += " <option value='3차공정'>3차공정</option>";
			row += " </select>";
			row += " </td>";
			
			// 라인코드 
			row += "<td>";
			row += "<input type='text' name='line_code' id='line_code' required readonly value='"+lineCode+"' class='input-fieldb'>";
			row += "</td>";
			
			// 라인명
			row += "<td>";
			row += "<input type='text' name='line_name' id='line_name' required class='input-fieldb'>";
			row += "</td>";
			
			// 사용여부
			row += " <td>";
			row += " <select name='line_use' id='line_use'>";
			row += " <option value='1'>Y</option>";
			row += " <option value='2'>N</option>";
			row += " </select>";
			row += " </td>";
			
			// 등록자	
			row += "<td>";
			row += " <input type='hidden' name='emp_id' id='emp_id' value = '<c:out value='${id.emp_id}'/>' required>";
			row += " <input type='text' name='emp_name' id='emp_name' value = '<c:out value='${id.emp_name}'/>' required readonly class='input-fieldb'>";
			row += "</td>";
			
			// 등록일
			row += " <td>";
			row += " <input type='text' name='insert_date' readonly value='";
			row += today;
			row += "'class='input-fieldb'>";
			row += " </td>";
			
			// 비고
			row += "<td>";
			row += "<input type='text' name='line_note' id='line_note' class='input-fieldb'>";
			row += "</td>";
			row += "</tr>";
			
            $('#lineTable').append(row);

//     		// 등록자(사원) 검색
//     		$('#emp_name').click(function () {
// //     			alert("등록자검색");
//     			openWindow("emp", "emp_name");
//     		}); // #emp_id click
		
		} // addRow()

			
			// 취소버튼(=리셋)
			$('#cancle').click(function () {
				$('#fr').each(function () {
					this.reset();
				});
			}); // cancle click	

	
	////삭제/////////////////////////////////////////////////////////
	$('#delete').click(function () {
		
		event.preventDefault();
		
		$('#add').attr("disabled", true);
		$('#modify').attr("disabled", true);
		
		if($(this).hasClass('true')){
			
			// 열: 체크박스 행: 라인코드
			$('table tr').each(function () {
				var code = $(this).find('td:nth-child(3)').text();
				
				var tbl = "<input type='checkbox' name='selected' value='";
					tbl += code;
					tbl += "'>";
				
				$(this).find('th:first').html("<input type='checkbox' id='selectAll'>");
				$(this).find('td:first').html(tbl);
			});
			
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
					
					
					Swal.fire({
						  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
								  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
						  icon: 'info', // 아이콘! 느낌표 색? 표시?
						  showDenyButton: true,
						  confirmButtonColor: '#17A2B8', // confrim 버튼 색깔 지정
						  cancelButtonColor: '#73879C', // cancel 버튼 색깔 지정
						  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
// 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
						  width : '300px', // alert창 크기 조절
						  
						}).then((result) => {
					
					 /* confirm => 예 눌렀을 때  */
					  if (result.isConfirmed) {
						  
					  
						$.ajax({
	 						url: "/performance/linedelete",
	 						type: "POST",
	 						data: {checked : checked},
	 						dataType: "text",	
	 						success: function () {
	 							Swal.fire({
									  title: "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "총" +checked.length+"건 삭제 완료",
									  icon: 'success',
									  width : '300px',
									}).then((result) => {
									  if (result.isConfirmed) {
									    location.reload();
									  }
									});
							},
							error: function () {
								Swal.fire({
									title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
									icon : 'question',
									width: '300px',
									});
								
							}
						});//ajax
						  } else if (result.isDenied) {
								Swal.fire({
								title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
								icon : 'error',
								width: '300px',
								});
					}// if(confirm)
				});		
						
				}// 체크OOO
				else{
					Swal.fire({
						title : "<div style='color:#495057;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
						icon : 'warning',
						width: '300px',
						});
				}// 체크 XXX
	
			}); // save
			
			$(this).removeClass('true');
		}// if(삭제 버튼 true class O)
		
		// 취소 -> 리셋
		$('#cancle').click(function () {
			$('input:checkbox').prop('checked', false);
		});
		
	});//delete.click
	
	});// 제이쿼리
	
</script>


<style>
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
    cursor: pointer;
    display: inline-block;
    text-align-last: center;
}
.input-fieldb {
    display: inline-block;
    text-align-last: center;
}
</style>


<!-- //////////////////////////////////////////////////////////////////////// -->
<!-- page content -->
<div class="right_col" role="main">

<h1 style="margin-left: 1%;">라인관리</h1>

<div style="margin: 1% 1%;">
	<hr>
	<form action="" method="get">
	<fieldset>
		<input type="hidden" name="input" id="input" value="${input}">
				
		<span>라인코드&nbsp;</span>
			<input type="text" name="line_code" placeholder="라인코드를 입력하세요."> &nbsp;&nbsp;
			
		<span>라인명&nbsp;</span>
			<input type="text" name="line_name" placeholder="라인명을 입력하세요."> &nbsp;&nbsp;
			
		<input type="submit" class="B B-info" value="조회">
		
		<br><br>
		
		<span>사용여부&nbsp;</span>
			&nbsp;<input type="radio" name="line_use" value="3" checked> 전체
			&nbsp;<input type="radio" name="line_use" value="1"> Y
			&nbsp;<input type="radio" name="line_use" value="2"> N
			
			<hr>
				
				<div class="custom-select1">
					<select name="line_place">
						<option value="전체" ${lvo.line_place == null ? 'selected' : ''}>1차공정</option>
						<option value="1차공정" ${lvo.line_place == '1차공정' ? 'selected' : ''}>1차공정</option>
						<option value="2차공정" ${lvo.line_place == '2차공정' ? 'selected' : ''}>2차공정</option>
						<option value="3차공정" ${lvo.line_place == '3차공정' ? 'selected' : ''}>3차공정</option>
					</select>
					
					<button onclick="selectOption(1)">1차공정 </button>
					<button onclick="selectOption(2)">2차공정 </button>
					<button onclick="selectOption(3)">3차공정</button>
				</div>
				<script>
				  function selectOption(index) {
				    var select = document.querySelector('.custom-select1 select');
				    select.selectedIndex = index;
				    select.dispatchEvent(new Event('change'));
				  }
				</script>
		</fieldset>
	</form>
</div>
<!-- //////////////////////////////////////////////////////////////////////// -->



<!-- //////////////////////////////////////////////////////////////////////// -->
<div class="col-md-12 col-sm-12">
	<div class="x_panel">
		<div class="x_title">
		<h2>라인 관리<small>총 ${lwpm.totalCount } 건</small></h2>
		
		<div style="float: left;  margin-top: 1.5px;">
			<c:if test="${empty param.input }">
				<button onclick="location.href='/performance/line'" class="B2 B2-info">↻</button>
			</c:if>
			<c:if test="${!empty param.input }">
				<button onclick="location.href='/performance/line?input=${param.input }'" class="B2 B2-info">↻</button>
			</c:if>
		</div>
				
			<div style="float: right;">
				<button id="add" class="true B B-info">추가</button>
				<button id="modify" class="B B-info" >수정</button>
				<button id="delete" class="true B B-info">삭제</button>
				<button type="reset" id="cancle" class="B B-info" >취소</button>
				<button type="submit" id="save" class="B B-info" >저장</button>
			</div>
			
			<div class="clearfix"></div>
			</div>
	<!-- //////////////////////////////////////////////////////////////////////// -->	
	
		<form id="fr">

	<script>
	    var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정
	
	    if (team === "생산팀" || team === "관리자") {
	        document.getElementById("add").disabled = false;
	        document.getElementById("modify").disabled = false;
	        document.getElementById("delete").disabled = false;
	        document.getElementById("cancle").disabled = false;
	        document.getElementById("save").disabled = false;
	        document.querySelector("[onclick^='location.href']").disabled = false;
	    } else {
	        document.getElementById("add").hidden = true;
	        document.getElementById("modify").hidden = true;
	        document.getElementById("delete").hidden = true;
	        document.getElementById("cancle").hidden = true;
	        document.getElementById("save").hidden = true;
	        document.querySelector("[onclick^='location.href']").hidden = true;
	    }
	</script>
<!-- //////////////////////////////////////////////////////////////////////// -->	
	
	<div class="x_content">
			<div class="table-responsive">
				<div class="table-wrapper" >
					<table id="lineTable" class="table table-striped jambo_table bulk_action" style="text-align-last:center;">
						<thead>
							<tr class="headings">	
								<th>번호</th>
								<th>공정</th>
								<th>라인코드</th>
								<th>라인명</th>
								<th>사용여부</th>
								<th type='hidden' style='display: none;'>등록자 코드</th>
								<th>등록자</th>
								<th>등록일</th>
								<th>비고</th>
							</tr>
						</thead>
						<tr type='hidden' style='display: none;'></tr>
				
						<c:forEach var="vo" items="${boardList }" varStatus="i">
							<tr>
								<td>${i.count}</td>
								<td>${vo.line_place}</td>
								<td id="lineCode">${vo.line_code}</td>
								<td>${vo.line_name}</td>
								
								<c:choose>
									<c:when test="${vo.line_use == 1 }">
										<td>Y</td>
									</c:when>
									<c:when test="${vo.line_use == 2 }">
										<td>N</td>
									</c:when>
								</c:choose>
								
								<td type='hidden' style='display: none;'><c:out value='${id.emp_id}'/></td>
								<td>${vo.emp.emp_name}</td>
								<td>${vo.insert_date}</td>
								<td>${vo.line_note}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</form>
<!-- //////////////////////////////////////////////////////////////////////// -->	

<div id="pagination" class="dataTables_paginate paging_simple_numbers">
	<ul class="pagination">
		<li class="paginate_button previous disabled">
		<c:if test="${lwpm.prev }">
			<a href="/performance/line?page=${lwpm.startPage-1 }&line_code=${lvo.line_code }&line_name=${lvo.line_name }&line_use=${lvo.line_use }&line_place=${lvo.line_place}">Previous</a>
		</c:if>
		</li>
		<li class="paginate_button previous disabled">
		<c:forEach var="page" begin="${lwpm.startPage }" end="${lwpm.endPage }" step="1">
			<a href="/performance/line?page=${page }&line_code=${lvo.line_code }&line_name=${lvo.line_name }&line_use=${lvo.line_use }&line_place=${lvo.line_place}">${page }</a>
		</c:forEach>
		</li>
		<li class="paginate_button previous disabled">
		<c:if test="${lwpm.next }">
			<a href="/performance/line?page=${lwpm.endPage+1 }&line_code=${lvo.line_code }&line_name=${lvo.line_name }&line_use=${lvo.line_use }&line_place=${lvo.line_place}">Next</a>
		</c:if>
		</li>
	</ul>
</div>

<!-- //////////////////////////////////////////////////////////////////////// -->
</div>
</div>

</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>