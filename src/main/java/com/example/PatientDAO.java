package com.example;

import java.sql.*;
import java.util.*;

public class PatientDAO {

    // ADD
    public static int addPatient(Patient p) {
        int status = 0;
        try {
            Connection con = DBConnection.getConnection();

            System.out.println("Saving Age = " + p.getAge());

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO patients(name, age, disease) VALUES(?,?,?)"
            );

            ps.setString(1, p.getName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getDisease());

            status = ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // GET ALL
    public static List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM patients");
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAge(rs.getInt("age"));
                p.setDisease(rs.getString("disease"));
                list.add(p);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // DELETE
    public static int deletePatient(int id) {
        int status = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM patients WHERE id=?");
            ps.setInt(1, id);
            status = ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // GET BY ID
    public static Patient getPatientById(int id) {
        Patient p = new Patient();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM patients WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAge(rs.getInt("age"));
                p.setDisease(rs.getString("disease"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return p;
    }

    // UPDATE
    public static int updatePatient(Patient p) {
        int status = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE patients SET name=?, age=?, disease=? WHERE id=?"
            );
            ps.setString(1, p.getName());
            ps.setInt(2, p.getAge());
            ps.setString(3, p.getDisease());
            ps.setInt(4, p.getId());

            status = ps.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    // SEARCH PATIENTS
    public static List<Patient> searchPatients(String search) {

        List<Patient> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM patients " +
                            "WHERE name LIKE ? OR disease LIKE ? " +
                            "ORDER BY id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            String keyword = "%" + search + "%";

            ps.setString(1, keyword);
            ps.setString(2, keyword);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Patient p = new Patient();

                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAge(rs.getInt("age"));
                p.setDisease(rs.getString("disease"));

                list.add(p);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }


}