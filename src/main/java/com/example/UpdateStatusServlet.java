package com.example;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String status = request.getParameter("status");

        // Validate ID
        int id;

        try {
            id = Integer.parseInt(idStr);
        } catch (Exception e) {
            response.sendRedirect("viewAppointments.jsp?error=invalid");
            return;
        }

        // Validate status
        if (!"Approved".equals(status)
                && !"Rejected".equals(status)) {

            response.sendRedirect("viewAppointments.jsp?error=invalid");
            return;
        }

        String sql =
                "UPDATE appointments SET status = ? WHERE id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, status);
            ps.setInt(2, id);

            int result = ps.executeUpdate();

            if (result > 0) {

                // Successfully updated
                response.sendRedirect(
                        "viewAppointments.jsp?success=status"
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