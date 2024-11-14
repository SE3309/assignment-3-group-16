INSERT INTO Staff_Shift (staff_id, shift_id)
SELECT s.staff_id, 1
FROM Staff s
WHERE s.role = 'Nurses'
LIMIT 1;

UPDATE Appointment a
JOIN MedicalRecord mr ON a.patient_id = mr.patient_id
JOIN Patient p ON a.patient_id = p.patient_id
SET a.status = 'Completed'
WHERE mr.diagnosis = 'Hypertension';

-- Run these both together 
DELETE FROM Procedures
WHERE record_id IN (
    SELECT record_id 
    FROM MedicalRecord 
    WHERE patient_id = 2
    AND TIMESTAMPDIFF(YEAR, (SELECT date_of_birth FROM Patient WHERE patient_id = 2), CURDATE()) < 25
    AND date_of_record < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);
DELETE FROM MedicalRecord
WHERE patient_id = 2
AND TIMESTAMPDIFF(YEAR, (SELECT date_of_birth FROM Patient WHERE patient_id = 2), CURDATE()) < 25
AND date_of_record < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Ask about ON DELETE


