page 55806 "Tracking Details"
{
    ApplicationArea = All;
    Caption = 'Asset Tracking Details';
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Tracking Detail";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Project; Rec.Project)
                {
                    ToolTip = 'Specifies the value of the Project field.', Comment = '%';
                }
                field("Project Location"; Rec."Project Location")
                {
                    ToolTip = 'Specifies the value of the Project Location field.', Comment = '%';
                }
                field("Project Period"; Rec."Project Period")
                {
                    ToolTip = 'Specifies the value of the Project Peried field.', Comment = '%';
                }
                field("Project Responsible Person"; Rec."Project Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Project Person field.', Comment = '%';
                }
                field("Asset Responsible Person"; Rec."Asset Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Asset Person field.', Comment = '%';
                }
                field("Asset Handover Date"; Rec."Asset Handover Date")
                {
                    ToolTip = 'Specifies the value of the Asset Handover Date field.', Comment = '%';
                }
                field("Asset Handover To"; Rec."Asset Handover To")
                {
                    ToolTip = 'Specifies the value of the Asset Handover To field.', Comment = '%';
                }
                field("Approval Sent Date"; Rec."Approval Sent Date")
                {
                    ToolTip = 'Specifies the value of the Approval Sent Date field.', Comment = '%';
                }
                field(Approved; Rec.Approved)
                {
                    ToolTip = 'Specifies the value of the Approved field.', Comment = '%';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.', Comment = '%';
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ToolTip = 'Specifies the value of the Approved Date field.', Comment = '%';
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
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TrackingDetailsL: Record "Tracking Detail";
                    ApprovalEntryCustom: Record "Approval Entry Custom";
                begin
                    // Retrieve the selected records from the page
                    CurrPage.SetSelectionFilter(TrackingDetailsL);

                    if TrackingDetailsL.FindSet() then begin
                        repeat
                            // Insert new record into "Approval Entry Custom"
                            ApprovalEntryCustom.Init();
                            ApprovalEntryCustom."Table ID" := Database::"Tracking Detail";
                            ApprovalEntryCustom.Details := TrackingDetailsL.RecordId;
                            ApprovalEntryCustom."Sender ID" := UserId;
                            ApprovalEntryCustom."Approver ID" := UserId;
                            ApprovalEntryCustom.Status := ApprovalEntryCustom.Status::Open;
                            ApprovalEntryCustom."Document Type" := ApprovalEntryCustom."Document Type"::"Fixed Asset";
                            // ApprovalEntryCustom."Amount" := TrackingDetailsL.; // Map the amount
                            // ApprovalEntryCustom."Currency Code" := TrackingDetailsL."Currency Code"; 
                            ApprovalEntryCustom.Insert(); // Insert the record

                        until TrackingDetailsL.Next() = 0;
                    end;

                    Message('Approval Request has been sent successfully.');
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
