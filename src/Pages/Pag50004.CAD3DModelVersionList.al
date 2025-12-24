/// <summary>
/// Page CAD3D Model Version List (ID 50004).
/// List page for viewing model version history.
/// </summary>
page 50004 "CAD3D Model Version List"
{
    Caption = 'CAD 3D Model Versions';
    PageType = List;
    SourceTable = "CAD3D Model Version";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the version number.';
                }

                field("Version Description"; Rec."Version Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the version description.';
                }

                field("Change Type"; Rec."Change Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of change.';
                }

                field("File Path"; Rec."File Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file path.';
                }

                field("File Size"; Rec."File Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the file size in MB.';
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created this version.';
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this version was created.';
                }
            }
        }
    }
}
