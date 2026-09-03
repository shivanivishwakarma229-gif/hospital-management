<%@ page import="java.util.List" %>
<%@ page import="com.example.Doctor" %>
<%@ page import="com.example.DoctorDAO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="layout.jsp"/>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3>📅 Book Appointment</h3>
        <p class="text-muted mb-0">
            Schedule an appointment with our doctors
        </p>
    </div>

    <a href="doctor.jsp" class="btn btn-secondary">
        ← Doctors
    </a>
</div>


<div class="card shadow-sm border-0" style="max-width: 700px;">

    <div class="card-body p-4">

        <form action="AppointmentServlet" method="post">

            <!-- Patient Name -->
            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Patient Name
                </label>

                <input
                        type="text"
                        name="patientName"
                        class="form-control"
                        placeholder="Enter patient name"
                        required>

            </div>


            <!-- Doctor -->
            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Select Doctor
                </label>

                <%
                    String selectedDoctorId = request.getParameter("doctorId");
                %>
                <select name="doctor" class="form-select" required>

                    <option value="">
                        Select a doctor
                    </option>

                    <%
                        List<Doctor> doctors = DoctorDAO.getAllDoctors();

                        if (doctors != null && !doctors.isEmpty()) {

                            for (Doctor d : doctors) {

                                boolean selected =
                                        String.valueOf(d.getId()).equals(selectedDoctorId);
                    %>

                    <option value="<%= d.getName() %>"
                            <%= selected ? "selected" : "" %>>

                        <%= d.getName() %> -
                        <%= d.getSpecialization() %>

                    </option>

                    <%
                            }

                        } else {
                    %>

                    <option value="">
                        No doctors available
                    </option>

                    <%
                        }
                    %>

                </select>

            </div>


            <!-- Date -->
            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Appointment Date
                </label>

                <input
                        type="date"
                        name="date"
                        class="form-control"
                        required>

            </div>


            <!-- Time -->
            <div class="mb-3">

                <label class="form-label fw-semibold">
                    Appointment Time
                </label>

                <input
                        type="time"
                        name="time"
                        class="form-control"
                        required>

            </div>


            <!-- Buttons -->
            <div class="d-flex gap-2">

                <button
                        type="submit"
                        class="btn btn-primary">

                    <i class="fa fa-calendar-check"></i>
                    Book Appointment

                </button>

                <a
                        href="dashboard.jsp"
                        class="btn btn-secondary">

                    ← Back

                </a>

            </div>

        </form>

    </div>

</div>


<jsp:include page="footer.jsp"/>