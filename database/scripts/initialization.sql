-- Database Initialization Script for CAD3D Application
-- This script demonstrates the SQL structure created by Business Central
-- Note: In BC, tables are created automatically by the AL runtime

-- =====================================================
-- SETUP CONFIGURATION
-- =====================================================
-- Initialize the CAD3D Setup record
-- In AL, this is done through the setup page, but here's the equivalent SQL concept

/*
INSERT INTO [CAD3D Setup] (
    [Primary Key],
    [Model Nos.],
    [Project Nos.],
    [Default Storage Path],
    [Enable AI Analysis],
    [Auto-Optimize Models],
    [Max File Size (MB)],
    [Supported Formats]
)
VALUES (
    '',
    'CAD3D-M',
    'CAD3D-P',
    'C:\CAD3D\Models',
    1,
    0,
    500.00,
    'STL,OBJ,FBX,STEP,IGES,DXF,DWG'
);
*/

-- =====================================================
-- SAMPLE DATA INSERTION
-- =====================================================

-- Sample Project
/*
INSERT INTO [CAD3D Project] (
    [No.],
    [Name],
    [Description],
    [Status],
    [Start Date],
    [End Date],
    [Project Manager],
    [Total Budget],
    [Created By],
    [Created Date]
)
VALUES (
    'PRJ-001',
    'Industrial Equipment Design',
    'Design of new industrial manufacturing equipment',
    0, -- Planning
    '2025-01-01',
    '2025-06-30',
    'ADMIN',
    150000.00,
    'ADMIN',
    '2025-01-01'
);
*/

-- Sample Models
/*
INSERT INTO [CAD3D Model] (
    [No.],
    [Name],
    [Description],
    [Model Type],
    [Status],
    [Project No.],
    [File Path],
    [File Size],
    [Vertex Count],
    [Polygon Count],
    [Version No.],
    [Dimensions X],
    [Dimensions Y],
    [Dimensions Z],
    [Material Type],
    [Estimated Cost],
    [Created By],
    [Created Date]
)
VALUES 
(
    'MDL-001',
    'Main Assembly',
    'Primary assembly component for the manufacturing line',
    5, -- Assembly
    0, -- Draft
    'PRJ-001',
    'C:\CAD3D\Models\MDL-001.stl',
    25.50,
    150000,
    75000,
    1,
    1500.000,
    800.000,
    600.000,
    'Stainless Steel',
    5000.00,
    'ADMIN',
    '2025-01-05'
),
(
    'MDL-002',
    'Drive Gear',
    'Main drive gear component',
    6, -- Part
    1, -- In Review
    'PRJ-001',
    'C:\CAD3D\Models\MDL-002.step',
    5.25,
    25000,
    12500,
    1,
    200.000,
    200.000,
    50.000,
    'Hardened Steel',
    850.00,
    'ADMIN',
    '2025-01-08'
);
*/

-- =====================================================
-- USEFUL QUERIES FOR MONITORING
-- =====================================================

-- Query 1: Get all models with their project information
/*
SELECT 
    m.[No.],
    m.[Name],
    m.[Model Type],
    m.[Status],
    m.[AI Optimization Score],
    p.[Name] AS [Project Name],
    p.[Project Manager]
FROM [CAD3D Model] m
LEFT JOIN [CAD3D Project] p ON m.[Project No.] = p.[No.]
ORDER BY m.[Created Date] DESC;
*/

-- Query 2: Get project summary with model counts
/*
SELECT 
    p.[No.],
    p.[Name],
    p.[Status],
    p.[Total Budget],
    p.[Actual Cost],
    COUNT(m.[No.]) AS [Model Count],
    SUM(m.[Estimated Cost]) AS [Total Model Cost]
FROM [CAD3D Project] p
LEFT JOIN [CAD3D Model] m ON p.[No.] = m.[Project No.]
GROUP BY p.[No.], p.[Name], p.[Status], p.[Total Budget], p.[Actual Cost]
ORDER BY p.[Start Date] DESC;
*/

-- Query 3: Models requiring AI analysis
/*
SELECT 
    [No.],
    [Name],
    [Model Type],
    [Status],
    [Created Date],
    DATEDIFF(day, [Created Date], GETDATE()) AS [Days Since Creation]
FROM [CAD3D Model]
WHERE [AI Analyzed] = 0
ORDER BY [Created Date];
*/

-- Query 4: AI optimization performance
/*
SELECT 
    [Model Type],
    COUNT(*) AS [Total Models],
    AVG([AI Optimization Score]) AS [Avg Score],
    MIN([AI Optimization Score]) AS [Min Score],
    MAX([AI Optimization Score]) AS [Max Score]
FROM [CAD3D Model]
WHERE [AI Analyzed] = 1
GROUP BY [Model Type]
ORDER BY [Avg Score] DESC;
*/

-- Query 5: Version history for a model
/*
SELECT 
    v.[Version No.],
    v.[Version Description],
    v.[Change Type],
    v.[File Size],
    v.[Created By],
    v.[Created Date]
FROM [CAD3D Model Version] v
WHERE v.[Model No.] = 'MDL-001'
ORDER BY v.[Version No.] DESC;
*/

-- Query 6: Storage space analysis
/*
SELECT 
    COUNT(*) AS [Total Models],
    SUM([File Size]) AS [Total Size (MB)],
    AVG([File Size]) AS [Avg Size (MB)],
    MAX([File Size]) AS [Max Size (MB)]
FROM [CAD3D Model];
*/

-- =====================================================
-- PERFORMANCE OPTIMIZATION
-- =====================================================

-- Index maintenance (BC handles this automatically, but for reference)
/*
-- Rebuild fragmented indexes
ALTER INDEX ALL ON [CAD3D Model] REBUILD;
ALTER INDEX ALL ON [CAD3D Project] REBUILD;
ALTER INDEX ALL ON [CAD3D Model Version] REBUILD;

-- Update statistics
UPDATE STATISTICS [CAD3D Model];
UPDATE STATISTICS [CAD3D Project];
UPDATE STATISTICS [CAD3D Model Version];
*/

-- =====================================================
-- CLEANUP AND ARCHIVAL
-- =====================================================

-- Archive old model versions (older than 1 year)
/*
-- First, back up to archive table
SELECT * 
INTO [CAD3D Model Version Archive]
FROM [CAD3D Model Version]
WHERE [Created Date] < DATEADD(year, -1, GETDATE());

-- Then delete from main table
DELETE FROM [CAD3D Model Version]
WHERE [Created Date] < DATEADD(year, -1, GETDATE());
*/

-- Clean up orphaned records (if any)
/*
-- Find models without projects
SELECT m.*
FROM [CAD3D Model] m
LEFT JOIN [CAD3D Project] p ON m.[Project No.] = p.[No.]
WHERE m.[Project No.] <> '' AND p.[No.] IS NULL;
*/

-- =====================================================
-- SECURITY AND COMPLIANCE
-- =====================================================

-- Create audit log query
/*
SELECT 
    [No.],
    [Name],
    [Created By],
    [Created Date],
    [Last Modified By],
    [Last Modified Date],
    DATEDIFF(day, [Created Date], [Last Modified Date]) AS [Days Active]
FROM [CAD3D Model]
ORDER BY [Last Modified Date] DESC;
*/

-- Data retention compliance
/*
-- Identify models for GDPR deletion (example: older than 7 years)
SELECT 
    [No.],
    [Name],
    [Created Date],
    DATEDIFF(year, [Created Date], GETDATE()) AS [Age in Years]
FROM [CAD3D Model]
WHERE DATEDIFF(year, [Created Date], GETDATE()) > 7;
*/

-- =====================================================
-- BACKUP VERIFICATION
-- =====================================================

-- Check database size and growth
/*
SELECT 
    DB_NAME() AS [Database Name],
    SUM(size * 8.0 / 1024) AS [Size (MB)],
    SUM(CASE WHEN type = 0 THEN size * 8.0 / 1024 ELSE 0 END) AS [Data Size (MB)],
    SUM(CASE WHEN type = 1 THEN size * 8.0 / 1024 ELSE 0 END) AS [Log Size (MB)]
FROM sys.database_files;
*/

-- =====================================================
-- NOTES
-- =====================================================
/*
1. In Business Central AL development, tables are created automatically
   by the AL runtime when the extension is published.

2. This SQL script is provided for reference and understanding of the
   underlying database structure.

3. Direct SQL manipulation is not recommended in BC environments.
   All data operations should go through AL code for proper transaction
   handling and business logic validation.

4. The actual table names in SQL Server will be prefixed with the
   company name and may have different naming conventions.

5. For production deployments, use BC's built-in tools:
   - Extension Management for deployments
   - Configuration Packages for data migration
   - Web Services for external integrations
*/
