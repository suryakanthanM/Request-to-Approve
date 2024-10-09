table 55805 "Asset Expense detail"
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
        field(55801; "Place of Maintainance"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(55802; "Type of Maintainance"; Option)
        {
            OptionMembers = "",Services,Regular,Repair;
        }
        field(55803; "Expected Available Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55804; "Service Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55805; CGST; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55806; "SGST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55807; "IGST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55808; "Send for Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55809; "Approval Send Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55810; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55811; "Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55812; "Approved Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55813; Balance; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55814; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(55815; "Line No."; Integer)
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

    local procedure MoveTOFixedAssetJournal(Var AssetExpenseDetailsP: Record "Asset Expense detail")
    var
        FAJournalLineL: Record "FA Journal Line";
    begin
        FAJournalLineL.Init();
        FAJournalLineL."FA Expenses ID" := AssetExpenseDetailsP.RecordID;
        FAJournalLineL.Insert(true);
    end;

    var
        R: Record "Approval Entry";
        A: Page "Requests to Approve";
}