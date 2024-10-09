pageextension 55813 FixedAssetJournal extends "Fixed Asset Journal"
{
    layout
    {
        addafter(Description)
        {
            field("FA Expenses ID"; Format(Rec."FA Expenses ID"))
            {
                ApplicationArea = All;
                Editable = false;
                trigger OnDrillDown()
                var
                    AssetExpenseDetailL: Record "Asset Expense detail";
                    AssetTrackingDetailL: Record "Tracking Detail";

                begin
                    if AssetExpenseDetailL.Get(Rec."FA Expenses ID") then
                        Page.Run(55805, AssetExpenseDetailL)
                    else if AssetTrackingDetailL.Get(Rec."FA Expenses ID") then
                        Page.Run(55806, AssetTrackingDetailL);
                end;
            }
        }
    }

}