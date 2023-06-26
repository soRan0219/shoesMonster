<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script>
    	
	function popUp() {
		var queryString = window.location.search;
		var urlParams = new URLSearchParams(queryString);
		
		var isPop = urlParams.get("input");
		
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
        	$('#save').hide();
        		
       		$('table tr:not(:first-child)').click(function(){
       			$(this).css('background', '#ccc');
        			
       			var prodCode = $(this).find('#prodCode').text();
         			
     			$('#'+isPop, opener.document).val(prodCode);
         			
         		window.close();
         	}); //테이블에서 누른 행 부모창에 자동입력하고 창 닫기
        		
    	} else {
    		alert("null");
    	} //if(팝업으로 열었을 때)
    		
	} //popUp()
    	
	
		
		
		//jQuery
        $(document).ready(function() {
        	

        	popUp();
			
        	
        	//테이블 항목들 인덱스 부여
    		$('table tr').each(function(index){
    			$(this).find('td:first').text(index);
    		});

        	
            var counter = 0;
            
            // 추가 버튼 클릭 시 row 생성
            function addRow() {
                var row = '<tr>' +
                    '<td><input type="text" name="products[' + counter + '].prod_code" required></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_name"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_category"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_unit"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_size"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_color"></td>' +
                    '<td><input type="text" name="products[' + counter + '].client_code" required></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_price"></td>' +
                    '<td><input type="text" name="products[' + counter + '].prod_note"></td>' +
                    '</tr>';

                $('#productTable').append(row);
                counter++;
                
            	 // 테이블이 많이 생성되면 스크롤바 생성
                var table = document.getElementById('productTable');
                table.scrollTop = table.scrollHeight;
            }

            // 버튼 클릭시 addRow() 기능 불러오기
            $('#addButton').click(function() {
                addRow();
            });
            
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

            
        });
    </script>

</head>
<body>

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
        	<label>품목 단위:</label>
        	<input type="text" name="prod_unit" id="searchUnit">
        	<input type="submit" value="검색">
        	<input type="button" value="검색" id="filterButton">
		</fieldset>
	</form>
	
	
	<form action="" method="post" onsubmit="return false" id="fr">
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
					<th>규격</th>
					<th>거래처코드</th>
					<th>매출단가</th>
					<th>비고</th>
				</tr>
			<c:forEach var="vo" items="${prodList}">
					<tr>
						<td></td>
         			    <td id="prodCode">${vo.prod_code }</td>
						<td>${vo.prod_name }</td>
						<td>${vo.prod_category }</td>
						<td>${vo.prod_unit }</td>
						<td>${vo.prod_color }</td>
						<td>${vo.prod_size }</td>
						<td>${vo.client_code }</td>
						<td>${vo.prod_price }</td>
						<td>${vo.prod_note }</td>
					</tr>
			</c:forEach>

		</table>
		
	</form>
	
	<div id="pagination" style="display: block; text-align: center;">		
		<c:if test="${paging.startPage != 1 }">
			<a href="/performance/product?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&prod_unit=${vo.prod_unit }">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="/performance/product?nowPage=${p }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&prod_unit=${vo.prod_unit }">${p }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/performance/product?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&prod_code=${vo.prod_code }&prod_name=${vo.prod_name }&prod_category=${vo.prod_category }&prod_unit=${vo.prod_unit }">&gt;</a>
		</c:if>
	</div>



</body>
</html>