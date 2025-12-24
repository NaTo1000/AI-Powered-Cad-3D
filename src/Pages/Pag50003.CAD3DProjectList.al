/// <summary>
/// Page CAD3D Project List (ID 50003).
/// List page for viewing and managing CAD 3D projects.
/// </summary>
page 50003 "CAD3D Project List"
{
    Caption = 'CAD 3D Projects';
    PageType = List;
    SourceTable = "CAD3D Project";
    CardPageId = "CAD3D Project Card";
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
                    ToolTip = 'Specifies the unique identifier for the project.';
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the project.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the project.';
                }

                field("Project Manager"; Rec."Project Manager")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the project manager.';
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date of the project.';
                }

                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date of the project.';
                }

                field("Total Budget"; Rec."Total Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total budget for the project.';
                }

                field("No. of Models"; Rec."No. of Models")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of models in the project.';
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
}
