table 55804 "Tracking Detail"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(55799; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55800; Date; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(55801; Project; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(55802; "Project Location"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(55803; "Project Period"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55804; "Project Responsible Person"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource;

        }
        field(55805; "Asset Responsible Person"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger OnValidate()
            var
                TrackingDetailL: Record "Tracking Detail";
            begin
                if "Line No." > 10000 then begin
                    TrackingDetailL.Get("No.", "Line No." - 10000);
                    TrackingDetailL."Asset Handover To" := "Asset Responsible Person";
                    TrackingDetailL."Asset Handover Date" := Today;
                    TrackingDetailL.Modify();
                end;
            end;
        }
        field(55806; "Asset Handover Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55807; "Asset Handover To"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55808; "Approval Sent Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55809; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55810; "Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55811; "Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55812; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }

    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
            clustered = true;
        }
    }

}