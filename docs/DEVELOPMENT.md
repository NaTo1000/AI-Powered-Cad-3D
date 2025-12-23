# Development Guide

## Getting Started

This guide will help you set up your development environment for the AI-Powered CAD 3D application.

## Prerequisites

### Required Software
1. **Visual Studio Code** (latest version)
   - Download from: https://code.visualstudio.com/

2. **AL Language Extension for VS Code**
   - Install from VS Code Extensions marketplace
   - Search for "AL Language"

3. **Business Central** (one of the following):
   - Business Central Sandbox (Cloud)
   - Business Central On-Premises
   - Business Central Docker Container (recommended for development)

4. **Git**
   - Download from: https://git-scm.com/

5. **Docker Desktop** (optional but recommended)
   - Download from: https://www.docker.com/products/docker-desktop

### Optional Tools
- SQL Server Management Studio (for database inspection)
- Postman (for API testing)
- PowerShell 7+

## Development Environment Setup

### Option 1: Docker Container (Recommended)

1. **Install Docker Desktop**
   ```bash
   # Verify Docker installation
   docker --version
   ```

2. **Start the Development Environment**
   ```bash
   # Clone the repository
   git clone https://github.com/NaTo1000/AI-Powered-Cad-3D.git
   cd AI-Powered-Cad-3D

   # Start containers
   docker-compose up -d
   ```

3. **Access Business Central**
   - URL: http://localhost:8080
   - Username: admin
   - Password: P@ssw0rd123!

### Option 2: Business Central Sandbox

1. **Get Sandbox Access**
   - Sign up at: https://dynamics.microsoft.com/en-us/business-central/overview/
   - Create a sandbox environment

2. **Configure VS Code**
   - Open `.vscode/launch.json`
   - Update the "Microsoft cloud sandbox" configuration with your credentials

### Option 3: On-Premises Installation

1. **Install Business Central**
   - Download from Microsoft Partner Center
   - Follow installation wizard

2. **Configure Connection**
   - Open `.vscode/launch.json`
   - Update "Your own server" configuration

## Project Setup

### 1. Clone the Repository
```bash
git clone https://github.com/NaTo1000/AI-Powered-Cad-3D.git
cd AI-Powered-Cad-3D
```

### 2. Open in VS Code
```bash
code .
```

### 3. Configure Launch Settings
Edit `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Your own server",
      "server": "http://your-server",
      "serverInstance": "BC",
      "authentication": "Windows",
      "startupObjectId": 50000,
      "startupObjectType": "Page"
    }
  ]
}
```

### 4. Download AL Language Symbols
- Press `F1` in VS Code
- Type "AL: Download Symbols"
- Select your target platform

## Building the Application

### Using VS Code

1. **Compile the Extension**
   - Press `Ctrl+Shift+B` (Windows/Linux) or `Cmd+Shift+B` (Mac)
   - Or: Press `F5` to build and deploy

2. **View Build Output**
   - Check the Output panel (View > Output)
   - Select "AL Language" from dropdown

### Using PowerShell

```powershell
# Build the extension
Compile-NAVApplicationObject -Path ".\src"

# Publish to BC
Publish-NAVApp -ServerInstance BC -Path ".\YourApp.app"
```

## Running Tests

### Run All Tests
```powershell
# Using BC PowerShell
Invoke-NAVCodeunit -ServerInstance BC -CodeunitId 50010
Invoke-NAVCodeunit -ServerInstance BC -CodeunitId 50012
```

### Run Tests from VS Code
1. Open test codeunit
2. Look for green arrow next to test procedures
3. Click to run individual test

### Run Tests via Docker
```bash
# Run tests in container
docker exec cad3d-bc-server powershell -Command "Invoke-BCTest"
```

## Code Structure

### Directory Layout
```
src/
├── Tables/          # Data structures
├── Pages/           # User interface
├── Codeunits/       # Business logic
├── Enums/           # Enumeration types
├── Queries/         # Data queries
├── Reports/         # Report objects
└── XMLports/        # Data import/export

test/                # Test codeunits
docs/                # Documentation
database/            # Database scripts
.github/workflows/   # CI/CD pipelines
```

### Naming Conventions

#### Tables
- Format: `Tab{ID}.{Name}.al`
- Example: `Tab50000.CAD3DModel.al`

#### Pages
- Format: `Pag{ID}.{Name}.al`
- Example: `Pag50000.CAD3DModelCard.al`

#### Codeunits
- Format: `Cod{ID}.{Name}.al`
- Example: `Cod50000.CAD3DAIManagement.al`

#### Enums
- Format: `Enum{ID}.{Name}.al`
- Example: `Enum50000.CAD3DModelType.al`

### Coding Standards

#### Comments
```al
/// <summary>
/// Brief description of the procedure.
/// </summary>
/// <param name="Parameter1">Parameter description.</param>
/// <returns>Return value description.</returns>
procedure MyProcedure(Parameter1: Text): Boolean
```

#### Variable Naming
```al
// Use PascalCase for variables
var
    CAD3DModel: Record "CAD3D Model";
    ModelCount: Integer;
    IsValid: Boolean;
```

#### Field Naming
```al
// Use spaces in field captions
field(1; "No."; Code[20])
{
    Caption = 'No.';
    DataClassification = CustomerContent;
}
```

## Debugging

### Enable Debugging
1. Set breakpoints in VS Code (click left margin)
2. Press `F5` to start debugging
3. Use Debug Console for evaluation

### Debug Actions
- `F5` - Continue
- `F10` - Step Over
- `F11` - Step Into
- `Shift+F11` - Step Out
- `Shift+F5` - Stop Debugging

### Debug Tips
```al
// Add debug messages
Message('Value: %1', MyVariable);

// Check conditions
if DebugMode then
    Error('Debug point reached');

// Log to event log
EventLog.LogMessage('CAD3D', 'Processing model', LogLevel::Information);
```

## Common Tasks

### Adding a New Table
1. Create file: `src/Tables/Tab5XXXX.MyTable.al`
2. Define structure:
```al
table 5XXXX "My Table"
{
    Caption = 'My Table';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; Name; Text[100]) { }
    }
    
    keys
    {
        key(PK; "No.") { Clustered = true; }
    }
}
```

### Adding a New Page
1. Create file: `src/Pages/Pag5XXXX.MyPage.al`
2. Define layout:
```al
page 5XXXX "My Page"
{
    PageType = Card;
    SourceTable = "My Table";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
            }
        }
    }
}
```

### Adding Business Logic
1. Create file: `src/Codeunits/Cod5XXXX.MyCodeunit.al`
2. Define procedures:
```al
codeunit 5XXXX "My Codeunit"
{
    procedure ProcessData(var MyTable: Record "My Table")
    begin
        // Implementation
    end;
}
```

## Version Control

### Git Workflow
```bash
# Create feature branch
git checkout -b feature/my-feature

# Make changes
git add .
git commit -m "Add new feature"

# Push to remote
git push origin feature/my-feature

# Create pull request on GitHub
```

### Commit Message Format
```
<type>: <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

Example:
```
feat: Add AI model optimization

Implement AI-powered polygon reduction and optimization
scoring for CAD models.

Closes #123
```

## Troubleshooting

### Symbols Not Loading
```bash
# Delete symbol cache
rm -rf .alpackages
rm -rf .alcache

# Re-download symbols
# In VS Code: F1 > AL: Download Symbols
```

### Build Errors
```bash
# Clean build
rm -rf .output

# Rebuild
# Press Ctrl+Shift+B
```

### Connection Issues
1. Check server is running
2. Verify credentials in launch.json
3. Test URL in browser
4. Check firewall settings

### Docker Issues
```bash
# Reset containers
docker-compose down
docker-compose up -d --force-recreate

# View logs
docker logs cad3d-bc-server
```

## Performance Tips

### Query Optimization
```al
// Use SetLoadFields for selective loading
CAD3DModel.SetLoadFields("No.", Name, Status);
CAD3DModel.FindSet();

// Use filtering before loops
CAD3DModel.SetRange(Status, CAD3DModel.Status::Approved);
if CAD3DModel.FindSet() then
    repeat
        // Process
    until CAD3DModel.Next() = 0;
```

### Caching
```al
// Cache setup records
if not IsSetupInitialized then begin
    CAD3DSetup.Get();
    IsSetupInitialized := true;
end;
```

## Resources

### Documentation
- [AL Development](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-dev-overview)
- [AL Language Reference](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-reference-overview)
- [Best Practices](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/compliance/apptest-bestpracticesforalcode)

### Community
- [Business Central Community](https://community.dynamics.com/business)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/dynamics-nav)
- [GitHub Discussions](https://github.com/NaTo1000/AI-Powered-Cad-3D/discussions)

### Support
- Email: dev-support@yourcompany.com
- Slack: #cad3d-dev
- Issue Tracker: https://github.com/NaTo1000/AI-Powered-Cad-3D/issues
