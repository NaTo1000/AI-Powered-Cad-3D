# Database Schema Documentation

## Overview
This document describes the database schema for the AI-Powered CAD 3D application built on Microsoft Dynamics 365 Business Central.

## Database Architecture

### Technology Stack
- **Platform**: Microsoft Dynamics 365 Business Central
- **Database Engine**: SQL Server
- **Language**: AL (Application Language)
- **Version**: Business Central 23.0+

### Schema Design Principles
1. **Normalized Design**: All tables follow 3NF normalization
2. **Data Classification**: Proper data classification for GDPR compliance
3. **Audit Trail**: Comprehensive audit fields on all main tables
4. **Performance**: Strategic indexing for optimal query performance
5. **Scalability**: Designed for enterprise-level data volumes

## Table Structures

### Table 50000: CAD3D Model
Primary table for storing 3D CAD model metadata.

**Fields:**
| Field | Type | Description | Indexed |
|-------|------|-------------|---------|
| No. | Code[20] | Unique model identifier (PK) | Yes (Clustered) |
| Name | Text[100] | Model name | No |
| Description | Text[250] | Detailed description | No |
| Model Type | Enum | Type classification (Mechanical, Architectural, etc.) | No |
| Status | Enum | Current status (Draft, Approved, etc.) | Yes |
| File Path | Text[250] | Location of 3D model file | No |
| File Size | Decimal | File size in MB | No |
| Vertex Count | Integer | Number of vertices in model | No |
| Polygon Count | Integer | Number of polygons in model | No |
| Created By | Code[50] | User who created the record | No |
| Created Date | Date | Creation date | Yes |
| Last Modified By | Code[50] | User who last modified | No |
| Last Modified Date | DateTime | Last modification timestamp | No |
| AI Optimization Score | Decimal | AI-generated optimization score (0-100) | No |
| AI Analyzed | Boolean | Flag indicating AI analysis status | Yes |
| AI Analysis Date | DateTime | When AI analysis was performed | Yes |
| Project No. | Code[20] | Link to project (FK) | Yes |
| Version No. | Integer | Current version number | Yes |
| Dimensions X/Y/Z | Decimal | Physical dimensions in mm | No |
| Material Type | Text[50] | Material specification | No |
| Estimated Cost | Decimal | Cost estimate | No |

**Indexes:**
- Primary Key: No. (Clustered)
- Project Key: Project No., Version No.
- Status Key: Status, Created Date
- AI Analysis Key: AI Analyzed, AI Analysis Date

**Relationships:**
- Many-to-One with CAD3D Project (via Project No.)
- One-to-Many with CAD3D Model Version (via No.)

### Table 50001: CAD3D Project
Project management table for organizing models.

**Fields:**
| Field | Type | Description | Indexed |
|-------|------|-------------|---------|
| No. | Code[20] | Unique project identifier (PK) | Yes (Clustered) |
| Name | Text[100] | Project name | No |
| Description | Text[250] | Project description | No |
| Status | Enum | Project status | Yes |
| Start Date | Date | Project start date | Yes |
| End Date | Date | Project end date | No |
| Project Manager | Code[50] | Responsible manager | No |
| Customer No. | Code[20] | Customer reference (FK) | Yes |
| Customer Name | Text[100] | Customer name (denormalized) | No |
| Total Budget | Decimal | Project budget | No |
| Actual Cost | Decimal | Actual cost incurred | No |
| No. of Models | Integer | Count of associated models (FlowField) | No |

**Indexes:**
- Primary Key: No. (Clustered)
- Status Key: Status, Start Date
- Customer Key: Customer No., Start Date

**Relationships:**
- One-to-Many with CAD3D Model
- Many-to-One with Customer (standard BC table)

### Table 50002: CAD3D Setup
Configuration and setup table (singleton).

**Fields:**
| Field | Type | Description |
|-------|------|-------------|
| Primary Key | Code[10] | Singleton key |
| Model Nos. | Code[20] | Number series for models |
| Project Nos. | Code[20] | Number series for projects |
| Default Storage Path | Text[250] | Default file storage location |
| AI Service Endpoint | Text[250] | AI service URL |
| AI Service API Key | Text[100] | API key (masked) |
| Enable AI Analysis | Boolean | AI features toggle |
| Auto-Optimize Models | Boolean | Automatic optimization flag |
| Max File Size (MB) | Decimal | Maximum allowed file size |
| Supported Formats | Text[250] | Comma-separated file formats |

**Data Classification:** SystemMetadata / EndUserIdentifiableInformation

### Table 50003: CAD3D Model Version
Version control and history tracking.

**Fields:**
| Field | Type | Description | Indexed |
|-------|------|-------------|---------|
| Model No. | Code[20] | Parent model reference (PK, FK) | Yes (Clustered) |
| Version No. | Integer | Version number (PK) | Yes (Clustered) |
| Version Description | Text[250] | Change description | No |
| File Path | Text[250] | Version file location | No |
| Created By | Code[50] | Version creator | No |
| Created Date | DateTime | Creation timestamp | Yes |
| Change Type | Enum | Type of change | No |
| File Size | Decimal | File size in MB | No |

**Indexes:**
- Primary Key: Model No., Version No. (Clustered)
- Date Key: Created Date

**Relationships:**
- Many-to-One with CAD3D Model (via Model No.)

## Data Flow

### Model Creation Flow
1. User creates new model record
2. System auto-assigns No. from number series
3. System sets Created By, Created Date, Status = Draft
4. Version No. initialized to 1
5. Record inserted into CAD3D Model table

### AI Analysis Flow
1. User triggers AI analysis on model
2. System validates AI service configuration
3. Model data sent to AI service endpoint
4. AI returns optimization score and recommendations
5. System updates AI fields (AI Analyzed, Score, Date)
6. Results displayed to user

### Version Control Flow
1. User creates new version
2. System finds highest version number
3. New CAD3D Model Version record created
4. Parent model Version No. incremented
5. Version history preserved

## Performance Considerations

### Indexing Strategy
- **Clustered indexes** on primary keys for efficient data retrieval
- **Non-clustered indexes** on frequently queried fields (Status, Dates)
- **Composite indexes** for multi-field searches (Project + Version)

### Query Optimization
- FlowFields used for calculated values to avoid expensive joins
- Filtered indexes on large tables
- Regular statistics updates recommended

### Scaling Recommendations
- Partition large tables by date ranges for historical data
- Archive old versions periodically
- Implement table compression for archived data
- Monitor and optimize slow queries quarterly

## Security and Compliance

### Data Classification
- **CustomerContent**: Model data, project data
- **SystemMetadata**: Configuration settings
- **EndUserIdentifiableInformation**: API keys (masked)

### Access Control
- Role-based security through BC permission sets
- Field-level security on sensitive data
- Audit trail on all modifications

### GDPR Compliance
- Data classification enables GDPR reports
- Customer data can be identified and exported
- Data retention policies configurable

## Backup and Recovery

### Backup Strategy
- Full database backup: Daily
- Transaction log backup: Hourly
- Backup retention: 30 days

### Disaster Recovery
- Recovery Time Objective (RTO): 4 hours
- Recovery Point Objective (RPO): 1 hour
- Geographic redundancy recommended

## Migration and Deployment

### Initial Setup
1. Deploy AL application to BC environment
2. System creates table structures automatically
3. Initialize CAD3D Setup record
4. Configure number series
5. Set up AI service integration

### Upgrade Path
- Version compatibility maintained
- Data migration scripts provided
- Zero-downtime upgrades supported

## Monitoring and Maintenance

### Health Checks
- Monitor table growth rates
- Track index fragmentation
- Analyze query performance
- Review error logs

### Maintenance Tasks
- Rebuild fragmented indexes monthly
- Update statistics weekly
- Clean up old versions quarterly
- Archive completed projects annually

## Support and Documentation

For additional information:
- AL Development: See app.json and source files
- API Integration: See AI service documentation
- Performance Tuning: Consult BC performance guide
