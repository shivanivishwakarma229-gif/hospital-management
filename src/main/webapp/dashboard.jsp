<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.example.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!-- COMMON LAYOUT -->
<jsp:include page="layout.jsp"/>

<%
    int totalPatients = 0;
    int totalDoctors = 0;
    int totalAppointments = 0;

    int approvedAppointments = 0;
    int pendingAppointments = 0;
    int rejectedAppointments = 0;

    try {

        Connection con = DBConnection.getConnection();

        // =================================================
        // TOTAL PATIENTS
        // =================================================

        PreparedStatement patientPs =
                con.prepareStatement(
                        "SELECT COUNT(*) FROM patients"
                );

        ResultSet patientRs = patientPs.executeQuery();

        if (patientRs.next()) {
            totalPatients = patientRs.getInt(1);
        }

        patientRs.close();
        patientPs.close();


        // =================================================
        // TOTAL DOCTORS
        // =================================================

        PreparedStatement doctorPs =
                con.prepareStatement(
                        "SELECT COUNT(*) FROM doctors"
                );

        ResultSet doctorRs = doctorPs.executeQuery();

        if (doctorRs.next()) {
            totalDoctors = doctorRs.getInt(1);
        }

        doctorRs.close();
        doctorPs.close();


        // =================================================
        // TOTAL APPOINTMENTS
        // =================================================

        PreparedStatement appointmentPs =
                con.prepareStatement(
                        "SELECT COUNT(*) FROM appointments"
                );

        ResultSet appointmentRs = appointmentPs.executeQuery();

        if (appointmentRs.next()) {
            totalAppointments = appointmentRs.getInt(1);
        }

        appointmentRs.close();
        appointmentPs.close();


        // =================================================
        // APPOINTMENT STATUS COUNTS
        // =================================================

        PreparedStatement statusPs =
                con.prepareStatement(
                        "SELECT status, COUNT(*) AS total " +
                        "FROM appointments " +
                        "GROUP BY status"
                );

        ResultSet statusRs = statusPs.executeQuery();

        while (statusRs.next()) {

            String status = statusRs.getString("status");
            int count = statusRs.getInt("total");

            if (status != null) {

                if (status.equalsIgnoreCase("Approved")) {

                    approvedAppointments = count;

                } else if (status.equalsIgnoreCase("Pending")) {

                    pendingAppointments = count;

                } else if (status.equalsIgnoreCase("Rejected")) {

                    rejectedAppointments = count;
                }
            }
        }

        statusRs.close();
        statusPs.close();


        // =================================================
        // CLOSE DATABASE CONNECTION
        // =================================================

        con.close();


    } catch (Exception e) {

        e.printStackTrace();
    }
%>


<!-- ========================================================= -->
<!-- DASHBOARD HEADER -->
<!-- ========================================================= -->

<div class="d-flex justify-content-between align-items-center mb-4">

    <div>

        <h2 class="mb-1">
            🏥 Hospital Dashboard
        </h2>

        <p class="text-muted mb-0">
            Overview of hospital management system
        </p>

    </div>

</div>


<!-- ========================================================= -->
<!-- MAIN STATISTICS -->
<!-- ========================================================= -->

<div class="row g-4 mb-4">


    <!-- PATIENTS -->

    <div class="col-md-4">

        <div class="card shadow-sm border-0 h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <p class="text-muted mb-1">
                            Total Patients
                        </p>

                        <h2 class="fw-bold mb-0 text-primary">
                            <%= totalPatients %>
                        </h2>

                    </div>

                    <div class="fs-1 text-primary">
                        👥
                    </div>

                </div>

                <hr>

                <a href="patient.jsp"
                   class="text-decoration-none">

                    View Patients →

                </a>

            </div>

        </div>

    </div>


    <!-- DOCTORS -->

    <div class="col-md-4">

        <div class="card shadow-sm border-0 h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <p class="text-muted mb-1">
                            Total Doctors
                        </p>

                        <h2 class="fw-bold mb-0 text-success">
                            <%= totalDoctors %>
                        </h2>

                    </div>

                    <div class="fs-1 text-success">
                        👨‍⚕️
                    </div>

                </div>

                <hr>

                <a href="doctor.jsp"
                   class="text-decoration-none">

                    View Doctors →

                </a>

            </div>

        </div>

    </div>


    <!-- APPOINTMENTS -->

    <div class="col-md-4">

        <div class="card shadow-sm border-0 h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <p class="text-muted mb-1">
                            Total Appointments
                        </p>

                        <h2 class="fw-bold mb-0 text-warning">
                            <%= totalAppointments %>
                        </h2>

                    </div>

                    <div class="fs-1 text-warning">
                        📅
                    </div>

                </div>

                <hr>

                <a href="viewAppointments.jsp"
                   class="text-decoration-none">

                    View Appointments →

                </a>

            </div>

        </div>

    </div>

</div>


<!-- ========================================================= -->
<!-- APPOINTMENT STATUS -->
<!-- ========================================================= -->

<div class="row g-4 mb-4">


    <!-- APPROVED -->

    <div class="col-md-4">

        <div class="card shadow-sm border-0 h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <p class="text-muted mb-1">
                            Approved Appointments
                        </p>

                        <h2 class="fw-bold mb-0 text-success">
                            <%= approvedAppointments %>
                        </h2>

                    </div>

                    <div class="fs-1 text-success">
                        ✅
                    </div>

                </div>

                <hr>

                <span class="text-success">
                    Appointments approved
                </span>

            </div>

        </div>

    </div>


    <!-- PENDING -->

    <div class="col-md-4">

        <div class="card shadow-sm border-0 h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <p class="text-muted mb-1">
                            Pending Appointments
                        </p>

                        <h2 class="fw-bold mb-0 text-warning">
                            <%= pendingAppointments %>
                        </h2>

                    </div>

                    <div class="fs-1 text-warning">
                        ⏳
                    </div>

                </div>

                <hr>

                <span class="text-warning">
                    Waiting for approval
                </span>

            </div>

        </div>

    </div>


    <!-- REJECTED -->

    <div class="col-md-4">

        <div class="card shadow-sm border-0 h-100">

            <div class="card-body">

                <div class="d-flex justify-content-between align-items-center">

                    <div>

                        <p class="text-muted mb-1">
                            Rejected Appointments
                        </p>

                        <h2 class="fw-bold mb-0 text-danger">
                            <%= rejectedAppointments %>
                        </h2>

                    </div>

                    <div class="fs-1 text-danger">
                        ❌
                    </div>

                </div>

                <hr>

                <span class="text-danger">
                    Appointments rejected
                </span>

            </div>

        </div>

    </div>

</div>


<!-- ========================================================= -->
<!-- RECENT APPOINTMENTS -->
<!-- ========================================================= -->

<div class="card shadow-sm border-0 mb-4">

    <div class="card-body">

        <div class="d-flex justify-content-between align-items-center mb-3">

            <div>
                <h5 class="mb-1">
                    📋 Recent Appointments
                </h5>

                <p class="text-muted mb-0">
                    Latest appointments in the hospital
                </p>
            </div>

            <a href="viewAppointments.jsp"
               class="btn btn-primary btn-sm">

                View All Appointments →

            </a>

        </div>


        <div class="table-responsive">

            <table class="table table-hover align-middle mb-0">

                <thead class="table-primary">

                    <tr>
                        <th>Patient</th>
                        <th>Doctor</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>

                </thead>


                <tbody>

                <%
                    try {

                        Connection recentCon =
                                DBConnection.getConnection();

                        PreparedStatement recentPs =
                                recentCon.prepareStatement(
                                    "SELECT patient_name, doctor_name, " +
                                    "appointment_date, appointment_time, status " +
                                    "FROM appointments " +
                                    "ORDER BY id DESC LIMIT 5"
                                );

                        ResultSet recentRs =
                                recentPs.executeQuery();

                        boolean hasAppointments = false;


                        while (recentRs.next()) {

                            hasAppointments = true;

                            String recentStatus =
                                    recentRs.getString("status");

                %>

                    <tr>

                        <td>
                            <strong>
                                <%= recentRs.getString("patient_name") %>
                            </strong>
                        </td>


                        <td>
                            <%= recentRs.getString("doctor_name") %>
                        </td>


                        <td>
                            <%= recentRs.getString("appointment_date") %>
                        </td>


                        <td>
                            <%= recentRs.getString("appointment_time") %>
                        </td>


                        <td>

                            <%
                                if ("Approved".equalsIgnoreCase(recentStatus)) {
                            %>

                                <span class="badge bg-success">
                                    Approved
                                </span>

                            <%
                                } else if ("Rejected".equalsIgnoreCase(recentStatus)) {
                            %>

                                <span class="badge bg-danger">
                                    Rejected
                                </span>

                            <%
                                } else {
                            %>

                                <span class="badge bg-warning text-dark">
                                    Pending
                                </span>

                            <%
                                }
                            %>

                        </td>

                    </tr>

                <%
                        }


                        if (!hasAppointments) {
                %>

                    <tr>

                        <td colspan="5"
                            class="text-center text-muted py-4">

                            No appointments found.

                        </td>

                    </tr>

                <%
                        }


                        recentRs.close();
                        recentPs.close();
                        recentCon.close();

                    } catch (Exception e) {

                        e.printStackTrace();
                %>

                    <tr>

                        <td colspan="5"
                            class="text-center text-danger py-4">

                            Unable to load recent appointments.

                        </td>

                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>

</div>

<!-- ========================================================= -->
<!-- APPOINTMENT STATUS CHART -->
<!-- ========================================================= -->

<div class="card shadow-sm border-0 mb-4">

    <div class="card-body">

        <h5 class="mb-1">
            📊 Appointment Status Overview
        </h5>

        <p class="text-muted mb-4">
            Overview of approved, pending and rejected appointments
        </p>

        <div style="max-width: 500px; margin: auto;">

            <canvas id="appointmentStatusChart"></canvas>

        </div>

    </div>

</div>


<!-- ========================================================= -->
<!-- CHART SCRIPT -->
<!-- ========================================================= -->

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>

    const approvedCount = <%= approvedAppointments %>;
    const pendingCount = <%= pendingAppointments %>;
    const rejectedCount = <%= rejectedAppointments %>;

    const ctx =
        document.getElementById('appointmentStatusChart');

    new Chart(ctx, {

        type: 'doughnut',

        data: {

            labels: [
                'Approved',
                'Pending',
                'Rejected'
            ],

            datasets: [{

                data: [
                    approvedCount,
                    pendingCount,
                    rejectedCount
                ],

                backgroundColor: [
                    '#198754',
                    '#ffc107',
                    '#dc3545'
                ],

                borderWidth: 1

            }]

        },

        options: {

            responsive: true,

            plugins: {

                legend: {
                    position: 'bottom'
                }

            }

        }

    });

</script>


<!-- ========================================================= -->
<!-- QUICK ACTIONS -->
<!-- ========================================================= -->

<div class="card shadow-sm border-0">

    <div class="card-body">

        <h5 class="mb-3">
            Quick Actions
        </h5>

        <div class="d-flex gap-2 flex-wrap">

            <a href="patient.jsp"
               class="btn btn-primary">

                👥 Manage Patients

            </a>

            <a href="doctor.jsp"
               class="btn btn-success">

                👨‍⚕️ Manage Doctors

            </a>

            <a href="appointment.jsp"
               class="btn btn-warning">

                📅 Book Appointment

            </a>

            <a href="viewAppointments.jsp"
               class="btn btn-dark">

                📋 View Appointments

            </a>

        </div>

    </div>

</div>


<!-- CLOSE LAYOUT -->

<jsp:include page="footer.jsp"/>