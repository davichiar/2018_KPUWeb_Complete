<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="bbs.BBSDTO"%>
<%@ page import="bbs.BBSDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>


<!doctype html>
<html>
  <head>
    <title>DVCLJ - 강의평가, 알고리즘</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- 부트스트랩 CSS 추가하기 -->
    <link rel="stylesheet" href="./css/bootstrap.min.css">

    <!-- 커스텀 CSS 추가하기 -->
    <link rel="stylesheet" href="./css/custom.css">
  </head>

  <body>
  <%
		String userID = null;
	
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.');");
			script.println("location.href = 'userLogin.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
%>
	
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="index.jsp">DVCLJ - 강의 평가 사이트</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav mr-auto">
          
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
              포트폴리오
            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">
              <a class="dropdown-item" href="myself.html">메인</a>
              <a class="dropdown-item" href="davichi.html">정다비치</a>
              <a class="dropdown-item" href="leejuho.html">이주호</a>
            </div>
          </li>
          
          <li class="nav-item active">
            <a class="nav-link" href="index.jsp">강의 평가</a>
          </li>
          
          <li class="nav-item active">
            <a class="nav-link" href="bbs.jsp">자유 게시판</a>
          </li>
          
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
              <%= userID %> 님
            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">
            <% if(userID == null) { %>
              <a class="dropdown-item" href="userLogin.jsp">로그인</a>
              <a class="dropdown-item" href="userRegister.jsp">회원가입</a>
            <% } else { %>
              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
            <% } %>
            </div>
          </li>
        </ul>

        <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
          <input type="text" name="search" class="form-control mr-sm-2" placeholder="내용을 입력하세요.">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
        </form>
      </div>
    </nav>


    <div class="container">
    	<div class="row">
	    	<table class="table table-hover mx-4 mt-4" style="text-align: center; border: 1px solid #dddddd">
	    		<thead>
	    			<tr>
	    				<th style="background-color: #eeeeee; text-align: center;">번호</th>
	    				<th style="background-color: #eeeeee; text-align: center;">제목</th>
	    				<th style="background-color: #eeeeee; text-align: center;">작성자</th>
	    				<th style="background-color: #eeeeee; text-align: center;">작성일</th>
	    			</tr>
	    		</thead>
	    		<tbody>
	    			<%
	    				BBSDAO bbsDAO = new BBSDAO();
	    				ArrayList<BBSDTO> list = bbsDAO.getList(pageNumber);
	    				
	    				for(int i = 0; i < list.size(); i++) {
	    			%>
	    			<tr>
	    				<td><%= list.get(i).getBbsID() %></td>
	    				<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
	    				<td><%= list.get(i).getUserID() %></td>
	    				<td><%= list.get(i).getBbsDate().substring(0, 11) + "일 "+ list.get(i).getBbsDate().substring(11, 13) + "시 " + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
	    			</tr>
	    			<%
	    				}
	    			%>
	    		</tbody>
	    	</table>
	    	<%
	    		if(pageNumber != 1) {
	    	%>
	    	<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left mx-3">이전</a>
	    	<%
	    		} if(bbsDAO.nextPage(pageNumber + 1)) {
	    	%>
	    	<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left mx-3">다음</a>
	    	<%
	    		}
	    	%>
	    	
	    <a href="write.jsp" class="btn btn-primary" >글쓰기</a>
    	</div>
    	
    </div>

    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
      Copyright ⓒ 2018 DVCLJ 정다비치, 이주호 All Rights Reserved.
    </footer>

    <!-- 제이쿼리 자바스크립트 추가하기 -->
    <script src="./js/jquery.min.js"></script>

    <!-- Popper 자바스크립트 추가하기 -->
    <script src="./js/popper.min.js"></script>

    <!-- 부트스트랩 자바스크립트 추가하기 -->
    <script src="./js/bootstrap.min.js"></script>
  </body>
</html>