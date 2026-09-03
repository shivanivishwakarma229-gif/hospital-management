<%@ page import="java.util.List" %>
<%@ page import="com.example.PatientDAO" %>
<%@ page import="com.example.Patient" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="layout.jsp"/>

<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<% if ("added".equals(success)) { %>

    <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
        <i class="fa fa-check-circle"></i>
        <strong>Success!</strong> Patient added successfully.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

<% } else if ("updated".equals(success)) { %>

    <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
        <i class="fa fa-check-circle"></i>
        <strong>Success!</strong> Patient updated successfully.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

<% } else if ("deleted".equals(success)) { %>

    <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
        <i class="fa fa-check-circle"></i>
        <strong>Success!</strong> Patient deleted successfully.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

<% } else if ("invalid".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Error!</strong> Invalid request.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

<% } else if ("update".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Error!</strong> Patient could not be updated.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

<% } else if ("delete".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Error!</strong> Patient could not be deleted.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

<% } %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3>👨‍⚕️ Patients</h3>

    <a href="add-patient.jsp" class="btn btn-success">
        + Add Patient
    </a>
</div>


<!-- SEARCH -->
<div class="card p-4 shadow-sm mb-4">

    <form action="patient.jsp" method="get" class="d-flex gap-2">

        <input
            type="text"
            name="search"
            class="form-control"
            placeholder="Search patient by name..."
            value="<%= request.getParameter("search") != null
                    ? request.getParameter("search") : "" %>"
        >

        <button type="submit" class="btn btn-primary">
            🔍 Search
        </button>

        <a href="patient.jsp" class="btn btn-secondary">
            Reset
        </a>

    </form>

</div>


<!-- PATIENT TABLE -->
<div class="card p-3 shadow-sm">

<table class="table table-hover text-center">

    <thead class="table-primary">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Disease</th>
            <th>Actions</th>
        </tr>
    </thead>

    <tbody>

<%
    String search = request.getParameter("search");

    List<Patient> list;

    if(search != null && !search.trim().isEmpty()) {

        list = PatientDAO.searchPatients(search.trim());

    } else {

        list = PatientDAO.getAllPatients();

    }

    if(list != null && !list.isEmpty()) {

        for(Patient p : list) {
%>

        <tr>

            <td><%= p.getId() %></td>

            <td><%= p.getName() %></td>

            <td><%= p.getAge() %></td>

            <td><%= p.getDisease() %></td>

            <td>

                <a
                    href="PatientServlet?action=edit&id=<%= p.getId() %>"
                    class="btn btn-warning btn-sm">
                    ✏ Edit
                </a>

                <a
                    href="PatientServlet?action=delete&id=<%= p.getId() %>"
                    class="btn btn-danger btn-sm"
                    onclick="return confirm('Are you sure you want to delete this patient?');">
                    🗑 Delete
                </a>

            </td>

        </tr>

<%
        }

    } else {
%>

        <tr>
            <td colspan="5" class="text-muted py-4">
                🔍 No patients found
            </td>
        </tr>

<%
    }
%>

    </tbody>

</table>

</div>


<jsp:include page="footer.jsp"/>