CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1),
    blood_type CHAR(3),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(50) UNIQUE,
    street_address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10)
);

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE
);

CREATE TABLE Shift (
    shift_id INT PRIMARY KEY,
    shift_date DATE,
    shift_time TIME,
    UNIQUE (shift_date, shift_time)
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(50),
    hire_date DATE,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(50) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id) ON DELETE SET NULL
);

CREATE TABLE Doctor (
    staff_id INT PRIMARY KEY,
    specialty TEXT,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE MedicalRecord (
    record_id INT PRIMARY KEY,
    patient_id INT,
    staff_id INT,
    diagnosis TEXT,
    date_of_record DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Doctor(staff_id) ON DELETE SET NULL
);

CREATE TABLE Medications (
    medication_id INT PRIMARY KEY,
    record_id INT,
    medication_name VARCHAR(100),
    dosage VARCHAR(50),
    FOREIGN KEY (record_id) REFERENCES MedicalRecord(record_id) ON DELETE CASCADE
);

CREATE TABLE Billing (
    billing_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    total_amount DECIMAL(10, 2) DEFAULT 0.00,
    payment_status ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Pending',
    invoice_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE
);

CREATE TABLE Insurance (
    insurance_id INT  AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    provider_name VARCHAR(100),
    policy_number VARCHAR(50) UNIQUE,
    coverage_start_date DATE,
    coverage_end_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE
);

CREATE TABLE Administrator (
    staff_id INT PRIMARY KEY,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE Staff_Shift (
    staff_id INT,
    shift_id INT,
    PRIMARY KEY (staff_id, shift_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY (shift_id) REFERENCES Shift(shift_id) ON DELETE CASCADE
);

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    staff_id INT,
    appointment_date DATE,
    appointment_time TIME,
    reason_for_visit TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES Doctor(staff_id) ON DELETE SET NULL
);

CREATE TABLE Resource (
    resource_id INT  AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
    resource_name VARCHAR(100),
    resource_type VARCHAR(50),
    status ENUM('Available', 'In Use', 'Under Maintenance'),
    FOREIGN KEY (department_id) REFERENCES Department(department_id) ON DELETE SET NULL,
    UNIQUE (department_id, resource_name)
);

CREATE TABLE PatientMedicalHistory (
    history_id INT PRIMARY KEY,
    patient_id INT,
    user_condition VARCHAR(100),
    diagnosis_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE
);

CREATE TABLE Procedures (
    procedure_id INT PRIMARY KEY,
    record_id INT,
    procedure_name VARCHAR(100),
    FOREIGN KEY (record_id) REFERENCES MedicalRecord(record_id) ON DELETE CASCADE
);

CREATE TABLE DoctorAvailability (
    availability_id INT PRIMARY KEY,
    staff_id INT,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (staff_id) REFERENCES Doctor(staff_id) ON DELETE CASCADE
);