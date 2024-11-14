CREATE VIEW RecentMedicalRecords AS
SELECT mr.record_id, p.patient_id, p.first_name, p.last_name, mr.diagnosis, mr.date_of_record
FROM MedicalRecord mr
JOIN Patient p ON mr.patient_id = p.patient_id
WHERE TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) < 30
  AND mr.date_of_record > DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
  
CREATE VIEW DoctorAppointments AS
SELECT a.appointment_id, d.staff_id, s.first_name AS doctor_first_name, s.last_name AS doctor_last_name, 
       a.patient_id, a.appointment_date, a.appointment_time, a.reason_for_visit, a.status
FROM Appointment a
JOIN Doctor d ON a.staff_id = d.staff_id
JOIN Staff s ON d.staff_id = s.staff_id;

SELECT * FROM RecentMedicalRecords LIMIT 5;
SELECT * FROM DoctorAppointments LIMIT 5;

INSERT INTO RecentMedicalRecords (record_id, patient_id, first_name, last_name, diagnosis, date_of_record)
VALUES (999, 2001, 'Alice', 'Johnson', 'Common Cold', '2024-07-15');

INSERT INTO DoctorAppointments (appointment_id, staff_id, doctor_first_name, doctor_last_name, patient_id, appointment_date, appointment_time, reason_for_visit, status)
VALUES (999, 5, 'David', 'West', 3001, '2024-10-12', '10:00:00', 'Follow-up', 'Scheduled');