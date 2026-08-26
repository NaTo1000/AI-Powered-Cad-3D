/// <summary>
/// Permission sets for CAD3D application roles.
/// </summary>
permissionset 50000 "CAD3D ADMIN"
{
    Assignable = true;
    Caption = 'CAD3D Administrator';

    Permissions =
        tabledata "CAD3D Model" = RIMD,
        tabledata "CAD3D Project" = RIMD,
        tabledata "CAD3D Setup" = RIMD,
        tabledata "CAD3D Model Version" = RIMD,
        page "CAD3D Model Card" = X,
        page "CAD3D Model List" = X,
        page "CAD3D Project Card" = X,
        page "CAD3D Project List" = X,
        page "CAD3D Model Version List" = X,
        page "CAD3D Setup" = X,
        codeunit "CAD3D AI Management" = X,
        codeunit "CAD3D Model Management" = X;
}

permissionset 50001 "CAD3D USER"
{
    Assignable = true;
    Caption = 'CAD3D User';

    Permissions =
        tabledata "CAD3D Model" = RIM,
        tabledata "CAD3D Project" = RIM,
        tabledata "CAD3D Setup" = R,
        tabledata "CAD3D Model Version" = RIM,
        page "CAD3D Model Card" = X,
        page "CAD3D Model List" = X,
        page "CAD3D Project Card" = X,
        page "CAD3D Project List" = X,
        page "CAD3D Model Version List" = X,
        codeunit "CAD3D AI Management" = X,
        codeunit "CAD3D Model Management" = X;
}
