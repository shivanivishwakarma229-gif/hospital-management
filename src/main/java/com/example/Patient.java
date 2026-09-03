package com.example;

public class Patient {
    private int id;
    private String name;
    private int age;
    private String disease;

    // GETTERS

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getDisease() {
        return disease;
    }

    // SETTERS

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;   // ✅ FIXED (MOST IMPORTANT LINE)
    }

    public void setDisease(String disease) {
        this.disease = disease;
    }
}