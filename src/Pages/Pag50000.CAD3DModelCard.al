/// <summary>
/// Page CAD3D Model Card (ID 50000).
/// Card page for managing individual CAD 3D models.
/// </summary>
page 50000 "CAD3D Model Card"
{
    Caption = 'CAD 3D Model Card';
    PageType = Card;
    SourceTable = "CAD3D Model";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the model.';
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the model.';
                    Importance = Promoted;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the model.';
                    MultiLine = true;
                }

                field("Model Type"; Rec."Model Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the model.';
                    Importance = Promoted;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the model.';
                    Importance = Promoted;
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
            }

            group(FileInfo)
            {
                Caption = 'File Information';

                field("File Path"; Rec."File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file path of the model.';
                }

                field("File Size"; Rec."File Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file size in MB.';
                }

                field("Vertex Count"; Rec."Vertex Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of vertices in the model.';
                }

                field("Polygon Count"; Rec."Polygon Count")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of polygons in the model.';
                }
            }

            group(Dimensions)
            {
                Caption = 'Dimensions';

                field("Dimensions X"; Rec."Dimensions X")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the X dimension in millimeters.';
                }

                field("Dimensions Y"; Rec."Dimensions Y")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Y dimension in millimeters.';
                }

                field("Dimensions Z"; Rec."Dimensions Z")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Z dimension in millimeters.';
                }

                field("Material Type"; Rec."Material Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material type.';
                }

                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated cost.';
                }
            }

            group(AIAnalysis)
            {
                Caption = 'AI Analysis';

                field("AI Analyzed"; Rec."AI Analyzed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if the model has been analyzed by AI.';
                }

                field("AI Optimization Score"; Rec."AI Optimization Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the AI optimization score (0-100).';
                    StyleExpr = ScoreStyle;
                }

                field("AI Analysis Date"; Rec."AI Analysis Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the AI analysis was performed.';
                }
            }

            group(Audit)
            {
                Caption = 'Audit Information';

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the model.';
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the model was created.';
                }

                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who last modified the model.';
                }

                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the model was last modified.';
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
                ToolTip = 'Performs AI analysis on the model.';
                Image = Analyze;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CAD3DAIMgt: Codeunit "CAD3D AI Management";
                begin
                    CAD3DAIMgt.AnalyzeModel(Rec);
                    CurrPage.Update();
                end;
            }

            action(OptimizeModel)
            {
                ApplicationArea = All;
                Caption = 'Optimize Model';
                ToolTip = 'Optimizes the model using AI.';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CAD3DAIMgt: Codeunit "CAD3D AI Management";
                begin
                    CAD3DAIMgt.OptimizeModel(Rec);
                    CurrPage.Update();
                end;
            }

            action(CreateVersion)
            {
                ApplicationArea = All;
                Caption = 'Create Version';
                ToolTip = 'Creates a new version of the model.';
                Image = Version;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CAD3DModelMgt: Codeunit "CAD3D Model Management";
                begin
                    CAD3DModelMgt.CreateVersion(Rec);
                    CurrPage.Update();
                end;
            }
        }

        area(Navigation)
        {
            action(Versions)
            {
                ApplicationArea = All;
                Caption = 'Versions';
                ToolTip = 'View version history of the model.';
                Image = History;
                RunObject = page "CAD3D Model Version List";
                RunPageLink = "Model No." = field("No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetScoreStyle();
    end;

    local procedure SetScoreStyle()
    begin
        if Rec."AI Optimization Score" >= 80 then
            ScoreStyle := 'Favorable'
        else if Rec."AI Optimization Score" >= 60 then
            ScoreStyle := 'Ambiguous'
        else
            ScoreStyle := 'Unfavorable';
    end;

    var
        ScoreStyle: Text;
}
