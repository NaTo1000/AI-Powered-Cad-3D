/// <summary>
/// Enum CAD3D Model Status (ID 50001).
/// Defines the status of CAD 3D model.
/// </summary>
enum 50001 "CAD3D Model Status"
{
    Extensible = true;

    value(0; Draft)
    {
        Caption = 'Draft';
    }
    value(1; "In Review")
    {
        Caption = 'In Review';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }
    value(3; "In Production")
    {
        Caption = 'In Production';
    }
    value(4; Archived)
    {
        Caption = 'Archived';
    }
}
