<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
/* 	$.ajax({
		url : '서비스 주소'
			, data : '서비스 처리에 필요한 인자값'
			, type : 'HTTP방식' (POST/GET 등)
			, dataType : 'return 받을 데이터 타입' (json, text 등)
			, success : function('결과값'){
			// 서비스 성공 시 처리 할 내용
			}, error : function('결과값'){
			// 서비스 실패 시 처리 할 내용
			}
		}); */

		function getMemberList() {

			$.ajax({
	            type: 'GET',
	            url: "board/press",
	            cache : false, // 이걸 안쓰거나 true하면 수정해도 값반영이 잘안댐
	            dataType: 'json',// 데이터 타입을 제이슨 꼭해야함, 다른방법도 2가지있음
		        success: function(result) {

					var htmls="";
					
		        	$("#press").html("");	

					$("<tr>" , {
								"<td>" + "아이디" + "</td>"+
								"<td>" + "구독" + "</td>"+
								"<td>" + "날짜" + "</td>"+				
					}).appendTo("#press") // 이것을 테이블에붙임

					if(result.length < 1){
						htmls.push("구독된 정보가 없습니다");
					} else {

		                    $(result).each(function(){			                    			                    
			                    htmls += '<tr>';
			                    htmls += '<td>'+ this.member_idx+ '</td>';
			                    htmls += '<td>'+ this.product_id + '</td>';
			                    htmls += '<td>'
			         			
// 			                    htmls += '<a href="${pageContext.request.contextPath}/content_view?product_id=' + this.product_id + '">' + this.product_name + '</a></td>';
 			                    htmls += '<td>'+ this.order_date + '</td>'; 
			                    htmls += '<td>'+ '<a class="a-delete" data-product_id="${dto.product_id}" href="${pageContext.request.contextPath}/board/delete?product_id=' + this.product_id +'">' +'삭제</a>'  +'</td>';
			                    htmls += '</tr>';			                    		                   
		                	});	//each end

		                	
					}

					$("#press").append(htmls);
					
		        }

			});	// Ajax end
		
		}//end	getList()	
	</script>
	<script>
	$(document).ready(function (){
		
		$(document).on("click",".a-delete",function(event){
			//prevendDefault()는 href로 연결해 주지 않고 단순히 click에 대한 처리를 하도록 해준다.
			event.preventDefault();
			console.log("구독취소"); 
			//해당 tr제거
			var trObj =  $(this).parent().parent();
			
			$.ajax({
			    type : "GET",
			    url : $(this).attr("href"),
			    success: function (result) {       
			        console.log(result); 
					if(result == "SUCCESS"){
			           //getList();
				      $(trObj).remove();  
				      	       
					}					        
			    },
			    error: function (e) {
			        console.log(e);
			    }
			})
			 
		});
	});	
	</script>
	<script>
		$(document).ready(function(){
			getMemberList();
		});
	</script>

</head>
<body>
	<table id="list-table" width="500" cellpadding="0" cellspacing="0" border="1">
	</table>
</body>
</html>