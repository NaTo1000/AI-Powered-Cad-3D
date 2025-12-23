/// <summary>
/// Page CAD3D Setup (ID 50005).
/// Setup page for CAD 3D module configuration.
/// </summary>
page 50005 "CAD3D Setup"
{
    Caption = 'CAD 3D Setup';
    PageType = Card;
    SourceTable = "CAD3D Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';

                field("Model Nos."; Rec."Model Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for models.';
                }

                field("Project Nos."; Rec."Project Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for projects.';
                }
            }

            group(Storage)
            {
                Caption = 'Storage';

                field("Default Storage Path"; Rec."Default Storage Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default storage path for model files.';
                }

                field("Max File Size (MB)"; Rec."Max File Size (MB)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum file size allowed.';
                }

                field("Supported Formats"; Rec."Supported Formats")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the supported file formats.';
                }
            }

            group(AIConfiguration)
            {
                Caption = 'AI Configuration';

                field("Enable AI Analysis"; Rec."Enable AI Analysis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enables AI analysis features.';
                }

                field("AI Service Endpoint"; Rec."AI Service Endpoint")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AI service endpoint URL.';
                }

                field("AI Service API Key"; Rec."AI Service API Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the API key for AI service authentication.';
                }

                field("Auto-Optimize Models"; Rec."Auto-Optimize Models")
                {
                    ApplicationArea = All;
                    ToolTip = 'Automatically optimizes models after analysis.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
