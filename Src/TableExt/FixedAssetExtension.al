tableextension 55803 FixedAssetExt extends "Fixed Asset"
{
    fields
    {
        field(55801; "No "; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55802; "Type "; Option)
        {
            OptionMembers = " ","Vehicles","TMI","HDD","Spares";
        }
        field(55803; "Make "; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(55804; "TMI Category "; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55805; "Sub Category "; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55806; "Reg No. "; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55807; "Vin\Seriel No. "; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55808; "KM "; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(55809; "Warranty Period "; Date)
        {
            DataClassification = ToBeClassified;
            
        }
        field(55810; "Warranty Till "; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55811; "Insurance Due "; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55812; "Service Due "; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55813; "FC Date "; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55814; "Current Project "; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55815; "Project Responsible "; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55816; "Asset Responsible "; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }



}