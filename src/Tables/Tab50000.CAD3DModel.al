/// <summary>
/// Table CAD3D Model (ID 50000).
/// Stores 3D CAD model metadata and references for AI-powered design management.
/// </summary>
table 50000 "CAD3D Model"
{
    Caption = 'CAD 3D Model';
    DataClassification = CustomerContent;
    DataCaptionFields = "No.", Name;
    DrillDownPageId = "CAD3D Model List";
    LookupPageId = "CAD3D Model List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CAD3DSetup.Get();
                    NoSeriesMgt.TestManual(CAD3DSetup."Model Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(3; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(4; "Model Type"; Enum "CAD3D Model Type")
        {
            Caption = 'Model Type';
            DataClassification = CustomerContent;
        }

        field(5; Status; Enum "CAD3D Model Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(6; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CAD3DModelMgt: Codeunit "CAD3D Model Management";
                CAD3DSetup: Record "CAD3D Setup";
            begin
                if "File Path" <> '' then begin
                    if not CAD3DModelMgt.ValidateModelFile("File Path") then begin
                        CAD3DSetup.Get();
                        Error('File format is not supported.\\Supported formats: %1\\File: %2',
                              CAD3DSetup."Supported Formats", "File Path");
                    end;
                end;
            end;
        }

        field(7; "File Size"; Decimal)
        {
            Caption = 'File Size (MB)';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }

        field(8; "Vertex Count"; Integer)
        {
            Caption = 'Vertex Count';
            DataClassification = CustomerContent;
        }

        field(9; "Polygon Count"; Integer)
        {
            Caption = 'Polygon Count';
            DataClassification = CustomerContent;
        }

        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }

        field(11; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(12; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }

        field(13; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(14; "AI Optimization Score"; Decimal)
        {
            Caption = 'AI Optimization Score';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }

        field(15; "AI Analyzed"; Boolean)
        {
            Caption = 'AI Analyzed';
            DataClassification = CustomerContent;
        }

        field(16; "AI Analysis Date"; DateTime)
        {
            Caption = 'AI Analysis Date';
            DataClassification = CustomerContent;
        }

        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(30; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = CustomerContent;
            TableRelation = "CAD3D Project"."No.";
        }

        field(31; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
            MinValue = 1;
        }

        field(40; "Dimensions X"; Decimal)
        {
            Caption = 'Dimensions X (mm)';
            DataClassification = CustomerContent;
            DecimalPlaces = 3 : 3;
            MinValue = 0;
        }

        field(41; "Dimensions Y"; Decimal)
        {
            Caption = 'Dimensions Y (mm)';
            DataClassification = CustomerContent;
            DecimalPlaces = 3 : 3;
            MinValue = 0;
        }

        field(42; "Dimensions Z"; Decimal)
        {
            Caption = 'Dimensions Z (mm)';
            DataClassification = CustomerContent;
            DecimalPlaces = 3 : 3;
            MinValue = 0;
        }

        field(43; "Material Type"; Text[50])
        {
            Caption = 'Material Type';
            DataClassification = CustomerContent;
        }

        field(44; "Estimated Cost"; Decimal)
        {
            Caption = 'Estimated Cost';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(ProjectKey; "Project No.", "Version No.")
        {
        }
        key(StatusKey; Status, "Created Date")
        {
        }
        key(AIAnalyzedKey; "AI Analyzed", "AI Analysis Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            CAD3DSetup.Get();
            CAD3DSetup.TestField("Model Nos.");
            NoSeriesMgt.InitSeries(CAD3DSetup."Model Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Created Date" := Today();
        "Created By" := UserId();
        "Version No." := 1;
        Status := Status::Draft;
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime();
        "Last Modified By" := UserId();
    end;

    trigger OnDelete()
    var
        CAD3DModelVersion: Record "CAD3D Model Version";
    begin
        CAD3DModelVersion.SetRange("Model No.", "No.");
        CAD3DModelVersion.DeleteAll(true);
    end;

    var
        CAD3DSetup: Record "CAD3D Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    /// <summary>
    /// Handles assist edit for the No. field.
    /// </summary>
    /// <param name="OldCAD3DModel">Previous record state.</param>
    /// <returns>True if number was changed.</returns>
    procedure AssistEdit(OldCAD3DModel: Record "CAD3D Model"): Boolean
    begin
        CAD3DSetup.Get();
        CAD3DSetup.TestField("Model Nos.");
        if NoSeriesMgt.SelectSeries(CAD3DSetup."Model Nos.", OldCAD3DModel."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
}
