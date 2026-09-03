package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String patient = request.getParameter("patientName");
        String doctor = request.getParameter("doctor");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        // Validate patient
        if (patient == null || patient.trim().isEmpty()) {
            response.getWriter().println("Patient name is required.");
            return;
        }

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO appointments " +
                            "(patient_name, doctor_name, appointment_date, appointment_time) " +
                            "VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, patient.trim());
            ps.setString(2, doctor);
            ps.setString(3, date);
            ps.setString(4, time);

            int result = ps.executeUpdate();

            if (result > 0) {

                response.sendRedirect("viewAppointments.jsp?success=added");

            } else {

                response.getWriter().println(
                        "Failed to book appointment."
                );
            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error while booking appointment: "
                            + e.getMessage()
            );
        }
    }
}