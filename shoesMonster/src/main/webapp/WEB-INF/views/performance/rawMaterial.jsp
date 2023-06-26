<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script>
    	
        $(document).ready(function() {

        	//테이블 항목들 인덱스 부여
    		$('table tr').each(function(index){
    			$(this).find('td:first').text(index);
    		});

        	
            var counter = 0;
            
            // 추가 버튼 클릭 시 row 생성
            function addRow() {
                var row = '<tr>' +
                	'<td></td>'+
                    '<td><input type="text" name="raws[' + counter + '].raw_code" required></td>' +
                    '<td><input type="text" name="raws[' + counter + '].raw_name"></td>' +
                    '<td><input type="text" name="raws[' + counter + '].raw_color"></td>' +
                    '<td><input type="text" name="raws[' + counter + '].raw_unit"></td>' +
                    '<td><input type="text" name="raws[' + counter + '].raw_size"></td>' +
                    '<td><input type="text" name="raws[' + counter + '].client_code"required></td>' +
                    '<td><input type="text" name="raws[' + counter + '].clients.client_actname"></td>' +
                    '<td><input type="text" name="raws[' + counter + '].raw_price"></td>' +
                    '<td><input type="text" name="raws[' + counter + '].raw_note"></td>' +
                    '</tr>';

                $('#rawTable').append(row);
                counter++;
                
            	 // 테이블이 많이 생성되면 스크롤바 생성
                var table = document.getElementById('rawTable');
                table.scrollTop = table.scrollHeight;
            }

            // 버튼 클릭시 addRow() 기능 불러오기
            $('#addButton').click(function() {
                addRow();
            });
            
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
							url: "/performance/rawMaterialDelete",
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

<!-- page content -->
<div class="right_col" role="main">

	<h1>rawMaterial</h1>
	
	<form action="" method="get">
		<fieldset>
       		<label>품번:</label>
        	<input type="text" name="raw_code" id="searchCode">
        	<label>거래처명:</label>
        	<input type="text" name="clients.client_actname" id="searchName">
        	<br>
        	<label>품명:</label>
        	<input type="text" name="raw_name" id="searchCategory"> 
        	<input type="submit" value="검색">
		</fieldset>
	</form>
	
	
	<form action="" method="post" id="fr">
		<button id="addButton">추가</button>
		<button id="modify">수정</button>
		<button id="delete">삭제</button>
		<button type="reset" id="cancle">취소</button>
		<input type="submit" value="저장" id="save">

	
		<table border="1" id="rawTable">
				<tr>
					<th>번호</th>
					<th>품번</th>
					<th>품명</th>
					<th>색상</th>
					<th>재고 단위</th>
					<th>규격</th>
					<th>거래처코드</th>
					<th>거래처명</th>
					<th>매입단가</th>
					<th>비고</th>
				</tr>
			<c:forEach var="vo" items="${rawList}">
					<tr>
						<td></td>
         			    <td id="rawCode">${vo.raw_code }</td>
						<td>${vo.raw_name }</td>
						<td>${vo.raw_color }</td>
						<td>${vo.raw_unit }</td>
						<td>${vo.raw_size }</td>
						<td>${vo.client_code }</td>
						<td>${vo.clients.client_actname }</td>
						<td>${vo.raw_price }</td>
						<td>${vo.raw_note }</td>
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