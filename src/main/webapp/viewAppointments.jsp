<%@ page import="java.sql.*" %>
<%@ page import="com.example.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="layout.jsp"/>

<%
String success = request.getParameter("success");
String error = request.getParameter("error");
%>

<% if ("updated".equals(success)) { %>

    <div class="alert alert-success alert-dismissible fade show shadow-sm">

        <i class="fa fa-check-circle"></i>

        <strong>Success!</strong>
        Appointment updated successfully.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>

    </div>




<% if ("deleted".equals(success)) { %>

    <div class="alert alert-success alert-dismissible fade show shadow-sm">
        <iclass="fa fa-check-circle"></i>
        <strong>Success!</strong> Appointment deleted successfully.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } %>
<% } else if ("invalid".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show">
        <strong>Error!</strong> Invalid appointment request.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } else if ("notfound".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show">
        <strong>Error!</strong> Appointment not found.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } else if ("database".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show">
        <strong>Error!</strong> Unable to delete appointment.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } %>

<!-- ========================================================= -->
<!-- PAGE HEADER -->
<!-- ========================================================= -->

<div class="d-flex justify-content-between align-items-center mb-4">

    <div>
        <h3 class="mb-1">
            📅 Appointments Dashboard
        </h3>

        <p class="text-muted mb-0">
            Manage hospital appointments
        </p>
    </div>

    <a href="appointment.jsp" class="btn btn-primary">
        <i class="fa fa-plus"></i>
        Book Appointment
    </a>

</div>


<%
Connection con = null;
Statement st = null;

int totalAppointments = 0;
int approvedAppointments = 0;
int pendingAppointments = 0;
int rejectedAppointments = 0;

try {

    con = DBConnection.getConnection();
    st = con.createStatement();

    /* TOTAL */
    ResultSet countRs =
            st.executeQuery("SELECT COUNT(*) FROM appointments");

    if (countRs.next()) {
        totalAppointments = countRs.getInt(1);
    }

    countRs.close();


    /* APPROVED */
    ResultSet approvedRs =
            st.executeQuery(
                    "SELECT COUNT(*) FROM appointments WHERE status='Approved'"
            );

    if (approvedRs.next()) {
        approvedAppointments = approvedRs.getInt(1);
    }

    approvedRs.close();


    /* PENDING */
    ResultSet pendingRs =
            st.executeQuery(
                    "SELECT COUNT(*) FROM appointments WHERE status='Pending'"
            );

    if (pendingRs.next()) {
        pendingAppointments = pendingRs.getInt(1);
    }

    pendingRs.close();


    /* REJECTED */
    ResultSet rejectedRs =
            st.executeQuery(
                    "SELECT COUNT(*) FROM appointments WHERE status='Rejected'"
            );

    if (rejectedRs.next()) {
        rejectedAppointments = rejectedRs.getInt(1);
    }

    rejectedRs.close();

%>


<!-- ========================================================= -->
<!-- STATISTICS -->
<!-- ========================================================= -->

<div class="row g-4 mb-4">


    <!-- TOTAL -->

    <div class="col-xl-3 col-md-6">

        <div class="card border-0 shadow-sm h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between">

                    <div>

                        <p class="text-muted mb-1">
                            Total Appointments
                        </p>

                        <h2 class="fw-bold text-primary mb-0">
                            <%= totalAppointments %>
                        </h2>

                    </div>

                    <div class="fs-1 text-primary">
                        <i class="fa fa-calendar"></i>
                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- APPROVED -->

    <div class="col-xl-3 col-md-6">

        <div class="card border-0 shadow-sm h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between">

                    <div>

                        <p class="text-muted mb-1">
                            Approved
                        </p>

                        <h2 class="fw-bold text-success mb-0">
                            <%= approvedAppointments %>
                        </h2>

                    </div>

                    <div class="fs-1 text-success">
                        <i class="fa fa-check-circle"></i>
                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- PENDING -->

    <div class="col-xl-3 col-md-6">

        <div class="card border-0 shadow-sm h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between">

                    <div>

                        <p class="text-muted mb-1">
                            Pending
                        </p>

                        <h2 class="fw-bold text-warning mb-0">
                            <%= pendingAppointments %>
                        </h2>

                    </div>

                    <div class="fs-1 text-warning">
                        <i class="fa fa-clock"></i>
                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- REJECTED -->

    <div class="col-xl-3 col-md-6">

        <div class="card border-0 shadow-sm h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between">

                    <div>

                        <p class="text-muted mb-1">
                            Rejected
                        </p>

                        <h2 class="fw-bold text-danger mb-0">
                            <%= rejectedAppointments %>
                        </h2>

                    </div>

                    <div class="fs-1 text-danger">
                        <i class="fa fa-times-circle"></i>
                    </div>

                </div>

            </div>

        </div>

    </div>

</div>


<!-- ========================================================= -->
<!-- APPOINTMENT TABLE -->
<!-- ========================================================= -->

<div class="card border-0 shadow-sm">

    <div class="card-body">

        <div class="d-flex justify-content-between align-items-center mb-3">

            <div>

                <h5 class="mb-1">
                    📋 Appointment List
                </h5>

                <small class="text-muted">
                    View and manage all appointments
                </small>

            </div>

        </div>


        <div class="table-responsive">

            <table class="table table-hover align-middle text-center">

                <thead class="table-primary">

                <tr>

                    <th>ID</th>

                    <th>Patient</th>

                    <th>Doctor</th>

                    <th>Date</th>

                    <th>Time</th>

                    <th>Status</th>

                    <th>Actions</th>

                </tr>

                </thead>


                <tbody>


<%
    ResultSet rs =
            st.executeQuery(
                    "SELECT * FROM appointments ORDER BY id DESC"
            );

    boolean hasAppointments = false;

    while (rs.next()) {

        hasAppointments = true;

        int appointmentId = rs.getInt("id");

        String patientName =
                rs.getString("patient_name");

        String doctorName =
                rs.getString("doctor_name");

        String appointmentDate =
                rs.getString("appointment_date");

        String appointmentTime =
                rs.getString("appointment_time");

        String status =
                rs.getString("status");

        if (status == null || status.trim().isEmpty()) {
            status = "Pending";
        }

        String badgeClass;

        if ("Approved".equalsIgnoreCase(status)) {

            badgeClass = "bg-success";

        } else if ("Rejected".equalsIgnoreCase(status)) {

            badgeClass = "bg-danger";

        } else {

            badgeClass = "bg-warning text-dark";

        }
%>


                <tr>

                    <!-- ID -->

                    <td>
                        <strong>
                            #<%= appointmentId %>
                        </strong>
                    </td>


                    <!-- PATIENT -->

                    <td>

                        <div class="fw-semibold">
                            <%= patientName %>
                        </div>

                    </td>


                    <!-- DOCTOR -->

                    <td>

                        <div class="fw-semibold">
                            <%= doctorName %>
                        </div>

                    </td>


                    <!-- DATE -->

                    <td>

                        <i class="fa fa-calendar text-primary"></i>

                        <%= appointmentDate %>

                    </td>


                    <!-- TIME -->

                    <td>

                        <i class="fa fa-clock text-primary"></i>

                        <%= appointmentTime %>

                    </td>


                    <!-- STATUS -->

                    <td>

                        <span class="badge <%= badgeClass %> px-3 py-2">

                            <%= status %>

                        </span>

                    </td>


                    <!-- ACTIONS -->

                    <td>

                        <div class="d-flex justify-content-center gap-1">


                            <!-- APPROVE -->

                            <a
                                href="UpdateStatusServlet?id=<%= appointmentId %>&status=Approved"
                                class="btn btn-success btn-sm"
                                title="Approve appointment">

                                <i class="fa fa-check"></i>

                            </a>


                            <!-- REJECT -->

                            <a
                                href="UpdateStatusServlet?id=<%= appointmentId %>&status=Rejected"
                                class="btn btn-danger btn-sm"
                                title="Reject appointment">

                                <i class="fa fa-times"></i>

                            </a>

                            <a href="EditAppointmentServlet?id=<%= rs.getInt("id") %>"
                               class="btn btn-warning btn-sm">
                                ✏
                            </a>


                            <!-- DELETE -->

                            <a
                                href="DeleteAppointmentServlet?id=<%= appointmentId %>"
                                class="btn btn-dark btn-sm"
                                title="Delete appointment"
                                onclick="return confirm('Are you sure you want to delete this appointment?');">

                                <i class="fa fa-trash"></i>

                            </a>

                        </div>

                    </td>

                </tr>


<%
    }

    rs.close();


    if (!hasAppointments) {
%>


                <tr>

                    <td colspan="7" class="py-5">

                        <div class="text-muted">

                            <i class="fa fa-calendar-xmark fa-2x mb-3"></i>

                            <h5>No appointments found</h5>

                            <p class="mb-0">
                                There are currently no appointments.
                            </p>

                        </div>

                    </td>

                </tr>


<%
    }

} catch (Exception e) {

    e.printStackTrace();
%>


                <tr>

                    <td colspan="7" class="py-4 text-danger">

                        ❌ Unable to load appointments.

                    </td>

                </tr>


<%
} finally {

    try {

        if (st != null) {
            st.close();
        }

    } catch (Exception ignored) {}

    try {

        if (con != null) {
            con.close();
        }

    } catch (Exception ignored) {}
}
%>


                </tbody>

            </table>

        </div>

    </div>

</div>


<jsp:include page="footer.jsp"/>