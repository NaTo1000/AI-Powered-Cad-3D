/// <summary>
/// Codeunit CAD3D Test Library (ID 50011).
/// Helper functions for test codeunits.
/// </summary>
codeunit 50011 "CAD3D Test Library"
{
    /// <summary>
    /// Initializes CAD3D Setup for testing.
    /// </summary>
    procedure InitializeSetup()
    var
        CAD3DSetup: Record "CAD3D Setup";
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        // Create or update setup
        if not CAD3DSetup.Get() then begin
            CAD3DSetup.Init();
            CAD3DSetup.Insert();
        end;

        // Create number series for models
        if not NoSeries.Get('CAD3D-M-TEST') then begin
            NoSeries.Init();
            NoSeries.Code := 'CAD3D-M-TEST';
            NoSeries.Description := 'CAD3D Model Test';
            NoSeries."Default Nos." := true;
            NoSeries.Insert();

            NoSeriesLine.Init();
            NoSeriesLine."Series Code" := 'CAD3D-M-TEST';
            NoSeriesLine."Line No." := 10000;
            NoSeriesLine."Starting No." := 'TESTM-00001';
            NoSeriesLine."Ending No." := 'TESTM-99999';
            NoSeriesLine."Increment-by No." := 1;
            NoSeriesLine.Insert();
        end;

        // Create number series for projects
        if not NoSeries.Get('CAD3D-P-TEST') then begin
            NoSeries.Init();
            NoSeries.Code := 'CAD3D-P-TEST';
            NoSeries.Description := 'CAD3D Project Test';
            NoSeries."Default Nos." := true;
            NoSeries.Insert();

            NoSeriesLine.Init();
            NoSeriesLine."Series Code" := 'CAD3D-P-TEST';
            NoSeriesLine."Line No." := 10000;
            NoSeriesLine."Starting No." := 'TESTP-00001';
            NoSeriesLine."Ending No." := 'TESTP-99999';
            NoSeriesLine."Increment-by No." := 1;
            NoSeriesLine.Insert();
        end;

        // Update setup with test number series
        CAD3DSetup."Model Nos." := 'CAD3D-M-TEST';
        CAD3DSetup."Project Nos." := 'CAD3D-P-TEST';
        CAD3DSetup."Default Storage Path" := 'C:\TestModels';
        CAD3DSetup."Max File Size (MB)" := 100;
        CAD3DSetup."Supported Formats" := 'STL,OBJ,FBX';
        CAD3DSetup."Enable AI Analysis" := false;
        CAD3DSetup.Modify();
    end;

    /// <summary>
    /// Creates a test model with default values.
    /// </summary>
    /// <returns>Created test model.</returns>
    procedure CreateTestModel(): Record "CAD3D Model"
    var
        CAD3DModel: Record "CAD3D Model";
    begin
        CAD3DModel.Init();
        CAD3DModel.Name := 'Test Model ' + Format(CurrentDateTime());
        CAD3DModel.Description := 'Test model for unit testing';
        CAD3DModel."Model Type" := CAD3DModel."Model Type"::Part;
        CAD3DModel."File Path" := 'C:\TestModels\test.stl';
        CAD3DModel."File Size" := 10.5;
        CAD3DModel."Vertex Count" := 10000;
        CAD3DModel."Polygon Count" := 5000;
        CAD3DModel."Dimensions X" := 50.0;
        CAD3DModel."Dimensions Y" := 50.0;
        CAD3DModel."Dimensions Z" := 50.0;
        CAD3DModel."Material Type" := 'Test Material';
        CAD3DModel.Insert(true);
        exit(CAD3DModel);
    end;

    /// <summary>
    /// Creates a test project with default values.
    /// </summary>
    /// <returns>Created test project.</returns>
    procedure CreateTestProject(): Record "CAD3D Project"
    var
        CAD3DProject: Record "CAD3D Project";
    begin
        CAD3DProject.Init();
        CAD3DProject.Name := 'Test Project ' + Format(CurrentDateTime());
        CAD3DProject.Description := 'Test project for unit testing';
        CAD3DProject."Start Date" := Today();
        CAD3DProject."End Date" := CalcDate('<+3M>', Today());
        CAD3DProject."Total Budget" := 10000.0;
        CAD3DProject.Insert(true);
        exit(CAD3DProject);
    end;

    /// <summary>
    /// Creates a test model with specific project.
    /// </summary>
    /// <param name="ProjectNo">Project number.</param>
    /// <returns>Created test model.</returns>
    procedure CreateTestModelForProject(ProjectNo: Code[20]): Record "CAD3D Model"
    var
        CAD3DModel: Record "CAD3D Model";
    begin
        CAD3DModel := CreateTestModel();
        CAD3DModel."Project No." := ProjectNo;
        CAD3DModel.Modify(true);
        exit(CAD3DModel);
    end;

    /// <summary>
    /// Cleans up test data.
    /// </summary>
    procedure CleanupTestData()
    var
        CAD3DModel: Record "CAD3D Model";
        CAD3DProject: Record "CAD3D Project";
        CAD3DModelVersion: Record "CAD3D Model Version";
    begin
        // Delete test models
        CAD3DModel.SetFilter("No.", 'TESTM-*');
        CAD3DModel.DeleteAll(true);

        // Delete test projects
        CAD3DProject.SetFilter("No.", 'TESTP-*');
        CAD3DProject.DeleteAll(true);

        // Clean up orphaned versions
        CAD3DModelVersion.SetFilter("Model No.", 'TESTM-*');
        CAD3DModelVersion.DeleteAll(true);
    end;

    /// <summary>
    /// Creates multiple test models.
    /// </summary>
    /// <param name="Count">Number of models to create.</param>
    procedure CreateMultipleTestModels(Count: Integer)
    var
        i: Integer;
    begin
        for i := 1 to Count do
            CreateTestModel();
    end;

    /// <summary>
    /// Gets a random model type.
    /// </summary>
    /// <returns>Random model type.</returns>
    procedure GetRandomModelType(): Enum "CAD3D Model Type"
    var
        ModelType: Enum "CAD3D Model Type";
        ModelTypeCount: Integer;
        TypeInt: Integer;
    begin
        // Get count of enum values (7 types: 0-6)
        ModelTypeCount := 7;
        TypeInt := Random(ModelTypeCount);

        case TypeInt of
            0:
                exit(ModelType::Mechanical);
            1:
                exit(ModelType::Architectural);
            2:
                exit(ModelType::Electrical);
            3:
                exit(ModelType::Product);
            4:
                exit(ModelType::Prototype);
            5:
                exit(ModelType::Assembly);
            6:
                exit(ModelType::Part);
        end;
    end;
}
