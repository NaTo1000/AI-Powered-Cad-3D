# Contributing to AI-Powered CAD 3D

Thank you for your interest in contributing to the AI-Powered CAD 3D project! This document provides guidelines for contributing.

## Code of Conduct

### Our Pledge
We are committed to providing a welcoming and inspiring community for everyone.

### Our Standards
- Be respectful and inclusive
- Accept constructive criticism gracefully
- Focus on what is best for the community
- Show empathy towards others

## How to Contribute

### Reporting Bugs
1. Check if the bug has already been reported
2. Create a new issue with:
   - Clear title and description
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Environment details

### Suggesting Features
1. Check existing feature requests
2. Create an issue with:
   - Clear use case
   - Proposed solution
   - Alternative solutions considered
   - Impact assessment

### Pull Request Process

#### 1. Fork and Clone
```bash
git clone https://github.com/YOUR-USERNAME/AI-Powered-Cad-3D.git
cd AI-Powered-Cad-3D
```

#### 2. Create a Branch
```bash
git checkout -b feature/your-feature-name
```

#### 3. Make Changes
- Follow coding standards
- Add tests for new functionality
- Update documentation
- Ensure all tests pass

#### 4. Commit Changes
```bash
git add .
git commit -m "feat: add new feature"
```

Use conventional commit format:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `test:` Tests
- `refactor:` Code refactoring
- `style:` Code formatting
- `chore:` Maintenance

#### 5. Push and Create PR
```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub.

### Pull Request Guidelines

**PR Title**: Use conventional commit format
```
feat: add AI model optimization
fix: correct version numbering
docs: update API documentation
```

**PR Description** should include:
- Summary of changes
- Related issue numbers
- Breaking changes (if any)
- Testing performed
- Screenshots (for UI changes)

**Before Submitting**:
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] No new warnings
- [ ] PR description is complete

## Development Guidelines

### Code Style

#### AL Code Style
```al
/// <summary>
/// Documentation comment for procedures.
/// </summary>
procedure MyProcedure()
var
    MyVariable: Text;
begin
    // Implementation
end;
```

#### Naming Conventions
- **Tables**: PascalCase with spaces (e.g., "CAD3D Model")
- **Fields**: PascalCase with spaces (e.g., "Model Type")
- **Variables**: PascalCase (e.g., CAD3DModel)
- **Procedures**: PascalCase (e.g., AnalyzeModel)
- **Constants**: UPPER_CASE (e.g., MAX_FILE_SIZE)

#### File Naming
- Tables: `Tab{ID}.{Name}.al`
- Pages: `Pag{ID}.{Name}.al`
- Codeunits: `Cod{ID}.{Name}.al`
- Enums: `Enum{ID}.{Name}.al`

### Testing Requirements

#### Unit Tests
All new features must include unit tests:
```al
[Test]
procedure TestMyFeature()
var
    Assert: Codeunit "Library Assert";
begin
    // [FEATURE] Feature Name
    // [SCENARIO] Scenario description
    
    // [GIVEN] Initial state
    
    // [WHEN] Action performed
    
    // [THEN] Expected result
    Assert.AreEqual(Expected, Actual, 'Error message');
end;
```

#### Test Coverage
- Aim for 80%+ code coverage
- Test happy paths
- Test error conditions
- Test edge cases

### Documentation

#### Code Documentation
- Add XML comments for all public procedures
- Explain complex algorithms
- Document assumptions and constraints

#### User Documentation
Update when adding features:
- README.md
- User manuals
- API documentation
- Architecture docs

### Security

#### Security Checklist
- [ ] No hardcoded credentials
- [ ] Input validation implemented
- [ ] SQL injection prevented
- [ ] XSS vulnerabilities addressed
- [ ] Authentication/authorization checked
- [ ] Data classification correct
- [ ] GDPR compliance maintained

#### Reporting Security Issues
**DO NOT** create public issues for security vulnerabilities.

Email: security@yourcompany.com

Include:
- Vulnerability description
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

## Review Process

### Code Review Criteria
Reviewers check for:
- Code quality and readability
- Test coverage
- Documentation completeness
- Security considerations
- Performance implications
- Breaking changes
- Backward compatibility

### Review Timeline
- Initial review: Within 2 business days
- Follow-up reviews: Within 1 business day
- Final approval: When all checks pass

### Addressing Feedback
- Respond to all comments
- Make requested changes
- Re-request review when ready
- Be patient and professional

## Release Process

### Version Numbering
We use Semantic Versioning (MAJOR.MINOR.PATCH):
- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes

### Release Checklist
- [ ] All tests pass
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version number bumped
- [ ] Release notes prepared
- [ ] Security scan completed
- [ ] Performance tested

## Community

### Communication Channels
- **GitHub Discussions**: General questions and ideas
- **GitHub Issues**: Bug reports and feature requests
- **Pull Requests**: Code contributions
- **Email**: dev-community@yourcompany.com

### Getting Help
1. Check documentation
2. Search existing issues
3. Ask in GitHub Discussions
4. Contact maintainers

## Recognition

### Contributors
We recognize all contributors in:
- README.md contributors section
- Release notes
- Project website

### Types of Contributions
All contributions are valued:
- Code contributions
- Documentation improvements
- Bug reports
- Feature suggestions
- Community support
- Testing and QA
- Translations
- Design work

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

Feel free to reach out:
- Email: opensource@yourcompany.com
- GitHub Discussions: https://github.com/NaTo1000/AI-Powered-Cad-3D/discussions
- Twitter: @yourcompany

Thank you for contributing to AI-Powered CAD 3D! 🚀
