pageextension 55807 "GenLedgSetupP" extends "General Ledger Setup"
{
    layout
    {
        addafter("Shortcut Dimension 8 Code")
        {
            field("FA Journal Template"; Rec."FA Journal Template")
            {
                ApplicationArea = All;
            }
            field("FA Journal Batch"; Rec."FA Journal Batch")
            {
                ApplicationArea = All;
            }
        }
    }
}