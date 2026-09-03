<%@ page import="java.util.List" %>
<%@ page import="com.example.DoctorDAO" %>
<%@ page import="com.example.Doctor" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!-- COMMON LAYOUT -->
<jsp:include page="layout.jsp"/>


<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>


<!-- ========================================================= -->
<!-- SUCCESS / ERROR MESSAGES -->
<!-- ========================================================= -->

<% if ("added".equals(success)) { %>

    <div class="alert alert-success alert-dismissible fade show shadow-sm">
        <i class="fa fa-check-circle"></i>
        <strong>Success!</strong> Doctor added successfully.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } else if ("updated".equals(success)) { %>

    <div class="alert alert-success alert-dismissible fade show shadow-sm">
        <i class="fa fa-check-circle"></i>
        <strong>Success!</strong> Doctor updated successfully.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } else if ("deleted".equals(success)) { %>

    <div class="alert alert-success alert-dismissible fade show shadow-sm">
        <i class="fa fa-check-circle"></i>
        <strong>Success!</strong> Doctor deleted successfully.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } else if ("invalid".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show">
        <strong>Error!</strong> Invalid doctor request.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } else if ("update".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show">
        <strong>Error!</strong> Doctor could not be updated.

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>
    </div>

<% } else if ("delete".equals(error)) { %>

    <div class="alert alert-danger alert-dismissible fade show">
        <strong>Error!</strong> Doctor could not be deleted.

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

        <h2 class="mb-1">
            👨‍⚕️ Our Doctors
        </h2>

        <p class="text-muted mb-0">
            Find the right doctor for your healthcare needs
        </p>

    </div>


    <a href="add-doctor.jsp"
       class="btn btn-success">

        <i class="fa fa-plus"></i>
        Add Doctor

    </a>

</div>


<!-- ========================================================= -->
<!-- SEARCH -->
<!-- ========================================================= -->

<div class="card shadow-sm p-4 mb-4">

    <form action="doctor.jsp"
          method="get"
          class="d-flex gap-2">

        <input
                type="text"
                name="search"
                class="form-control"
                placeholder="Search doctor or specialization..."
                value="<%= request.getParameter("search") != null
                        ? request.getParameter("search")
                        : "" %>"
        >

        <button type="submit"
                class="btn btn-primary">

            🔍 Search

        </button>


        <a href="doctor.jsp"
           class="btn btn-secondary">

            Reset

        </a>

    </form>

</div>


<!-- ========================================================= -->
<!-- DOCTOR CARDS -->
<!-- ========================================================= -->

<div class="row g-4">


<%

    String search = request.getParameter("search");

    List<Doctor> doctors;


    if (search != null && !search.trim().isEmpty()) {

        doctors = DoctorDAO.searchDoctors(search.trim());

    } else {

        doctors = DoctorDAO.getAllDoctors();

    }


    if (doctors != null && !doctors.isEmpty()) {


        for (Doctor d : doctors) {

%>


<!-- ========================================================= -->
<!-- SINGLE DOCTOR CARD -->
<!-- ========================================================= -->

<div class="col-xl-4 col-lg-6 col-md-6">

    <div class="card doctor-card shadow-sm h-100">


        <!-- DOCTOR PHOTO -->


        <div class="text-center pt-4">

            <%
                String photo = d.getPhoto();

                if (photo == null || photo.trim().isEmpty()) {
                    photo = "doctor1.jpg";
                }
            %>

            <img
                src="images/<%= photo %>"
                alt="<%= d.getName() %>"
                class="doctor-photo"
            >

        </div>


        <div class="card-body text-center">


            <!-- NAME -->

            <h4 class="doctor-name">

                <%= d.getName() %>

            </h4>


            <!-- SPECIALIZATION -->

            <span class="badge bg-primary mb-3">

                <%= d.getSpecialization() %>

            </span>


            <!-- QUALIFICATION -->

            <p class="mb-2">

                <i class="fa fa-graduation-cap text-primary"></i>

                <strong>Qualification:</strong>

                <%= d.getQualification() %>

            </p>


            <!-- EXPERIENCE -->

            <p class="mb-2">

                <i class="fa fa-briefcase text-primary"></i>

                <strong>Experience:</strong>

                <%= d.getExperience() %> years

            </p>


            <!-- CLINIC TIME -->

            <p class="mb-2">

                <i class="fa fa-clock text-primary"></i>

                <strong>Clinic:</strong>

                <%= d.getClinicTime() %>

            </p>


            <!-- AVAILABLE DAYS -->

            <p class="mb-2">

                <i class="fa fa-calendar-days text-primary"></i>

                <strong>Available:</strong>

                <%= d.getAvailableDays() %>

            </p>


            <!-- CONTACT -->

            <p class="mb-3">

                <i class="fa fa-phone text-success"></i>

                <strong><%= d.getContact() %></strong>

            </p>


            <!-- ================================================= -->
            <!-- BUTTONS -->
            <!-- ================================================= -->

            <div class="d-flex justify-content-center gap-2 flex-wrap">


                <!-- CALL -->

                <a href="tel:<%= d.getContact() %>"
                   class="btn btn-success">

                    <i class="fa fa-phone"></i>
                    Call

                </a>


                <!-- BOOK APPOINTMENT -->

                <a href="appointment.jsp?doctorId=<%= d.getId() %>"
                   class="btn btn-primary">

                    <i class="fa fa-calendar-check"></i>
                    Book Appointment

                </a>

            </div>


            <hr>


            <!-- ADMIN ACTIONS -->

            <div class="d-flex justify-content-center gap-2">


                <a
                        href="DoctorServlet?action=edit&id=<%= d.getId() %>"
                        class="btn btn-warning btn-sm">

                    ✏ Edit

                </a>


                <a href="DoctorServlet?action=delete&id=<%= d.getId() %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete Dr. <%= d.getName() %>?');">
                    <i class="fa fa-trash"></i>
                    Delete
                </a>

            </div>


        </div>

    </div>

</div>


<%

        }


    } else {

%>


<!-- NO DOCTORS -->

<div class="col-12">

    <div class="card shadow-sm text-center p-5">

        <h4>🔍 No doctors found</h4>

        <p class="text-muted">

            Try searching with another doctor name
            or specialization.

        </p>

    </div>

</div>


<%

    }

%>


</div>


<!-- FOOTER -->

<jsp:include page="footer.jsp"/>