-- Таблица для проверки, если ее еще нет
IF OBJECT_ID('dbo.StudentsStats', 'U') IS NOT NULL 
    DROP TABLE dbo.StudentsStats;

CREATE TABLE dbo.StudentsStats (
    YearInt INT PRIMARY KEY,
    EnrolledStudents INT,
    GraduatedStudents INT
);

-- Тестовые данные для расчета разницы
INSERT INTO dbo.StudentsStats (YearInt, EnrolledStudents, GraduatedStudents)
VALUES 
(2023, 150, 120),
(2024, 180, 140),
(2025, 165, 155),
(2026, 200, 160);
GO

-- Функция со встроенными функциями (строки, математика, дата)
CREATE OR ALTER FUNCTION dbo.fn_ShowBuiltInFunctionsExamples
(
    @InputString VARCHAR(50),
    @InputNumber DECIMAL(10,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        UPPER(@InputString) AS UpperCaseText,
        LOWER(@InputString) AS LowerCaseText,
        LEN(@InputString) AS StringLength,
        REVERSE(@InputString) AS ReversedText,
        ROUND(@InputNumber, 0) AS RoundedNumber,
        ABS(@InputNumber * -1) AS AbsoluteValue,
        CEILING(@InputNumber) AS CeilingValue,
        GETDATE() AS CurrentDateTime,
        YEAR(GETDATE()) AS CurrentYear,
        DB_NAME() AS CurrentDatabase,
        SUSER_NAME() AS CurrentUser
);
GO

-- Процедура для расчета разницы между выпускниками и поступившими
CREATE OR ALTER PROCEDURE dbo.sp_CalculateStudentsDifference
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Проверка на всякий случай
    IF NOT EXISTS (SELECT 1 FROM dbo.StudentsStats WHERE YearInt = @Year)
    BEGIN
        PRINT 'Данных за этот год нет';
        RETURN;
    END

    -- Сам расчет
    SELECT 
        YearInt AS [Год],
        EnrolledStudents AS [Поступило],
        GraduatedStudents AS [Выпустилось],
        (GraduatedStudents - EnrolledStudents) AS [Разница]
    FROM 
        dbo.StudentsStats
    WHERE 
        YearInt = @Year;
END;
GO
