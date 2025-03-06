unit System.Formatters.FormatDocsUtils;

interface

uses
  System.SysUtils,
  System.MaskUtils;

type
  TFormatDocsUtils = class sealed
  public
    class function CPF(const AValue: String): String;
    class function CNPJ(const AValue: String): String;
    class function CEP(const AValue: String): String;
  end;

implementation

type
  TDocumentosMask = packed record
  public const
    CEP = '00\.000\-000;0;';
    CNPJ = '00\.000\.000\/0000\-00;0;*';
    CPF = '000\.000\.000\-00;0;*';
  end;

{ TFormatDocsUtils }

class function TFormatDocsUtils.CNPJ(const AValue: String): String;
var
  lMaskCep: string;
begin
  if AValue.Length <> 14 then
    raise EArgumentException.CreateFmt('Parametro AValue (%s) deve ter 14 digitos', [AValue]);

  lMaskCep :=  TDocumentosMask.CNPJ;
  Result := FormatMaskText(
    lMaskCep,
    AValue);
end;

class function TFormatDocsUtils.CPF(const AValue: String): String;
var
  lMaskCPF: string;
begin
  if AValue.Length <> 11 then
    raise EArgumentException.CreateFmt('Parametro AValue (%s) deve ter 11 digitos', [AValue]);

  lMaskCPF := TDocumentosMask.CPF;
  Result := FormatMaskText(
    lMaskCPF,
    AValue);
end;

class function TFormatDocsUtils.CEP(const AValue: String): String;
var
  lMaskCEP: string;
begin
  if AValue.Length <> 8 then
    raise EArgumentException.CreateFmt('Parametro AValue (%s) deve ter 8 digitos', [AValue]);

  lMaskCEP := TDocumentosMask.CEP;
  Result := FormatMaskText(
    lMaskCEP,
    AValue);
end;

end.
