<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.hobbyist.oneday.model.vo.Oneday, com.hobbyist.oneday.model.vo.Cate" %>

<%	
	List<Oneday> list = (List)request.getAttribute("List");
	List<Cate> category = (List)request.getAttribute("Category");
	int cPage = (Integer)request.getAttribute("cPage");
	int numPerPage = (Integer)request.getAttribute("numPerPage");
	int totalCount = (Integer)request.getAttribute("TotalCount");
	String pageBar = (String)request.getAttribute("pageBar");
	String keyword = (String)request.getAttribute("keyword");
	String sort = (String)request.getAttribute("sort");
%>

<%@ include file="/views/common/header.jsp" %>

<!-- 로그인 안된 상태로 왔을때 접근 막기 -->
<script>
	if(<%= logginMember!=null && logginMember.getMemberEmail().equals("admin") %>) {
		
	} else {
		alert('관리자만 접근 가능합니다');
		location.href=history.back(-1);
	}
</script>

<section id="admin">
	<div class="admin_content">
		<div class="admin_top" id="admin_top">
			<ul>
				<li onclick="location.href='<%= request.getContextPath() %>'"><img src="<%= request.getContextPath() %>/images/back.png" width="18px"></li>
				<li>ONEDAY CLASS  | 원데이클래스</li>
				<li>관리자페이지 > 원데이클래스 관리 > 원데이클래스 목록</li>
			</ul>
			
		</div><br>
		
		<!-- 관리자메뉴는 중복되기때문에 admin_menu.jsp 파일로 인클루드 시켜 가져옴 -->
		<%@ include file="/views/admin/admin_menu.jsp" %> 
		<!-- 관리자 메뉴 인클루드 끝 -->

		<div class="admin_right">
			<h3>ONEDAY CLASS</h3>
			<div id="admin_main">
				<div class="main-top">
					<table>
						<tr>
							<td colspan="8" style="text-align:center;">총 ( <%= totalCount %> ) 건의 상품목록</td>
						</tr>
						<tr>
							<th style="width:50px;">번호</th>
							<th style="width:90px;">분류</th>
							<th style="width:400px;">클래스이름</th>
							<th style="width:120px;">작가</th>
							<th style="width:60px;">가격</th>
							<th style="width:100px;">등록일</th>
						</tr>
						<% for(Oneday s : list) { %>
							<tr>
								<td><%= s.getOnedayNo() %></td>
								<td><%= s.getOnedayCate() %></td>
								<td><a href="<%= request.getContextPath() %>/admin/adminOnedayView?no=<%= s.getOnedayNo() %>"><%= s.getOnedayName() %></a></td>
								<td><%= s.getOnedayWriter() %></td>
								<td><%= s.getOnedayPrice() %></td>
								<td><%= s.getOnedayDate() %></td>
							</tr>
						<% } %>
						<tr>
							<td colspan="8" class="pageBar"><%= pageBar %></td>
						</tr>
					</table>
				</div>
				<div class="main-bottom"></div>
			</div>
		</div>
	</div>
</section>

<%@ include file="/views/common/footer.jsp" %>