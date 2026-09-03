package com.example;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // =========================
        // ADD PATIENT
        // =========================
        if ("add".equals(action)) {

            String name = req.getParameter("name");
            String ageStr = req.getParameter("age");
            String disease = req.getParameter("disease");

            // Remove unnecessary spaces
            if (name != null) {
                name = name.trim();
            }

            if (disease != null) {
                disease = disease.trim();
            }

            // =========================
            // VALIDATION
            // =========================

            if (name == null || name.isEmpty()) {
                req.setAttribute("error", "Patient name is required.");
                req.getRequestDispatcher("add-patient.jsp").forward(req, res);
                return;
            }

            // Name should contain only letters and spaces
            if (!name.matches("[a-zA-Z ]+")) {
                req.setAttribute("error",
                        "Patient name should contain only letters and spaces.");
                req.getRequestDispatcher("add-patient.jsp").forward(req, res);
                return;
            }

            if (ageStr == null || ageStr.trim().isEmpty()) {
                req.setAttribute("error", "Patient age is required.");
                req.getRequestDispatcher("add-patient.jsp").forward(req, res);
                return;
            }

            int age;

            try {
                age = Integer.parseInt(ageStr);
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Please enter a valid age.");
                req.getRequestDispatcher("add-patient.jsp").forward(req, res);
                return;
            }

            // Age validation
            if (age < 1 || age > 120) {
                req.setAttribute("error",
                        "Age must be between 1 and 120 years.");
                req.getRequestDispatcher("add-patient.jsp").forward(req, res);
                return;
            }

            if (disease == null || disease.isEmpty()) {
                req.setAttribute("error",
                        "Disease / health problem is required.");
                req.getRequestDispatcher("add-patient.jsp").forward(req, res);
                return;
            }

            // =========================
            // CREATE PATIENT
            // =========================

            Patient p = new Patient();

            p.setName(name);
            p.setAge(age);
            p.setDisease(disease);

            System.out.println("Age from form = " + age);
            System.out.println("Saving Age = " + p.getAge());

            // =========================
            // SAVE TO DATABASE
            // =========================

            int result = PatientDAO.addPatient(p);

            if (result > 0) {

                // Success message
                res.sendRedirect("patient.jsp?success=added");

            } else {

                req.setAttribute("error",
                        "Unable to add patient. Please try again.");

                req.getRequestDispatcher("add-patient.jsp")
                        .forward(req, res);
            }

            return;
        }


        // =========================
        // UPDATE PATIENT
        // =========================

        if ("update".equals(action)) {

            String idStr = req.getParameter("id");
            String name = req.getParameter("name");
            String ageStr = req.getParameter("age");
            String disease = req.getParameter("disease");

            if (name != null) {
                name = name.trim();
            }

            if (disease != null) {
                disease = disease.trim();
            }

            // Validate ID
            int id;

            try {
                id = Integer.parseInt(idStr);
            } catch (Exception e) {
                res.sendRedirect("patient.jsp?error=invalid");
                return;
            }

            // Validate name
            if (name == null || name.isEmpty()
                    || !name.matches("[a-zA-Z ]+")) {

                req.setAttribute("error",
                        "Please enter a valid patient name.");

                Patient p = PatientDAO.getPatientById(id);
                req.setAttribute("patient", p);

                req.getRequestDispatcher("edit-patient.jsp")
                        .forward(req, res);

                return;
            }

            // Validate age
            int age;

            try {
                age = Integer.parseInt(ageStr);
            } catch (Exception e) {

                req.setAttribute("error",
                        "Please enter a valid age.");

                Patient p = PatientDAO.getPatientById(id);
                req.setAttribute("patient", p);

                req.getRequestDispatcher("edit-patient.jsp")
                        .forward(req, res);

                return;
            }

            if (age < 1 || age > 120) {

                req.setAttribute("error",
                        "Age must be between 1 and 120 years.");

                Patient p = PatientDAO.getPatientById(id);
                req.setAttribute("patient", p);

                req.getRequestDispatcher("edit-patient.jsp")
                        .forward(req, res);

                return;
            }

            // Validate disease
            if (disease == null || disease.isEmpty()) {

                req.setAttribute("error",
                        "Disease / health problem is required.");

                Patient p = PatientDAO.getPatientById(id);
                req.setAttribute("patient", p);

                req.getRequestDispatcher("edit-patient.jsp")
                        .forward(req, res);

                return;
            }

            // Create patient object
            Patient p = new Patient();

            p.setId(id);
            p.setName(name);
            p.setAge(age);
            p.setDisease(disease);

            int result = PatientDAO.updatePatient(p);

            if (result > 0) {
                res.sendRedirect("patient.jsp?success=updated");
            } else {
                res.sendRedirect("patient.jsp?error=update");
            }

            return;
        }
    }


    // =========================
    // GET REQUESTS
    // =========================

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // =========================
        // DELETE
        // =========================

        if ("delete".equals(action)) {

            String idStr = req.getParameter("id");

            try {

                int id = Integer.parseInt(idStr);

                int result = PatientDAO.deletePatient(id);

                if (result > 0) {
                    res.sendRedirect("patient.jsp?success=deleted");
                } else {
                    res.sendRedirect("patient.jsp?error=delete");
                }

            } catch (Exception e) {

                res.sendRedirect("patient.jsp?error=delete");

            }

            return;
        }


        // =========================
        // EDIT
        // =========================

        if ("edit".equals(action)) {

            try {

                int id = Integer.parseInt(
                        req.getParameter("id")
                );

                Patient p = PatientDAO.getPatientById(id);

                req.setAttribute("patient", p);

                RequestDispatcher rd =
                        req.getRequestDispatcher("edit-patient.jsp");

                rd.forward(req, res);

            } catch (Exception e) {

                res.sendRedirect("patient.jsp?error=invalid");

            }

            return;
        }
    }
}