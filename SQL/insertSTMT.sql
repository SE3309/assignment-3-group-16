-- Question 3
INSERT INTO Patient (patient_id, first_name, last_name, date_of_birth, gender, blood_type, phone, email, street_address, city, state, zip_code) 
VALUES (1, 'John', 'Doe', '2004-09-10', 'M', 'O+', '123-456-7890', 'john.doe@example.com', '54 St Patrick St', 'Toronto', 'ON', 'M5T1V1
');

INSERT INTO Patient 
VALUES (2, 'Devraj', 'Nagpal', '2004-09-10', 'F', 'B-', '647-999-1000', 'devraj.nagpal@gmail.com', '1151 Richmond St', 'London', 'ON', 'N6A3K7');

CREATE TEMPORARY TABLE TempPatient AS
SELECT 3 AS patient_id, 'Yash' AS first_name, 'Vekaria' AS last_name, '2004-03-09' AS date_of_birth, 'M' AS gender, 'O-' AS blood_type, '321-654-0987' AS phone, 'yash.V@example.com' AS email, '123 Binary Brothers St' AS street_address, 'Othertown' AS city, 'ON' AS state, '10000' AS zip_code;
INSERT INTO Patient (patient_id, first_name, last_name, date_of_birth, gender, blood_type, phone, email, street_address, city, state, zip_code)
SELECT patient_id, first_name, last_name, date_of_birth, gender, blood_type, phone, email, street_address, city, state, zip_code
FROM TempPatient;
DROP TEMPORARY TABLE TempPatient;

-- Question 4
-- Need to insert data to department for it to work with staff and doctors
INSERT INTO Department (department_id,department_name)
VALUES (1,'ER'),(2,'OR'),(3,'ICU'),(4,'L&D'),(5,'Pharmacy');
-- Tables that have data already, Patient, Staff, Medical Records, Department, Doctor, Appointment

-- Load Administrator table 
INSERT INTO administrator (staff_id)
SELECT staff_id 
FROM staff
WHERE role = 'Administrator';

-- Biling 
INSERT INTO billing (patient_id, total_amount, payment_status, invoice_date)
SELECT patient_id, 100.00, 'Pending', CURDATE()
FROM patient
LIMIT 5;

-- Doctor Availablity 
INSERT INTO DoctorAvailability (availability_id, staff_id, day_of_week, start_time, end_time)
SELECT 1, staff_id, 'Monday', '09:00:00', '17:00:00' FROM Doctor WHERE specialty = 'Internal medicine' LIMIT 1;
INSERT INTO DoctorAvailability (availability_id, staff_id, day_of_week, start_time, end_time)
SELECT 2, staff_id, 'Tuesday', '09:00:00', '17:00:00' FROM Doctor WHERE specialty = 'Surgery' LIMIT 1;
INSERT INTO DoctorAvailability (availability_id, staff_id, day_of_week, start_time, end_time)
SELECT 3, staff_id, 'Wednesday', '09:00:00', '17:00:00' FROM Doctor WHERE specialty = 'Dermatology'LIMIT 1;
INSERT INTO DoctorAvailability (availability_id, staff_id, day_of_week, start_time, end_time)
SELECT 4, staff_id, 'Wednesday', '09:00:00', '17:00:00' FROM Doctor WHERE specialty = 'Surgery'LIMIT 1;
INSERT INTO DoctorAvailability (availability_id, staff_id, day_of_week, start_time, end_time)
SELECT 5shift, staff_id, 'Friday', '09:00:00', '17:00:00' FROM Doctor WHERE specialty = 'Internal medicine'LIMIT 1;

-- Insurance
INSERT INTO Insurance (insurance_id, patient_id, provider_name, policy_number, coverage_start_date, coverage_end_date)
SELECT 1, patient_id, 'Health Provider A', 'POL12345', '2023-01-01', '2024-01-01' FROM Patient WHERE first_name = 'Devraj' LIMIT 1;
INSERT INTO Insurance (insurance_id, patient_id, provider_name, policy_number, coverage_start_date, coverage_end_date)
SELECT 2, patient_id, 'Health Provider B', 'POL67890', '2023-02-01', '2024-02-01' FROM Patient WHERE first_name = 'Yash'  LIMIT 1;
INSERT INTO Insurance (insurance_id, patient_id, provider_name, policy_number, coverage_start_date, coverage_end_date)
SELECT 3, patient_id, 'Health Provider C', 'POL11223', '2023-03-01', '2024-03-01' FROM Patient WHERE first_name = 'Alexander'  LIMIT 1;
INSERT INTO Insurance (insurance_id, patient_id, provider_name, policy_number, coverage_start_date, coverage_end_date)
SELECT 4, patient_id, 'Health Provider D', 'POL44556', '2023-04-01', '2024-04-01' FROM Patient WHERE first_name = 'Elizabeth'  LIMIT 1;
INSERT INTO Insurance (insurance_id, patient_id, provider_name, policy_number, coverage_start_date, coverage_end_date)
SELECT 5, patient_id, 'Health Provider E', 'POL77889', '2023-05-01', '2024-05-01' FROM Patient WHERE first_name = 'Elizabeth'  LIMIT 1;

-- Medication 
INSERT INTO Medications (medication_id, record_id, medication_name, dosage)
SELECT 1, record_id, 'Medication A', '50 mg' FROM MedicalRecord WHERE diagnosis = 'Hypothyroidism' LIMIT 1;
INSERT INTO Medications (medication_id, record_id, medication_name, dosage)
SELECT 2, record_id, 'Medication B', '100 mg' FROM MedicalRecord WHERE diagnosis = 'Hypertension' LIMIT 1;
INSERT INTO Medications (medication_id, record_id, medication_name, dosage)
SELECT 3, record_id, 'Medication C', '200 mg' FROM MedicalRecord WHERE diagnosis = 'Migraine' LIMIT 1;
INSERT INTO Medications (medication_id, record_id, medication_name, dosage)
SELECT 4, record_id, 'Medication D', '25 mg' FROM MedicalRecord WHERE diagnosis = 'Chronic lower back pain' LIMIT 1;
INSERT INTO Medications (medication_id, record_id, medication_name, dosage)
SELECT 5, record_id, 'Medication E', '75 mg' FROM MedicalRecord WHERE diagnosis = 'Seasonal allergies' LIMIT 1;


-- PatientMedicalHistory 
-- Fix this part make it unique  
INSERT INTO PatientMedicalHistory (history_id, patient_id, user_condition, diagnosis_date)
SELECT 1, patient_id, 'Getting  better', '2022-01-01' FROM Patient WHERE first_name = 'Devraj'  LIMIT 1;
INSERT INTO PatientMedicalHistory (history_id, patient_id, user_condition, diagnosis_date)
SELECT 2, patient_id, 'Sweating alot', '2022-02-01' FROM Patient WHERE first_name = 'Yash' LIMIT 1;
INSERT INTO PatientMedicalHistory (history_id, patient_id, user_condition, diagnosis_date)
SELECT 3, patient_id, 'Good', '2022-03-01' FROM Patient WHERE first_name = 'Alexander' LIMIT 1;
INSERT INTO PatientMedicalHistory (history_id, patient_id, user_condition, diagnosis_date)
SELECT 4, patient_id, 'Constant pain', '2022-04-01' FROM Patient WHERE first_name = 'Elizabeth' LIMIT 1;
INSERT INTO PatientMedicalHistory (history_id, patient_id, user_condition, diagnosis_date)
SELECT 5, patient_id, 'Bleeding alot', '2022-05-01' FROM Patient WHERE first_name = 'Megan' LIMIT 1;


-- Procedures
INSERT INTO Procedures (procedure_id, record_id, procedure_name)
SELECT 1, record_id, 'Procedure A' FROM MedicalRecord WHERE patient_id = 2  LIMIT 1;
INSERT INTO Procedures (procedure_id, record_id, procedure_name)
SELECT 2, record_id, 'Procedure B' FROM MedicalRecord WHERE patient_id = 5 LIMIT 1;
INSERT INTO Procedures (procedure_id, record_id, procedure_name)
SELECT 3, record_id, 'Procedure C' FROM MedicalRecord WHERE patient_id = 6  LIMIT 1;
INSERT INTO Procedures (procedure_id, record_id, procedure_name)
SELECT 4, record_id, 'Procedure D' FROM MedicalRecord WHERE patient_id = 8  LIMIT 1;
INSERT INTO Procedures (procedure_id, record_id, procedure_name)
SELECT 5, record_id, 'Procedure E' FROM MedicalRecord WHERE patient_id = 11 LIMIT 1;

-- Resources
INSERT INTO Resource (resource_id, department_id, resource_name, resource_type, status)
SELECT 1, department_id, 'Resource A', 'Type X', 'Available' FROM Department WHERE department_id = 1 LIMIT 1;
INSERT INTO Resource (resource_id, department_id, resource_name, resource_type, status)
SELECT 2, department_id, 'Resource B', 'Type Y', 'In Use' FROM Department WHERE department_id = 2 LIMIT 1;
INSERT INTO Resource (resource_id, department_id, resource_name, resource_type, status)
SELECT 3, department_id, 'Resource C', 'Type Z', 'Under Maintenance' FROM Department WHERE department_id = 3 LIMIT 1;
INSERT INTO Resource (resource_id, department_id, resource_name, resource_type, status)
SELECT 4, department_id, 'Resource D', 'Type X', 'Available' FROM Department WHERE department_id = 4  LIMIT 1;
INSERT INTO Resource (resource_id, department_id, resource_name, resource_type, status)
SELECT 5, department_id, 'Resource E', 'Type Y', 'In Use' FROM Department WHERE department_id = 5  LIMIT 1;


-- Shift
INSERT INTO Shift (shift_id, shift_date, shift_time)
VALUES 
    (1, '2023-07-01', '08:00:00'),
    (2, '2023-07-02', '08:00:00'),
    (3, '2023-07-03', '08:00:00'),
    (4, '2023-07-04', '08:00:00'),
    (5, '2023-07-05', '08:00:00');

-- Staff_Shift
INSERT INTO Staff_Shift (staff_id, shift_id)
SELECT staff_id, 1 FROM Staff LIMIT 1;
INSERT INTO Staff_Shift (staff_id, shift_id)
SELECT staff_id, 2 FROM Staff LIMIT 1;
INSERT INTO Staff_Shift (staff_id, shift_id)
SELECT staff_id, 3 FROM Staff LIMIT 1;
INSERT INTO Staff_Shift (staff_id, shift_id)
SELECT staff_id, 4 FROM Staff LIMIT 1;
INSERT INTO Staff_Shift (staff_id, shift_id)
SELECT staff_id, 5 FROM Staff LIMIT 1;
 
