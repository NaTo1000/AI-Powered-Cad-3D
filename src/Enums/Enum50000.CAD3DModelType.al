/// <summary>
/// Enum CAD3D Model Type (ID 50000).
/// Defines the type of CAD 3D model.
/// </summary>
enum 50000 "CAD3D Model Type"
{
    Extensible = true;

    value(0; Mechanical)
    {
        Caption = 'Mechanical';
    }
    value(1; Architectural)
    {
        Caption = 'Architectural';
    }
    value(2; Electrical)
    {
        Caption = 'Electrical';
    }
    value(3; Product)
    {
        Caption = 'Product Design';
    }
    value(4; Prototype)
    {
        Caption = 'Prototype';
    }
    value(5; Assembly)
    {
        Caption = 'Assembly';
    }
    value(6; Part)
    {
        Caption = 'Part';
    }
}
