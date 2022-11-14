codeunit 80100 "EVT License Mgt"
{
    procedure LicenseValidation(var Rec: Record "EVT Licensing Setup")
    var
        Convert: codeunit "Base64 Convert";
        CryptographyManagement: codeunit "Cryptography Management";
        TempBlob: codeunit "Temp Blob";
        PubKeyInStr: InStream;
        SignatureInStr: InStream;
        SignatureBase64InStr: InStream;
        SignatureOutStr: OutStream;
        HashAlgorithm: enum "Hash Algorithm";
        InputString: Text;
        PubKeyBase64: Text;
        PubKeyXmlString: Text;
        SignatureBase64Txt: Text;
        NotVerifiedLbl: label 'Not Verified';
        VerifiedLbl: label 'Verified';
    begin
        Rec.FindFirst();
        if Rec.GetTenantId() <> Rec."Tenant Id" then
            Error(WrongTenantIdErr) else
            if Rec."Expiration Date" >= Today then begin
                Rec.CalcFields(PublicKey);
                Rec.PublicKey.CreateInStream(PubKeyInStr);
                PubKeyInStr.Read(PubKeyBase64);
                PubKeyXmlString := Convert.FromBase64(PubKeyBase64);

                InputString := Rec."Tenant Id" + Format(Rec."Expiration Date");

                Rec.CalcFields(SignatureBase64);
                Rec.SignatureBase64.CreateInStream(SignatureBase64InStr);
                SignatureBase64InStr.Read(SignatureBase64Txt);
                TempBlob.CreateOutStream(SignatureOutStr);
                Convert.FromBase64(SignatureBase64Txt, SignatureOutStr);
                TempBlob.CreateInStream(SignatureInStr);
                if CryptographyManagement.VerifyData(InputString, PubKeyXmlString, HashAlgorithm::SHA256, SignatureInStr) then
                    Message(VerifiedLbl) else
                    Message(NotVerifiedLbl);
            end else
                Error(LicenseIsExpiredErr);

    end;

    var
        WrongTenantIdErr: label 'Tenant Id doesn''t match';
        LicenseIsExpiredErr: label 'The License is expired';
}
