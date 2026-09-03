package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteAppointmentServlet")
public class DeleteAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        // Validate ID
        int id;

        try {
            id = Integer.parseInt(idStr);
        } catch (Exception e) {

            response.sendRedirect(
                    "viewAppointments.jsp?error=invalid"
            );

            return;
        }

        String sql = "DELETE FROM appointments WHERE id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            int result = ps.executeUpdate();

            if (result > 0) {

                // Appointment deleted successfully
                response.sendRedirect(
                        "viewAppointments.jsp?success=deleted"
                );

            } else {

                // Appointment ID not found
                response.sendRedirect(
                        "viewAppointments.jsp?error=notfound"
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