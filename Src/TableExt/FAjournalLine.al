tableextension 55812 "FA Journal Line" extends "FA Journal Line"
{
    fields
    {
        field(55801; "FA Expenses ID"; RecordId)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        SendToApprovalEntryCustom(Rec);
    end;

    trigger OnModify()
    begin
        SendToApprovalEntryCustom(Rec);
    end;

    local procedure SendToApprovalEntryCustom(FAJournalLineRec: Record "FA Journal Line")
    var
        ApprovalEntryCustom: Record "Approval Entry Custom";
        RequestToApproveCustomPage: Page "Requests to Approve Custom";
    begin

        ApprovalEntryCustom.Init();
        ApprovalEntryCustom."Record ID to Approve" := FAJournalLineRec.RecordId;
        ApprovalEntryCustom."Approver ID" := UserId;
        ApprovalEntryCustom.Status := ApprovalEntryCustom.Status::Open;
        ApprovalEntryCustom."Due Date" := WorkDate + 7;
        ApprovalEntryCustom."Sender ID" := UserId;

        // RequestToApproveCustomPage.SetToApprove(Format(FAJournalLineRec."Document No.") + ' - ' + FAJournalLineRec.Description);
        ApprovalEntryCustom."Amount" := FAJournalLineRec.Amount;
        ApprovalEntryCustom.Insert();
    end;
}