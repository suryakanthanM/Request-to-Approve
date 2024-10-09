pageextension 55805 FixedAssetExts extends "Fixed Asset card"
{
    layout
    {
        addafter(Description)
        {
            field("No "; Rec."No ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Type; Rec."Type ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Make; Rec."Make ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("TMI Category"; Rec."TMI Category ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sub Category"; Rec."Sub Category ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Reg No."; Rec."Reg No. ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Vin\Seriel No."; Rec."Vin\Seriel No. ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Km; Rec."KM ")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(General)
        {
            field("Warranty Peried "; Rec."Warranty Period ")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Warranty Till "; Rec."Warranty Till ")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Insurance Due "; Rec."Insurance Due ")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Service Due "; Rec."Service Due ")
            {
                ApplicationArea = All;
            }
            field("FC Date "; Rec."FC Date ")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("Current Project "; Rec."Current Project ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Project Responsible "; Rec."Project Responsible ")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Asset Responsible "; Rec."Asset Responsible ")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(General)
        {
            part("Tracking Details"; "Tracking Details")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                UpdatePropagation = Both;


            }
            part("Asset Expense details"; "Asset Expense details")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        TrackingDetailsL: Record "Tracking Detail";
    begin
        TrackingDetailsL.SetRange("No.", Rec."No.");
        if TrackingDetailsL.FindLast() then begin
            Rec."Project Responsible " := TrackingDetailsL."Project Responsible Person";
            Rec."Asset Responsible " := TrackingDetailsL."Asset Responsible Person";

        end;
        CurrPage.Update();
    end;

}