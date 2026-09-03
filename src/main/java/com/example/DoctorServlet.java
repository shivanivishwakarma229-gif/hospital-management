package com.example;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/DoctorServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1 MB
        maxFileSize = 5 * 1024 * 1024,        // 5 MB
        maxRequestSize = 10 * 1024 * 1024     // 10 MB
)
public class DoctorServlet extends HttpServlet {

    // =========================================================
    // POST REQUEST
    // ADD / UPDATE
    // =========================================================

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // =====================================================
        // ADD DOCTOR
        // =====================================================

        if ("add".equals(action)) {

            String name = req.getParameter("name");
            String specialization = req.getParameter("specialization");
            String qualification = req.getParameter("qualification");
            String experienceStr = req.getParameter("experience");
            String clinicTime = req.getParameter("clinic_time");
            String availableDays = req.getParameter("available_days");
            String contact = req.getParameter("contact");

            // -----------------------------
            // CLEAN DATA
            // -----------------------------

            if (name != null)
                name = name.trim();

            if (specialization != null)
                specialization = specialization.trim();

            if (qualification != null)
                qualification = qualification.trim();

            if (clinicTime != null)
                clinicTime = clinicTime.trim();

            if (availableDays != null)
                availableDays = availableDays.trim();

            if (contact != null)
                contact = contact.trim();


            // -----------------------------
            // VALIDATE NAME
            // -----------------------------

            if (name == null || name.isEmpty()) {

                req.setAttribute("error",
                        "Doctor name is required.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);

                return;
            }


            // -----------------------------
            // VALIDATE SPECIALIZATION
            // -----------------------------

            if (specialization == null ||
                    specialization.isEmpty()) {

                req.setAttribute("error",
                        "Doctor specialization is required.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);

                return;
            }


            // -----------------------------
            // VALIDATE QUALIFICATION
            // -----------------------------

            if (qualification == null ||
                    qualification.isEmpty()) {

                req.setAttribute("error",
                        "Doctor qualification is required.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);

                return;
            }


            // -----------------------------
            // EXPERIENCE
            // -----------------------------

            int experience;

            try {

                experience =
                        Integer.parseInt(experienceStr);

            } catch (Exception e) {

                req.setAttribute("error",
                        "Please enter a valid experience.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);

                return;
            }


            if (experience < 0 || experience > 60) {

                req.setAttribute("error",
                        "Experience must be between 0 and 60 years.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);

                return;
            }


            // -----------------------------
            // CLINIC TIME
            // -----------------------------

            if (clinicTime == null ||
                    clinicTime.isEmpty()) {

                req.setAttribute("error",
                        "Clinic time is required.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);

                return;
            }


            // -----------------------------
            // AVAILABLE DAYS
            // -----------------------------

            if (availableDays == null ||
                    availableDays.isEmpty()) {

                req.setAttribute("error",
                        "Available days are required.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);

                return;
            }


            // -----------------------------
            // CONTACT
            // -----------------------------

            if (contact == null ||
                    !contact.matches("[0-9]{10}")) {

                req.setAttribute("error",
                        "Contact number must contain exactly 10 digits.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);

                return;
            }


            // =====================================================
            // PHOTO UPLOAD
            // =====================================================

            Part photoPart = req.getPart("photo");

            String photoFileName = null;

            if (photoPart != null &&
                    photoPart.getSize() > 0 &&
                    photoPart.getSubmittedFileName() != null &&
                    !photoPart.getSubmittedFileName().trim().isEmpty()) {
                String originalFileName =
                        Paths.get(
                                photoPart.getSubmittedFileName()
                        ).getFileName().toString();

                // Only allow image extensions
                String lowerName =
                        originalFileName.toLowerCase();

                if (!lowerName.endsWith(".jpg") &&
                        !lowerName.endsWith(".jpeg") &&
                        !lowerName.endsWith(".png")) {

                    req.setAttribute("error",
                            "Only JPG, JPEG and PNG images are allowed.");

                    req.getRequestDispatcher("add-doctor.jsp")
                            .forward(req, res);

                    return;
                }


                // Create unique filename
                photoFileName =
                        System.currentTimeMillis()
                                + "_"
                                + originalFileName;


                // Get upload directory
                String uploadPath =
                        getServletContext()
                                .getRealPath("")
                                + File.separator
                                + "images";


                File uploadDir =
                        new File(uploadPath);

                if (!uploadDir.exists()) {

                    uploadDir.mkdirs();
                }


                // Save image
                photoPart.write(
                        uploadPath
                                + File.separator
                                + photoFileName
                );
            }


            // =====================================================
            // CREATE DOCTOR OBJECT
            // =====================================================

            Doctor d = new Doctor();

            d.setName(name);
            d.setSpecialization(specialization);
            d.setQualification(qualification);
            d.setExperience(experience);
            d.setClinicTime(clinicTime);
            d.setAvailableDays(availableDays);
            d.setContact(contact);
            d.setPhoto(photoFileName);


            // =====================================================
            // SAVE DATABASE
            // =====================================================

            int result =
                    DoctorDAO.addDoctor(d);


            if (result > 0) {

                res.sendRedirect(
                        "doctor.jsp?success=added"
                );

            } else {

                req.setAttribute("error",
                        "Unable to add doctor. Please try again.");

                req.getRequestDispatcher("add-doctor.jsp")
                        .forward(req, res);
            }

            return;
        }


        // =====================================================
        // UPDATE DOCTOR
        // =====================================================

        if ("update".equals(action)) {

            String idStr = req.getParameter("id");

            String name = req.getParameter("name");
            String specialization =
                    req.getParameter("specialization");

            String qualification =
                    req.getParameter("qualification");

            String experienceStr =
                    req.getParameter("experience");

            String clinicTime =
                    req.getParameter("clinic_time");

            String availableDays =
                    req.getParameter("available_days");

            String contact =
                    req.getParameter("contact");


            int id;

            try {

                id = Integer.parseInt(idStr);

            } catch (Exception e) {

                res.sendRedirect(
                        "doctor.jsp?error=invalid"
                );

                return;
            }


            // -----------------------------
            // CLEAN
            // -----------------------------

            if (name != null)
                name = name.trim();

            if (specialization != null)
                specialization = specialization.trim();

            if (qualification != null)
                qualification = qualification.trim();

            if (clinicTime != null)
                clinicTime = clinicTime.trim();

            if (availableDays != null)
                availableDays = availableDays.trim();

            if (contact != null)
                contact = contact.trim();


            // -----------------------------
            // VALIDATION
            // -----------------------------

            if (name == null ||
                    name.isEmpty()) {

                req.setAttribute("error",
                        "Doctor name is required.");

                Doctor d =
                        DoctorDAO.getDoctorById(id);

                req.setAttribute("doctor", d);

                req.getRequestDispatcher(
                        "edit-doctor.jsp"
                ).forward(req, res);

                return;
            }


            if (specialization == null ||
                    specialization.isEmpty()) {

                req.setAttribute("error",
                        "Doctor specialization is required.");

                Doctor d =
                        DoctorDAO.getDoctorById(id);

                req.setAttribute("doctor", d);

                req.getRequestDispatcher(
                        "edit-doctor.jsp"
                ).forward(req, res);

                return;
            }


            if (qualification == null ||
                    qualification.isEmpty()) {

                req.setAttribute("error",
                        "Doctor qualification is required.");

                Doctor d =
                        DoctorDAO.getDoctorById(id);

                req.setAttribute("doctor", d);

                req.getRequestDispatcher(
                        "edit-doctor.jsp"
                ).forward(req, res);

                return;
            }


            int experience;

            try {

                experience =
                        Integer.parseInt(experienceStr);

            } catch (Exception e) {

                req.setAttribute("error",
                        "Please enter a valid experience.");

                Doctor d =
                        DoctorDAO.getDoctorById(id);

                req.setAttribute("doctor", d);

                req.getRequestDispatcher(
                        "edit-doctor.jsp"
                ).forward(req, res);

                return;
            }


            if (experience < 0 ||
                    experience > 60) {

                req.setAttribute("error",
                        "Experience must be between 0 and 60 years.");

                Doctor d =
                        DoctorDAO.getDoctorById(id);

                req.setAttribute("doctor", d);

                req.getRequestDispatcher(
                        "edit-doctor.jsp"
                ).forward(req, res);

                return;
            }


            if (clinicTime == null ||
                    clinicTime.isEmpty()) {

                req.setAttribute("error",
                        "Clinic time is required.");

                Doctor d =
                        DoctorDAO.getDoctorById(id);

                req.setAttribute("doctor", d);

                req.getRequestDispatcher(
                        "edit-doctor.jsp"
                ).forward(req, res);

                return;
            }


            if (availableDays == null ||
                    availableDays.isEmpty()) {

                req.setAttribute("error",
                        "Available days are required.");

                Doctor d =
                        DoctorDAO.getDoctorById(id);

                req.setAttribute("doctor", d);

                req.getRequestDispatcher(
                        "edit-doctor.jsp"
                ).forward(req, res);

                return;
            }


            if (contact == null ||
                    !contact.matches("[0-9]{10}")) {

                req.setAttribute("error",
                        "Contact number must contain exactly 10 digits.");

                Doctor d =
                        DoctorDAO.getDoctorById(id);

                req.setAttribute("doctor", d);

                req.getRequestDispatcher(
                        "edit-doctor.jsp"
                ).forward(req, res);

                return;
            }


            // =====================================================
            // GET OLD DOCTOR
            // =====================================================

            Doctor oldDoctor =
                    DoctorDAO.getDoctorById(id);


            String photoFileName =
                    oldDoctor != null
                            ? oldDoctor.getPhoto()
                            : null;


            // =====================================================
            // NEW PHOTO
            // =====================================================

            Part photoPart =
                    req.getPart("photo");


            if (photoPart != null &&
                    photoPart.getSize() > 0) {

                String originalFileName =
                        Paths.get(
                                photoPart.getSubmittedFileName()
                        ).getFileName().toString();


                String lowerName =
                        originalFileName.toLowerCase();


                if (!lowerName.endsWith(".jpg") &&
                        !lowerName.endsWith(".jpeg") &&
                        !lowerName.endsWith(".png")) {

                    req.setAttribute("error",
                            "Only JPG, JPEG and PNG images are allowed.");

                    req.setAttribute(
                            "doctor",
                            oldDoctor
                    );

                    req.getRequestDispatcher(
                            "edit-doctor.jsp"
                    ).forward(req, res);

                    return;
                }


                photoFileName =
                        System.currentTimeMillis()
                                + "_"
                                + originalFileName;


                String uploadPath =
                        getServletContext()
                                .getRealPath("")
                                + File.separator
                                + "images"
                                + File.separator
                                + "doctors";


                File uploadDir =
                        new File(uploadPath);


                if (!uploadDir.exists()) {

                    uploadDir.mkdirs();
                }


                photoPart.write(
                        uploadPath
                                + File.separator
                                + photoFileName
                );
            }


            // =====================================================
            // CREATE UPDATED DOCTOR
            // =====================================================

            Doctor d = new Doctor();

            d.setId(id);
            d.setName(name);
            d.setSpecialization(specialization);
            d.setQualification(qualification);
            d.setExperience(experience);
            d.setClinicTime(clinicTime);
            d.setAvailableDays(availableDays);
            d.setContact(contact);
            d.setPhoto(photoFileName);


            int result =
                    DoctorDAO.updateDoctor(d);


            if (result > 0) {

                res.sendRedirect(
                        "doctor.jsp?success=updated"
                );

            } else {

                res.sendRedirect(
                        "doctor.jsp?error=update"
                );
            }

            return;
        }
    }


    // =========================================================
    // GET REQUESTS
    // DELETE / EDIT
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse res)
            throws ServletException, IOException {

        String action =
                req.getParameter("action");


        // =====================================================
        // DELETE
        // =====================================================

        if ("delete".equals(action)) {

            try {

                int id =
                        Integer.parseInt(
                                req.getParameter("id")
                        );


                int result =
                        DoctorDAO.deleteDoctor(id);


                if (result > 0) {

                    res.sendRedirect(
                            "doctor.jsp?success=deleted"
                    );

                } else {

                    res.sendRedirect(
                            "doctor.jsp?error=delete"
                    );
                }

            } catch (Exception e) {

                res.sendRedirect(
                        "doctor.jsp?error=delete"
                );
            }

            return;
        }


        // =====================================================
        // EDIT
        // =====================================================

        if ("edit".equals(action)) {

            try {

                int id =
                        Integer.parseInt(
                                req.getParameter("id")
                        );


                Doctor d =
                        DoctorDAO.getDoctorById(id);


                if (d == null) {

                    res.sendRedirect(
                            "doctor.jsp?error=invalid"
                    );

                    return;
                }


                req.setAttribute(
                        "doctor",
                        d
                );


                RequestDispatcher rd =
                        req.getRequestDispatcher(
                                "edit-doctor.jsp"
                        );


                ((javax.servlet.RequestDispatcher) rd).forward(req, res);

            } catch (Exception e) {

                e.printStackTrace();

                res.sendRedirect(
                        "doctor.jsp?error=invalid"
                );
            }

            return;
        }
    }
}