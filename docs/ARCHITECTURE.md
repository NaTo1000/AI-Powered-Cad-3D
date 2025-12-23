# System Architecture

## Overview
The AI-Powered CAD 3D application is built on Microsoft Dynamics 365 Business Central platform using AL (Application Language). It follows enterprise architecture patterns with clear separation of concerns.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        Presentation Layer                        │
├─────────────────────────────────────────────────────────────────┤
│  Pages (UI)                                                       │
│  ├── CAD3D Model Card / List                                    │
│  ├── CAD3D Project Card / List                                  │
│  ├── CAD3D Setup                                                │
│  └── CAD3D Model Version List                                   │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        Business Logic Layer                      │
├─────────────────────────────────────────────────────────────────┤
│  Codeunits                                                       │
│  ├── CAD3D AI Management (50000)                               │
│  │   ├── AnalyzeModel()                                        │
│  │   ├── OptimizeModel()                                       │
│  │   └── CalculateOptimizationScore()                          │
│  │                                                              │
│  └── CAD3D Model Management (50001)                            │
│      ├── CreateVersion()                                        │
│      ├── ValidateModelFile()                                    │
│      └── CalculateEstimatedCost()                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         Data Layer                               │
├─────────────────────────────────────────────────────────────────┤
│  Tables                                                          │
│  ├── CAD3D Model (50000)                                        │
│  ├── CAD3D Project (50001)                                      │
│  ├── CAD3D Setup (50002)                                        │
│  └── CAD3D Model Version (50003)                                │
│                                                                  │
│  Enums                                                           │
│  ├── CAD3D Model Type (50000)                                   │
│  ├── CAD3D Model Status (50001)                                 │
│  ├── CAD3D Project Status (50002)                               │
│  └── CAD3D Change Type (50003)                                  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    External Integrations                         │
├─────────────────────────────────────────────────────────────────┤
│  ├── AI Service API (Model Analysis & Optimization)             │
│  ├── File Storage System (Model File Management)                │
│  └── Business Central Standard Objects (Users, Customers, etc.) │
└─────────────────────────────────────────────────────────────────┘
```

## Layer Descriptions

### 1. Presentation Layer
**Technology**: AL Pages
**Responsibility**: User interface and user interaction

Components:
- **Card Pages**: Detailed view/edit for single records
- **List Pages**: Browse multiple records with filtering
- **Setup Pages**: Configuration and administration
- **FactBoxes**: Contextual information panels

Design Patterns:
- Master-Detail pattern for related data
- Wizard pattern for multi-step processes
- Dashboard pattern for KPIs and summaries

### 2. Business Logic Layer
**Technology**: AL Codeunits
**Responsibility**: Business rules and workflows

Components:
- **Management Codeunits**: Core business operations
- **Validation Logic**: Data integrity checks
- **Calculation Functions**: Complex computations
- **Integration Handlers**: External system communication

Design Patterns:
- Facade pattern for complex operations
- Strategy pattern for AI algorithms
- Template method for version control

### 3. Data Layer
**Technology**: AL Tables and Enums
**Responsibility**: Data structure and persistence

Components:
- **Tables**: Database entities with triggers
- **Enums**: Enumerated types for categorization
- **FlowFields**: Calculated fields
- **Indexes**: Performance optimization

Design Patterns:
- Repository pattern (implicit in BC)
- Unit of Work pattern (BC transactions)
- Data Transfer Object pattern

### 4. Integration Layer
**Technology**: HTTP Clients, APIs
**Responsibility**: External system communication

Components:
- **AI Service Integration**: Model analysis APIs
- **File Storage**: Document management
- **Standard BC Integration**: Users, customers, etc.

## Data Flow Patterns

### Model Creation Flow
```
User Input → Page Validation → Table Insert Trigger → 
Number Series Assignment → Audit Fields Population → 
Database Commit → UI Refresh
```

### AI Analysis Flow
```
User Action → Validate Setup → Collect Model Data → 
HTTP Request to AI Service → Parse Response → 
Update Model Record → Display Results → Log Analysis
```

### Version Control Flow
```
User Request → Check Permissions → Find Latest Version → 
Create Version Record → Copy File → Update Model → 
Create Audit Entry → Notify User
```

## Security Architecture

### Authentication
- Business Central user authentication
- SSO support (Azure AD)
- Multi-factor authentication (MFA)

### Authorization
```
Permission Sets
├── CAD3D ADMIN (Full access)
├── CAD3D MANAGER (Read/Write, no setup)
├── CAD3D USER (Read/Write own projects)
└── CAD3D VIEWER (Read only)
```

### Data Security
- Field-level security
- Record-level security (via filters)
- Data classification (GDPR)
- Encryption at rest and in transit

## Performance Architecture

### Caching Strategy
- Browser caching for static content
- BC server-side caching for FlowFields
- AI service response caching (5 minutes)

### Database Optimization
- Clustered indexes on primary keys
- Non-clustered indexes on frequently queried fields
- Filtered indexes for large tables
- Query hints for complex joins

### Scalability
- Horizontal scaling via BC farm deployment
- Vertical scaling for database servers
- CDN for static assets
- Load balancing for high availability

## Deployment Architecture

### Development Environment
```
Developer Workstation
├── VS Code with AL Extension
├── Docker (BC Container)
├── Git for version control
└── Local testing environment
```

### Staging Environment
```
Azure/On-Premises
├── Business Central Server
├── SQL Server Database
├── IIS Web Server
└── AI Service Integration (Test)
```

### Production Environment
```
High Availability Setup
├── BC Server Farm (2+ nodes)
├── SQL Server AlwaysOn (HA)
├── Load Balancer
├── AI Service Integration (Prod)
└── Monitoring & Logging
```

## Integration Patterns

### AI Service Integration
```
Pattern: RESTful API with retry logic
Protocol: HTTPS with API key authentication
Format: JSON request/response
Timeout: 30 seconds with exponential backoff
Error Handling: Graceful degradation
```

### File Storage Integration
```
Pattern: Abstract storage interface
Options: 
  - Local file system
  - Azure Blob Storage
  - Network share (UNC path)
Access: Service account with minimal permissions
```

## Error Handling Strategy

### Error Categories
1. **User Errors**: Validation failures, handled with user messages
2. **System Errors**: Database issues, logged and alerted
3. **Integration Errors**: External service failures, retry with fallback
4. **Critical Errors**: Data corruption, full error trace and notification

### Error Recovery
- Automatic retry for transient failures
- Transaction rollback for data errors
- Graceful degradation for non-critical features
- Administrator notification for critical issues

## Monitoring & Observability

### Application Metrics
- Page load times
- API response times
- Database query performance
- User activity tracking

### Infrastructure Metrics
- CPU and memory utilization
- Disk I/O and storage capacity
- Network throughput
- Service availability

### Business Metrics
- Models created per day
- AI analysis success rate
- User adoption rate
- System usage patterns

## Technology Stack

### Core Technologies
- **Platform**: Microsoft Dynamics 365 Business Central
- **Language**: AL (Application Language)
- **Database**: SQL Server 2019+
- **Runtime**: .NET Framework 4.8

### Development Tools
- Visual Studio Code
- AL Language Extension
- Docker Desktop
- Git

### DevOps Tools
- GitHub Actions (CI/CD)
- CodeQL (Security scanning)
- Super Linter (Code quality)
- Azure DevOps (Optional)

## Design Principles

### SOLID Principles
- **Single Responsibility**: Each codeunit has one purpose
- **Open/Closed**: Extensible via events and interfaces
- **Liskov Substitution**: Enum extensibility
- **Interface Segregation**: Focused interfaces
- **Dependency Inversion**: Loose coupling via events

### CAP Theorem
- **Consistency**: ACID transactions via SQL Server
- **Availability**: Load balancing and failover
- **Partition Tolerance**: Handled at infrastructure level

### 12-Factor App
- Codebase in Git
- Dependencies declared in app.json
- Config in setup tables
- Backing services via APIs
- Build, release, run separation
- Stateless processes
- Port binding via BC server
- Concurrency via BC architecture
- Disposability via proper shutdown
- Dev/prod parity
- Logs as event streams
- Admin processes via pages

## Future Architecture Enhancements

### Planned Improvements
1. **Microservices**: Extract AI service as separate microservice
2. **Event-Driven**: Implement event sourcing for audit
3. **CQRS**: Separate read and write models
4. **GraphQL**: Alternative API for flexible queries
5. **Real-time**: WebSocket support for live updates
6. **Offline**: PWA capabilities for offline access

### Scalability Roadmap
- Database sharding for large deployments
- Read replicas for reporting
- Redis cache for session management
- Kubernetes orchestration
- Multi-region deployment
