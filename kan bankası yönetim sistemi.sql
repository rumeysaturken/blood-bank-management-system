
USE BloodBankDB;
GO
/*
Projede kullanacaðýmýz tablolar þunlar:

Donors (Baðýþçýlar)

Recipients (Alýcýlar)

Hospitals (Hastaneler)

BloodUnits (Kan Üniteleri)

Requests (Kan Talebi)

*/
-- Baðýmlý tablolardan baþla
IF OBJECT_ID('dbo.Requests', 'U') IS NOT NULL
    DROP TABLE dbo.Requests;

IF OBJECT_ID('dbo.BloodUnits', 'U') IS NOT NULL
    DROP TABLE dbo.BloodUnits;

-- Sonra baðýmsýz tablolar
IF OBJECT_ID('dbo.Hospitals', 'U') IS NOT NULL
    DROP TABLE dbo.Hospitals;

IF OBJECT_ID('dbo.Recipients', 'U') IS NOT NULL
    DROP TABLE dbo.Recipients;

IF OBJECT_ID('dbo.Donors', 'U') IS NOT NULL
    DROP TABLE dbo.Donors;

	-- Donors Tablosu
CREATE TABLE Donors (
    DonorID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18 AND Age <= 65),
    BloodGroup NVARCHAR(3) NOT NULL,
    HasTransmissibleDisease BIT NOT NULL DEFAULT 0,
    DonationDate DATE NOT NULL
);

-- Recipients Tablosu
CREATE TABLE Recipients (
    RecipientID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Age INT,
    BloodGroup NVARCHAR(3) NOT NULL
);

-- Hospitals Tablosu
CREATE TABLE Hospitals (
    HospitalID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Address NVARCHAR(250),
    ContactNumber NVARCHAR(20)
);

-- BloodUnits Tablosu
CREATE TABLE BloodUnits (
    BloodUnitID INT IDENTITY(1,1) PRIMARY KEY,
    DonorID INT NOT NULL,
    BloodGroup NVARCHAR(3) NOT NULL,
    CollectionDate DATE NOT NULL,
    ExpirationDate DATE NOT NULL,
    IsContaminated BIT NOT NULL DEFAULT 0,
    IsUsed BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_BloodUnits_Donors FOREIGN KEY (DonorID) REFERENCES Donors(DonorID)
);

-- Requests Tablosu
CREATE TABLE Requests (
    RequestID INT IDENTITY(1,1) PRIMARY KEY,
    HospitalID INT NOT NULL,
    BloodGroup NVARCHAR(3) NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    RequestDate DATE NOT NULL,
    Fulfilled BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Requests_Hospitals FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID)
);
-- Donors (Baðýþçýlar) - 20 kayýt
INSERT INTO Donors (Name, Age, BloodGroup, HasTransmissibleDisease, DonationDate) VALUES
('Ahmet Yýlmaz', 30, 'A+', 0, '2025-07-10'),
('Mehmet Demir', 45, 'B-', 1, '2025-07-15'),
('Elif Kaya', 27, 'O+', 0, '2025-07-18'),
('Ayþe Yýldýz', 35, 'AB+', 0, '2025-07-12'),
('Caner Þahin', 40, 'A-', 0, '2025-07-14'),
('Deniz Çelik', 50, 'B+', 0, '2025-07-16'),
('Emre Aksoy', 28, 'O-', 0, '2025-07-11'),
('Fatma Korkmaz', 33, 'A+', 0, '2025-07-13'),
('Gülhan Koç', 42, 'AB-', 0, '2025-07-19'),
('Hakan Doðan', 29, 'B+', 0, '2025-07-15'),
('Ýrem Sarý', 31, 'O+', 0, '2025-07-18'),
('Jale Yýlmaz', 38, 'A-', 0, '2025-07-17'),
('Kerem Öz', 26, 'B-', 1, '2025-07-20'),
('Lale Aslan', 44, 'AB+', 0, '2025-07-21'),
('Murat Arslan', 39, 'O-', 0, '2025-07-22'),
('Nazan Yalçýn', 37, 'A+', 0, '2025-07-23'),
('Ozan Yýldýrým', 41, 'B+', 0, '2025-07-24'),
('Pelin Güner', 34, 'AB-', 0, '2025-07-25'),
('Ramazan Çetin', 30, 'O+', 0, '2025-07-26'),
('Selin Kara', 28, 'A-', 0, '2025-07-27');

-- Recipients (Alýcýlar) - 20 kayýt
INSERT INTO Recipients (Name, Age, BloodGroup) VALUES
('Fatma Öztürk', 50, 'A+'),
('Ali Can', 60, 'AB-'),
('Buse Demir', 45, 'B+'),
('Cem Yýlmaz', 52, 'O-'),
('Derya Kaya', 30, 'A-'),
('Erdem Akýn', 33, 'AB+'),
('Funda Þen', 40, 'O+'),
('Gökhan Öz', 36, 'B-'),
('Hale Kýlýç', 28, 'A+'),
('Ýlker Çelik', 47, 'AB-'),
('Jülide Taþ', 54, 'O+'),
('Kemal Aslan', 39, 'B+'),
('Leyla Polat', 44, 'A-'),
('Mert Yýldýz', 41, 'AB+'),
('Nihan Özkan', 35, 'O-'),
('Onur Demirtaþ', 50, 'B-'),
('Pýnar Sarý', 29, 'A+'),
('Rabia Kaya', 38, 'AB-'),
('Serkan Taþ', 42, 'O+'),
('Tuðba Þahin', 34, 'B+');

-- Hospitals (Hastaneler) - 10 kayýt
INSERT INTO Hospitals (Name, Address, ContactNumber) VALUES
('Ýstanbul Eðitim ve Araþtýrma Hastanesi', 'Ýstanbul', '0212 123 4567'),
('Ankara Üniversitesi Týp Fakültesi Hastanesi', 'Ankara', '0312 765 4321'),
('Ýzmir Atatürk Eðitim ve Araþtýrma Hastanesi', 'Ýzmir', '0232 111 2233'),
('Hacettepe Üniversitesi Hastanesi', 'Ankara', '0312 234 5678'),
('Ege Üniversitesi Hastanesi', 'Ýzmir', '0232 444 5566'),
('Marmara Üniversitesi Hastanesi', 'Ýstanbul', '0212 333 4455'),
('Celal Bayar Üniversitesi Hastanesi', 'Manisa', '0236 555 6677'),
('Akdeniz Üniversitesi Hastanesi', 'Antalya', '0242 666 7788'),
('Gazi Üniversitesi Hastanesi', 'Ankara', '0312 777 8899'),
('Ondokuz Mayýs Üniversitesi Hastanesi', 'Samsun', '0362 888 9900');

-- BloodUnits (Kan Üniteleri) - 20 kayýt
INSERT INTO BloodUnits (DonorID, BloodGroup, CollectionDate, ExpirationDate, IsContaminated, IsUsed) VALUES
(1, 'A+', '2025-07-10', '2025-08-14', 0, 0),
(2, 'B-', '2025-07-15', '2025-08-19', 1, 0),
(3, 'O+', '2025-07-18', '2025-08-22', 0, 1),
(4, 'AB+', '2025-07-12', '2025-08-16', 0, 0),
(5, 'A-', '2025-07-14', '2025-08-18', 0, 0),
(6, 'B+', '2025-07-16', '2025-08-20', 0, 0),
(7, 'O-', '2025-07-11', '2025-08-15', 0, 0),
(8, 'A+', '2025-07-13', '2025-08-17', 0, 0),
(9, 'AB-', '2025-07-19', '2025-08-23', 0, 0),
(10, 'B+', '2025-07-15', '2025-08-19', 0, 0),
(11, 'O+', '2025-07-18', '2025-08-22', 0, 0),
(12, 'A-', '2025-07-17', '2025-08-21', 0, 0),
(13, 'B-', '2025-07-20', '2025-08-24', 1, 0),
(14, 'AB+', '2025-07-21', '2025-08-25', 0, 0),
(15, 'O-', '2025-07-22', '2025-08-26', 0, 0),
(16, 'A+', '2025-07-23', '2025-08-27', 0, 0),
(17, 'B+', '2025-07-24', '2025-08-28', 0, 0),
(18, 'AB-', '2025-07-25', '2025-08-29', 0, 0),
(19, 'O+', '2025-07-26', '2025-08-30', 0, 0),
(20, 'A-', '2025-07-27', '2025-08-31', 0, 0);

-- Requests (Kan Talepleri) - 15 kayýt
INSERT INTO Requests (HospitalID, BloodGroup, Quantity, RequestDate, Fulfilled) VALUES
(1, 'A+', 5, '2025-07-20', 0),
(2, 'B-', 3, '2025-07-21', 1),
(3, 'O+', 4, '2025-07-22', 0),
(4, 'AB+', 2, '2025-07-23', 1),
(5, 'A-', 6, '2025-07-24', 0),
(6, 'B+', 1, '2025-07-25', 0),
(7, 'O-', 3, '2025-07-26', 0),
(8, 'A+', 7, '2025-07-27', 0),
(9, 'AB-', 2, '2025-07-28', 0),
(10, 'B+', 5, '2025-07-29', 1),
(1, 'O+', 4, '2025-07-30', 0),
(2, 'A-', 3, '2025-07-31', 0),
(3, 'B-', 1, '2025-08-01', 0),
(4, 'AB+', 2, '2025-08-02', 0),
(5, 'O-', 3, '2025-08-03', 0);


--Kan Stok Durumu Sorgusu:

SELECT 
    BloodGroup,
    COUNT(*) AS AvailableUnits
FROM BloodUnits
WHERE 
    IsUsed = 0
    AND IsContaminated = 0
    AND ExpirationDate >= CAST(GETDATE() AS DATE)
GROUP BY BloodGroup
ORDER BY BloodGroup;

--kaç ünite kan mevcut onu gösterir

--Kan Talebi ve Stok Karþýlaþtýrmasý
SELECT 
    r.BloodGroup,
    SUM(r.Quantity) AS TotalRequested,
    ISNULL(s.AvailableUnits, 0) AS AvailableUnits,
    CASE 
        WHEN ISNULL(s.AvailableUnits, 0) >= SUM(r.Quantity) THEN 'Yeterli'
        ELSE 'Yetersiz'
    END AS StockStatus
FROM Requests r
LEFT JOIN (
    SELECT 
        BloodGroup,
        COUNT(*) AS AvailableUnits
    FROM BloodUnits
    WHERE 
        IsUsed = 0
        AND IsContaminated = 0
        AND ExpirationDate >= CAST(GETDATE() AS DATE)
    GROUP BY BloodGroup
) s ON r.BloodGroup = s.BloodGroup
GROUP BY r.BloodGroup, s.AvailableUnits
ORDER BY r.BloodGroup;

/*
Bu sorgu:

Her kan grubu için hastanelerden gelen toplam talebi,

Stoktaki kullanýlabilir kan miktarýný,

Stok durumunu (Yeterli / Yetersiz) gösterir.

*/

--Baðýþçýlarýn bulaþýcý hastalýk durumunu sorgulamak için:
SELECT DonorID, Name, HasTransmissibleDisease
FROM Donors
WHERE HasTransmissibleDisease = 1;

--Kullanýlmýþ veya kirli kanlarý listelemek için:

SELECT BloodUnitID, BloodGroup, CollectionDate
FROM BloodUnits
WHERE IsUsed = 1 OR IsContaminated = 1;

--Belirli bir hastanenin kan taleplerini görmek için (örneðin HospitalID=1):

SELECT *
FROM Requests
WHERE HospitalID = 1;

--Stokta kullanýlabilir kan miktarýný ExpirationDate filtresi olmadan hesaplayalým:

WITH StockTotals AS (
    SELECT BloodGroup, COUNT(*) AS AvailableUnits
    FROM BloodUnits
    WHERE IsUsed = 0 AND IsContaminated = 0
    GROUP BY BloodGroup
),
RequestTotals AS (
    SELECT BloodGroup, SUM(Quantity) AS TotalRequested
    FROM Requests
    GROUP BY BloodGroup
)
SELECT 
    rt.BloodGroup,
    rt.TotalRequested,
    ISNULL(st.AvailableUnits, 0) AS AvailableUnits,
    CASE WHEN ISNULL(st.AvailableUnits, 0) >= rt.TotalRequested THEN 'Yeterli' ELSE 'Yetersiz' END AS StockStatus
FROM RequestTotals rt
LEFT JOIN StockTotals st ON rt.BloodGroup = st.BloodGroup
ORDER BY rt.BloodGroup;

-- Kullanýlabilir kanlarýn son kullanma tarihlerini ve stok miktarlarýný detaylý görelim:

SELECT 
    BloodGroup, 
    COUNT(*) AS AvailableUnits,
    MIN(ExpirationDate) AS EarliestExpirationDate,
    MAX(ExpirationDate) AS LatestExpirationDate
FROM BloodUnits
WHERE IsUsed = 0 AND IsContaminated = 0
GROUP BY BloodGroup
ORDER BY BloodGroup;

--istersen aþaðýdaki sorgu ile kirli veya kullanýlmýþ kanlarý listeleyip neden stokta olamadýklarýný inceleyebiliriz:

SELECT BloodUnitID, BloodGroup, IsUsed, IsContaminated, ExpirationDate
FROM BloodUnits
WHERE IsUsed = 1 OR IsContaminated = 1 OR ExpirationDate < CAST(GETDATE() AS DATE)
ORDER BY ExpirationDate;

--Özet tablo ile hastane bazýnda talepler ve stok durumu çýkarmak istersek:

WITH StockTotals AS (
    SELECT BloodGroup, COUNT(*) AS AvailableUnits
    FROM BloodUnits
    WHERE IsUsed = 0 AND IsContaminated = 0
    GROUP BY BloodGroup
)
SELECT 
    h.Name AS HospitalName,
    r.BloodGroup,
    SUM(r.Quantity) AS TotalRequested,
    ISNULL(st.AvailableUnits, 0) AS AvailableUnits,
    CASE WHEN ISNULL(st.AvailableUnits, 0) >= SUM(r.Quantity) THEN 'Yeterli' ELSE 'Yetersiz' END AS StockStatus
FROM Requests r
JOIN Hospitals h ON r.HospitalID = h.HospitalID
LEFT JOIN StockTotals st ON r.BloodGroup = st.BloodGroup
GROUP BY h.Name, r.BloodGroup, st.AvailableUnits
ORDER BY h.Name, r.BloodGroup;



go
 --aktif donör takibi son 3 ayda baðýþ yapanlar

 SELECT 
    DonorID,
    Name,
    BloodGroup,
    DonationDate
FROM Donors
WHERE DonationDate >= DATEADD(MONTH, -3, CAST(GETDATE() AS DATE))
ORDER BY DonationDate DESC;

--ayný kiþilerin birden fazla baðýþý varsa kaç defa baðýþ yaptýklarýný listeleyen 

SELECT 
    Name,
    BloodGroup,
    COUNT(*) AS TotalDonations
FROM Donors
WHERE DonationDate >= DATEADD(MONTH, -3, CAST(GETDATE() AS DATE))
GROUP BY Name, BloodGroup
ORDER BY TotalDonations DESC;

--Sorgu: Aktif Donör Performansý (Son 6 Ayda En Çok Baðýþ Yapanlar)
/*
Bu Sorgu Ne Yapar?
Son 6 aydaki baðýþlara bakar.

En çok baðýþ yapan 5 kiþiyi sýralar.

Donörün hastalýklý olup olmadýðýný da gösterir.

Son baðýþ tarihini de listeler.
*/
-- Ýlk 5 aktif ve uygun donörü getir (son 6 ayda)
SELECT TOP 5
    d.DonorID,
    d.Name,
    d.BloodGroup,
    d.HasTransmissibleDisease,
    COUNT(b.BloodUnitID) AS DonationCount,
    MAX(b.CollectionDate) AS LastDonationDate
FROM Donors d
JOIN BloodUnits b ON d.DonorID = b.DonorID
WHERE 
    b.CollectionDate >= DATEADD(MONTH, -6, GETDATE())
GROUP BY 
    d.DonorID, d.Name, d.BloodGroup, d.HasTransmissibleDisease
ORDER BY 
    DonationCount DESC, LastDonationDate DESC;


	--güvenli ve düzenli donörleri listeler 
	SELECT 
    d.DonorID,
    d.Name,
    d.BloodGroup,
    COUNT(b.BloodUnitID) AS TotalValidDonations
FROM Donors d
JOIN BloodUnits b ON d.DonorID = b.DonorID
WHERE 
    d.HasTransmissibleDisease = 0 AND
    b.IsContaminated = 0 AND
    b.IsUsed = 0
GROUP BY 
    d.DonorID, d.Name, d.BloodGroup
HAVING 
    COUNT(b.BloodUnitID) >= 2
ORDER BY 
    TotalValidDonations DESC;

	/*
	Bu Sorgu Ne Saðlar?
 En az 2 defa temiz ve güvenli kan baðýþý yapmýþ donörleri gösterir.
 Bu kiþileri bir "güvenilir donör havuzu" gibi düþünebilirsin.
 Sistem içinde bir otomatik öncelikli liste yapýlabilir (örneðin, acil durumda bu kiþilerle iletiþime geçilebilir).*/

 --Kritik (Nadir) Kan Gruplarýnýn Takibi
/* Aþaðýdaki nadir ve kritik kan gruplarýnýn stok durumunu analiz etmek:

O- (herkese verebilir, sadece O- alabilir)

AB- (çok nadir)

B-

A-
*/
--Sorgu: Kritik Kan Gruplarý ve Stok Durumu

SELECT 
    BloodGroup,
    COUNT(*) AS AvailableUnits
FROM BloodUnits
WHERE 
    BloodGroup IN ('O-', 'AB-', 'B-', 'A-') AND
    IsUsed = 0 AND
    IsContaminated = 0 AND
    ExpirationDate >= CAST(GETDATE() AS DATE)
GROUP BY BloodGroup
ORDER BY BloodGroup;

go
CREATE TRIGGER trg_AfterNewDonor
ON Donors
AFTER INSERT
AS
BEGIN
    INSERT INTO BloodUnits (DonorID, BloodGroup, CollectionDate, ExpirationDate, IsContaminated, IsUsed)
    SELECT 
        i.DonorID,
        i.BloodGroup,
        i.DonationDate,
        DATEADD(DAY, 42, i.DonationDate),
        0, -- Kan temiz kabul ediliyor
        0  -- Kullanýlmadý
    FROM inserted i;
END;
go

INSERT INTO Donors (Name, Age, BloodGroup, HasTransmissibleDisease, DonationDate)
VALUES ('Test Donor', 30, 'A+', 0, GETDATE());

SELECT TOP 1 *
FROM BloodUnits
WHERE DonorID = (SELECT MAX(DonorID) FROM Donors)
ORDER BY BloodUnitID DESC;

--Trigger, baðýþçý kaydedildiðinde kan stoðuna otomatik olarak o baðýþa ait kan bilgisini ekleyip güncel tutuyor.

--Uyarý Sorgusu Yazalým
--Kritik kan gruplarý: O-, AB-, B-, A-
--Eþik: Stok miktarý 5 birimin altýna düþtüðünde uyarý versin

SELECT 
    BloodGroup,
    COUNT(*) AS AvailableUnits,
    CASE 
        WHEN COUNT(*) < 5 THEN 'KRÝTÝK SEVÝYEDE'
        ELSE 'YETERLÝ'
    END AS StockStatus
FROM BloodUnits
WHERE 
    BloodGroup IN ('O-', 'AB-', 'B-', 'A-')
    AND IsUsed = 0
    AND IsContaminated = 0
    AND ExpirationDate >= CAST(GETDATE() AS DATE)
GROUP BY BloodGroup
ORDER BY BloodGroup;

--view içinde görmek için
go
CREATE OR ALTER VIEW vw_CriticalBloodStockStatus AS
SELECT 
    BloodGroup,
    COUNT(*) AS AvailableUnits,
    CASE 
        WHEN COUNT(*) < 5 THEN 'KRÝTÝK SEVÝYEDE'
        ELSE 'YETERLÝ'
    END AS StockStatus
FROM BloodUnits
WHERE 
    BloodGroup IN ('O-', 'AB-', 'B-', 'A-')
    AND IsUsed = 0
    AND IsContaminated = 0
    AND ExpirationDate >= CAST(GETDATE() AS DATE)
GROUP BY BloodGroup;
go

