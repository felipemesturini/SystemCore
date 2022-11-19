unit System.Number.StringUtils;

interface

uses
  System.RegularExpressions;

type
  TStringUtils = class sealed
  public
    class function NumberOnly(const AValue: string): string;
    class function CorrectPhoneNumber(const AValue: string): string;
    class function CorrectCellPhoneNumber(const AValue: string): string;
    class function GenerateRandomText(ASize: Byte = 60): string;
    class function BinaryToInt64(const AValue: string): Int64;
  end;

implementation

{ TStringUtils }
uses
  System.StrUtils,
  System.SysUtils;

class function TStringUtils.CorrectCellPhoneNumber(const AValue: string): string;
var
  lFone: string;
begin
  lFone := TStringUtils.NumberOnly(AValue);
  if lFone.Trim.IsEmpty then
    Exit(EmptyStr);
  if lFone.Length <= 8 then
  begin
    lFone := '549' + lFone;
    lFone := lFone.PadLeft(
      11,
      '0');
  end
  else if lFone.Length <= 9 then
  begin
    lFone := '54' + lFone;
    lFone := lFone.PadLeft(
      11,
      '0');
  end
  else if lFone.Length <= 10 then
  begin
    lFone := lFone.Insert(
      2,
      '9');
    lFone := lFone.PadLeft(
      11,
      '0');
  end;
  Result := RightStr(
    lFone,
    11)
end;

class function TStringUtils.CorrectPhoneNumber(const AValue: string): string;
var
  lFone: string;
begin
  lFone := TStringUtils.NumberOnly(AValue);
  if lFone.Trim.IsEmpty then
    Exit(EmptyStr);
  if lFone.Length < 10 then
  begin
    lFone := '54' + lFone;
    lFone := lFone.PadLeft(
      10,
      '0');
  end;
  Result := RightStr(
    lFone,
    10)
end;

class function TStringUtils.GenerateRandomText(ASize: Byte = 60): string;
const
  CHAR_RANDOM = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  lSize: Integer;
  lIndex: Integer;
begin
  Randomize();
  Result := EmptyStr;
  for lSize := 0 to Pred(ASize) do
  begin
    lIndex := Random(CHAR_RANDOM.Length);
    Result := Result + CHAR_RANDOM.Substring(lIndex, 1);
  end;

end;

class function TStringUtils.NumberOnly(const AValue: string): string;
begin
  Result := TRegEx.Replace(
    AValue,
    '\D',
    '');
end;

class function TStringUtils.BinaryToInt64(const AValue: string): Int64;
var
  lDecimal: Real;
  lIndixador: Integer;
  lExpoente: Integer;
  lLogaritimo: Extended;
begin
  lDecimal := 0.00;
  lExpoente := 0;
  lLogaritimo := Ln(2);
  for lIndixador := AValue.Length downto 1 do
  begin
    lDecimal := lDecimal + (StrToFloat(AValue[lIndixador]) * Exp(lExpoente * lLogaritimo));
    lExpoente := lExpoente + 1;
  end;
  Result := Round(lDecimal);
end;

end.
