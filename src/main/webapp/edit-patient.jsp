```jsp
<%@ page import="com.example.Patient" %>

<%
    Patient p = (Patient) request.getAttribute("patient");

    if (p == null) {
        response.sendRedirect("PatientServlet?action=list");
        return;
    }
%>

<jsp:include page="layout.jsp"/>

<div class="container-fluid px-4">

    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold mb-1">
                <i class="fa-solid fa-user-pen me-2"></i>
                Edit Patient
            </h2>
            <p class="text-muted mb-0">
                Update patient information
            </p>
        </div>

        <a href="PatientServlet?action=list" class="btn btn-outline-secondary">
            <i class="fa-solid fa-arrow-left me-2"></i>
            Back to Patients
        </a>
    </div>

    <!-- Edit Patient Card -->
    <div class="card shadow-sm border-0">

        <div class="card-header bg-white border-0 py-3">
            <h5 class="mb-0 fw-semibold">
                <i class="fa-solid fa-hospital-user me-2"></i>
                Patient Information
            </h5>
        </div>

        <div class="card-body">

            <form action="PatientServlet" method="post">

                <input type="hidden" name="action" value="update"/>
                <input type="hidden" name="id" value="<%= p.getId() %>"/>

                <div class="row g-4">

                    <!-- Patient Name -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            Patient Name
                        </label>

                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa-solid fa-user"></i>
                            </span>

                            <input type="text"
                                   class="form-control"
                                   name="name"
                                   value="<%= p.getName() %>"
                                   required>
                        </div>
                    </div>

                    <!-- Age -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            Age
                        </label>

                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa-solid fa-calendar"></i>
                            </span>

                            <input type="number"
                                   class="form-control"
                                   name="age"
                                   value="<%= p.getAge() %>"
                                   min="0"
                                   required>
                        </div>
                    </div>

                    <!-- Disease -->
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">
                            Disease / Medical Condition
                        </label>

                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fa-solid fa-notes-medical"></i>
                            </span>

                            <input type="text"
                                   class="form-control"
                                   name="disease"
                                   value="<%= p.getDisease() %>"
                                   required>
                        </div>
                    </div>

                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-end gap-2 mt-4">

                    <a href="PatientServlet?action=list"
                       class="btn btn-light border">
                        <i class="fa-solid fa-xmark me-1"></i>
                        Cancel
                    </a>

                    <button type="submit" class="btn btn-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i>
                        Update Patient
                    </button>

                </div>

            </form>

        </div>
    </div>

</div>

<jsp:include page="footer.jsp"/>
```
