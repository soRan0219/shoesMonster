<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
    			$(this).find('td:first').text(index);
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
				
            });
            
            function addRow() {
                var row = '<tr>' +
                	'<td></td>'+
                	'<input type="hidden" name="reqs[' + counter + '].raw_code" id = "raw_code'+counter+'" >' +
                    '<td><input type="text" name="reqs[' + counter + '].req_code" " value="'+ reqCode +'" readonly required></td>' +
                    '<input type="hidden" name="reqs[' + counter + '].prod_code" id= "prod_code'+counter+'" >' +
                    '<td><input type="text" name="reqs[' + counter + '].prod.prod_name" id = "prod_name'+counter+'" readonly onclick=serchProd("prod_code'+counter+'");></td>' +
                    '<td><input type="text" name="reqs[' + counter + '].raw.raw_name" id="raw_name'+counter+'" readonly onclick=serchRaw("raw_code'+counter+'");></td>' +
                    '<td><input type="text" name="reqs[' + counter + '].req_dan"></td>' +
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
						
						$.ajax({
							url: "/performance/requirementDelete",
							type: "post",
							data: {checked:checked},
							dataType: "text",
							success: function() {
								alert("삭제 성공");
								location.reload();
							},
							error: function() {
								alert("삭제 실패");
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

	<h1>Requirements</h1>
	
	<form action="" method="get">
		<fieldset>
       		<label>소요코드:</label>
        	<input type="text" name="req_code" id="searchCode">
        	<label>품번:</label>
        	<input type="text" name="prod_code" id="searchName">
        	<br>
        	<label>품명:</label>
        	<input type="text" name="prod.prod_name" id="searchCategory"> 
        	<input type="submit" value="검색">
		</fieldset>
	</form>
	
	
	<form action="" method="post" id="fr">
		<button id="addButton">추가</button>
		<button id="modify">수정</button>
		<button id="delete">삭제</button>
		<button type="reset" id="cancle">취소</button>
		<input type="submit" value="저장" id="save">

	
		<table border="1" id="reqTable">
				<tr>
					<th>번호</th>
					<th>소요코드</th>
					<th type='hidden' style='display: none;'>품번</th>
					<th>완제품</th>
					<th>원자재</th>
					<th>소요량</th>
					<th>총 소요량</th>
					<th>비고</th>
				</tr>
			<c:forEach var="vo" items="${reqList}">
					<tr>
						<td></td>
         			    <td id="reqCode">${vo.req_code }</td>
         			    <td type='hidden' style='display: none;'>${vo.prod_code }</td>
						<td id="prodName">${vo.prod.prod_name }</td>
						<td>${vo.raw.raw_name }</td>
						<td>${vo.req_dan }</td>
						<td> </td>
						<td>${vo.req_note }</td>
					</tr>
			</c:forEach>

		</table>
		
	</form>
	
	<div style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="/performance/rawMaterial?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&raw_code=${vo.raw_code }&raw_name=${vo.raw_name }&clients.client_actname=${vo.clients.client_actname }">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/performance/rawMaterial?nowPage=${p }&cntPerPage=${paging.cntPerPage}&raw_code=${vo.raw_code }&raw_name=${vo.raw_name }&clients.client_actname=${vo.clients.client_actname }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/performance/rawMaterial?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&raw_code=${vo.raw_code }&raw_name=${vo.raw_name }&clients.client_actname=${vo.clients.client_actname }">&gt;</a>
		</c:if>
	</div>
	
</div>
<!-- /page content -->
<%@ include file="../include/footer.jsp"%>