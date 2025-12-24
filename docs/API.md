# API Documentation

## Overview
The CAD3D application provides RESTful APIs through Business Central's OData endpoints for external system integration.

## Base URL
```
Production: https://api.businesscentral.dynamics.com/v2.0/{tenant}/Production/ODataV4/
Sandbox: https://api.businesscentral.dynamics.com/v2.0/{tenant}/Sandbox/ODataV4/
On-Premises: https://your-server:7048/{instance}/ODataV4/
```

## Authentication
All API requests require authentication using OAuth 2.0.

### Authentication Flow
```http
POST https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
&client_id={client_id}
&client_secret={client_secret}
&scope=https://api.businesscentral.dynamics.com/.default
```

### Using Access Token
```http
GET {base_url}/Company('{company}')/CAD3DModel
Authorization: Bearer {access_token}
```

## API Endpoints

### CAD3D Models

#### List All Models
```http
GET /Company('{company}')/CAD3DModel
```

**Query Parameters:**
- `$filter` - Filter results (e.g., `Status eq 'Approved'`)
- `$select` - Select specific fields
- `$orderby` - Sort results
- `$top` - Limit results
- `$skip` - Skip results for pagination

**Response:**
```json
{
  "@odata.context": "...",
  "value": [
    {
      "@odata.etag": "W/\"...\"",
      "No": "MDL-001",
      "Name": "Main Assembly",
      "Description": "Primary assembly component",
      "Model_Type": "Assembly",
      "Status": "Approved",
      "File_Path": "C:\\CAD3D\\Models\\MDL-001.stl",
      "File_Size": 25.50,
      "Vertex_Count": 150000,
      "Polygon_Count": 75000,
      "AI_Optimization_Score": 87.50,
      "AI_Analyzed": true,
      "AI_Analysis_Date": "2025-01-15T14:30:00Z",
      "Project_No": "PRJ-001",
      "Version_No": 1,
      "Created_By": "ADMIN",
      "Created_Date": "2025-01-05"
    }
  ]
}
```

#### Get Specific Model
```http
GET /Company('{company}')/CAD3DModel('{No}')
```

**Response:** Single model object

#### Create Model
```http
POST /Company('{company}')/CAD3DModel
Content-Type: application/json

{
  "Name": "New Component",
  "Description": "Component description",
  "Model_Type": "Part",
  "Status": "Draft",
  "Project_No": "PRJ-001",
  "File_Path": "C:\\CAD3D\\Models\\new.stl",
  "File_Size": 10.5,
  "Vertex_Count": 50000,
  "Polygon_Count": 25000,
  "Dimensions_X": 100.0,
  "Dimensions_Y": 150.0,
  "Dimensions_Z": 50.0,
  "Material_Type": "Aluminum"
}
```

**Response:** Created model object with HTTP 201

#### Update Model
```http
PATCH /Company('{company}')/CAD3DModel('{No}')
Content-Type: application/json
If-Match: {etag}

{
  "Status": "Approved",
  "AI_Optimization_Score": 95.0
}
```

**Response:** Updated model object

#### Delete Model
```http
DELETE /Company('{company}')/CAD3DModel('{No}')
If-Match: {etag}
```

**Response:** HTTP 204 No Content

### CAD3D Projects

#### List All Projects
```http
GET /Company('{company}')/CAD3DProject
```

#### Get Specific Project
```http
GET /Company('{company}')/CAD3DProject('{No}')
```

#### Get Project with Models
```http
GET /Company('{company}')/CAD3DProject('{No}')?$expand=Models
```

#### Create Project
```http
POST /Company('{company}')/CAD3DProject
Content-Type: application/json

{
  "Name": "New Project",
  "Description": "Project description",
  "Status": "Planning",
  "Start_Date": "2025-02-01",
  "End_Date": "2025-08-31",
  "Project_Manager": "MANAGER1",
  "Total_Budget": 200000.00
}
```

#### Update Project
```http
PATCH /Company('{company}')/CAD3DProject('{No}')
Content-Type: application/json
If-Match: {etag}

{
  "Status": "Active",
  "Actual_Cost": 50000.00
}
```

### CAD3D Model Versions

#### List Model Versions
```http
GET /Company('{company}')/CAD3DModelVersion?$filter=Model_No eq '{ModelNo}'
```

#### Get Specific Version
```http
GET /Company('{company}')/CAD3DModelVersion(Model_No='{ModelNo}',Version_No={VersionNo})
```

#### Create Version
```http
POST /Company('{company}')/CAD3DModelVersion
Content-Type: application/json

{
  "Model_No": "MDL-001",
  "Version_No": 2,
  "Version_Description": "Updated design",
  "Change_Type": "Major_Update",
  "File_Path": "C:\\CAD3D\\Models\\MDL-001-v2.stl",
  "File_Size": 26.75
}
```

## Custom Actions

### Run AI Analysis
```http
POST /Company('{company}')/CAD3DModel('{No}')/Microsoft.NAV.RunAIAnalysis
Content-Type: application/json

{}
```

**Response:**
```json
{
  "@odata.context": "...",
  "AI_Optimization_Score": 88.5,
  "AI_Analyzed": true,
  "AI_Analysis_Date": "2025-01-20T10:15:00Z"
}
```

### Optimize Model
```http
POST /Company('{company}')/CAD3DModel('{No}')/Microsoft.NAV.OptimizeModel
Content-Type: application/json

{}
```

**Response:**
```json
{
  "@odata.context": "...",
  "Polygon_Count": 63750,
  "AI_Optimization_Score": 95.0,
  "OptimizationApplied": true
}
```

### Create Model Version
```http
POST /Company('{company}')/CAD3DModel('{No}')/Microsoft.NAV.CreateVersion
Content-Type: application/json

{
  "VersionDescription": "Design revision",
  "ChangeType": "Design_Revision"
}
```

## Filtering Examples

### Filter by Status
```http
GET /Company('{company}')/CAD3DModel?$filter=Status eq 'Approved'
```

### Filter by Date Range
```http
GET /Company('{company}')/CAD3DModel?$filter=Created_Date ge 2025-01-01 and Created_Date le 2025-01-31
```

### Filter by Project
```http
GET /Company('{company}')/CAD3DModel?$filter=Project_No eq 'PRJ-001'
```

### Filter AI Analyzed Models
```http
GET /Company('{company}')/CAD3DModel?$filter=AI_Analyzed eq true and AI_Optimization_Score ge 80
```

### Complex Filter
```http
GET /Company('{company}')/CAD3DModel?$filter=Status eq 'Approved' and Model_Type eq 'Part' and AI_Optimization_Score ge 85
```

## Sorting Examples

### Sort by Name
```http
GET /Company('{company}')/CAD3DModel?$orderby=Name
```

### Sort by Score Descending
```http
GET /Company('{company}')/CAD3DModel?$orderby=AI_Optimization_Score desc
```

### Sort by Multiple Fields
```http
GET /Company('{company}')/CAD3DModel?$orderby=Status,Created_Date desc
```

## Pagination

### First Page
```http
GET /Company('{company}')/CAD3DModel?$top=20
```

### Second Page
```http
GET /Company('{company}')/CAD3DModel?$top=20&$skip=20
```

## Field Selection

### Select Specific Fields
```http
GET /Company('{company}')/CAD3DModel?$select=No,Name,Status,AI_Optimization_Score
```

## Expanding Related Data

### Expand Project Information
```http
GET /Company('{company}')/CAD3DModel?$expand=Project
```

### Expand Multiple Relations
```http
GET /Company('{company}')/CAD3DModel?$expand=Project,Versions
```

## Error Responses

### 400 Bad Request
```json
{
  "error": {
    "code": "BadRequest",
    "message": "Invalid request body",
    "details": [
      {
        "code": "ValidationError",
        "message": "Field 'Name' is required",
        "target": "Name"
      }
    ]
  }
}
```

### 401 Unauthorized
```json
{
  "error": {
    "code": "Unauthorized",
    "message": "Authentication failed"
  }
}
```

### 404 Not Found
```json
{
  "error": {
    "code": "NotFound",
    "message": "Model 'MDL-999' does not exist"
  }
}
```

### 409 Conflict
```json
{
  "error": {
    "code": "Conflict",
    "message": "The record has been modified by another user",
    "target": "etag"
  }
}
```

### 429 Too Many Requests
```json
{
  "error": {
    "code": "TooManyRequests",
    "message": "Rate limit exceeded. Retry after 60 seconds",
    "retryAfter": 60
  }
}
```

## Rate Limiting

- **Rate Limit**: 5000 requests per hour per client
- **Burst Limit**: 100 requests per minute
- **Headers**:
  - `X-RateLimit-Limit`: Maximum requests allowed
  - `X-RateLimit-Remaining`: Requests remaining
  - `X-RateLimit-Reset`: Time when limit resets (Unix timestamp)

## Best Practices

### 1. Use Field Selection
Select only needed fields to reduce payload size:
```http
GET /Company('{company}')/CAD3DModel?$select=No,Name,Status
```

### 2. Use Efficient Filtering
Filter on server side instead of client side:
```http
GET /Company('{company}')/CAD3DModel?$filter=Status eq 'Approved'
```

### 3. Implement Pagination
Always use pagination for large datasets:
```http
GET /Company('{company}')/CAD3DModel?$top=50&$skip=0
```

### 4. Handle ETags Properly
Always include If-Match header for updates:
```http
PATCH /Company('{company}')/CAD3DModel('{No}')
If-Match: W/"JzQ0O0VnQUFBQUo3QlRVQU1BQT0nOzIwMjUwMzUwMTk7Njc5NzUyNTA1OScg"
```

### 5. Implement Retry Logic
Use exponential backoff for transient failures.

### 6. Cache Responses
Cache GET responses when appropriate with ETags.

### 7. Monitor Rate Limits
Track rate limit headers and throttle accordingly.

## Code Examples

### Python
```python
import requests

# Authentication
token_url = f"https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token"
token_data = {
    'grant_type': 'client_credentials',
    'client_id': client_id,
    'client_secret': client_secret,
    'scope': 'https://api.businesscentral.dynamics.com/.default'
}
token_response = requests.post(token_url, data=token_data)
access_token = token_response.json()['access_token']

# Get Models
headers = {'Authorization': f'Bearer {access_token}'}
response = requests.get(
    f"{base_url}/Company('{company}')/CAD3DModel?$filter=Status eq 'Approved'",
    headers=headers
)
models = response.json()['value']
```

### JavaScript
```javascript
// Using axios
const axios = require('axios');

// Get access token
const tokenResponse = await axios.post(
  `https://login.microsoftonline.com/${tenant}/oauth2/v2.0/token`,
  new URLSearchParams({
    grant_type: 'client_credentials',
    client_id: clientId,
    client_secret: clientSecret,
    scope: 'https://api.businesscentral.dynamics.com/.default'
  })
);

const accessToken = tokenResponse.data.access_token;

// Get models
const response = await axios.get(
  `${baseUrl}/Company('${company}')/CAD3DModel`,
  {
    headers: { Authorization: `Bearer ${accessToken}` },
    params: {
      $filter: "Status eq 'Approved'",
      $top: 50
    }
  }
);

const models = response.data.value;
```

### C#
```csharp
using System.Net.Http;
using System.Net.Http.Headers;
using Microsoft.Identity.Client;

// Get access token
var app = ConfidentialClientApplicationBuilder.Create(clientId)
    .WithClientSecret(clientSecret)
    .WithAuthority(new Uri($"https://login.microsoftonline.com/{tenant}"))
    .Build();

var result = await app.AcquireTokenForClient(
    new[] { "https://api.businesscentral.dynamics.com/.default" }
).ExecuteAsync();

// Get models
var client = new HttpClient();
client.DefaultRequestHeaders.Authorization = 
    new AuthenticationHeaderValue("Bearer", result.AccessToken);

var response = await client.GetAsync(
    $"{baseUrl}/Company('{company}')/CAD3DModel?$filter=Status eq 'Approved'"
);

var models = await response.Content.ReadAsAsync<ODataResponse<CAD3DModel>>();
```

## Webhooks

### Event Subscriptions
Subscribe to entity changes:

```http
POST /Company('{company}')/subscriptions
Content-Type: application/json

{
  "notificationUrl": "https://your-api.com/webhook",
  "resource": "/Company('{company}')/CAD3DModel",
  "changeType": "created,updated",
  "expirationDateTime": "2025-12-31T23:59:59Z"
}
```

### Webhook Payload
```json
{
  "subscriptionId": "sub-123",
  "changeType": "updated",
  "resource": "/Company('CRONUS')/CAD3DModel('MDL-001')",
  "resourceData": {
    "No": "MDL-001",
    "Status": "Approved",
    "AI_Optimization_Score": 95.0
  },
  "timestamp": "2025-01-20T15:30:00Z"
}
```

## Support

For API support:
- Email: api-support@yourcompany.com
- Documentation: https://docs.yourcompany.com
- Status Page: https://status.yourcompany.com
