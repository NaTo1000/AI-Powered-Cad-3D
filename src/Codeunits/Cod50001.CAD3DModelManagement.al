/// <summary>
/// Codeunit CAD3D Model Management (ID 50001).
/// Handles model version control and file operations.
/// </summary>
codeunit 50001 "CAD3D Model Management"
{
    /// <summary>
    /// Creates a new version of a CAD model.
    /// </summary>
    /// <param name="CAD3DModel">The model to version.</param>
    procedure CreateVersion(var CAD3DModel: Record "CAD3D Model")
    var
        CAD3DModelVersion: Record "CAD3D Model Version";
        NewVersionNo: Integer;
        VersionDescription: Text[250];
    begin
        // Find the highest version number
        CAD3DModelVersion.SetRange("Model No.", CAD3DModel."No.");
        if CAD3DModelVersion.FindLast() then
            NewVersionNo := CAD3DModelVersion."Version No." + 1
        else
            NewVersionNo := 1;

        // Prompt for version description
        VersionDescription := '';
        if not Confirm('Create version %1 for model %2?', true, NewVersionNo, CAD3DModel."No.") then
            exit;

        // Create new version record
        CAD3DModelVersion.Init();
        CAD3DModelVersion."Model No." := CAD3DModel."No.";
        CAD3DModelVersion."Version No." := NewVersionNo;
        CAD3DModelVersion."Version Description" := VersionDescription;
        CAD3DModelVersion."File Path" := CAD3DModel."File Path";
        CAD3DModelVersion."File Size" := CAD3DModel."File Size";
        CAD3DModelVersion."Change Type" := CAD3DModelVersion."Change Type"::"Major Update";
        CAD3DModelVersion.Insert(true);

        // Update model version number
        CAD3DModel."Version No." := NewVersionNo;
        CAD3DModel.Modify(true);

        Message('Version %1 created successfully.', NewVersionNo);
    end;

    /// <summary>
    /// Validates model file before import.
    /// </summary>
    /// <param name="FilePath">The file path to validate.</param>
    /// <returns>True if file is valid.</returns>
    procedure ValidateModelFile(FilePath: Text[250]): Boolean
    var
        CAD3DSetup: Record "CAD3D Setup";
        FileExtension: Text[10];
        SupportedFormats: List of [Text];
        Format: Text;
    begin
        if not CAD3DSetup.Get() then
            exit(true); // If setup doesn't exist, allow all formats

        // Extract file extension
        FileExtension := GetFileExtension(FilePath);

        // Split supported formats
        SupportedFormats := CAD3DSetup."Supported Formats".Split(',');

        foreach Format in SupportedFormats do begin
            if UpperCase(Format.Trim()) = UpperCase(FileExtension) then
                exit(true);
        end;

        exit(false);
    end;

    local procedure GetFileExtension(FilePath: Text[250]): Text[10]
    var
        DotPos: Integer;
    begin
        DotPos := FilePath.LastIndexOf('.');
        if DotPos > 0 then
            exit(CopyStr(FilePath, DotPos + 1));
        exit('');
    end;

    /// <summary>
    /// Calculates estimated cost based on model dimensions and material.
    /// </summary>
    /// <param name="CAD3DModel">The model to calculate cost for.</param>
    /// <returns>Estimated cost.</returns>
    procedure CalculateEstimatedCost(var CAD3DModel: Record "CAD3D Model"): Decimal
    var
        Volume: Decimal;
        CostPerCubicMm: Decimal;
    begin
        // Calculate volume in cubic millimeters
        Volume := CAD3DModel."Dimensions X" * CAD3DModel."Dimensions Y" * CAD3DModel."Dimensions Z";

        // Default cost per cubic mm (this would come from material pricing in production)
        CostPerCubicMm := 0.0001;

        exit(Volume * CostPerCubicMm);
    end;
}
