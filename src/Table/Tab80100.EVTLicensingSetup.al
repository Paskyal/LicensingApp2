table 80100 "EVT Licensing Setup"
{
    Caption = 'License Setup';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; PK; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "License No."; Code[20])
        {
            Caption = 'License No.';
            DataClassification = CustomerContent;
        }
        field(3; "Tenant Id"; Text[100])
        {
            Caption = 'Tenant Id';
            DataClassification = CustomerContent;
        }
        field(4; "Issue Date"; Text[50])
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
        }
        field(5; "Starting Date"; Text[50])
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(6; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }

        field(8; "Module 1"; Boolean)
        {
            Caption = 'Module 1';
            DataClassification = CustomerContent;
        }
        field(9; "Module 2"; Boolean)
        {
            Caption = 'Module 2';
            DataClassification = CustomerContent;
        }
        field(10; "Module 3"; Boolean)
        {
            Caption = 'Module 3';
            DataClassification = CustomerContent;
        }
        field(11; "License File"; Blob)
        {
            Caption = 'License File';
            DataClassification = CustomerContent;
        }
        field(14; SignatureBase64; Blob)
        {
            Caption = 'Encrypted Data';
            DataClassification = CustomerContent;
        }
        field(15; PublicKey; Blob)
        {
            Caption = 'PublicKey';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if not Rec.IsEmpty then Rec.Delete();
    end;

    procedure GetAadTenantId(): Text
    var
        AzureADTenant: codeunit "Azure AD Tenant";
    begin
        exit(AzureADTenant.GetAadTenantId());
    end;

    procedure ImportLicense()
    var
        lisenseMgt: codeunit "EVT License Mgt";
        InStr: InStream;
        OutStr: OutStream;
        ExtFilterTxt: label 'Xml Files|*.xml';
        FromFile: Text;
        ImportLicenseTxt: label 'Select a license file';
    begin
        Rec.Init();
        Rec."License File".CreateOutStream(OutStr);
        UploadIntoStream(ImportLicenseTxt, '', ExtFilterTxt, FromFile, InStr);
        Xmlport.Import(Xmlport::"EVT LicenseImport", InStr);
        lisenseMgt.LicenseValidation(Rec);
        CopyStream(OutStr, InStr);
    end;

    procedure GetTenantId(): Text
    begin
        exit(CopyStr(Rec.GetAadTenantId(), 1, MaxStrLen(TenantId())));
    end;
}
