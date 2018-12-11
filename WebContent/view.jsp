<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BBSDTO"%>
<%@ page import="bbs.BBSDAO"%>
<%@ page import="user.UserDAO"%>
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
		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
			script.close();
		}
		BBSDTO bbs = new BBSDAO().getBbs(bbsID);
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
    		<table class="table table-striped mt-4 mx-4" style="text-align: center; border: 1px solid #dddddd; ">
	    		<thead>
	    			<tr>
	    				<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
	    			</tr>
	    		</thead>
	    		<tbody>
	    			<tr>
	    				<td style="width: 20%;">글 제목</td>
	    				<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
	    			</tr>
	    			<tr>
	    				<td>작성자</td>
	    				<td colspan="2"><%= bbs.getUserID() %></td>
	    			</tr>
	    			<tr>
	    				<td>작성일자</td>
	    				<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + "일 "+ bbs.getBbsDate().substring(11, 13) + "시 " + bbs.getBbsDate().substring(14, 16) + "분" %></td>
	    			</tr>
	    			<tr>
	    				<td>내용</td>
	    				<td colspan="2" style="height: 250px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
	    			</tr>
	    		</tbody>
    		</table>
    		<a href="bbs.jsp" class="btn btn-primary mx-1">목록</a>
    		<%
    			if(userID != null && userID.equals(bbs.getUserID())) {
    		%>
    		<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-success mx-1">수정</a>
    		<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteActionBBS.jsp?bbsID=<%= bbsID %>" class="btn btn-danger mx-1">삭제</a>
    		
    		<%
    			}
    		%>
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