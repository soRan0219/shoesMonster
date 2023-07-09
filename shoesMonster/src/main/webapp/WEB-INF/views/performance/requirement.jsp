<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
</style>
<!-- 폰트 -->


<script>		
	 	//input으로 바꾸기 
		function inputCng(obj, type, name, value) {
			var inputBox = "<input type='"+type+"' name='"+name+"' id='"+name+"' value='"+value+"'>";
			obj.html(inputBox);
		} //inputCng	
    
		// 팝업 옵션
		const popupOpt = "top=60,left=140,width=600,height=600";
	
		//검색 팝업
	  	function openWindow(search, inputId) {
	   	 	var url = "/workorder/search?type=" + search + "&input=" + inputId;
	    	var popup = window.open(url, "", popupOpt);
	    } //openWindow()
	    
	    //검색 팝업2
		function openWindow2(search, inputId) {
			var url = "/performance/whsearch?type=" + search + "&input=" + inputId;
			var popup = window.open(url, "", popupOpt);
		} //openWindow()
		
		//추가 시 품번 검색 
        function serchProd(inputId){
        	openWindow("prod",inputId);
        }
		
      	//추가 시 원자재 검색 
        function serchRaw(inputId){
        	openWindow2("raw",inputId);
        }
	    	
	  	
        $(document).ready(function() {
        	
        	//테이블 항목들 인덱스 부여
    		$('table tr').each(function(index){
    			var num = "<c:out value='${paging.nowPage}'/>";
    			var num2 = "<c:out value='${paging.cntPerPage}'/>";
    			$(this).find('td:first').text(((num-1)*num2) + index-1);
    		});
        	
    		// 추가 시 필요한 변수들

            var counter = 0;
            var codeNum = 0;
        	var reqCode = 0;
            
            // 추가 버튼 클릭 시 row 생성
            

            // 버튼 클릭시 addRow() 기능 불러오기
            $('#addButton').click(function() {
            	event.preventDefault();
            	$('#delete').attr("disabled", true);
				$('#modify').attr("disabled", true);
				
				$.ajax({
  				  url: "/performance/reqCode",
  				  method: "GET",
  				  dataType: "text",
  				  success: function(data) {
  				    // Ajax 요청 안에서 데이터를 받아와서 변수에 할당 및 후속 작업 수행
  				    codeNum = data;
  				    console.log("Ajax 내부에서의 codeNum:", codeNum); // Ajax 내부에서의 codeNum: [받아온 데이터]
  				    
  				    // 변수에 할당된 데이터를 기반으로 추가 작업 수행
  				    someFunction(codeNum);
  				  }
  				}); // ajax 끝

  				function someFunction(data) {
  					 codeNum = data; // 외부에서의 codeNum: [받아온 데이터]
 						 var num = parseInt(codeNum.substring(2)) + counter+1; // 문자열을 숫자로 변환하여 1 증가
 						 var paddedNum = padNumber(num, codeNum.length - 2); // 숫자를 패딩하여 길이 유지
 						 reqCode = codeNum.charAt(0) + codeNum.charAt(1) + paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
 			             addRow();
 			             counter++;
  				} // someFunction(data)
  				
  				$('#save').click(function() {
            		
						$('#fr').submit();

				}); //save
				
            });
            
            function addRow() {
                var row = '<tr>' +
                	'<td></td>'+
                	'<input type="hidden" name="reqs[' + counter + '].raw_code" id = "raw_code'+counter+'" required>' +
                    '<td><input type="text" name="reqs[' + counter + '].req_code" " value="'+ reqCode +'" readonly required></td>' +
                    '<input type="hidden" name="reqs[' + counter + '].prod_code" id= "prod_code'+counter+'" >' +
                    '<td><input type="text" name="reqs[' + counter + '].prod.prod_name" id = "prod_name'+counter+'" readonly onclick=serchProd("prod_code'+counter+'");></td>' +
                    '<td><input type="text" name="reqs[' + counter + '].raw.raw_name" id="raw_name'+counter+'" readonly onclick=serchRaw("raw_code'+counter+'");></td>' +
                    '<td><input type="number" name="reqs[' + counter + '].req_dan" required></td>' +
                    '<td></td>' +
                    '<td><input type="text" name="reqs[' + counter + '].req_note"></td>' +
                    '</tr>';
                    
                $('#reqTable').append(row);
                
            	 // 테이블이 많이 생성되면 스크롤바 생성
                var table = document.getElementById('reqTable');
                table.scrollTop = table.scrollHeight;
				
            }
            
            function padNumber(number, length) {
                var paddedNumber = number.toString();
                while (paddedNumber.length < length) {
                    paddedNumber = "0" + paddedNumber;
                }
                return paddedNumber;
       		 } // padNumber(number, length)
            
            // =============================================================================================================
 

        	//취소버튼 -> 리셋
			$('#cancle').click(function(){
				$('#fr').each(function(){
					this.reset();
				});
			}); //cacle click
			
			
			// 삭제 기능
			$('#delete').click(function(event){
				event.preventDefault();
				$('#addButton').attr("disabled", true);
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
					
//	 				alert(checked);
					
					if(checked.length > 0) {
						Swal.fire({
							  title: "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>" + "총" +checked.length+"건\n정말 삭제하시겠습니까?"+ "</div>",
									  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
							  icon: 'info', // 아이콘! 느낌표 색? 표시?
							  showDenyButton: true,
							  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
							  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
							  confirmButtonText: 'Yes', // confirm 버튼 텍스트 지정
//	 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
							  width : '300px', // alert창 크기 조절
							  
							}).then((result) => {
						
						 /* confirm => 예 눌렀을 때  */
						  if (result.isConfirmed) {
							  
						  
							$.ajax({
		 						url: "/performance/requirementDelete",
		 						type: "POST",
		 						data: {checked : checked},
		 						dataType: "text",	
		 						success: function () {
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
								error: function () {
									Swal.fire({
										title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "삭제 중 오류가 발생했습니다",
										icon : 'question',
										width: '300px',
										});
									
								}
							});//ajax
							  } else if (result.isDenied) {
									Swal.fire({
									title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "삭제가 취소되었습니다",
									icon : 'error',
									width: '300px',
									});
						}// if(confirm)
					});		
							
					}// 체크OOO
					else{
						Swal.fire({
							title : "<div style='color:#3085d6;font-size:20px;font-weight:lighter'>"+ "선택된 항목이 없습니다",
							icon : 'warning',
							width: '300px',
							});
					}// 체크 XXX
		
				}); // save
				
						 
// 						Swal.fire({
// 						  title: "<div style='color:#3085d6;font-size:20px'>" + "총" +checked.length+"행\n정말 삭제하시겠습니까?"+ "</div>",
// 								  // “<div style=’color:#f00;font-size:15px’>” + msg + “</div>”,    //  HTML & CSS 로 직접수정
// 						  icon: 'warning', // 아이콘! 느낌표 색? 표시?
// 						  showDenyButton: true,
// 						  confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
// 						  cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
// 						  confirmButtonText: '예', // confirm 버튼 텍스트 지정
// 						  cancelButtonText: '아니오', // cancel 버튼 텍스트 지정
// 						  width : '300px' // alert창 크기 조절
						   
// 						}).then((result) => {
// 						 /* confirm => 예 눌렀을 때  */
// 						  if (result.isConfirmed) {
							  
// 							  $.ajax({
// 									url: "/performance/rawMaterialDelete",
// 									type: "post",
// 									data: {checked:checked},
// 									dataType: "text",
// 									success: function() {
// 										Swal.fire({
// 											  title:  "총" +checked.length+"건 삭제 완료",
// 											  icon: 'error',
// 											}).then((result) => {
// 											  if (result.isConfirmed) {
// 											    location.reload();
// 											  }
// 											});
// 									},
// 									error: function() {
// 										Swal.fire('삭제 실패!.', '', 'success')
// 									}
// 								}); //ajax
							  
// 						  } else if (result.isDenied) {
// 						    Swal.fire('삭제가 취소되었습니다.', '', 'info')
// 						  }
// 						});
						
						
// 					} //체크된거 있을대
// 					else {
// 						 Swal.fire('선택된 항목이 없습니다.', '', 'info')
// 					} //체크된거 없을때
					
// 				}); //save
				
				//취소 -> 리셋
				$('#cancle').click(function(){
					$('input:checkbox').prop('checked', false);
				});
				
			}); //delete click
			
			/////////////// 수정 //////////////////////////////
			var isExecuted = false;
			
			//수정버튼 클릭
			$('#modify').click(function() {
				event.preventDefault();
				$('#addButton').attr("disabled", true);
				$('#delete').attr("disabled", true);

				//행 하나 클릭했을 때	
				$('table tr:not(:first-child)').click(function() {
					
					//하나씩만 선택 가능
					if(!isExecuted) {
						isExecuted = true;
								
						$(this).addClass('selected');
						//품목코드 저장
						let updateCode = $(this).find('#reqCode').text().trim();
						console.log(updateCode);
		
						var jsonData = {
							req_code : updateCode
						};
		
						var self = $(this);
		
						$.ajax({
							url : "/performance/reqOne",
							type : "post",
							contentType : "application/json; charset=UTF-8",
							dataType : "json",
							data : JSON.stringify(jsonData),
							success : function(data) {
								// alert("*** 아작스 성공 ***");
								var sum = 0;
								
								var preVOs = [
										data.req_code,
										data.prod_code,
										data.prod.prod_name,
										data.raw.raw_name,
										data.req_dan,
										data.req_dan,
										data.req_note,
										data.raw_code
										];
								
							
		
								var names = [
										"req_code",
										"prod_code",
										"prod_name",
										"raw_name",
										"req_dan",
										"req_sum",
										"req_note",
										"raw_code"
										];
		
								//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
								
								self.find('td').each(function(idx,item) {
									if (idx > 0) {
										inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
// 									
										if(idx==4){
											var row = '<input type="hidden" name="'+names[7]+'" value="'+preVOs[7]+'" id="raw_code">'
											$(".selected").append(row);
										}


									} //라인코드부터 다 수정 가능하게
		
								}); // self.find(~~)
								
								
		
								//품번 검색 
								$('#prod_code').click(function() {
									openWindow("prod","prod_code");
								}); //prodCode click
								
								//품번 검색 팝업(raw)
								$('#raw_name').click(function() {
									openWindow2("raw", "search_raw");
								}); //rawCode click
		
							},
							error : function(data) {
								alert("아작스 실패 ~~");
							}
						}); //ajax
		
						//저장버튼 -> form 제출
						$('#save').click(function() {
		
							$('#fr').attr("action","/performance/reqModify");
							$('#fr').attr("method","post");
							$('#fr').submit();
		
						}); //save

					} //하나씩만 선택 가능
						
						
					//취소버튼 -> 리셋
					$('#cancle').click(function() {
						$('#fr').each(function() {
							this.reset();
						});
					}); //cancle click

				}); //tr click

			}); //modify click

            
        });
    </script>

<!-- page content -->
<div class="right_col" role="main">

	<h1 style="margin-left: 1%;">소요량 관리</h1>

	<div style="margin-left: 1%;">
		<form method="get">
			<fieldset>
				<label>소요코드 : </label> 
				<input type="text" name="req_code" id="searchCode"> 
				<label>완제품 : </label> 
				<input type="hidden"name="prod_code" id="prod_code9999"> 
				<input type="text"name="prod_name" id="prod_name9999" readonly onclick="serchProd('prod_code9999')"> 
				<label>원자재 : </label>
				<input type="hidden" name="raw_code" id="raw_code9999"> 
				<input type="text" name="raw_name" id="raw_name9999" readonly onclick="serchRaw('raw_code9999')"> 
				<input type="submit" class="B B-info" value="검색">
			</fieldset>
		</form>
		
	</div>

	<hr>

	<div class="col-md-12 col-sm-12">
		<div class="x_panel">
			
				<div class="x_title">
					<h2>소요량 관리<small>총 ${paging.total} 건</small></h2>
					
					<div style="float: left;  margin-top: 1.5px;">
						<c:if test="${empty param.input }">
							<button onclick="location.href='/performance/requirement'" class="B2 B2-info">↻</button>
						</c:if>
						<c:if test="${!empty param.input }">
							<button onclick="location.href='/performance/requirement?input=${param.input }'" class="B2 B-info">↻</button>
						</c:if>
					</div>
										
					<div style="float: right;">
						<button id="addButton" class="B B-info">추가</button>
						<button id="modify" class="B B-info">수정</button>
						<button id="delete" class="B B-info">삭제</button>
						<button type="reset" id="cancle" class="B B-info">취소</button>
						<input type="submit" class="B B-info" value="저장" id="save">
					</div>
					
					<div class="clearfix"></div>
				</div>
				
				<!-- 버튼 제어 -->
			<form id="fr" method="post">
				<script>
					var team = "${sessionScope.id.emp_department }"; // 팀 조건에 따라 변수 설정

					if (team === "자재팀" || team === "관리자") {
						document.getElementById("addButton").disabled = false;
						document.getElementById("modify").disabled = false;
						document.getElementById("delete").disabled = false;
						document.getElementById("cancle").disabled = false;
						document.getElementById("save").disabled = false;
						document
								.querySelector("[onclick^='location.href']").disabled = false;
					} else {
						document.getElementById("addButton").hidden = true;
						document.getElementById("modify").hidden = true;
						document.getElementById("delete").hidden = true;
						document.getElementById("cancle").hidden = true;
						document.getElementById("save").hidden = true;
						document
								.querySelector("[onclick^='location.href']").hidden = true;
					}
				</script>
				<!-- 버튼 제어 -->

				<div style="overflow-x: auto;">
					<table border="1" id="reqTable"
						class="table table-striped jambo_table bulk_action"
						style="text-align: center;">
						<colgroup>
							<col style="width: 50px">
							<col style="width: 100px">
							<col style="width: 100px">
							<col style="width: 100px">
							<col style="width: 100px">
							<col style="width: 100px">
							<col style="width: 150px">
						</colgroup>
						<thead>
							<tr class="headings">
								<th>번호</th>
								<th>소요코드</th>
								<th type='hidden' style='display: none;'>품번</th>
								<th>완제품</th>
								<th>원자재</th>
								<th>소요량</th>
								<th>총 소요량</th>
								<th>비고</th>
							</tr>
						</thead>
							<tr type='hidden' style='display: none;'></tr>
						<c:forEach var="vo" items="${reqList}">
							<tr>
								<td></td>
								<td id="reqCode">${vo.req_code }</td>
								<td type='hidden' style='display: none;'>${vo.prod_code }</td>
								<td id="prodName">${vo.prod.prod_name }</td>
								<td>${vo.raw.raw_name }</td>
								<td>${vo.req_dan }</td>
								<td></td>
								<td>${vo.req_note }</td>
							</tr>
						</c:forEach>
					</table>
					</div>
				</form>
		</div>
	</div>

	<div id="pagination" class="dataTables_paginate paging_simple_numbers" style="margin-right: 1%;">
		<ul class="pagination">
			<li class="paginate_button previous disabled">
				<c:if test="${paging.startPage != 1 }">
					<a href="/performance/requirement?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&req_code=${vo.req_code }&prod_code=${vo.prod_code }&raw_code=${vo.raw_code }">Previous</a>
				</c:if>
			</li>
			<li class="paginate_button previous disabled">
				<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
					<a href="/performance/requirement?nowPage=${p }&cntPerPage=${paging.cntPerPage}&req_code=${vo.req_code }&prod_code=${vo.prod_code }&raw_code=${vo.raw_code }">${p }</a>
				</c:forEach>
			</li>
			<li class="paginate_button previous disabled">
				<c:if test="${paging.endPage != paging.lastPage}">
					<a href="/performance/requirement?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&req_code=${vo.req_code }&prod_code=${vo.prod_code }&raw_code=${vo.raw_code }">Next</a>
				</c:if>
			</li>
		</ul>
	</div>
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>