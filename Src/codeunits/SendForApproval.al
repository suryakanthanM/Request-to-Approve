codeunit 55808 "ApprovalSending Management"
{
    procedure CreateBatchTemplate(var AssetExpenseDetailP: Record "Asset Expense detail")
    var
        GenLedgerSetupL: Record "General Ledger Setup";
        FABatchTemp: Record "FA Journal Batch";
        SalesReceiSetup: Record "Sales & Receivables Setup";
        FixedAssetL: Record "Fixed Asset";

    begin
        AssetExpenseDetailP.FindSet();
        GenLedgerSetupL.Get();
        SalesReceiSetup.Get();
        FixedAssetL.Get(AssetExpenseDetailP."No.");

        if not FABatchTemp.Get(GenLedgerSetupL."FA Journal Template", CopyStr(AssetExpenseDetailP."No.", 1, 10))
        then begin
            FABatchTemp.Init();
            FABatchTemp.Validate("Journal Template Name", GenLedgerSetupL."FA Journal Template");
            FABatchTemp.Validate(Name, CopyStr(AssetExpenseDetailP."No.", 1, 10));
            FABatchTemp.Insert(true);
            FABatchTemp.Validate(Description, FixedAssetL.Description);
            FABatchTemp."No. Series" := SalesReceiSetup."Fixed Asset Nos";
            FABatchTemp.Recurring := true;
            FABatchTemp.Modify();
        end;
    end;

    procedure SendForApproval(var AssetExpenseDetailP: Record "Asset Expense detail")
    var
        FAJnlLineL: Record "FA Journal Line";
        FAJnlLine2L: Record "FA Journal Line";
        GenLedgerSetupL: Record "General Ledger Setup";
        SalesReceiSetup: Record "Sales & Receivables Setup";
        FixedAssetL: Record "Fixed Asset";
        NoSeries: Codeunit "No. Series";
        DocumentNoL: Code[20];
        AccountNoL: Text[30];
        LineNoL: Integer;
        AlreadysendError: Label 'Nothing to Send for Approval';
        RecordinPaymentJnl: Label 'Selected Records already sent for Approval';
    begin
        DocumentNoL := '';
        LineNoL := 0;
        GenLedgerSetupL.Get();
        SalesReceiSetup.Get();
        FixedAssetL.Get(AssetExpenseDetailP."No.");
        GenLedgerSetupL.TestField("FA Journal Template");
        GenLedgerSetupL.TestField("FA Journal Batch");
        SalesReceiSetup.TestField("Fixed Asset Nos");

        DocumentNoL := NoSeries.GetNextNo(SalesReceiSetup."Fixed Asset Nos", Today);

        FAJnlLineL.Reset();
        FAJnlLineL.SetRange("Journal Template Name", GenLedgerSetupL."FA Journal Template");
        // GenJnlLineL.SetRange("Journal Batch Name", ExpensesRequestP.Job);//>> Due to the Size of Data type >>
        FAJnlLineL.SetRange("Journal Batch Name", CopyStr(AssetExpenseDetailP."No.", 1, 10));
        if FAJnlLineL.FindLast() then
            LineNoL := FAJnlLineL."Line No." + 10000
        else
            LineNoL := 10000;
        if AssetExpenseDetailP.FindSet() then
            repeat
                if not AssetExpenseDetailP.Approved then begin
                    if not AlreadySentForApproval(AssetExpenseDetailP) then begin
                        FAJnlLineL.Init();
                        FAJnlLineL.Validate("Journal Template Name", GenLedgerSetupL."FA Journal Template");
                        // GenJnlLineL.Validate("Journal Batch Name", ExpensesRequestP.Job);//>> Due to the Size of Data type >>
                        FAJnlLineL.Validate("Journal Batch Name", CopyStr(AssetExpenseDetailP."No.", 1, 10));

                        FAJnlLineL."Line No." := LineNoL;
                        FAJnlLineL.Validate("Document Type", FAJnlLineL."Document Type"::Invoice);
                        FAJnlLineL.Validate("Document No.", DocumentNoL);
                        FAJnlLineL.Validate("FA No.", AssetExpenseDetailP."No.");
                        // FAJnlLineL.Validate("Account No.", ExpensesRequestP."No.");
                        // FAJnlLineL.Validate(Description, ExpensesRequestP.Description);
                        // FAJnlLineL.Validate(Remarks, ExpensesRequestP.Remarks);

                        FAJnlLineL.Validate("Posting Date", Today);
                        FAJnlLineL.Validate(Description, FixedAssetL.Description);
                        FAJnlLineL.Validate(Amount, AssetExpenseDetailP."Service Cost");
                        FAJnlLineL."FA Expenses ID" := AssetExpenseDetailP.RecordId;
                        FAJnlLineL.Insert(true);
                        LineNoL += 10000;

                    end;
                end
                else
                    Error('Selected Record is Already Rejected');


            until AssetExpenseDetailP.Next() = 0
        else
            Error(AlreadySendError);
    end;

    procedure AlreadySentForApproval(var AssetExpenseDetailP: Record "Asset Expense detail"): Boolean
    var
        FAJnlLineL: Record "FA Journal Line";
    begin
        FAJnlLineL.SetRange("FA Expenses ID", AssetExpenseDetailP.RecordId);
        if FAJnlLineL.IsEmpty() then
            exit(false);
        exit(true);
    end;


    procedure CreateBatchTemplateTracking(var TrackingDetailsp: Record "Tracking Detail")
    var
        GenLedgerSetupL: Record "General Ledger Setup";
        FABatchTemp: Record "FA Journal Batch";
        SalesReceiSetup: Record "Sales & Receivables Setup";
        FixedAssetL: Record "Fixed Asset";

    begin
        TrackingDetailsp.FindSet();
        GenLedgerSetupL.Get();
        SalesReceiSetup.Get();
        FixedAssetL.Get(TrackingDetailsp."No.");

        if not FABatchTemp.Get(GenLedgerSetupL."FA Journal Template", CopyStr(TrackingDetailsp."No.", 1, 10))
        then begin
            FABatchTemp.Init();
            FABatchTemp.Validate("Journal Template Name", GenLedgerSetupL."FA Journal Template");
            FABatchTemp.Validate(Name, CopyStr(TrackingDetailsp."No.", 1, 10));
            FABatchTemp.Insert(true);
            FABatchTemp.Validate(Description, FixedAssetL.Description);
            FABatchTemp."No. Series" := SalesReceiSetup."Fixed Asset Tracking Nos";
            FABatchTemp.Recurring := true;
            FABatchTemp.Modify();
        end;
    end;

    procedure SendForApprovalTracking(var TrackingDetailsp: Record "Tracking Detail")
    var
        FAJnlLineL: Record "FA Journal Line";
        FAJnlLine2L: Record "FA Journal Line";
        GenLedgerSetupL: Record "General Ledger Setup";
        SalesReceiSetup: Record "Sales & Receivables Setup";
        FixedAssetL: Record "Fixed Asset";
        NoSeries: Codeunit "No. Series";
        DocumentNoL: Code[20];
        AccountNoL: Text[30];
        LineNoL: Integer;
        AlreadysendError: Label 'Nothing to Send for Approval';
        RecordinPaymentJnl: Label 'Selected Records already sent for Approval';
    begin
        DocumentNoL := '';
        LineNoL := 0;
        GenLedgerSetupL.Get();
        SalesReceiSetup.Get();
        FixedAssetL.Get(TrackingDetailsp."No.");
        GenLedgerSetupL.TestField("FA Journal Template");
        GenLedgerSetupL.TestField("FA Journal Batch");
        SalesReceiSetup.TestField("Fixed Asset Nos");

        DocumentNoL := NoSeries.GetNextNo(SalesReceiSetup."Fixed Asset Nos", Today);

        FAJnlLineL.Reset();
        FAJnlLineL.SetRange("Journal Template Name", GenLedgerSetupL."FA Journal Template");
        // GenJnlLineL.SetRange("Journal Batch Name", ExpensesRequestP.Job);//>> Due to the Size of Data type >>
        FAJnlLineL.SetRange("Journal Batch Name", CopyStr(TrackingDetailsp."No.", 1, 10));
        if FAJnlLineL.FindLast() then
            LineNoL := FAJnlLineL."Line No." + 10000
        else
            LineNoL := 10000;
        if TrackingDetailsp.FindSet() then
            repeat
                if not TrackingDetailsp.Approved then begin
                    if not AlreadySentForApprovalTracking(TrackingDetailsp) then begin
                        FAJnlLineL.Init();
                        FAJnlLineL.Validate("Journal Template Name", GenLedgerSetupL."FA Journal Template");
                        // GenJnlLineL.Validate("Journal Batch Name", ExpensesRequestP.Job);//>> Due to the Size of Data type >>
                        FAJnlLineL.Validate("Journal Batch Name", CopyStr(TrackingDetailsp."No.", 1, 10));

                        FAJnlLineL."Line No." := LineNoL;
                        FAJnlLineL.Validate("Document Type", FAJnlLineL."Document Type"::Invoice);
                        FAJnlLineL.Validate("Document No.", DocumentNoL);
                        FAJnlLineL.Validate("FA No.", TrackingDetailsp."No.");
                        // FAJnlLineL.Validate("Account No.", ExpensesRequestP."No.");
                        // FAJnlLineL.Validate(Description, ExpensesRequestP.Description);
                        // FAJnlLineL.Validate(Remarks, ExpensesRequestP.Remarks);

                        FAJnlLineL.Validate("Posting Date", Today);
                        FAJnlLineL.Validate(Description, FixedAssetL.Description);
                        // FAJnlLineL.Validate(Amount, TrackingDetailsp."Service Cost");
                        FAJnlLineL."FA Expenses ID" := TrackingDetailsp.RecordId;
                        FAJnlLineL.Insert(true);
                        LineNoL += 10000;

                    end;
                end
                else
                    Error('Selected Record is Already Rejected');


            until TrackingDetailsp.Next() = 0
        else
            Error(AlreadySendError);
    end;

    procedure AlreadySentForApprovalTracking(var TrackingDetailsp: Record "Tracking Detail"): Boolean
    var
        FAJnlLineL: Record "FA Journal Line";
    begin
        FAJnlLineL.SetRange("FA Expenses ID", TrackingDetailsp.RecordId);
        if FAJnlLineL.IsEmpty() then
            exit(false);
        exit(true);
    end;

}
