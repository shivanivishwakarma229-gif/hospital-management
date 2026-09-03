<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="layout.jsp"/>

<%
    String error = (String) request.getAttribute("error");
%>

<!-- ============================= -->
<!-- PAGE HEADER -->
<!-- ============================= -->

<div class="d-flex justify-content-between align-items-center mb-4">

    <div>
        <h3 class="mb-1">
            🩺 Add Doctor
        </h3>

        <p class="text-muted mb-0">
            Add a new doctor to the hospital management system
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

    <div class="alert alert-danger alert-dismissible fade show shadow-sm"
         role="alert">

        <i class="fa fa-circle-exclamation"></i>

        <strong>Error!</strong>
        <%= error %>

        <button type="button"
                class="btn-close"
                data-bs-dismiss="alert">
        </button>

    </div>

<% } %>


<!-- ============================= -->
<!-- DOCTOR FORM -->
<!-- ============================= -->

<div class="card shadow-sm border-0 doctor-form-card">

    <div class="card-body p-4">

        <form action="DoctorServlet"
              method="post"
              enctype="multipart/form-data">

            <!-- IMPORTANT -->
            <input type="hidden" name="action" value="add">


            <!-- ============================= -->
            <!-- DOCTOR NAME -->
            <!-- ============================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">
                    <i class="fa fa-user-md"></i>
                    Doctor Name
                </label>

                <input
                    type="text"
                    name="name"
                    class="form-control"
                    placeholder="Enter doctor name"
                    required
                >

            </div>


            <!-- ============================= -->
            <!-- SPECIALIZATION -->
            <!-- ============================= -->

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

                    <option value="Cardiologist">
                        Cardiologist
                    </option>

                    <option value="Dentist">
                        Dentist
                    </option>

                    <option value="Dermatologist">
                        Dermatologist
                    </option>

                    <option value="Neurologist">
                        Neurologist
                    </option>

                    <option value="Orthopedic">
                        Orthopedic
                    </option>

                    <option value="Pediatrician">
                        Pediatrician
                    </option>

                    <option value="General Physician">
                        General Physician
                    </option>

                    <option value="Gynecologist">
                        Gynecologist
                    </option>

                    <option value="ENT Specialist">
                        ENT Specialist
                    </option>

                </select>

            </div>


            <!-- ============================= -->
            <!-- QUALIFICATION -->
            <!-- ============================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">
                    <i class="fa fa-graduation-cap"></i>
                    Qualification
                </label>

                <input
                    type="text"
                    name="qualification"
                    class="form-control"
                    placeholder="Example: MBBS, MD"
                    required
                >

            </div>


            <!-- ============================= -->
            <!-- EXPERIENCE -->
            <!-- ============================= -->

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
                        placeholder="Years of experience"
                        min="0"
                        max="60"
                        required
                    >

                    <span class="input-group-text">
                        Years
                    </span>

                </div>

            </div>


            <!-- ============================= -->
            <!-- CLINIC TIME -->
            <!-- ============================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">
                    <i class="fa fa-clock"></i>
                    Clinic Time
                </label>

                <input
                    type="text"
                    name="clinic_time"
                    class="form-control"
                    placeholder="Example: 10:00 AM - 2:00 PM"
                    required
                >

                <small class="text-muted">
                    Enter the doctor's consultation timing.
                </small>

            </div>


            <!-- ============================= -->
            <!-- AVAILABLE DAYS -->
            <!-- ============================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">
                    <i class="fa fa-calendar-days"></i>
                    Available Days
                </label>

                <input
                    type="text"
                    name="available_days"
                    class="form-control"
                    placeholder="Example: Monday - Friday"
                    required
                >

            </div>


            <!-- ============================= -->
            <!-- CONTACT -->
            <!-- ============================= -->

            <div class="mb-3">

                <label class="form-label fw-semibold">
                    <i class="fa fa-phone"></i>
                    Contact Number
                </label>

                <input
                    type="tel"
                    name="contact"
                    class="form-control"
                    placeholder="Enter 10 digit mobile number"
                    maxlength="10"
                    pattern="[0-9]{10}"
                    required
                >

                <small class="text-muted">
                    Enter exactly 10 digits.
                </small>

            </div>


            <!-- ============================= -->
            <!-- PHOTO -->
            <!-- ============================= -->

            <div class="mb-4">

                <label class="form-label fw-semibold">
                    <i class="fa fa-image"></i>
                    Doctor Photo
                </label>

                <div class="mb-4">

                    <label class="form-label fw-semibold">
                        <i class="fa fa-image"></i>
                        Doctor Photo
                    </label>

                    <input
                        type="file"
                        name="photo"
                        class="form-control"
                        accept="image/jpeg,image/png,image/jpg"
                        required>

                    <small class="text-muted">
                        Upload JPG or PNG image.
                    </small>

                </div>

                <small class="text-muted">
                    Enter the image filename.
                    Example: doctor1.jpg
                </small>

            </div>


            <!-- ============================= -->
            <!-- BUTTONS -->
            <!-- ============================= -->

            <div class="d-flex gap-2">

                <button
                    type="submit"
                    class="btn btn-primary px-4">

                    <i class="fa fa-save"></i>
                    Save Doctor

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


<!-- ============================= -->
<!-- FOOTER -->
<!-- ============================= -->

<jsp:include page="footer.jsp"/>