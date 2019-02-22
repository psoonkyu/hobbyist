<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.hobbyist.member.model.vo.Member, com.hobbyist.order.model.vo.OrderData, com.hobbyist.shop.model.vo.Shop" %>

<%
	Member member = (Member)request.getAttribute("Member");
	List<Shop> orderList = (List)request.getAttribute("OrderList");
%>

<%@ include file="/views/common/header.jsp" %>


<section id="order">
	<div class="order_content">
		<div class="myorder_banner">
		<h3>주문하기</h3>
		</div>
		<ul class="myorder_submenu">
		<li onclick="location.href='#step01';">주문클래스 확인 →</li>
		<li onclick="location.href='#step02';">회원정보 입력 →</li>
		<li onclick="location.href='#step03';">할인정보 입력 →</li>
		<li onclick="location.href='#step04';">결제방법 선택</li>
		</ul>
		<br>
		<form name="orderFrm" action="<%= request.getContextPath() %>/order/orderInsert" method="POST">
		<table>
			<tr>
				<th class="tableLine" colspan="2" id="step01"><h3>주문클래스</h3></th>
			</tr>
			<tr>
				<td colspan="2">
					<table id="myCart_Ajax">
						<% 
							int prices = 0;
							int price = 0;
						
							if(!orderList.isEmpty()) {
								%>
								<tr>
									<th style="width: 100px;">카테고리</th>
									<th style="width: 140px;"></th>
									<th style="width: 400px;">클래스</th>
									<th style="width: 100px;">옵션</th>
									<th style="width: 120px;">가격</th>
							</tr>
						<% 
								for(Shop s : orderList) {
						%>
							<tr>
								<td><%= s.getShopCate() %></td>
								<td><img src="<%= request.getContextPath() %>/upload/shop/images/<%= s.getShopImage1() %>" width="150px"></td>
								<td><%= s.getShopName() %></td>
								<td><input type="hidden" name="classOptions" value="<%= s.getShopOption1() %>"><%= s.getShopOption1() %></td>
								<td><% price=s.getShopPrice(); prices += price; %><%= s.getShopPrice() %></td>
							</tr>
							<input type="hidden" name="classNos" value="<%= s.getShopNo() %>"/>
						<%
								}}
						%>
						<input type="hidden" name="order_price" value="<%=prices %>"/>
						</table>
				</td>
			</tr>
			<tr>
				<th class="tableLine" colspan="2" id="step02"><h3>회원정보</h3></th>
			</tr>
			<tr>
				<input type="hidden" name="member" value="<%= member.getMemberEmail() %>"/>
				<th style="width: 200px;">주문자 이름</th>
				<td style="width: 700px;"><%= member.getMemberName() %></td>
			</tr>
			<tr>
				<th>주문자 이메일</th>
				<td><%= member.getMemberEmail() %></td>
			</tr>
			<tr>
				<th>주문자 전화번호</th>
				<td><%= member.getMemberPhone() %></td>
			</tr>
			<tr>
				<th>주문자 주소</th>
				<td>MEMBER 테이블에 주소 컬럼이 없음...</td>
			</tr>
			<tr>
				<th class="tableLine" colspan="2"><h3>수령인 정보</h3>주문자와 동일함 <input type="checkbox" name="sameInfo"/></th>
			</tr>
			<tr>
				<th>수령인 이름</th>
				<td><input type="text" name="order_add_name" placeholder="이름을 작성해주세요"></td>
			</tr>
			<tr>
				<th>수령인 전화번호</th>
				<td><input type="text" name="order_add_phone" placeholder="전화번호를 작성해주세요"></td>
			</tr>
			<tr>
				<th>수령인 주소</th>
				<td><input type="text" name="order_add_address" placeholder="주소를 작성해주세요"></td>
			</tr>
			<tr>
				<th>배송 메세지</th>
				<td><select name="order_msg">
					<option>택배기사님에게 전달할 메세지 선택</option>
					<option value="문 앞">문 앞</option>
					<option value="직접 받고 부재 시 문 앞">직접 받고 부재 시 문 앞</option>
					<option value="경비실">경비실</option>
					<option value="택배함">택배함</option>
				</select></td>
			</tr>
			<tr>
				<th class="tableLine" colspan="2"  id="step03"><h3>할인정보 입력</h3></th>
			</tr>
			<tr>
				<th>가용포인트</th>
				<td></td>
			</tr>
			<tr>
				<th>사용할 포인트</th>
				<td><input type="number" name="usePoint"/></td>
			</tr>
			<tr>
				<th>예상적립포인트</th>
				<td>
					<% 
						int resultPoint = 0;
						for(Shop s : orderList) {
							resultPoint += s.getShopPoint();
						}
					%>
						<input type="hidden" name="addPoint" value="<%= resultPoint %>"/><%= resultPoint %>
				</td>
			</tr>
			<tr>
				<th class="tableLine" colspan="2"  id="step04"><h3>결제방법 선택</h3></th>
			</tr>
			<tr>
				<th>결제방법</th>
				<td>
					<select id="order_type" name="order_type">
						<option>선택</option>
						<option value="kakao">카카오페이 [점검중]</option>
						<option value="card">카드결제</option>
						<option value="mobile">휴대폰결제</option>
					</select>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<!-- 모달창 -->
					<!-- // 카카오페이 결제창 모달 -->
					<div id="kakao" class="modal">
						  <h3>카카오페이 결제 [점검중]</h3>
						  <a href="#" rel="modal:close">Close</a>
					</div>
					
					<!-- // 카드결제창 모달 -->
					<div id="card" class="modal" style="text-align : center;">
						  <h3>카드결제</h3>
						  <table>
						  	<tr>
						  		<th style="width: 150px">상품명</th>
						  		<td style="width: 500px"><%= orderList.get(0).getShopName() %>포함 <%= orderList.size() %>건</td>
						  	</tr>
						  	<tr>
						  		<th>총 결제금액</th>
						  		<td><%= prices %></td>
						  	</tr>
						  	<tr>
						  		<th colspan="2">입력하신 이메일로 결제내역을 보내드립니다 <br>
						  		이메일 주소 : <input type="text" /></th>
						  	</tr>
						  	<tr>
						  		<td colspan="2" style="text-align: center;">
						  			<table>
						  				<tr>
						  					<th style="width: 120px;">카드사 선택</th>
						  					<td style="width: 300px;"><select><option>카드선택</option><option value="SH">SH카드</option><option value="KH">KH카드</option></select></td>
						  				</tr>
						  				<tr>
						  					<th>할부기간</th>
						  					<td><select><option>일시불</option><option value="3month">3개월</option><option value="6month">4개월</option><option value="6month">5개월</option><option value="6month">6개월</option><option value="6month">10개월</option></select>
						  				</tr>
						  				<tr>
						  					<th>카드번호</th>
						  					<td><input style="width: 50px;" type="text" maxlength="4">-<input style="width: 50px;"  type="text" maxlength="4">-<input style="width: 50px;"  type="text" maxlength="4">-<input  style="width: 50px;" type="text" maxlength="4">
						  				</tr>
						  				<tr>
						  					<th colspan="2">Hobbyist 상품결제에 동의합니다 <input type="checkbox"></th>
						  				</tr>
						  			</table>
						  		</td>
						  	</tr>
						  	<tr>
						  		<th colspan="2"><button>결제하기</button></th>
						  	</tr>
						  </table>
					</div>
					
					<!-- // 휴대폰결제창 모달 -->
					<div id="mobile" class="modal">
						  <h3>휴대폰결제</h3>
					</div>
				</th>
			</tr>
			<tr>
				<th class="tableLine" colspan="2"  id="step05"><button type="button" onclick="fn_pay()">결제하기</button></th>
			</tr>
		</table>
			<input type="hidden" id="classNo" name="classNo"/>
			<input type="hidden" id="classOption" name="classOption"/>
		</form>
	</div>
	
	<script>
	
		$('#order_type').on('change', function () {
			var orderType = $('#order_type').val();
			if(orderType=='kakao') {
				$("#kakao").css("display","block");
				$("#card").css("display","none");
				$("#mobile").css("display","none");
			} else if (orderType=='card') {
				$("#kakao").css("display","none");
				$("#card").css("display","block");
				$("#mobile").css("display","none");
			} else if (orderType=='mobile') {
				$("#kakao").css("display","none");
				$("#card").css("display","none");
				$("#mobile").css("display","block");
			}
		});
		
		function fn_pay() {
			var selectNo = '';
			var classOption = '';
			var classNos = $('[name=classNos]');
			var classOptions = $('[name=classOptions]');
			$.each(classOptions, function(index) {
						selectNo += classNos[index].value +',';
						classOption += classOptions[index].value + ',';
			});
			$('#classNo').val(selectNo);
			$('#classOption').val(classOption);
			orderFrm.submit();
		}
		</script>
</section>

<%@ include file="/views/common/footer.jsp" %>