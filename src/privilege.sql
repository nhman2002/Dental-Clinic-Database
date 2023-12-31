use DentalClinicDev
go

UPDATE account --update admin pass for login, pass 123456
SET password = '$2a$12$c0bY.IqcxKRZEMlWPVGg4OH/x9Tw2owCba74mFiyTrrp9Vxl4.UXy'
WHERE username = 'ADM-123456';

-- CREATE ROLLE
CREATE ROLE DB_ADMIN;
CREATE ROLE PATIENT;
CREATE ROLE STAFF;
CREATE ROLE DENTIST;

-- CREATE LOGIN ACC
CREATE LOGIN MAN
WITH PASSWORD = '123';
CREATE LOGIN HIEU
WITH PASSWORD = '123';
CREATE LOGIN NAM
WITH PASSWORD = '123';
CREATE LOGIN TRUNG
WITH PASSWORD = '123';

-- EXEC ADD ACC TO ROLE
GO
EXEC sp_addrolemember STAFF, MAN1;
EXEC sp_addrolemember DB_ADMIN, HIEU;
EXEC sp_addrolemember PATIENT, NAM;
EXEC sp_addrolemember DENTIST, TRUNG;

-- ADD accessAdmin TO ROLE DB_ADMIN
ALTER ROLE db_accessadmin ADD MEMBER HIEU;
go

-- GRANT VIEW TO PATIENT
CREATE VIEW VIEW_PATIENT_INFO
as
SELECT *
FROM [dbo].[Patient], [dbo].[PaymentRecord]
WHERE [dbo].[Patient].[id] = @PATIENT_ID 
	AND [dbo].[Patient].[id] = [dbo].[PaymentRecord].[patientID] 
go

-- GRANT VIEW TO DENTIST
CREATE VIEW VIEW_DENTIST_INFO
as
SELECT *
FROM [dbo].[Personnel]
WHERE [dbo].[Dentist].[id] = @DENTIST_ID 
go

CREATE VIEW VIEW_SESSION_INFO
as
SELECT *
FROM [dbo].[Session], [dbo].[TreatmentSession], [dbo].[PersonnelSession]
WHERE [dbo].[PersonnelSession].[dentistID] = @DENTIST_ID 
	AND [dbo].[PersonnelSession].[sessionID] = [dbo].[Session].[id]
	AND [dbo].[Session].[id] = [dbo].[TreatmentSession].[id]
go

-- GRANT PRIVILEGE TO STAFF
GRANT UPDATE ON [dbo].[ACCOUNT](PASSWORD) TO STAFF;
GRANT SELECT ON [dbo].[ACCOUNT] TO STAFF;
GRANT ALL ON [dbo].[PERSONNEL] TO STAFF;
GRANT ALL ON [dbo].[AppointmentRequest] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[DRUG] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[DAY] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[SCHEDULE] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[ROOM] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[PROCEDURE] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[CATEGORY] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[SESSION] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[TREATMENTSESSION] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[TOOTH] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[TOOTHSESSION] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[EXAMINATIONSESSION] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[RE[EXAMINATIONSESSION]] TO STAFF;
GRANT SELECT,UPDATE,INSERT ON [dbo].[PATIENT] TO STAFF;
GRANT ALL PRIVILEGES ON [dbo].[PAYMENTRECORD] TO STAFF;

-- GRANT PRIVILEGE TO DENTIST
GRANT UPDATE ON [dbo].[DRUG](DESCRIPTION) TO DENTIST;
GRANT SELECT ON [dbo].[DRUG] TO DENTIST;
GRANT UPDATE ON [dbo].[TREATMENTSESSION](DESCRIPTION) TO DENTIST;
GRANT UPDATE ON [dbo].[TREATMENTSESSION](HEALTHNOTE) TO DENTIST;
GRANT SELECT ON [dbo].[TREATMENTSESSION] TO DENTIST;
GRANT UPDATE ON [dbo].[SESSION](NOTE) TO DENTIST;
GRANT SELECT ON [dbo].[SESSION] TO DENTIST;
GRANT UPDATE ON [dbo].[ACCOUNT](PASSWORD) TO DENTIST;
GRANT UPDATE ON [dbo].[ACCOUNT](USERNAME) TO DENTIST;
GRANT ALL PRIVILEGES ON VIEW_DENTIST_INFO TO DENTIST
GRANT ALL PRIVILEGES ON VIEW_SESSION_INFO TO DENTIST

-- GRANT PRIVILEGE TO PATIENT
GRANT UPDATE ON [dbo].[ACCOUNT](PASSWORD) TO PATIENT;
GRANT UPDATE ON [dbo].[ACCOUNT](USERNAME) TO PATIENT;
GRANT INSERT ON [dbo].[AppointmentRequest] TO PATIENT;
GRANT ALL PRIVILEGES ON VIEW_PATIENT_INFO TO PATIENT;
