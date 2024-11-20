SELECT p.patient_id, p.first_name, p.last_name, p.date_of_birth, a.appointment_date, a.reason_for_visit
FROM Patient p
LEFT JOIN Appointment a
ON p.patient_id = a.patient_id
WHERE 
    a.appointment_date = (
        SELECT MAX(appointment_date)
        FROM Appointment
        WHERE patient_id = p.patient_id
    )
UNION
SELECT p.patient_id, p.first_name, p.last_name, p.date_of_birth, NULL AS appointment_date, NULL AS reason_for_visit
FROM Patient p
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM Appointment a
        WHERE a.patient_id = p.patient_id
    );


SELECT p.first_name AS patient_name, d.first_name AS doctor_name, a.appointment_date, a.reason_for_visit
FROM Appointment a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor doc ON a.staff_id = doc.staff_id
JOIN Staff d ON doc.staff_id = d.staff_id;

SELECT s.first_name, COUNT(a.appointment_id) AS appointment_count
FROM Appointment a
JOIN Doctor d ON a.staff_id = d.staff_id
JOIN Staff s ON d.staff_id = s.staff_id
GROUP BY s.first_name;

SELECT patient_id, first_name, last_name
FROM Patient
WHERE patient_id IN (
    SELECT patient_id
    FROM MedicalRecord
    GROUP BY patient_id
    HAVING COUNT(record_id) > 1
);

SELECT s.staff_id, s.first_name, s.last_name
FROM Staff s
WHERE EXISTS (
    SELECT 1
    FROM Appointment a
    WHERE a.staff_id = s.staff_id
);

SELECT department_id, COUNT(staff_id) AS num_staff
FROM Staff
GROUP BY department_id
HAVING num_staff > 5;

SELECT mr.record_id, p.first_name, p.last_name, mr.diagnosis, mr.date_of_record
FROM MedicalRecord mr
JOIN Patient p ON mr.patient_id = p.patient_id
WHERE TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) > 50;
