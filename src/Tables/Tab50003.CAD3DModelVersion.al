/// <summary>
/// Table CAD3D Model Version (ID 50003).
/// Tracks version history of CAD 3D models.
/// </summary>
table 50003 "CAD3D Model Version"
{
    Caption = 'CAD 3D Model Version';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Model No."; Code[20])
        {
            Caption = 'Model No.';
            DataClassification = CustomerContent;
            TableRelation = "CAD3D Model"."No.";
            NotBlank = true;
        }

        field(2; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
            MinValue = 1;
            NotBlank = true;
        }

        field(3; "Version Description"; Text[250])
        {
            Caption = 'Version Description';
            DataClassification = CustomerContent;
        }

        field(4; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = CustomerContent;
        }

        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            Editable = false;
        }

        field(6; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(7; "Change Type"; Enum "CAD3D Change Type")
        {
            Caption = 'Change Type';
            DataClassification = CustomerContent;
        }

        field(8; "File Size"; Decimal)
        {
            Caption = 'File Size (MB)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(PK; "Model No.", "Version No.")
        {
            Clustered = true;
        }
        key(DateKey; "Created Date")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime();
        "Created By" := UserId();
    end;
}
