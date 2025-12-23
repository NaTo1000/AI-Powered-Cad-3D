/// <summary>
/// Table CAD3D Setup (ID 50002).
/// Configuration and setup for CAD 3D module.
/// </summary>
table 50002 "CAD3D Setup"
{
    Caption = 'CAD 3D Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }

        field(10; "Model Nos."; Code[20])
        {
            Caption = 'Model Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }

        field(11; "Project Nos."; Code[20])
        {
            Caption = 'Project Nos.';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }

        field(20; "Default Storage Path"; Text[250])
        {
            Caption = 'Default Storage Path';
            DataClassification = SystemMetadata;
        }

        field(21; "AI Service Endpoint"; Text[250])
        {
            Caption = 'AI Service Endpoint';
            DataClassification = SystemMetadata;
        }

        field(22; "AI Service API Key"; Text[100])
        {
            Caption = 'AI Service API Key';
            DataClassification = EndUserIdentifiableInformation;
            ExtendedDatatype = Masked;
        }

        field(23; "Enable AI Analysis"; Boolean)
        {
            Caption = 'Enable AI Analysis';
            DataClassification = SystemMetadata;
        }

        field(24; "Auto-Optimize Models"; Boolean)
        {
            Caption = 'Auto-Optimize Models';
            DataClassification = SystemMetadata;
        }

        field(30; "Max File Size (MB)"; Decimal)
        {
            Caption = 'Max File Size (MB)';
            DataClassification = SystemMetadata;
            DecimalPlaces = 2 : 2;
            InitValue = 500;
            MinValue = 1;
        }

        field(31; "Supported Formats"; Text[250])
        {
            Caption = 'Supported Formats';
            DataClassification = SystemMetadata;
            InitValue = 'STL,OBJ,FBX,STEP,IGES,DXF,DWG';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
