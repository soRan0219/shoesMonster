<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	
	//검색 팝업(거래처)
  	function openWindow(search, inputId) {
   	 	var url = "/workorder/search?type=" + search + "&input=" + inputId;
    	var popup = window.open(url, "", popupOpt);
    } //openWindow()
    
	
	// 추가 시 거래처 검색 
    function serchClient(inputId){
    	openWindow("client",inputId);
    }
    
    // 추가 시 창고 검색
    function serchWh(inputId){
    	openWindow("wh",inputId);
    }
	
    	
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
        		
        	$('#addButton').hide();
        	$('#modify').hide();
        	$('#delete').hide();
        	$('#cancle').hide();
        	$('#save').hide();
        		
       		$('table tr:not(:first-child)').click(function(){
       			$(this).css('background', '#ccc');
        			
       			var prodCode = $(this).find('#prodCode').text();
     			var prodName = $(this).find('#prodName').text();
     			
     			var number = isPop.match(/\d+/);
     			$('#'+isPop, opener.document).val(prodCode);
     			if(number !=null){
     			$('#prod_name'+number, opener.document).val(prodName);
     			} else {
     			$('#prod_name', opener.document).val(prodName);
     			}
     			
         		window.close();
         	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
        		
    	} else {
    		console.log("팝업아님");
    	} //if(팝업으로 열었을 때)
    		
	} //popUp()
	
	 
		
		//jQuery
        $(document).ready(function() {
        	
        	popUp();
        	
        	//테이블 항목들 인덱스 부여
    		$('table tr').each(function(index){
    			$(this).find('td:first').text(index);
    		});
        	
      	 // 추가 시 필요한 변수들

            var counter = 0;
            var codeNum = 0;
        	var prodCode = 0;
            
         // 버튼 클릭시 addRow() 기능 불러오기
            $('#addButton').click(function() {
            	event.preventDefault();
            	$('#modify').attr("disabled", true);
    			$('#delete').attr("disabled", true);
    			
    			$.ajax({
    				  url: "/performance/prodCode",
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
   			             prodCode = codeNum.charAt(0) + codeNum.charAt(1)+ paddedNum.toString(); // 패딩된 숫자를 다시 문자열로 변환
   			             addRow();
   			             counter++;
    				} // someFunction(data)
            	
            }); //  $('#addButton').click(function()
            
            // 추가 버튼 클릭 시 row 생성
            function addRow() {
            	
                var row = '<tr>' +
                	'<td></td>'+
                    '<td><input type="text" name="products[' + counter + '].prod_code" id="" value="'+ prodCode +'" required></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_name"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_category"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_unit"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_size"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_color"></td>' +
                    '<td><input type="text" name="products[' + counter + '].client_code" id="client_code'+counter+'" onclick=serchClient("client_code'+counter+'"); required></td>' +
                    '<td><input type="text" name="products[' + counter + '].clients.client_actname" id="client_actname'+counter+'" onclick=serchClient("client_code'+counter+'"); required></td>' +
                    '<td><input type="text" name="products[' + counter + '].wh_code" id="wh_code'+counter+'" onclick=serchWh("wh_code'+counter+'"); required></td>' +
                    '<td><input type="text" name="products[' + counter + '].wh.wh_name" id="wh_name'+counter+'" onclick=serchWh("wh_name'+counter+'"); required></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_price"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_note"></td>' +
                    '</tr>';

                $('#productTable').append(row);
                
            	 // 테이블이 많이 생성되면 스크롤바 생성
                var table = document.getElementById('productTable');
                table.scrollTop = table.scrollHeight;
	        } // addRow()
	            
	           
            function padNumber(number, length) {
	                var paddedNumber = number.toString();
	                while (paddedNumber.length < length) {
	                    paddedNumber = "0" + paddedNumber;
	                }
	                return paddedNumber;
	        } // padNumber(number, length)

           
            
            // =============================================================================================================
            
        	

            // 저장 버튼 클릭 시 페이지 이동
            $('form').submit(function() {
               return true;
            });
            

        	//취소버튼 -> 리셋
			$('#cancle').click(function(){
				$('#fr').each(function(){
					this.reset();
				});
			}); //cacle click
			
			
			// 삭제 기능
			$('#delete').click(function(){
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
							url: "/performance/prodDelete",
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
		
			var isExecuted = false;
			
			/////////////// 수정 //////////////////////////////
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
						let updateCode = $(this).find('#prodCode').text().trim();
						console.log(updateCode);
		
						var jsonData = {
							prod_code : updateCode
						};
		
						var self = $(this);
		
						$.ajax({
							url : "/performance/prodOne",
							type : "post",
							contentType : "application/json; charset=UTF-8",
							dataType : "json",
							data : JSON.stringify(jsonData),
							success : function(data) {
								// alert("*** 아작스 성공 ***");
				
								var preVOs = [
										data.prod_code,
										data.prod_name,
										data.prod_category,
										data.prod_unit,
										data.prod_color,
										data.prod_size,
										data.client_code,
										data.clients.client_actname,
										data.wh_code,
										data.wh.wh_name,
										data.prod_price,
										data.prod_note,
										];
							
		
								var names = [
										"prod_code",
										"prod_name",
										"prod_category",
										"prod_unit",
										"prod_color",
										"prod_size",
										"client_code",
										"client_name",
										"wh_code",
										"wh_name",
										"prod_price",
										"prod_note", 
										];
		
								//tr안의 td 요소들 input으로 바꾸고 기존 값 띄우기
								self.find('td').each(function(idx,item) {
		
									if (idx > 0) {
										inputCng($(this),"text",names[idx - 1],preVOs[idx - 1]);
									} //품목코드부터 다 수정 가능하게
		
								}); // self.find(~~)
		
		
								// 거래처 검색 
								$('#client_code').click(function() {
									openWindow("client","client_code");
								}); //client_code click
								
								// 창고 검색
								$('#wh_code').click(function() {
									openWindow("wh","wh_code");
								}); // wh_code click
		
							
							},
							error : function(data) {
								alert("아작스 실패 ~~");
							}
						}); //ajax
		
						//저장버튼 -> form 제출
						$('#save').click(function() {
		
							$('#fr').attr("action","/performance/prodModify");
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

	<h1>product</h1>
	
	<form action="" method="get">
		<fieldset>
       		
       		<input type="hidden" name="input" id="input" value="${input }">
       		
       		<label>품번:</label>
        	<input type="text" name="prod_code" id="searchCode">
        	<label>품명:</label>
        	<input type="text" name="prod_name" id="searchName">
        	<br>
        	<label>카테고리:</label>
        	<input type="text" name="prod_category" id="searchCategory"> 
        	<label>거래처 : </label>
        	<input type="text" name="client_code" id="searchUnit">
        	<input type="submit" value="검색">
		</fieldset>
	</form>
	
	
	<form action="" method="post" id="fr">
		<button id="addButton">추가</button>
		<button id="modify">수정</button>
		<button id="delete">삭제</button>
		<button type="reset" id="cancle">취소</button>
		<input type="submit" value="저장" id="save">

	
		<table border="1" id="productTable">
				<tr>
					<th>번호</th>
					<th>품번</th>
					<th>품명</th>
					<th>카테고리</th>
					<th>품목 단위</th>
					<th>컬러</th>
					<th>사이즈</th>
					<th>거래처코드</th>
					<th>거래처명</th>
					<th>창고코드</th>
					<th>창고명</th>
					<th>매출단가</th>
					<th>비고</th>
				</tr>
			<c:forEach var="vo" items="${prodList}">
					<tr>
						<td></td>
         			    <td id="prodCode">${vo.prod_code }</td>
						<td id="prodName">${vo.prod_name }</td>
						<td>${vo.prod_category }</td>
						<td>${vo.prod_unit }</td>
						<td>${vo.prod_color }</td>
						<td>${vo.prod_size }</td>
						<td>${vo.client_code }</td>
						<td>${vo.clients.client_actname }</td>
						<td>${vo.wh_code }</td>
						<td>${vo.wh.wh_name }</td>
						<td>${vo.prod_price }</td>
						<td>${vo.prod_note }</td>
					</tr>
			</c:forEach>

		</table>
		
	</form>
	
	<div id="pagination" style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="/performance/product?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&client_code=${vo.client_code }">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/performance/product?nowPage=${p }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&client_code=${vo.client_code }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/performance/product?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&client_code=${vo.client_code }">&gt;</a>
		</c:if>
	</div>
	
</div>
<!-- /page content -->

<%@ include file="../include/footer.jsp"%>