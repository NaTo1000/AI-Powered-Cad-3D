/// <summary>
/// Enum CAD3D Change Type (ID 50003).
/// Defines the type of change in model version.
/// </summary>
enum 50003 "CAD3D Change Type"
{
    Extensible = true;

    value(0; "Minor Update")
    {
        Caption = 'Minor Update';
    }
    value(1; "Major Update")
    {
        Caption = 'Major Update';
    }
    value(2; "Bug Fix")
    {
        Caption = 'Bug Fix';
    }
    value(3; "Feature Addition")
    {
        Caption = 'Feature Addition';
    }
    value(4; "Design Revision")
    {
        Caption = 'Design Revision';
    }
}
