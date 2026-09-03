<%@ page import="com.example.Patient" %>

<%
Patient p = (Patient)request.getAttribute("patient");
%>

<form action="PatientServlet" method="post">
    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="id" value="<%=p.getId()%>"/>

    Name: <input type="text" name="name" value="<%=p.getName()%>"><br>
    Age: <input type="number" name="age" value="<%=p.getAge()%>"><br>
    Disease: <input type="text" name="disease" value="<%=p.getDisease()%>"><br>

    <button type="submit">Update</button>
</form>