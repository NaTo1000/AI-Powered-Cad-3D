/// <summary>
/// Codeunit CAD3D Model Test (ID 50010).
/// Unit tests for CAD3D Model functionality.
/// </summary>
codeunit 50010 "CAD3D Model Test"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        CAD3DTestLibrary: Codeunit "CAD3D Test Library";
        IsInitialized: Boolean;

    [Test]
    procedure TestCreateModel()
    var
        CAD3DModel: Record "CAD3D Model";
    begin
        // [FEATURE] Model Creation
        // [SCENARIO] User creates a new CAD3D model
        Initialize();

        // [GIVEN] A new model
        CAD3DModel.Init();
        CAD3DModel.Name := 'Test Model';
        CAD3DModel.Description := 'Test Description';
        CAD3DModel."Model Type" := CAD3DModel."Model Type"::Part;

        // [WHEN] Model is inserted
        CAD3DModel.Insert(true);

        // [THEN] Model is created with correct default values
        Assert.AreNotEqual('', CAD3DModel."No.", 'Model number should be assigned');
        Assert.AreEqual(1, CAD3DModel."Version No.", 'Version should be 1');
        Assert.AreEqual(CAD3DModel.Status::Draft, CAD3DModel.Status, 'Status should be Draft');
        Assert.AreEqual(UserId(), CAD3DModel."Created By", 'Created By should be current user');
        Assert.AreEqual(Today(), CAD3DModel."Created Date", 'Created Date should be today');
    end;

    [Test]
    procedure TestModelModificationTracking()
    var
        CAD3DModel: Record "CAD3D Model";
        OriginalModifiedDate: DateTime;
    begin
        // [FEATURE] Audit Trail
        // [SCENARIO] Model modification is tracked
        Initialize();

        // [GIVEN] An existing model
        CAD3DModel := CAD3DTestLibrary.CreateTestModel();
        OriginalModifiedDate := CAD3DModel."Last Modified Date";

        // [WHEN] Model is modified
        Sleep(100); // Ensure time difference
        CAD3DModel.Name := 'Modified Name';
        CAD3DModel.Modify(true);

        // [THEN] Modification tracking fields are updated
        Assert.AreNotEqual(OriginalModifiedDate, CAD3DModel."Last Modified Date", 'Modified date should be updated');
        Assert.AreEqual(UserId(), CAD3DModel."Last Modified By", 'Modified By should be current user');
    end;

    [Test]
    procedure TestModelValidation()
    var
        CAD3DModel: Record "CAD3D Model";
    begin
        // [FEATURE] Data Validation
        // [SCENARIO] Model requires valid name
        Initialize();

        // [GIVEN] A model with empty name
        CAD3DModel.Init();

        // [WHEN] Trying to insert without name
        // [THEN] Error is raised
        asserterror CAD3DModel.Insert(true);
        Assert.ExpectedError(''); // Should fail validation
    end;

    [Test]
    procedure TestModelVersioning()
    var
        CAD3DModel: Record "CAD3D Model";
        CAD3DModelVersion: Record "CAD3D Model Version";
        CAD3DModelMgt: Codeunit "CAD3D Model Management";
    begin
        // [FEATURE] Version Control
        // [SCENARIO] User creates a new version of a model
        Initialize();

        // [GIVEN] An existing model
        CAD3DModel := CAD3DTestLibrary.CreateTestModel();
        Assert.AreEqual(1, CAD3DModel."Version No.", 'Initial version should be 1');

        // [WHEN] A new version is created
        CAD3DModelMgt.CreateVersion(CAD3DModel);

        // [THEN] Version history is created
        CAD3DModelVersion.SetRange("Model No.", CAD3DModel."No.");
        Assert.AreEqual(2, CAD3DModelVersion.Count(), 'Should have 2 versions');

        CAD3DModel.Get(CAD3DModel."No.");
        Assert.AreEqual(2, CAD3DModel."Version No.", 'Model version should be incremented');
    end;

    [Test]
    procedure TestAIAnalysis()
    var
        CAD3DModel: Record "CAD3D Model";
        CAD3DAIMgt: Codeunit "CAD3D AI Management";
    begin
        // [FEATURE] AI Analysis
        // [SCENARIO] User runs AI analysis on a model
        Initialize();
        EnableAIService();

        // [GIVEN] A model without AI analysis
        CAD3DModel := CAD3DTestLibrary.CreateTestModel();
        Assert.IsFalse(CAD3DModel."AI Analyzed", 'Model should not be analyzed initially');

        // [WHEN] AI analysis is run
        CAD3DAIMgt.AnalyzeModel(CAD3DModel);

        // [THEN] AI analysis fields are updated
        Assert.IsTrue(CAD3DModel."AI Analyzed", 'Model should be marked as analyzed');
        Assert.AreNotEqual(0, CAD3DModel."AI Optimization Score", 'Score should be set');
        Assert.AreNotEqual(0DT, CAD3DModel."AI Analysis Date", 'Analysis date should be set');
    end;

    [Test]
    procedure TestModelOptimization()
    var
        CAD3DModel: Record "CAD3D Model";
        CAD3DAIMgt: Codeunit "CAD3D AI Management";
        OriginalPolygonCount: Integer;
        OriginalScore: Decimal;
    begin
        // [FEATURE] AI Optimization
        // [SCENARIO] User optimizes a model using AI
        Initialize();
        EnableAIService();

        // [GIVEN] An analyzed model
        CAD3DModel := CAD3DTestLibrary.CreateTestModel();
        CAD3DModel."Polygon Count" := 100000;
        CAD3DModel.Modify(true);
        CAD3DAIMgt.AnalyzeModel(CAD3DModel);

        OriginalPolygonCount := CAD3DModel."Polygon Count";
        OriginalScore := CAD3DModel."AI Optimization Score";

        // [WHEN] Model is optimized
        CAD3DAIMgt.OptimizeModel(CAD3DModel);

        // [THEN] Model is optimized
        Assert.IsTrue(CAD3DModel."Polygon Count" < OriginalPolygonCount, 'Polygon count should be reduced');
        Assert.IsTrue(CAD3DModel."AI Optimization Score" >= OriginalScore, 'Score should improve');
    end;

    [Test]
    procedure TestCostEstimation()
    var
        CAD3DModel: Record "CAD3D Model";
        CAD3DModelMgt: Codeunit "CAD3D Model Management";
        EstimatedCost: Decimal;
    begin
        // [FEATURE] Cost Estimation
        // [SCENARIO] System calculates estimated cost based on dimensions
        Initialize();

        // [GIVEN] A model with dimensions
        CAD3DModel := CAD3DTestLibrary.CreateTestModel();
        CAD3DModel."Dimensions X" := 100.0;
        CAD3DModel."Dimensions Y" := 100.0;
        CAD3DModel."Dimensions Z" := 100.0;
        CAD3DModel.Modify(true);

        // [WHEN] Cost is estimated
        EstimatedCost := CAD3DModelMgt.CalculateEstimatedCost(CAD3DModel);

        // [THEN] Cost is calculated correctly
        Assert.IsTrue(EstimatedCost > 0, 'Estimated cost should be positive');
        Assert.AreEqual(EstimatedCost, CAD3DModel."Dimensions X" * CAD3DModel."Dimensions Y" * CAD3DModel."Dimensions Z" * 0.0001,
            'Cost calculation should be correct');
    end;

    [Test]
    procedure TestFileFormatValidation()
    var
        CAD3DModelMgt: Codeunit "CAD3D Model Management";
        ValidFilePath: Text[250];
    begin
        // [FEATURE] File Validation
        // [SCENARIO] System validates supported file formats
        Initialize();

        // [GIVEN] A file with supported format
        ValidFilePath := 'C:\Models\test.stl';

        // [WHEN] File is validated
        // [THEN] Validation passes
        Assert.IsTrue(CAD3DModelMgt.ValidateModelFile(ValidFilePath), 'STL format should be valid');

        // [GIVEN] A file with unsupported format
        ValidFilePath := 'C:\Models\test.xyz';

        // [WHEN] File is validated
        // [THEN] Validation fails
        asserterror CAD3DModelMgt.ValidateModelFile(ValidFilePath);
    end;

    [Test]
    procedure TestModelDeletion()
    var
        CAD3DModel: Record "CAD3D Model";
        CAD3DModelVersion: Record "CAD3D Model Version";
        CAD3DModelMgt: Codeunit "CAD3D Model Management";
        ModelNo: Code[20];
    begin
        // [FEATURE] Data Integrity
        // [SCENARIO] Deleting model removes associated versions
        Initialize();

        // [GIVEN] A model with versions
        CAD3DModel := CAD3DTestLibrary.CreateTestModel();
        ModelNo := CAD3DModel."No.";
        CAD3DModelMgt.CreateVersion(CAD3DModel);

        // [WHEN] Model is deleted
        CAD3DModel.Delete(true);

        // [THEN] Versions are also deleted
        CAD3DModelVersion.SetRange("Model No.", ModelNo);
        Assert.IsTrue(CAD3DModelVersion.IsEmpty(), 'Versions should be deleted with model');
    end;

    local procedure Initialize()
    begin
        if IsInitialized then
            exit;

        CAD3DTestLibrary.InitializeSetup();
        IsInitialized := true;
    end;

    local procedure EnableAIService()
    var
        CAD3DSetup: Record "CAD3D Setup";
    begin
        CAD3DSetup.Get();
        CAD3DSetup."Enable AI Analysis" := true;
        CAD3DSetup."AI Service Endpoint" := 'http://localhost:8081/api/analyze';
        CAD3DSetup."AI Service API Key" := 'test-api-key';
        CAD3DSetup.Modify();
    end;
}
