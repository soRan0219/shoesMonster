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
    	
        $(document).ready(function() {
        	
        	let popVal;
        	
        	window.addEventListener('message', function(event){
        		
        		if(event) {
// 	        		alert(event);
	        		
	        		$('#addButton').hide();
	        		$('#save').hide();
	        		
	       			$('#productTable tr:not(:first-child)').click(function(){
	         			$(this).css('background', '#ccc');
	         			
	         			var prodCode = $(this).find('#prodCode').text();
	         			
	         			var inputId = event.data.inputId;
	         			
	         			if(inputId==="prod_code") {
	         				$('#prod_code', opener.document).val(prodCode);
	         			} else if(inputId==="search_prod") {
	         				$('#search_prod', opener.document).val(prodCode);
	         			}
	         			
	         			window.close();
	         		}); 
	        		
	        		popVal = event;
        		} else {
        			alert("null");
        		}
        		
        	
        	}); //addEventListener
        	
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
            
            
            // 필터링 기능
            $('#filterButton').click(function(event) {
            	 
            	
            	//================ 기존코드 ========================
            	
//             	event.preventDefault(); // 페이지 이동 막기
            	 
//                 var searchCode = $('#searchCode').val().toLowerCase();
//                 var searchName = $('#searchName').val().toLowerCase();
//                 var searchCategory = $('#searchCategory').val().toLowerCase();
//                 var searchUnit = $('#searchUnit').val().toLowerCase();
                
//                 $('#productTable tr').each(function() {
//                     var code = $(this).find('td:nth-child(1)').text().toLowerCase();
//                     var name = $(this).find('td:nth-child(2)').text().toLowerCase();
//                     var category = $(this).find('td:nth-child(3)').text().toLowerCase();
//                     var unit = $(this).find('td:nth-child(4)').text().toLowerCase();
                    
//                     if (code.includes(searchCode) 
//                     	&& name.includes(searchName) 
//                     	&& category.includes(searchCategory) 
//                     	&& unit.includes(searchUnit)){
                    	
//                         $(this).show();
                        
//                     } else {
                    	
//                         $(this).hide();
                        
//                     }
//                 });
                
                
            	//================ 기존코드 ========================
            	
            	
                var searchCode = $('#searchCode').val().toLowerCase();
                var searchName = $('#searchName').val().toLowerCase();
                var searchCategory = $('#searchCategory').val().toLowerCase();
                var searchUnit = $('#searchUnit').val().toLowerCase();
            	
//             	alert(searchName);
            		
            	var jsonData = {
            			prod_code:searchCode,
            			prod_name:searchName,
            			prod_category:searchCategory,
            			prod_unit:searchUnit
            	};
            	
            	$.ajax({
            		url: "/performance/search",
            		type: "post",
            		contentType: "application/json; charset=UTF-8",
    				dataType: "json",
    				data: JSON.stringify(jsonData),
    				success: function(data) {
    					//data => List 객체
    					if(data.length != 0) {
    						//검색 결과 있을 때
    						for(var i=0; i<data.length; i++) {
    							console.log(data[i].prod_code);
    							
    							//th 밑에 있던 줄 모두 제거하고 검색결과 append
    							var tbl = "<tr>";
    							tbl += " <td id='prodCode'>" + data[i].prod_code + "</td>";
    							tbl += " <td>" + data[i].prod_name + "</td>";
    							tbl += " <td>" + data[i].prod_category + "</td>";
    							tbl += " <td>" + data[i].prod_unit + "</td>";
    							tbl += " <td>" + data[i].prod_color + "</td>";
    							tbl += " <td>" + data[i].prod_size + "</td>";
    							tbl += " <td>" + data[i].client_code + "</td>";
    							tbl += " <td>" + data[i].prod_price + "</td>";
    							tbl += " <td>" + data[i].prod_note + "</td>";
    							tbl += "</tr>";
    							
    							if(i==0) {
    								$('#productTable tr:gt(0)').remove();
    								$('#productTable').append(tbl);
    							} else {
    								$('#productTable').append(tbl);
    							}
    							
    						} //for
    					} //if(검색결과 있을 때)
    					
    					//팝업으로 열었을 때
    					if(popVal) {
    						
    			   			$('#productTable tr:not(:first-child)').click(function(){
    			     			$(this).css('background', '#ccc');
    			     			
    			     			var prodCode = $(this).find('#prodCode').text();
    			     			
    			     			var inputId = popVal.data.inputId;
    			     			
    			     			if(inputId==="prod_code") {
    			     				$('#prod_code', opener.document).val(prodCode);
    			     			} else if(inputId==="search_prod") {
    			     				$('#search_prod', opener.document).val(prodCode);
    			     			}
    			     			
    			     			window.close();
    			     		}); 
    						
    					} //if(popVal)
    					
    					
    					
    				},
    				error: function() {
    					alert(" ****** 실패 *******");
    				}
            	}); //ajax
            		
            }); //검색
            
        	
        	
        	
        	
            // 저장 버튼 클릭 시 페이지 이동
            $('form').submit(function() {
               return true;
            });
            
            
            
        });
    </script>

</head>
<body>

	<h1>product</h1>
	
	<form action="" method="get">
		<fieldset>
       		<label>품번:</label>
        	<input type="text" name="prod_code" id="searchCode">
        	<label>품명:</label>
        	<input type="text" name="prod_name" id="searchName">
        	<br>
        	<label>카테고리:</label>
        	<input type="text" name="prod_category" id="searchCategory"> 
        	<label>품목 단위:</label>
        	<input type="text" name="prod_unit" id="searchUnit">
<!--         	<input type="submit" value="검색"> -->
        	<input type="button" value="검색" id="filterButton">
		</fieldset>
	</form>
	
	
	<form action="" method="post" onsubmit="return false">
		<button id="addButton">추가</button>
		<input id="save" type="submit" value="저장">
		
	
		
	
		<table border="1" id="productTable">
				<tr>
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



</body>
</html>