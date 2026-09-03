<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>Hospital Management System</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">

</head>

<body>

<div class="hospital-wrapper">

    <div class="container-fluid">

        <div class="row">

            <!-- SIDEBAR -->
            <div class="col-md-2 sidebar">

                <h4 class="sidebar-title">
                    🏥 Admin
                </h4>

                <hr>

                <a href="dashboard.jsp">
                    <i class="fa fa-home"></i>
                    Dashboard
                </a>

                <a href="patient.jsp">
                    <i class="fa fa-users"></i>
                    Patients
                </a>

                <a href="appointment.jsp">
                    <i class="fa fa-calendar-plus"></i>
                    Book Appointment
                </a>

                <a href="viewAppointments.jsp">
                    <i class="fa fa-calendar"></i>
                    Appointments
                </a>

                <a href="doctor.jsp">
                    <i class="fa fa-user-doctor"></i>
                    Doctors
                </a>

                <a href="logout.jsp">
                    <i class="fa fa-sign-out-alt"></i>
                    Logout
                </a>

            </div>

            <!-- MAIN CONTENT -->
            <div class="col-md-10 main-content">
