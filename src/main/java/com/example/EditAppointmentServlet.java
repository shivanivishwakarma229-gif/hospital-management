package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditAppointmentServlet")
public class EditAppointmentServlet extends HttpServlet {

    // =========================================================
    // GET - OPEN EDIT APPOINTMENT PAGE
    // =========================================================

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        int id;

        try {

            id = Integer.parseInt(idStr);

        } catch (Exception e) {

            response.sendRedirect(
                    "viewAppointments.jsp?error=invalid"
            );

            return;
        }


        String sql =
                "SELECT * FROM appointments WHERE id = ?";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);


            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    // Send appointment data to JSP

                    request.setAttribute(
                            "appointment",
                            new Object()
                    );

                    request.setAttribute(
                            "appointmentId",
                            rs.getInt("id")
                    );

                    request.setAttribute(
                            "patientName",
                            rs.getString("patient_name")
                    );

                    request.setAttribute(
                            "doctorName",
                            rs.getString("doctor_name")
                    );

                    request.setAttribute(
                            "appointmentDate",
                            rs.getString("appointment_date")
                    );

                    request.setAttribute(
                            "appointmentTime",
                            rs.getString("appointment_time")
                    );

                    request.setAttribute(
                            "status",
                            rs.getString("status")
                    );


                    // Open edit page

                    request.getRequestDispatcher(
                            "edit-appointment.jsp"
                    ).forward(request, response);

                } else {

                    response.sendRedirect(
                            "viewAppointments.jsp?error=notfound"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "viewAppointments.jsp?error=database"
            );
        }
    }


    // =========================================================
    // POST - UPDATE APPOINTMENT
    // =========================================================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");

        String patientName =
                request.getParameter("patientName");

        String doctor =
                request.getParameter("doctor");

        String date =
                request.getParameter("date");

        String time =
                request.getParameter("time");

        String status =
                request.getParameter("status");


        // =====================================================
        // VALIDATE ID
        // =====================================================

        int id;

        try {

            id = Integer.parseInt(idStr);

        } catch (Exception e) {

            response.sendRedirect(
                    "viewAppointments.jsp?error=invalid"
            );

            return;
        }


        // =====================================================
        // CLEAN INPUT
        // =====================================================

        if (patientName != null) {
            patientName = patientName.trim();
        }

        if (doctor != null) {
            doctor = doctor.trim();
        }

        if (date != null) {
            date = date.trim();
        }

        if (time != null) {
            time = time.trim();
        }

        if (status != null) {
            status = status.trim();
        }


        // =====================================================
        // VALIDATION
        // =====================================================

        if (patientName == null || patientName.isEmpty()) {

            response.sendRedirect(
                    "EditAppointmentServlet?action=edit&id="
                            + id
                            + "&error=patient"
            );

            return;
        }


        if (doctor == null || doctor.isEmpty()) {

            response.sendRedirect(
                    "EditAppointmentServlet?action=edit&id="
                            + id
                            + "&error=doctor"
            );

            return;
        }


        if (date == null || date.isEmpty()) {

            response.sendRedirect(
                    "EditAppointmentServlet?action=edit&id="
                            + id
                            + "&error=date"
            );

            return;
        }


        if (time == null || time.isEmpty()) {

            response.sendRedirect(
                    "EditAppointmentServlet?action=edit&id="
                            + id
                            + "&error=time"
            );

            return;
        }


        // =====================================================
        // VALIDATE STATUS
        // =====================================================

        if (!"Pending".equals(status)
                && !"Approved".equals(status)
                && !"Rejected".equals(status)) {

            status = "Pending";
        }


        // =====================================================
        // UPDATE DATABASE
        // =====================================================

        String sql =
                "UPDATE appointments SET "
                        + "patient_name = ?, "
                        + "doctor_name = ?, "
                        + "appointment_date = ?, "
                        + "appointment_time = ?, "
                        + "status = ? "
                        + "WHERE id = ?";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, patientName);
            ps.setString(2, doctor);
            ps.setString(3, date);
            ps.setString(4, time);
            ps.setString(5, status);
            ps.setInt(6, id);


            int result = ps.executeUpdate();


            if (result > 0) {

                response.sendRedirect(
                        "viewAppointments.jsp?success=updated"
                );

            } else {

                response.sendRedirect(
                        "viewAppointments.jsp?error=update"
                );
            }


        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "viewAppointments.jsp?error=database"
            );
        }
    }
}