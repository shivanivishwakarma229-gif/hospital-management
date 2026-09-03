

<%@ include file="header.jsp" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>


<%@ include file="footer.jsp" %>