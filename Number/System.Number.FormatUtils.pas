unit System.Number.FormatUtils;

interface

uses
  System.SysUtils,
  System.MaskUtils;

type
  TFormatUtils = class sealed
  private
    class function Digits(const AValue: String): String;
  public
    class function Currency(const AValue: Currency): String;
    class function Decimal(const AValue: Extended): String;
    class function IntegerWithZeros(const AValue: Integer; const AZeros: Byte = 6): String;
    class function CPF(const AValue: String): String;
    class function CNPJ(const AValue: String): String;
    class function IE(const AValue, AEstado: String): String;
    class function Cep(const AValue: String): String;
    class function DocumentNumber(const AValue: Integer): String;
  end;

implementation

uses
  System.Number.StringUtils;

type
  TDocumentosMask = packed record
  public const
    CEP = '';
    CNPJ = '';
    CPF = '';
  end;

{ TStringUtils }

class function TFormatUtils.Cep(const AValue: String): String;
var
  lMaskCep: string;

begin
  lMaskCep := TDocumentosMask.CEP.Substring(0, Pos(';', TDocumentosMask.CEP)) + '0;';
  Result := FormatMaskText(
    lMaskCep,
    Digits(AValue));
end;

class function TFormatUtils.CNPJ(const AValue: String): String;
var
  lMaskCep: string;
begin
  lMaskCep := TDocumentosMask.CNPJ.Substring(0, Pos(';', TDocumentosMask.CNPJ)) + '0;';
  Result := FormatMaskText(
    lMaskCep,
    Digits( AValue ));
end;

class function TFormatUtils.CPF(const AValue: String): String;
var
  lMaskCPF: string;
begin
  if AValue.Length <> 11 then
    raise EArgumentException.Create('CPF informado não é valido');

  lMaskCPF := TDocumentosMask.CPF.Substring(0, Pos(';', TDocumentosMask.CPF)) + '0;';
  Result := FormatMaskText(
    lMaskCPF,
    Digits(AValue));
end;

class function TFormatUtils.Currency(const AValue: Currency): String;
begin
  Result := CurrToStrF(
    AValue,
    TFloatFormat.ffCurrency,
    2);
end;

class function TFormatUtils.Decimal(const AValue: Extended): String;
begin
  Result := FormatFloat(
    '0,.00',
    AValue);
end;

class function TFormatUtils.Digits(const AValue: String): String;
begin
  Result := TStringUtils.NumberOnly(AValue);
end;

class function TFormatUtils.DocumentNumber(const AValue: Integer): String;
begin
  Result := String.Format('%.6d', [AValue]);
end;

class function TFormatUtils.IE(const AValue, AEstado: String): String;
begin
  Result := AValue;
end;

class function TFormatUtils.IntegerWithZeros(const AValue: Integer; const AZeros: Byte = 6): String;
begin
  Result := Format(
    '%.' + AZeros.ToString + 'd',
    [AValue]);
end;

end.
