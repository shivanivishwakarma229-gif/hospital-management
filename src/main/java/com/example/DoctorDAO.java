package com.example;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {


    // =========================================================
    // GET ALL DOCTORS
    // =========================================================

    public static List<Doctor> getAllDoctors() {

        List<Doctor> list = new ArrayList<>();

        String sql = "SELECT * FROM doctors ORDER BY id ASC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Doctor d = new Doctor();

                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setSpecialization(rs.getString("specialization"));
                d.setQualification(rs.getString("qualification"));
                d.setExperience(rs.getInt("experience"));
                d.setClinicTime(rs.getString("clinic_time"));
                d.setAvailableDays(rs.getString("available_days"));
                d.setContact(rs.getString("contact"));
                d.setPhoto(rs.getString("photo"));

                list.add(d);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }


    // =========================================================
    // GET DOCTOR BY ID
    // =========================================================

    public static Doctor getDoctorById(int id) {

        Doctor d = null;

        String sql = "SELECT * FROM doctors WHERE id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    d = new Doctor();

                    d.setId(rs.getInt("id"));
                    d.setName(rs.getString("name"));
                    d.setSpecialization(rs.getString("specialization"));
                    d.setQualification(rs.getString("qualification"));
                    d.setExperience(rs.getInt("experience"));
                    d.setClinicTime(rs.getString("clinic_time"));
                    d.setAvailableDays(rs.getString("available_days"));
                    d.setContact(rs.getString("contact"));
                    d.setPhoto(rs.getString("photo"));
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return d;
    }


    // =========================================================
    // ADD DOCTOR
    // =========================================================

    public static int addDoctor(Doctor d) {

        String sql = "INSERT INTO doctors " +
                "(name, specialization, qualification, experience, " +
                "clinic_time, available_days, contact, photo) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, d.getName());
            ps.setString(2, d.getSpecialization());
            ps.setString(3, d.getQualification());
            ps.setInt(4, d.getExperience());
            ps.setString(5, d.getClinicTime());
            ps.setString(6, d.getAvailableDays());
            ps.setString(7, d.getContact());
            ps.setString(8, d.getPhoto());

            return ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // UPDATE DOCTOR
    // =========================================================

    public static int updateDoctor(Doctor d) {

        String sql = "UPDATE doctors SET " +
                "name = ?, " +
                "specialization = ?, " +
                "qualification = ?, " +
                "experience = ?, " +
                "clinic_time = ?, " +
                "available_days = ?, " +
                "contact = ?, " +
                "photo = ? " +
                "WHERE id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, d.getName());
            ps.setString(2, d.getSpecialization());
            ps.setString(3, d.getQualification());
            ps.setInt(4, d.getExperience());
            ps.setString(5, d.getClinicTime());
            ps.setString(6, d.getAvailableDays());
            ps.setString(7, d.getContact());
            ps.setString(8, d.getPhoto());
            ps.setInt(9, d.getId());

            return ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // DELETE DOCTOR
    // =========================================================

    public static int deleteDoctor(int id) {

        String sql = "DELETE FROM doctors WHERE id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // SEARCH DOCTORS
    // =========================================================

    public static List<Doctor> searchDoctors(String search) {

        List<Doctor> list = new ArrayList<>();

        String sql = "SELECT * FROM doctors " +
                "WHERE name LIKE ? " +
                "OR specialization LIKE ? " +
                "ORDER BY id ASC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            String keyword = "%" + search + "%";

            ps.setString(1, keyword);
            ps.setString(2, keyword);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Doctor d = new Doctor();

                    d.setId(rs.getInt("id"));
                    d.setName(rs.getString("name"));
                    d.setSpecialization(rs.getString("specialization"));
                    d.setQualification(rs.getString("qualification"));
                    d.setExperience(rs.getInt("experience"));
                    d.setClinicTime(rs.getString("clinic_time"));
                    d.setAvailableDays(rs.getString("available_days"));
                    d.setContact(rs.getString("contact"));
                    d.setPhoto(rs.getString("photo"));

                    list.add(d);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }
}