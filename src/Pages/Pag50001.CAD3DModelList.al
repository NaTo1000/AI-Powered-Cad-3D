/// <summary>
/// Page CAD3D Model List (ID 50001).
/// List page for viewing and managing CAD 3D models.
/// </summary>
page 50001 "CAD3D Model List"
{
    Caption = 'CAD 3D Models';
    PageType = List;
    SourceTable = "CAD3D Model";
    CardPageId = "CAD3D Model Card";
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the model.';
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the model.';
                }

                field("Model Type"; Rec."Model Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the model.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the model.';
                }

                field("Project No."; Rec."Project No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the project this model belongs to.';
                }

                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current version number.';
                }

                field("AI Optimization Score"; Rec."AI Optimization Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AI optimization score (0-100).';
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the model was created.';
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the model.';
                }
            }
        }

        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunAIAnalysis)
            {
                ApplicationArea = All;
                Caption = 'Run AI Analysis';
                ToolTip = 'Performs AI analysis on the selected model.';
                Image = Analyze;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CAD3DAIMgt: Codeunit "CAD3D AI Management";
                begin
                    CAD3DAIMgt.AnalyzeModel(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
