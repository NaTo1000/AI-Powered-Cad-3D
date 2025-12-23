/// <summary>
/// Enum CAD3D Project Status (ID 50002).
/// Defines the status of CAD 3D project.
/// </summary>
enum 50002 "CAD3D Project Status"
{
    Extensible = true;

    value(0; Planning)
    {
        Caption = 'Planning';
    }
    value(1; Active)
    {
        Caption = 'Active';
    }
    value(2; "On Hold")
    {
        Caption = 'On Hold';
    }
    value(3; Completed)
    {
        Caption = 'Completed';
    }
    value(4; Cancelled)
    {
        Caption = 'Cancelled';
    }
}
