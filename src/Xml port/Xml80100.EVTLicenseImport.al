xmlport 80100 "EVT LicenseImport"
{
    Caption = 'License Import';
    Direction = Import;
    Format = Xml;
    schema
    {
        tableelement(Root; "EVT Licensing Setup")
        {
            fieldelement(LicenseNo; Root."License No.")
            {
            }
            fieldelement(TenantID; Root."Tenant Id")
            {
            }
            fieldelement(IssueDate; Root."Issue Date")
            {
            }
            fieldelement(StartingDate; Root."Starting Date")
            {
            }
            fieldelement(ExpirationDate; Root."Expiration Date")
            {
            }
            fieldelement(Module1; Root."Module 1")
            {
            }
            fieldelement(Module2; Root."Module 2")
            {
            }
            fieldelement(Module3; Root."Module 3")
            {
            }
            textelement(PublicKey)
            {
            }
            textelement(Signature)
            {
            }
            trigger OnAfterInsertRecord()
            var
                Setup: Record "EVT Licensing Setup";
                PKOutStr: OutStream;
                SigOutStr: OutStream;
            begin
                if not Setup.Get() then
                    Setup.Insert();
                Setup."License No." := Root."License No.";
                Setup."Tenant Id" := Root."Tenant Id";
                Setup."Issue Date" := Root."Issue Date";
                Setup."Starting Date" := Root."Starting Date";
                Setup."Expiration Date" := Root."Expiration Date";
                Setup."Module 1" := Root."Module 1";
                Setup."Module 2" := Root."Module 2";
                Setup."Module 3" := Root."Module 3";
                Setup.CalcFields(PublicKey);
                Setup.PublicKey.CreateOutStream(PKOutStr);
                PKOutStr.Write(PublicKey);
                Setup.CalcFields(SignatureBase64);
                Setup.SignatureBase64.CreateOutStream(SigOutStr);
                SigOutStr.Write(Signature);
                Setup.Modify();
            end;
        }
    }
}
