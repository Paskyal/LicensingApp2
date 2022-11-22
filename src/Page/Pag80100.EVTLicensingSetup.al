page 80100 "EVT Licensing Setup"
{
    ApplicationArea = All;
    Caption = 'Licensing Setup';
    PageType = Card;
    SourceTable = "EVT Licensing Setup";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("License No."; Rec."License No.")
                {
                    ToolTip = 'Specifies the value of the License No. field.';
                    ApplicationArea = All;
                }
                field("Tenant Id"; Rec."Tenant Id")
                {
                    ToolTip = 'Specifies the value of the Tenant Id field.';
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ToolTip = 'Specifies the value of the Issue Date field.';
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                    ApplicationArea = All;
                }
                field("Module 1"; Rec."Module 1")
                {
                    ToolTip = 'Specifies the value of the Module 1 field.';
                    ApplicationArea = All;
                }
                field("Module 2"; Rec."Module 2")
                {
                    ToolTip = 'Specifies the value of the Module 2 field.';
                    ApplicationArea = All;
                }
                field("Module 3"; Rec."Module 3")
                {
                    ToolTip = 'Specifies the value of the Module 3 field.';
                    ApplicationArea = All;
                }
                field("License file"; Rec."License File".HasValue)
                {
                    Caption = 'License file';
                    ToolTip = 'Specifies the value of the License file field.';
                    ApplicationArea = All;
                    Visible = false;
                }

                field(PublicKey; Rec.PublicKey.HasValue)
                {
                    ToolTip = 'Specifies the value of the PublicKey field.';
                    Caption = 'Public Key';
                    ApplicationArea = All;
                    visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportLicense)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Imports a License';
                Caption = 'Import License';
                Image = CreateXMLFile;

                trigger OnAction()
                begin
                    Rec.ImportLicense()
                end;
            }
        }
    }
}