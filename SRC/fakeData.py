from faker import Faker
import random
from mysql.connector import connect, Error

fake = Faker()

num_patients = 2000
num_staff = 500
num_medical_records = 4000
num_appointment = 4000
diagnoses = [
    "Acute bronchitis",
    "Seasonal allergies",
    "Hypertension",
    "Diabetes mellitus",
    "Chronic obstructive pulmonary disease",
    "Gastroesophageal reflux disease",
    "Urinary tract infection",
    "Migraine",
    "Chronic lower back pain",
    "Hyperlipidemia",
    "Asthma",
    "Depression",
    "Anxiety disorder",
    "Influenza",
    "Hypothyroidism",
    "Sinusitis",
    "Osteoarthritis",
    "Rheumatoid arthritis",
    "Pneumonia",
    "Acute pharyngitis"
]

def generate_diagnosis():
    return random.choice(diagnoses)
reason = [
    "Annual physical exam",
    "Follow-up appointment",
    "Vaccination",
    "Flu-like symptoms",
    "Persistent cough",
    "Stomach pain",
    "Vision check-up",
    "High blood pressure follow-up",
    "Pregnancy check-up",
    "Post-surgical follow-up",
    "Diabetes management",
    "Ear infection",
    "Joint pain"

]

def generate_reason_for_visit():
    return random.choice(reason)
specialites = [
    "Surgery",
    "Internal medicine",
    "Family medicine",
    "Emergency medicine",
    "Dermatology"
]
def generate_specialty():
    return random.choice(specialites)

def create_connection():
    try:
        connection = connect(
            host='localhost',  
            user='root',  
            password='mySQLDevrajpyD3.', 
            database='3309'  
        )
        if connection.is_connected():
            print("Successfully connected to the database")
        return connection
    except Error as e:
        print(f"Error: {e}")
        return None

def generate_patient_data(connection):
    cursor = connection.cursor()
    for i in range(num_patients):
        patient_id = 4 + i
        first_name = fake.first_name()
        last_name = fake.last_name()
        date_of_birth = fake.date_of_birth(minimum_age=0, maximum_age=90)
        gender = random.choice(['M', 'F'])
        blood_type = random.choice(['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'])
        phone = fake.unique.numerify("###-###-####") 
        email = fake.unique.email()
        street_address = fake.street_address()
        city = fake.city()
        state =  "ON" 
        zip_code = random.choice([fake.postalcode(), fake.zipcode()])
        
        query = """
        INSERT INTO Patient (patient_id, first_name, last_name, date_of_birth, gender, blood_type, phone, email, street_address, city, state, zip_code)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (patient_id, first_name, last_name, date_of_birth, gender, blood_type, phone, email, street_address, city, state, zip_code))
    
    connection.commit()
    print("Patient data inserted.")

def generate_staff_data(connection):
    cursor = connection.cursor()
    for i in range(num_staff):
        staff_id = i + 1
        first_name = fake.first_name()
        last_name = fake.last_name()
        role = random.choice(['Doctor', 'Nurses', 'Administrator', 'Technicians'])
        hire_date = fake.date_between(start_date='-10y', end_date='today')
        phone = fake.unique.numerify("###-###-####") 
        email = fake.unique.email()
        department_id = random.randint(1, 5)
        
        query = """
        INSERT INTO Staff (staff_id, first_name, last_name, role, hire_date, phone, email, department_id)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (staff_id, first_name, last_name, role, hire_date, phone, email, department_id))
    
    connection.commit()
    print("Staff data inserted.")
def generate_doctor_data(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT staff_id FROM Staff WHERE role = 'Doctor'")
    doctor_ids = cursor.fetchall()
    
    for (staff_id,) in doctor_ids:
        specialty = generate_specialty()
        query = """
        INSERT INTO Doctor (staff_id, specialty) VALUES (%s, %s)
        """
        cursor.execute(query, (staff_id,specialty))
    
    connection.commit()
    print("Doctor data inserted.")
def generate_medical_record_data(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT patient_id FROM Patient")
    patient_ids = [row[0] for row in cursor.fetchall()]
    
    cursor.execute("SELECT staff_id FROM Doctor")
    doctor_ids = [row[0] for row in cursor.fetchall()]
    
    record_id = 1
    for patient_id in patient_ids:
        staff_id = random.choice(doctor_ids)
        diagnosis = generate_diagnosis()
        date_of_record = fake.date_between(start_date='-2y', end_date='today')
        
        query = """
        INSERT INTO MedicalRecord (record_id, patient_id, staff_id, diagnosis, date_of_record)
        VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(query, (record_id, patient_id, staff_id, diagnosis, date_of_record))
        record_id += 1  

    for _ in range(num_medical_records - len(patient_ids)):
        patient_id = random.choice(patient_ids)
        staff_id = random.choice(doctor_ids)
        diagnosis = generate_diagnosis()
        date_of_record = fake.date_between(start_date='-2y', end_date='today')
        
        query = """
        INSERT INTO MedicalRecord (record_id, patient_id, staff_id, diagnosis, date_of_record)
        VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(query, (record_id, patient_id, staff_id, diagnosis, date_of_record))
        record_id += 1

    connection.commit()
    print("Medical record data inserted.")

def generate_appointment_data(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT patient_id FROM Patient")
    patient_ids = [row[0] for row in cursor.fetchall()]
    
    cursor.execute("SELECT staff_id FROM Doctor")
    doctor_ids = [row[0] for row in cursor.fetchall()]
    
    appointment_id = 1
    for patient_id in patient_ids:
        staff_id = random.choice(doctor_ids)
        appointment_date = fake.date_between(start_date='-2y', end_date='today')
        appointment_time = fake.time()
        reason_for_visit = generate_reason_for_visit()
        status = random.choice(['Scheduled', 'Completed', 'Cancelled'])
        
        query = """
        INSERT INTO Appointment (appointment_id, patient_id, staff_id, appointment_date, appointment_time, reason_for_visit, status)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (appointment_id, patient_id, staff_id, appointment_date, appointment_time, reason_for_visit, status))
        appointment_id += 1 

    for _ in range(num_appointment - len(patient_ids)):
        patient_id = random.choice(patient_ids)
        staff_id = random.choice(doctor_ids)
        appointment_date = fake.date_between(start_date='-2y', end_date='today')
        appointment_time = fake.time()
        reason_for_visit = generate_reason_for_visit()
        status = random.choice(['Scheduled', 'Completed', 'Cancelled'])
        
        query = """
        INSERT INTO Appointment (appointment_id, patient_id, staff_id, appointment_date, appointment_time, reason_for_visit, status)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (appointment_id, patient_id, staff_id, appointment_date, appointment_time, reason_for_visit, status))
        appointment_id += 1

    connection.commit()
    print("Appointment data inserted.")

def get_existing_ids(connection, table, column):
    cursor = connection.cursor()
    cursor.execute(f"SELECT {column} FROM {table}")
    return [row[0] for row in cursor.fetchall()]

connection = create_connection()
if connection:
    generate_patient_data(connection)
    generate_staff_data(connection)
    
    patient_ids = get_existing_ids(connection, 'Patient', 'patient_id')
    staff_ids = get_existing_ids(connection, 'Staff', 'staff_id')
    
    generate_doctor_data(connection)
    generate_medical_record_data(connection)
    generate_appointment_data(connection)
    
    connection.close()

