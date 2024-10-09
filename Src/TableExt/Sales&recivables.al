tableextension 55809 "Sales&ReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(55801; "Fixed Asset Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(55802; "Fixed Asset Tracking Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

    }
}


pageextension 55810 "Sales&ReceivablesSetupP" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Fixed Asset Nos"; Rec."Fixed Asset Nos")
            {
                ApplicationArea = All;
            }
            field("Fixed Asset Tracking Nos"; Rec."Fixed Asset Tracking Nos")
            {
                ApplicationArea = All;
            }
        }
    }
}
