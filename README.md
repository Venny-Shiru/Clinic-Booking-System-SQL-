# Clinic-Booking-System-SQL-
# 🏥 Clinic Booking System (MySQL)

A full-featured relational database system for managing patient appointments, doctors, prescriptions, and room scheduling in a clinical environment.

---

## 📋 Project Description

This project implements a MySQL-based backend for a clinic booking and management system. It allows clinic staff to:
- Register patients and doctors
- Schedule appointments with room assignments
- Record prescriptions
- Manage access through user roles (admin, doctor, receptionist, developer)

The database schema is normalized and supports 1:N and M:N relationships using proper constraints and foreign keys.

---

## 🚀 Setup Instructions

### 1. Clone this Repository

```bash
git clone https://github.com/Venny-Shiru/clinic-booking-system.git
cd clinic-booking-system
````

### 2. Open MySQL and Import the Database

You can import the SQL schema and data using the MySQL command-line tool or any GUI like MySQL Workbench.

#### Option A: Using MySQL CLI

```bash
mysql -u root -p < clinic_booking_system.sql
```

#### Option B: Using MySQL Workbench

1. Open MySQL Workbench
2. Connect to your server
3. Open `clinic_booking_system.sql`
4. Execute the full script

---

## 🔐 Roles & Permissions

The system uses MySQL roles to manage permissions:

| Role           | Permissions                                         |
| -------------- | --------------------------------------------------- |
| `admin`        | Full access to the database                         |
| `developer`    | Full access (for development/testing purposes)      |
| `doctor`       | Read patients and appointments, write prescriptions |
| `receptionist` | Register patients and appointments                  |

---

## 🧪 Sample Users

* Developer: `dev_user` / `DevPass123!`
* Admin: `admin_user` / `AdminPass123!`
* Doctor: `dr_smith` / `DocPass123!`
* Receptionist: `reception_user` / `ReceptionPass123!`

---

## 📂 Contents

* `clinic_booking_system.sql` — Full schema, sample data, user roles, and privileges
* https://drive.google.com/file/d/1yXpYA2xCrONfOB4QRg3b0bvPnGl8SjLD/view?usp=sharing - ER Diagram Link

---

## 📜 License

MIT License. Use freely with attribution.

```
