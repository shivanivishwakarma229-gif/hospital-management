<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="layout.jsp"/>
<div class="d-flex justify-content-between align-items-center mb-4">

    <div>
        <h3>
            <i class="fa fa-user-plus"></i>
            Add New Patient
        </h3>

        <p class="text-muted mb-0">
            Register a new patient in the hospital system
        </p>
    </div>

    <a href="patient.jsp" class="btn btn-secondary">
        <i class="fa fa-arrow-left"></i>
        Back to Patients
    </a>

</div>


<%
    String error = (String) request.getAttribute("error");

    if(error != null) {
%>

<div class="alert alert-danger alert-dismissible fade show">
    <i class="fa fa-circle-exclamation"></i>

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


<div class="card shadow-sm border-0">

    <div class="card-header bg-primary text-white">

        <h5 class="mb-0">
            <i class="fa fa-user"></i>
            Patient Information
        </h5>

    </div>


    <div class="card-body p-4">

        <form action="PatientServlet" method="post">

            <input type="hidden"
                   name="action"
                   value="add">


            <div class="row">

                <!-- NAME -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Patient Name
                        <span class="text-danger">*</span>
                    </label>

                    <input
                        type="text"
                        name="name"
                        class="form-control"
                        placeholder="Enter patient full name"
                        required
                    >

                    <small class="text-muted">
                        Example: Shivani Vishwakarma
                    </small>

                </div>


                <!-- AGE -->

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Age
                        <span class="text-danger">*</span>
                    </label>

                    <input
                        type="number"
                        name="age"
                        class="form-control"
                        min="1"
                        max="120"
                        placeholder="Enter age"
                        required
                    >

                    <small class="text-muted">
                        Age must be between 1 and 120
                    </small>

                </div>


                <!-- DISEASE -->

                <div class="col-md-12 mb-4">

                    <label class="form-label">
                        Disease / Health Problem
                        <span class="text-danger">*</span>
                    </label>

                    <textarea
                        name="disease"
                        class="form-control"
                        rows="3"
                        placeholder="Enter disease or health problem"
                        required
                    ></textarea>

                </div>

            </div>


            <!-- BUTTONS -->

            <div class="d-flex gap-2">

                <button
                    type="submit"
                    class="btn btn-primary">

                    <i class="fa fa-save"></i>
                    Save Patient

                </button>


                <a
                    href="patient.jsp"
                    class="btn btn-outline-secondary">

                    Cancel

                </a>

            </div>

        </form>

    </div>

</div>

<%@ include file="footer.jsp" %>