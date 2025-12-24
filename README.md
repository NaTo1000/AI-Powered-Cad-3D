# AI-Powered CAD 3D

[![CI/CD Pipeline](https://github.com/NaTo1000/AI-Powered-Cad-3D/actions/workflows/ci-cd-pipeline.yml/badge.svg)](https://github.com/NaTo1000/AI-Powered-Cad-3D/actions/workflows/ci-cd-pipeline.yml)
[![Security Scanning](https://github.com/NaTo1000/AI-Powered-Cad-3D/actions/workflows/security-scan.yml/badge.svg)](https://github.com/NaTo1000/AI-Powered-Cad-3D/actions/workflows/security-scan.yml)
[![Performance Monitoring](https://github.com/NaTo1000/AI-Powered-Cad-3D/actions/workflows/performance-monitoring.yml/badge.svg)](https://github.com/NaTo1000/AI-Powered-Cad-3D/actions/workflows/performance-monitoring.yml)

Enterprise-grade AI-powered 3D CAD solution for Microsoft Dynamics 365 Business Central with comprehensive design automation, optimization, and collaboration features.

## 🚀 Features

### Core Functionality
- **3D Model Management**: Complete lifecycle management for CAD models
- **Project Organization**: Project-based model organization and tracking
- **Version Control**: Comprehensive version history and change tracking
- **AI-Powered Analysis**: Automated model analysis and optimization scoring
- **Material & Cost Estimation**: Automatic cost calculation based on dimensions
- **Multi-Format Support**: STL, OBJ, FBX, STEP, IGES, DXF, DWG

### Enterprise Features
- **Role-Based Access Control**: Secure permission management
- **Audit Trail**: Complete audit logging for compliance
- **GDPR Compliance**: Data classification and export capabilities
- **Multi-Company Support**: Full Business Central multi-company architecture
- **API Integration**: RESTful APIs for external system integration
- **Real-time Collaboration**: Multi-user concurrent access

### AI Capabilities
- **Model Optimization**: AI-driven polygon reduction and optimization
- **Quality Scoring**: Automated quality assessment (0-100 scale)
- **Design Recommendations**: Intelligent design improvement suggestions
- **Performance Analysis**: Automated performance benchmarking

## 📋 Prerequisites

- **Microsoft Dynamics 365 Business Central**: Version 23.0 or later
- **AL Development Tools**: Visual Studio Code with AL Language extension
- **SQL Server**: 2019 or later (for on-premises deployments)
- **Docker** (optional): For containerized development
- **.NET Framework**: 4.8 or later

## 🛠️ Installation

### 1. Clone the Repository
```bash
git clone https://github.com/NaTo1000/AI-Powered-Cad-3D.git
cd AI-Powered-Cad-3D
```

### 2. Configure VS Code
Open the project in Visual Studio Code. The workspace is pre-configured with:
- AL Language extension settings
- Code analyzers (CodeCop, UICop, PerTenantExtensionCop)
- Launch configurations for local and cloud development

### 3. Configure App Settings
Edit `app.json` to customize:
- Publisher name
- Company URLs
- Version numbering
- ID ranges (if needed)

### 4. Deploy to Business Central

#### For Cloud (SaaS):
```powershell
# Using AL:Go
Publish-ALApp -PackagePath ".\app.json"
```

#### For On-Premises:
```powershell
# Using BC Development Shell
Publish-NAVApp -ServerInstance BC -Path ".\YourApp.app"
```

### 5. Initialize Setup
1. Open Business Central
2. Search for "CAD3D Setup"
3. Configure:
   - Number series for models and projects
   - Storage paths
   - AI service endpoint and API key
   - File format restrictions

## 📚 Documentation

### Architecture Documentation
- [Database Schema](./database/documentation/DATABASE_SCHEMA.md) - Complete database design documentation
- [API Documentation](./docs/API.md) - RESTful API reference
- [Architecture Overview](./docs/ARCHITECTURE.md) - System architecture and design patterns

### Developer Guides
- [Development Setup](./docs/DEVELOPMENT.md) - Local development environment setup
- [Coding Standards](./docs/CODING_STANDARDS.md) - AL coding conventions
- [Testing Guide](./docs/TESTING.md) - Unit and integration testing

### User Documentation
- [User Manual](./docs/USER_MANUAL.md) - End-user guide
- [Administrator Guide](./docs/ADMIN_GUIDE.md) - System administration
- [Quick Start](./docs/QUICKSTART.md) - Getting started guide

## 🏗️ Project Structure

```
AI-Powered-Cad-3D/
├── .github/
│   └── workflows/          # CI/CD pipelines
│       ├── ci-cd-pipeline.yml
│       ├── security-scan.yml
│       └── performance-monitoring.yml
├── .vscode/
│   ├── launch.json         # Debug configurations
│   ├── settings.json       # VS Code settings
│   └── ruleset.json        # Code analysis rules
├── database/
│   ├── documentation/      # Database documentation
│   └── scripts/           # SQL scripts
├── docs/                   # Project documentation
├── src/
│   ├── Tables/            # Database tables (50000-50099)
│   ├── Pages/             # UI pages
│   ├── Codeunits/         # Business logic
│   ├── Enums/             # Enumeration types
│   ├── Queries/           # Data queries
│   ├── Reports/           # Report objects
│   └── XMLports/          # Data import/export
├── app.json               # AL project configuration
└── README.md              # This file
```

## 🔧 Configuration

### Number Series Setup
Configure in CAD3D Setup page:
- **Model Numbers**: CAD3D-M (e.g., CAD3D-M00001)
- **Project Numbers**: CAD3D-P (e.g., CAD3D-P00001)

### AI Service Configuration
```json
{
  "ai_service_endpoint": "https://your-ai-service.com/api",
  "api_key": "your-api-key-here",
  "enable_auto_optimize": false,
  "optimization_threshold": 60
}
```

### File Storage Configuration
- **Default Path**: Set in CAD3D Setup
- **Max File Size**: 500 MB (configurable)
- **Supported Formats**: STL, OBJ, FBX, STEP, IGES, DXF, DWG

## 🧪 Testing

### Run Unit Tests
```powershell
# Run all tests
Invoke-BCTest -ServerInstance BC

# Run specific test suite
Invoke-BCTest -ServerInstance BC -TestSuite "CAD3D Tests"
```

### Test Coverage
- Unit Tests: Core business logic
- Integration Tests: End-to-end scenarios
- Performance Tests: Load and stress testing
- Security Tests: Vulnerability scanning

## 🚀 CI/CD Pipeline

### Automated Workflows

#### 1. CI/CD Pipeline (`ci-cd-pipeline.yml`)
- **Triggers**: Push to main/develop, Pull requests
- **Jobs**:
  - Code quality checks
  - Build and compilation
  - Automated testing
  - Database validation
  - Multi-environment deployment (Dev → Staging → Production)
  - Smoke testing
  - Release tagging

#### 2. Security Scanning (`security-scan.yml`)
- **Triggers**: Push, Pull requests, Daily schedule
- **Scans**:
  - CodeQL analysis
  - Dependency vulnerability checks
  - Secret scanning
  - OWASP security assessment

#### 3. Performance Monitoring (`performance-monitoring.yml`)
- **Triggers**: Weekly schedule, Manual
- **Tests**:
  - Load testing
  - Stress testing
  - Database performance
  - Resource monitoring

### Deployment Environments
- **Development**: Auto-deploy from `develop` branch
- **Staging**: Auto-deploy from `release/*` branches
- **Production**: Manual approval required from `main` branch

## 🔒 Security

### Security Features
- ✅ Role-based access control
- ✅ Field-level security
- ✅ Data encryption at rest
- ✅ Audit logging
- ✅ GDPR compliance
- ✅ API authentication
- ✅ Input validation
- ✅ SQL injection prevention

### Security Scanning
- Daily automated security scans
- Dependency vulnerability checks
- Secret detection
- CodeQL analysis

## 📊 Monitoring & Observability

### Health Checks
- Application health endpoints
- Database connectivity checks
- AI service availability
- Storage capacity monitoring

### Performance Metrics
- Response time tracking
- Throughput monitoring
- Resource utilization
- Query performance

### Logging
- Application logs
- Audit trail logs
- Error tracking
- Performance logs

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards
- Follow AL coding conventions
- Add XML documentation comments
- Include unit tests
- Update documentation
- Pass all CI checks

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

### Getting Help
- 📖 [Documentation](./docs/)
- 🐛 [Issue Tracker](https://github.com/NaTo1000/AI-Powered-Cad-3D/issues)
- 💬 [Discussions](https://github.com/NaTo1000/AI-Powered-Cad-3D/discussions)

### Commercial Support
For enterprise support, training, and customization:
- Email: support@yourcompany.com
- Website: https://yourcompany.com

## 🗺️ Roadmap

### Version 1.1 (Q1 2026)
- [ ] Advanced AI model optimization
- [ ] Real-time collaboration features
- [ ] Mobile app support
- [ ] Enhanced reporting

### Version 1.2 (Q2 2026)
- [ ] Cloud storage integration
- [ ] 3D model viewer
- [ ] Automated quality assurance
- [ ] Machine learning model training

### Version 2.0 (Q4 2026)
- [ ] Generative AI design
- [ ] VR/AR visualization
- [ ] Advanced simulation
- [ ] Blockchain integration for IP protection

## 🙏 Acknowledgments

- Microsoft Dynamics 365 Business Central team
- AL Language development community
- Open source 3D CAD libraries
- AI/ML research community

## 📈 Project Status

- ✅ Core functionality: Complete
- ✅ Database schema: Implemented
- ✅ CI/CD pipeline: Active
- ✅ Security scanning: Enabled
- ✅ Documentation: Comprehensive
- 🔄 AI integration: In progress
- 🔄 Advanced features: Planned

---

**Built with ❤️ for the CAD and manufacturing community**