/// <summary>
/// Page CAD3D Project Card (ID 50002).
/// Card page for managing CAD 3D projects.
/// </summary>
page 50002 "CAD3D Project Card"
{
    Caption = 'CAD 3D Project Card';
    PageType = Card;
    SourceTable = "CAD3D Project";
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
                    ToolTip = 'Specifies the unique identifier for the project.';
                    Importance = Promoted;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the project.';
                    Importance = Promoted;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the project.';
                    MultiLine = true;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the project.';
                    Importance = Promoted;
                }

                field("Project Manager"; Rec."Project Manager")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the project manager.';
                }
            }

            group(Timeline)
            {
                Caption = 'Timeline';

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
            }

            group(Customer)
            {
                Caption = 'Customer Information';

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer name.';
                }
            }

            group(Financial)
            {
                Caption = 'Financial';

                field("Total Budget"; Rec."Total Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total budget for the project.';
                }

                field("Actual Cost"; Rec."Actual Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual cost incurred.';
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

    actions
    {
        area(Navigation)
        {
            action(Models)
            {
                ApplicationArea = All;
                Caption = 'Models';
                ToolTip = 'View models in this project.';
                Image = ItemLines;
                RunObject = page "CAD3D Model List";
                RunPageLink = "Project No." = field("No.");
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }
}
