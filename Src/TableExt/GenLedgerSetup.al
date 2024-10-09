tableextension 55806 GenLedgSetUp extends "General Ledger Setup"
{
    fields
    {
        field(55801; "FA Journal Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FA Journal Template";
        }
        field(55802; "FA Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FA Journal Batch".Name where("Journal Template Name" = field("FA Journal Template"));
        }
    }
}