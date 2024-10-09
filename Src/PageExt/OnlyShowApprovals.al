// pageextension 55801 "Request to Approve Ext" extends "Requests to Approve"
// {
//     actions
//     {
//         addafter(Query)
//         {
//             action("Open Payment Journal for Approval")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Only Open Records';
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = Approve;
//                 ToolTip = 'Open the Payment Journal and filter it to show only lines that require approval.';

//                 trigger OnAction()
//                 var
//                     GenJournalLinePage: Page "Payment Journal";
//                     GenJournalLine: Record "Gen. Journal Line";
//                 begin
//                     // Get the related Gen. Journal Line records
//                     GenJournalLine.SetRange("Document No.", Rec."Document No.");
//                     GenJournalLine.SetRange("Pending Approval", true);
//                     GenJournalLine.SetRange("Pending Approval", false);

//                     // Open the Payment Journal page with the filtered records
//                     GenJournalLinePage.SetTableView(GenJournalLine);
//                     GenJournalLinePage.Run();
//                 end;
//             }
//         }
//     }
// }