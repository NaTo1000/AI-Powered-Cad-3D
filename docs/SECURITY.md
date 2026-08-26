# Security Best Practices

## Overview
This document outlines security best practices for deploying and operating the AI-Powered CAD 3D application.

## Secret Management

### ⚠️ CRITICAL: Never Commit Secrets to Git

**DO NOT** commit the following to version control:
- Passwords
- API keys
- Connection strings
- Certificates
- Private keys
- OAuth tokens

### Kubernetes Secret Management

#### Development Environment
For local development, you can use the docker-compose.yml with environment variables:

```bash
# Set environment variables
export BC_PASSWORD="YourSecurePassword"
export SQL_PASSWORD="YourSQLPassword"
export AI_API_KEY="YourAPIKey"

# Run docker-compose
docker-compose up
```

#### Production Environment

**Option 1: External Secret Management (Recommended)**

Use Azure Key Vault, HashiCorp Vault, or AWS Secrets Manager:

```yaml
# Using Azure Key Vault with Secrets Store CSI Driver
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: cad3d-keyvault
spec:
  provider: azure
  parameters:
    keyvaultName: "your-keyvault-name"
    objects: |
      array:
        - |
          objectName: "bc-password"
          objectType: "secret"
        - |
          objectName: "sql-password"
          objectType: "secret"
```

**Option 2: Create Secrets via kubectl**

```bash
# Create secrets from command line (NOT from manifest)
kubectl create secret generic cad3d-secrets \
  --from-literal=bc-username=admin \
  --from-literal=bc-password=$(openssl rand -base64 32) \
  --from-literal=sql-password=$(openssl rand -base64 32) \
  --from-literal=ai-api-key=$AI_API_KEY \
  --namespace=cad3d-app

# Verify secret was created (values will be base64 encoded)
kubectl get secret cad3d-secrets -n cad3d-app -o yaml
```

**Option 3: Sealed Secrets**

Use Bitnami Sealed Secrets for encrypted secrets in Git:

```bash
# Install sealed-secrets controller
kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.24.0/controller.yaml

# Create sealed secret
kubectl create secret generic cad3d-secrets \
  --from-literal=bc-password=YourPassword \
  --dry-run=client -o yaml | \
  kubeseal -o yaml > sealed-secret.yaml

# Commit sealed-secret.yaml to Git (safe to commit)
```

## Application Security

### Authentication

#### Business Central Authentication
- Use Windows Authentication for on-premises
- Use Azure AD for cloud deployments
- Enable Multi-Factor Authentication (MFA)
- Rotate credentials regularly (every 90 days)

#### API Authentication
- Use OAuth 2.0 for API access
- Implement proper token expiration
- Store tokens securely
- Use separate credentials per environment

### Authorization

#### Role-Based Access Control (RBAC)

Use the built-in permission sets:

```al
permissionset 50000 "CAD3D ADMIN"
{
    Assignable = true;
    Caption = 'CAD3D Administrator';
    Permissions = 
        tabledata "CAD3D Model" = RIMD,
        tabledata "CAD3D Project" = RIMD,
        tabledata "CAD3D Setup" = RIMD,
        tabledata "CAD3D Model Version" = RIMD,
        page "CAD3D Model Card" = X,
        page "CAD3D Model List" = X,
        page "CAD3D Project Card" = X,
        page "CAD3D Project List" = X,
        page "CAD3D Model Version List" = X,
        page "CAD3D Setup" = X,
        codeunit "CAD3D AI Management" = X,
        codeunit "CAD3D Model Management" = X;
}

permissionset 50001 "CAD3D USER"
{
    Assignable = true;
    Caption = 'CAD3D User';
    Permissions = 
        tabledata "CAD3D Model" = RIM,
        tabledata "CAD3D Project" = RIM,
        tabledata "CAD3D Setup" = R,
        tabledata "CAD3D Model Version" = RIM,
        page "CAD3D Model Card" = X,
        page "CAD3D Model List" = X,
        page "CAD3D Project Card" = X,
        page "CAD3D Project List" = X,
        page "CAD3D Model Version List" = X,
        codeunit "CAD3D AI Management" = X,
        codeunit "CAD3D Model Management" = X;
}
```

Use `CAD3D ADMIN` for full management tasks and `CAD3D USER` for day-to-day operations without delete privileges.

### Data Protection

#### Encryption at Rest
- Enable Transparent Data Encryption (TDE) for SQL Server
- Use encrypted volumes for file storage
- Encrypt backups

#### Encryption in Transit
- Use HTTPS/TLS 1.2+ for all communications
- Configure Business Central for SSL
- Use secure connection strings

#### Data Classification
All fields are properly classified:
- `CustomerContent`: User data
- `SystemMetadata`: Configuration
- `EndUserIdentifiableInformation`: Sensitive data (masked)

### Input Validation

The application implements comprehensive input validation:

```al
// Example: File path validation
trigger OnValidate()
var
    CAD3DModelMgt: Codeunit "CAD3D Model Management";
begin
    if "File Path" <> '' then
        if not CAD3DModelMgt.ValidateModelFile("File Path") then
            Error('Invalid file format');
end;
```

### SQL Injection Prevention

Business Central AL automatically prevents SQL injection:
- Uses parameterized queries
- No dynamic SQL
- Type-safe field access

## Network Security

### Firewall Rules

**Business Central Server:**
- Port 80 (HTTP) - Internal only
- Port 443 (HTTPS) - Public
- Port 7046 (Dev Services) - Internal only

**SQL Server:**
- Port 1433 - Internal only
- Never expose to public internet

### Network Segmentation

```
Internet → Load Balancer → BC Servers → SQL Server
                                ↓
                         File Storage (Private)
```

## Monitoring and Auditing

### Security Monitoring

Enable and monitor:
- Failed login attempts
- Permission changes
- Data access patterns
- API usage
- File operations

### Audit Trail

All critical operations are logged:
- Record creation/modification
- User actions
- System changes
- Security events

### Log Analysis

```bash
# View security events
kubectl logs -n cad3d-app -l app=cad3d-bc --tail=100 | grep "SECURITY"

# Check failed authentications
kubectl logs -n cad3d-app -l app=cad3d-bc | grep "AUTH_FAILED"
```

## Vulnerability Management

### Regular Updates
- Keep Business Central updated
- Apply security patches promptly
- Update dependencies regularly
- Monitor CVE databases

### Security Scanning

The CI/CD pipeline includes:
- CodeQL analysis (daily)
- Dependency scanning (on every commit)
- Secret scanning (on every commit)
- Container scanning (weekly)

### Penetration Testing

Conduct regular penetration testing:
- Annual external pen test
- Quarterly internal security audits
- Pre-release security review

## Compliance

### GDPR Compliance

The application is GDPR-ready:
- Data classification implemented
- Right to be forgotten supported
- Data export capabilities
- Audit trail for data access

### SOC 2 Compliance

For SOC 2 compliance:
- Document access controls
- Maintain audit logs
- Implement change management
- Regular security training

## Incident Response

### Security Incident Procedure

1. **Detect**: Monitor logs and alerts
2. **Contain**: Isolate affected systems
3. **Investigate**: Analyze breach scope
4. **Remediate**: Fix vulnerabilities
5. **Document**: Record incident details
6. **Review**: Update procedures

### Emergency Contacts

- Security Team: security@yourcompany.com
- On-Call: +1-555-SECURITY
- Incident Response: incidents@yourcompany.com

## Security Checklist

### Before Deployment

- [ ] All secrets stored in external secret manager
- [ ] TLS/SSL certificates configured and valid
- [ ] Firewall rules configured
- [ ] RBAC permissions set up
- [ ] Logging and monitoring enabled
- [ ] Backup procedures tested
- [ ] Security scanning completed
- [ ] Penetration testing performed
- [ ] Incident response plan documented

### Regular Maintenance

- [ ] Weekly: Review security logs
- [ ] Monthly: Update dependencies
- [ ] Quarterly: Rotate credentials
- [ ] Quarterly: Security training
- [ ] Annually: External security audit
- [ ] Annually: Disaster recovery test

## Security Tools

### Recommended Tools

1. **Secret Management**
   - Azure Key Vault
   - HashiCorp Vault
   - AWS Secrets Manager

2. **Monitoring**
   - Azure Security Center
   - Splunk
   - ELK Stack

3. **Scanning**
   - Snyk
   - Aqua Security
   - Prisma Cloud

4. **SIEM**
   - Azure Sentinel
   - Splunk Enterprise Security
   - IBM QRadar

## Additional Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)
- [Microsoft Security Best Practices](https://docs.microsoft.com/en-us/security/)
- [Kubernetes Security](https://kubernetes.io/docs/concepts/security/)

## Support

For security questions or concerns:
- Email: security@yourcompany.com
- Security Portal: https://security.yourcompany.com
- Bug Bounty: https://bugbounty.yourcompany.com
