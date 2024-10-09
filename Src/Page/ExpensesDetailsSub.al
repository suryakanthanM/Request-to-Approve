page 55805 "Asset Expense Details"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Asset Expense Detail";
    AutoSplitKey = true;
    LinksAllowed = true;
    InsertAllowed = true;
    Editable = true;
    DeleteAllowed = true;


    layout
    {
        area(Content)
        {
            repeater("Expenses Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Place of Maintainance"; Rec."Place of Maintainance")
                {
                    ApplicationArea = All;
                }
                field("Type of Maintainance"; Rec."Type of Maintainance")
                {
                    ApplicationArea = All;
                }
                field("Expected Available Date"; Rec."Expected Available Date")
                {
                    ApplicationArea = All;
                }
                field("Service Cost"; Rec."Service Cost")
                {
                    ApplicationArea = All;
                }
                field(CGST; Rec.CGST)
                {
                    ApplicationArea = All;
                }
                field(SGST; Rec.SGST)
                {
                    ApplicationArea = All;
                }
                field(IGST; Rec.IGST)
                {
                    ApplicationArea = All;
                }
                field("Send for Approval"; Rec."Send for Approval")
                {
                    ApplicationArea = All;
                }
                field("Approval Send Date"; Rec."Approval Send Date")
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approved Cost"; Rec."Approved Cost")
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    Actions
    {
        area(Processing)
        {
            action("Send for Approvals")
            {
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    AssetExpenseDetailsRec: Record "Asset Expense detail";
                    ApprovalEntryCustomRec: Record "Approval Entry Custom";
                begin
                    CurrPage.SetSelectionFilter(AssetExpenseDetailsRec); 

                    if AssetExpenseDetailsRec.FindSet() then begin
                        repeat
                            ApprovalEntryCustomRec.Init();
                            ApprovalEntryCustomRec."Table ID" := DATABASE::"Asset Expense detail";
                            ApprovalEntryCustomRec.Details := AssetExpenseDetailsRec.RecordId;
                            ApprovalEntryCustomRec."Amount" := AssetExpenseDetailsRec."Service Cost";
                            ApprovalEntryCustomRec."Sender ID" := UserId;
                            ApprovalEntryCustomRec."Approver ID" := UserId;
                            ApprovalEntryCustomRec."Document Type" := ApprovalEntryCustomRec."Document Type"::"Fixed Asset";
                            ApprovalEntryCustomRec."Status" := ApprovalEntryCustomRec.Status::Open;
                            ApprovalEntryCustomRec.Insert();
                        until AssetExpenseDetailsRec.Next() = 0;
                        Message('Approval Request has been sent successfully');
                    end;
                end;
            }
        }

    }

    trigger OnModifyRecord(): Boolean
    var
        FixedAssetRec: Record "Fixed Asset";
    begin

        if FixedAssetRec.Get(Rec."No.") then begin

            if (FixedAssetRec."Warranty Period " = 0D) or
               (FixedAssetRec."Warranty Till " = 0D) or
               (FixedAssetRec."Insurance Due " = 0D) or
               (FixedAssetRec."FC Date " = 0D) then begin
                Error('You cannot edit the Tracking Details because one or more mandatory fields are missing on the Fixed Asset Card. ' +
                    'Please fill in the Warranty Period, Warranty Till, Insurance Due, and FC Date.');
            end;
        end;
        exit(true);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        FixedAssetRec: Record "Fixed Asset";
    begin

        if FixedAssetRec.Get(Rec."No.") then begin
            if (FixedAssetRec."Warranty Period " = 0D) or
               (FixedAssetRec."Warranty Till " = 0D) or
               (FixedAssetRec."Insurance Due " = 0D) or
               (FixedAssetRec."FC Date " = 0D) then begin
                Error('You cannot insert a Tracking Detail because one or more mandatory fields are missing on the Fixed Asset Card. ' +
                    'Please fill in the Warranty Period, Warranty Till, Insurance Due, and FC Date.');
            end;
        end;
        exit(true);
    end;
}