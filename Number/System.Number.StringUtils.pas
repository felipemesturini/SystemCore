unit System.Number.StringUtils;

interface

uses
  System.RegularExpressions;

type
  TStringUtils = class sealed
  public
    class function NumberOnly(const AValue: String): String;
    class function CorrectPhoneNumber(const AValue: String): String;
    class function CorrectCellPhoneNumber(const AValue: String): String;
    class function GenerateRandomText(ASize: Byte = 60): String;
  end;

implementation

{ TStringUtils }
uses
  System.StrUtils,
  System.SysUtils;

class function TStringUtils.CorrectCellPhoneNumber(const AValue: String): String;
var
  lFone: string;
begin
  lFone := TStringUtils.NumberOnly(AValue);
  if lFone.Trim.IsEmpty then
    Exit(EmptyStr);
  if lFone.Length <= 8 then
  begin
    lFone :=  '549' + lFone;
    lFone := lFone.PadLeft(11, '0');
  end
  else if lFone.Length <= 9 then
  begin
    lFone :=  '54' + lFone;
    lFone := lFone.PadLeft(11, '0');
  end
  else if lFone.Length <= 10 then
  begin
    lFone :=  lFone.Insert(2, '9');
    lFone := lFone.PadLeft(11, '0');
  end;
  Result := RightStr(lFone, 11)
end;

class function TStringUtils.CorrectPhoneNumber(const AValue: String): String;
var
  lFone: string;
begin
  lFone := TStringUtils.NumberOnly(AValue);
  if lFone.Trim.IsEmpty then
    Exit(EmptyStr);
  if lFone.Length < 10 then
  begin
    lFone :=  '54' + lFone;
    lFone := lFone.PadLeft(10, '0');
  end;
  Result := RightStr(lFone, 10)
end;

class function TStringUtils.GenerateRandomText(ASize: Byte = 60): String;
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
    Result := Result +  CHAR_RANDOM.Substring(lIndex, 1);
  end;

end;

class function TStringUtils.NumberOnly(const AValue: String): String;
begin
  Result := TRegEx.Replace(AValue, '\D', '');
end;

end.
