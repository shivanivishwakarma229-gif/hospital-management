<%@ page import="com.example.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.DoctorDAO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="layout.jsp"/>

<%
    // Get appointment object sent by servlet
    Object appointmentObj = request.getAttribute("appointment");

    if (appointmentObj == null) {
%>

    <div class="alert alert-danger">
        <strong>Error!</strong> Appointment information not found.
    </div>

    <a href="viewAppointments.jsp" class="btn btn-secondary">
        ← Back to Appointments
    </a>

<%
        return;
    }

    // Read appointment values from request attributes
    int id = (Integer) request.getAttribute("appointmentId");

    String patientName = (String) request.getAttribute("patientName");
    String doctorName = (String) request.getAttribute("doctorName");
    String appointmentDate = (String) request.getAttribute("appointmentDate");
    String appointmentTime = (String) request.getAttribute("appointmentTime");
    String status = (String) request.getAttribute("status");

    if (patientName == null) patientName = "";
    if (doctorName == null) doctorName = "";
    if (appointmentDate == null) appointmentDate = "";
    if (appointmentTime == null) appointmentTime = "";
    if (status == null) status = "Pending";

    String error = (String) request.getAttribute("error");
%>


<!-- ========================================================= -->
<!-- PAGE HEADER -->
<!-- ========================================================= -->

<div class="d-flex justify-content-between align-items-center mb-4">

    <div>

        <h3>
            ✏️ Edit Appointment
        </h3>

        <p class="text-muted mb-0">
            Update patient appointment details
        </p>

    </div>

    <a href="viewAppointments.jsp"
       class="btn btn-secondary">

        ← Back to Appointments

    </a>

</div>


<!-- ========================================================= -->
<!-- ERROR MESSAGE -->
<!-- ========================================================= -->

<%
    if (error != null) {
%>

<div class="alert alert-danger alert-dismissible fade show">

    <i class="fa fa-exclamation-circle"></i>

    <strong>Error!</strong>
    <%= error %>

    <button type="button"
            class="btn-close"
            data-bs-dismiss="alert">
    </button>

</div>

<%
    }
%>


<!-- ========================================================= -->
<!-- EDIT APPOINTMENT CARD -->
<!-- ========================================================= -->

<div class="card shadow-sm border-0"
     style="max-width: 700px;">

    <div class="card-body p-4">


        <form action="EditAppointmentServlet"
              method="post">


            <!-- Appointment ID -->

            <input type="hidden"
                   name="id"
                   value="<%= id %>">


            <!-- ================================================= -->
            <!-- PATIENT NAME -->
            <!-- ================================================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    Patient Name

                </label>

                <input
                        type="text"
                        name="patientName"
                        class="form-control"
                        value="<%= patientName %>"
                        placeholder="Enter patient name"
                        required>

            </div>


            <!-- ================================================= -->
            <!-- DOCTOR -->
            <!-- ================================================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    Select Doctor

                </label>


                <select name="doctor"
                        class="form-select"
                        required>

                    <option value="">
                        Select Doctor
                    </option>


<%
    List<Doctor> doctors = DoctorDAO.getAllDoctors();

    if (doctors != null) {

        for (Doctor doctor : doctors) {

            String selected = "";

            if (doctor.getName().equals(doctorName)) {
                selected = "selected";
            }
%>

                    <option
                            value="<%= doctor.getName() %>"
                            <%= selected %>>

                        <%= doctor.getName() %>
                        -
                        <%= doctor.getSpecialization() %>

                    </option>

<%
        }
    }
%>

                </select>

            </div>


            <!-- ================================================= -->
            <!-- DATE -->
            <!-- ================================================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    Appointment Date

                </label>

                <input
                        type="date"
                        name="date"
                        class="form-control"
                        value="<%= appointmentDate %>"
                        required>

            </div>


            <!-- ================================================= -->
            <!-- TIME -->
            <!-- ================================================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    Appointment Time

                </label>

                <input
                        type="time"
                        name="time"
                        class="form-control"
                        value="<%= appointmentTime %>"
                        required>

            </div>


            <!-- ================================================= -->
            <!-- STATUS -->
            <!-- ================================================= -->

            <div class="mb-4">

                <label class="form-label fw-semibold">

                    Appointment Status

                </label>

                <select name="status"
                        class="form-select">

                    <option value="Pending"
                        <%= "Pending".equals(status) ? "selected" : "" %>>

                        Pending

                    </option>

                    <option value="Approved"
                        <%= "Approved".equals(status) ? "selected" : "" %>>

                        Approved

                    </option>

                    <option value="Rejected"
                        <%= "Rejected".equals(status) ? "selected" : "" %>>

                        Rejected

                    </option>

                </select>

            </div>


            <!-- ================================================= -->
            <!-- BUTTONS -->
            <!-- ================================================= -->

            <div class="d-flex gap-2">

                <button
                        type="submit"
                        class="btn btn-primary">

                    <i class="fa fa-save"></i>

                    Update Appointment

                </button>


                <a
                        href="viewAppointments.jsp"
                        class="btn btn-secondary">

                    Cancel

                </a>

            </div>


        </form>

    </div>

</div>


<jsp:include page="footer.jsp"/>