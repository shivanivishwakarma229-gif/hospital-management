<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.example.Doctor" %>

<%
    Doctor doctor = (Doctor) request.getAttribute("doctor");

    if (doctor == null) {
        response.sendRedirect("doctor.jsp?error=invalid");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<jsp:include page="layout.jsp"/>


<!-- ============================= -->
<!-- PAGE HEADER -->
<!-- ============================= -->

<div class="d-flex justify-content-between align-items-center mb-4">

    <div>

        <h3 class="mb-1">
            ✏️ Edit Doctor
        </h3>

        <p class="text-muted mb-0">
            Update doctor information
        </p>

    </div>


    <a href="doctor.jsp" class="btn btn-secondary">

        <i class="fa fa-arrow-left"></i>
        Back to Doctors

    </a>

</div>


<!-- ============================= -->
<!-- ERROR MESSAGE -->
<!-- ============================= -->

<% if (error != null) { %>

<div class="alert alert-danger alert-dismissible fade show">

    <i class="fa fa-circle-exclamation"></i>

    <strong>Error!</strong>
    <%= error %>

    <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert">
    </button>

</div>

<% } %>


<!-- ============================= -->
<!-- EDIT FORM -->
<!-- ============================= -->

<div class="card shadow-sm border-0 doctor-form-card">

    <div class="card-body p-4">

        <form action="DoctorServlet" method="post" enctype="multipart/form-data">

            <input
                    type="hidden"
                    name="action"
                    value="update">


            <input
                    type="hidden"
                    name="id"
                    value="<%= doctor.getId() %>">


            <!-- DOCTOR NAME -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    <i class="fa fa-user-md"></i>
                    Doctor Name

                </label>

                <input
                        type="text"
                        name="name"
                        class="form-control"
                        value="<%= doctor.getName() %>"
                        required>

            </div>


            <!-- SPECIALIZATION -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    <i class="fa fa-stethoscope"></i>
                    Specialization

                </label>

                <select
                        name="specialization"
                        class="form-select"
                        required>

                    <option value="">
                        Select specialization
                    </option>

                    <option value="Cardiologist"
                        <%= "Cardiologist".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        Cardiologist
                    </option>

                    <option value="Dentist"
                        <%= "Dentist".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        Dentist
                    </option>

                    <option value="Dermatologist"
                        <%= "Dermatologist".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        Dermatologist
                    </option>

                    <option value="Neurologist"
                        <%= "Neurologist".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        Neurologist
                    </option>

                    <option value="Orthopedic"
                        <%= "Orthopedic".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        Orthopedic
                    </option>

                    <option value="Pediatrician"
                        <%= "Pediatrician".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        Pediatrician
                    </option>

                    <option value="General Physician"
                        <%= "General Physician".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        General Physician
                    </option>

                    <option value="Gynecologist"
                        <%= "Gynecologist".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        Gynecologist
                    </option>

                    <option value="ENT Specialist"
                        <%= "ENT Specialist".equals(doctor.getSpecialization()) ? "selected" : "" %>>
                        ENT Specialist
                    </option>

                </select>

            </div>


            <!-- QUALIFICATION -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    <i class="fa fa-graduation-cap"></i>
                    Qualification

                </label>

                <input
                        type="text"
                        name="qualification"
                        class="form-control"
                        value="<%= doctor.getQualification() != null
                                ? doctor.getQualification() : "" %>"
                        required>

            </div>


            <!-- EXPERIENCE -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    <i class="fa fa-briefcase"></i>
                    Experience

                </label>

                <div class="input-group">

                    <input
                            type="number"
                            name="experience"
                            class="form-control"
                            value="<%= doctor.getExperience() %>"
                            min="0"
                            max="60"
                            required>

                    <span class="input-group-text">
                        Years
                    </span>

                </div>

            </div>


            <!-- CLINIC TIME -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    <i class="fa fa-clock"></i>
                    Clinic Time

                </label>

                <input
                        type="text"
                        name="clinic_time"
                        class="form-control"
                        value="<%= doctor.getClinicTime() != null
                                ? doctor.getClinicTime() : "" %>"
                        required>

            </div>


            <!-- AVAILABLE DAYS -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    <i class="fa fa-calendar-days"></i>
                    Available Days

                </label>

                <input
                        type="text"
                        name="available_days"
                        class="form-control"
                        value="<%= doctor.getAvailableDays() != null
                                ? doctor.getAvailableDays() : "" %>"
                        required>

            </div>


            <!-- CONTACT -->

            <div class="mb-3">

                <label class="form-label fw-semibold">

                    <i class="fa fa-phone"></i>
                    Contact Number

                </label>

                <input
                        type="tel"
                        name="contact"
                        class="form-control"
                        value="<%= doctor.getContact() != null
                                ? doctor.getContact() : "" %>"
                        maxlength="10"
                        pattern="[0-9]{10}"
                        required>

            </div>


            <!-- PHOTO -->

            <div class="mb-4">

                <label class="form-label fw-semibold">

                    <i class="fa fa-image"></i>
                    Doctor Photo

                </label>

                <input
                        type="text"
                        name="photo"
                        class="form-control"
                        value="<%= doctor.getPhoto() != null
                                ? doctor.getPhoto() : "" %>"
                        placeholder="Example: doctor1.jpg">

            </div>


            <!-- BUTTONS -->

            <div class="d-flex gap-2">

                <button
                        type="submit"
                        class="btn btn-primary px-4">

                    <i class="fa fa-save"></i>
                    Update Doctor

                </button>


                <a
                        href="doctor.jsp"
                        class="btn btn-secondary px-4">

                    <i class="fa fa-times"></i>
                    Cancel

                </a>

            </div>

        </form>

    </div>

</div>


<jsp:include page="footer.jsp"/>