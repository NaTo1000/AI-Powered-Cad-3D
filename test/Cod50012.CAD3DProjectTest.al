/// <summary>
/// Codeunit CAD3D Project Test (ID 50012).
/// Unit tests for CAD3D Project functionality.
/// </summary>
codeunit 50012 "CAD3D Project Test"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        CAD3DTestLibrary: Codeunit "CAD3D Test Library";
        IsInitialized: Boolean;

    [Test]
    procedure TestCreateProject()
    var
        CAD3DProject: Record "CAD3D Project";
    begin
        // [FEATURE] Project Creation
        // [SCENARIO] User creates a new CAD3D project
        Initialize();

        // [GIVEN] A new project
        CAD3DProject.Init();
        CAD3DProject.Name := 'Test Project';
        CAD3DProject.Description := 'Test Description';

        // [WHEN] Project is inserted
        CAD3DProject.Insert(true);

        // [THEN] Project is created with correct default values
        Assert.AreNotEqual('', CAD3DProject."No.", 'Project number should be assigned');
        Assert.AreEqual(CAD3DProject.Status::Planning, CAD3DProject.Status, 'Status should be Planning');
        Assert.AreEqual(UserId(), CAD3DProject."Created By", 'Created By should be current user');
        Assert.AreEqual(Today(), CAD3DProject."Created Date", 'Created Date should be today');
    end;

    [Test]
    procedure TestProjectWithModels()
    var
        CAD3DProject: Record "CAD3D Project";
        CAD3DModel: Record "CAD3D Model";
        ModelCount: Integer;
    begin
        // [FEATURE] Project-Model Relationship
        // [SCENARIO] Project tracks number of associated models
        Initialize();

        // [GIVEN] A project with models
        CAD3DProject := CAD3DTestLibrary.CreateTestProject();
        CAD3DTestLibrary.CreateTestModelForProject(CAD3DProject."No.");
        CAD3DTestLibrary.CreateTestModelForProject(CAD3DProject."No.");
        CAD3DTestLibrary.CreateTestModelForProject(CAD3DProject."No.");

        // [WHEN] Model count is calculated
        CAD3DProject.CalcFields("No. of Models");

        // [THEN] Correct count is returned
        Assert.AreEqual(3, CAD3DProject."No. of Models", 'Should have 3 models');
    end;

    [Test]
    procedure TestProjectStatusTransition()
    var
        CAD3DProject: Record "CAD3D Project";
    begin
        // [FEATURE] Status Management
        // [SCENARIO] Project status transitions through lifecycle
        Initialize();

        // [GIVEN] A new project
        CAD3DProject := CAD3DTestLibrary.CreateTestProject();
        Assert.AreEqual(CAD3DProject.Status::Planning, CAD3DProject.Status, 'Initial status should be Planning');

        // [WHEN] Status is changed to Active
        CAD3DProject.Status := CAD3DProject.Status::Active;
        CAD3DProject.Modify(true);

        // [THEN] Status is updated
        CAD3DProject.Get(CAD3DProject."No.");
        Assert.AreEqual(CAD3DProject.Status::Active, CAD3DProject.Status, 'Status should be Active');

        // [WHEN] Status is changed to Completed
        CAD3DProject.Status := CAD3DProject.Status::Completed;
        CAD3DProject.Modify(true);

        // [THEN] Status is updated
        CAD3DProject.Get(CAD3DProject."No.");
        Assert.AreEqual(CAD3DProject.Status::Completed, CAD3DProject.Status, 'Status should be Completed');
    end;

    [Test]
    procedure TestProjectModificationTracking()
    var
        CAD3DProject: Record "CAD3D Project";
        OriginalModifiedDate: DateTime;
    begin
        // [FEATURE] Audit Trail
        // [SCENARIO] Project modification is tracked
        Initialize();

        // [GIVEN] An existing project
        CAD3DProject := CAD3DTestLibrary.CreateTestProject();
        OriginalModifiedDate := CAD3DProject."Last Modified Date";

        // [WHEN] Project is modified
        Sleep(100); // Ensure time difference
        CAD3DProject.Name := 'Modified Name';
        CAD3DProject.Modify(true);

        // [THEN] Modification tracking fields are updated
        Assert.AreNotEqual(OriginalModifiedDate, CAD3DProject."Last Modified Date", 'Modified date should be updated');
        Assert.AreEqual(UserId(), CAD3DProject."Last Modified By", 'Modified By should be current user');
    end;

    [Test]
    procedure TestProjectBudgetTracking()
    var
        CAD3DProject: Record "CAD3D Project";
    begin
        // [FEATURE] Budget Management
        // [SCENARIO] Project tracks budget and actual costs
        Initialize();

        // [GIVEN] A project with budget
        CAD3DProject := CAD3DTestLibrary.CreateTestProject();
        CAD3DProject."Total Budget" := 50000.0;
        CAD3DProject.Modify(true);

        // [WHEN] Actual costs are updated
        CAD3DProject."Actual Cost" := 25000.0;
        CAD3DProject.Modify(true);

        // [THEN] Budget is tracked correctly
        Assert.AreEqual(50000.0, CAD3DProject."Total Budget", 'Budget should be 50000');
        Assert.AreEqual(25000.0, CAD3DProject."Actual Cost", 'Actual cost should be 25000');
        Assert.IsTrue(CAD3DProject."Actual Cost" <= CAD3DProject."Total Budget", 'Should be under budget');
    end;

    local procedure Initialize()
    begin
        if IsInitialized then
            exit;

        CAD3DTestLibrary.InitializeSetup();
        IsInitialized := true;
    end;
}
