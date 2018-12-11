<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BBSDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");

	String userID = null;
	String bbsTitle = null;
	String bbsContent = null;
	
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(request.getParameter("bbsTitle") != null) {
		bbsTitle = (String) request.getParameter("bbsTitle");
	}
	if(request.getParameter("bbsContent") != null) {
		bbsContent = (String) request.getParameter("bbsContent");
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
	
	if (bbsTitle == null || bbsContent == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	else {
		BBSDAO bbsDAO = new BBSDAO();
		int result = bbsDAO.write(bbsTitle, userID, bbsContent);
		
		if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
			script.close();
		}
	}
%>