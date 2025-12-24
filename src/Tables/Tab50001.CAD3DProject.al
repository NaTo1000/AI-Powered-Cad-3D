/// <summary>
/// Table CAD3D Project (ID 50001).
/// Manages CAD 3D design projects with collaboration features.
/// </summary>
table 50001 "CAD3D Project"
{
    Caption = 'CAD 3D Project';
    DataClassification = CustomerContent;
    DataCaptionFields = "No.", Name;
    DrillDownPageId = "CAD3D Project List";
    LookupPageId = "CAD3D Project List";

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
                    NoSeriesMgt.TestManual(CAD3DSetup."Project Nos.");
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

        field(4; Status; Enum "CAD3D Project Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }

        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }

        field(7; "Project Manager"; Code[50])
        {
            Caption = 'Project Manager';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }

        field(8; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(9; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(10; "Total Budget"; Decimal)
        {
            Caption = 'Total Budget';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }

        field(11; "Actual Cost"; Decimal)
        {
            Caption = 'Actual Cost';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }

        field(12; "No. of Models"; Integer)
        {
            Caption = 'No. of Models';
            FieldClass = FlowField;
            CalcFormula = count("CAD3D Model" where("Project No." = field("No.")));
            Editable = false;
        }

        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(30; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            Editable = false;
        }

        field(31; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(32; "Last Modified By"; Code[50])
        {
            Caption = 'Last Modified By';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            Editable = false;
        }

        field(33; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(StatusKey; Status, "Start Date")
        {
        }
        key(CustomerKey; "Customer No.", "Start Date")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            CAD3DSetup.Get();
            CAD3DSetup.TestField("Project Nos.");
            NoSeriesMgt.InitSeries(CAD3DSetup."Project Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Created Date" := Today();
        "Created By" := UserId();
        Status := Status::Planning;
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime();
        "Last Modified By" := UserId();
    end;

    var
        CAD3DSetup: Record "CAD3D Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
