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
                    // Visible = false;
                }

                field(PublicKey; Rec.PublicKey.HasValue)
                {
                    ToolTip = 'Specifies the value of the PublicKey field.';
                    Caption = 'Public Key';
                    ApplicationArea = All;
                    visible = false;
                    // trigger OnAssistEdit()
                    // var
                    //     Selected: Integer;
                    //     PubKeyInStr: InStream;
                    //     PubKeyOutStr: OutStream;
                    //     PubKeyInStr2: InStream;
                    //     Notice: text;
                    //     FileName: Text;
                    //     Options: Text[30];
                    //     ToFile: Text;
                    // begin
                    //     Options := OptionsImportDownloadLbl;
                    //     Selected := Dialog.StrMenu(Options, 1, ChooseOptionLbl);
                    //     if Selected = 1 then begin
                    //         Notice := KeyImportedLbl;
                    //         UploadIntoStream(SelectPubKeyTxt, '', ExtFilterTxt, FileName, PubKeyInStr);
                    //         Rec.PublicKey.CreateOutStream(PubKeyOutStr);
                    //         CopyStream(PubKeyOutStr, PubKeyInStr);
                    //         Message(Notice, Selected)
                    //     end;
                    //     if Selected = 2 then begin
                    //         Notice := KeyDownloadedLbl;
                    //         Rec.CalcFields(PublicKey);
                    //         Rec.PublicKey.CreateInStream(PubKeyInStr2);
                    //         ToFile := 'Public Key.xml';
                    //         DownloadFromStream(PubKeyInStr2, 'Dialog', '', '', ToFile);
                    //         Message(Notice);
                    //     end;
                    // end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Actions")
            {
                action(Import)
                {
                    Image = Import;
                    Caption = 'Import';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Import from Stream action.';
                    // Promoted = true;
                    // PromotedOnly = true;
                    // PromotedCategory = Process;
                    // PromotedIsBig = true;
                    trigger OnAction()
                    var
                        InStr: InStream;
                    begin
                        Rec.CalcFields("License File");
                        Rec."License File".CreateInStream(InStr);
                        Xmlport.Import(Xmlport::"EVT LicenseImport", InStr);
                        // Message(SuccessLbl);
                    end;
                }
                action(GetTenantID)
                {
                    Image = Info;
                    Caption = 'Get tenant ID';
                    ApplicationArea = All;
                    // Promoted = true;
                    // PromotedOnly = true;
                    // PromotedCategory = Process;
                    // PromotedIsBig = true;
                    ToolTip = 'Executes the Tenant ID action.';
                    // trigger OnAction()
                    // var
                    //     TenantId: Text[150];
                    //     EmtyTenantLbl: label 'Empty Tenant ID';
                    // begin
                    //     TenantId := CopyStr(Rec.GetAadTenantId(), 1, MaxStrLen(TenantId));
                    //     if TenantId = '' then
                    //         Message(EmtyTenantLbl);
                    //     Rec.Validate("Tenant Id", TenantId);
                    //     CurrPage.Update(true);
                    // end;
                }
            }
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

    var
        KeyImportedLbl: label 'You Imported a Public Key';
        KeyDownloadedLbl: label 'You Imported a Public Key';
        ExtFilterTxt: label 'Xml Files|*.xml';
        SelectPubKeyTxt: label 'Select a Public Key file';
        SelectPrivKeyTxt: label 'Select a Private Key file';
        PrivKeyImportedLbl: label 'You Imported a Private Key';
        ChooseOptionLbl: label 'Choose one of the following options:';
        OptionsImportDownloadLbl: label 'Import,Download';
        OptionImportLbl: label 'Import';
}