unit System.Validation.DocumentUtils;

interface

type
  TDocumentUtils = class sealed
  public
    class function ValidCNPJ(const AValue: String): Boolean;
    class function ValidCPF(const AValue: String): Boolean;
    class function ValidIE(const AValue: String): Boolean;
    class function ValidCep(const AValue: String): Boolean;
    class function ValidEmail(const AValue: String): Boolean;
    class function ValidIp(const AValue: String): Boolean;
  end;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.Number.StringUtils,
  System.RegularExpressions;

{ TDocumentUtils }

class function TDocumentUtils.ValidCep(const AValue: String): Boolean;
begin
  Result := TStringUtils.NumberOnly(AValue).Trim.Length = 8;
end;

class function TDocumentUtils.ValidCNPJ(const AValue: String): Boolean;
var
  lCnpjNumbers: string;
  lDigits: Char;
  lAllNumberEquals: string;
  lSum: Integer;
  lIndex: Integer;
  lDigitOne: Integer;
  lDigitTwo: Integer;
begin
  lCnpjNumbers := TStringUtils.NumberOnly(AValue);
  if (TStringUtils.NumberOnly(lCnpjNumbers).Trim.IsEmpty) then
    Exit(True);
  if lCnpjNumbers.Length <> 14 then
    Exit(False);

  for lDigits in '0123456789' do begin
    lAllNumberEquals := StringOfChar(lDigits, 14);
    if lCnpjNumbers.Equals(lAllNumberEquals) then
      Exit(False);
  end;
  if lCnpjNumbers.Length <> 14 then
    Exit(False);

  lSum := 0;
  for lIndex := 1 to 12 do begin
    if lIndex < 5 then
      Inc(lSum, StrToIntDef(Copy(lCnpjNumbers, lIndex, 1), 0) * (6 - lIndex))
    else
      Inc(lSum, StrToIntDef(Copy(lCnpjNumbers, lIndex, 1), 0) * (14 - lIndex))
  end;
  lDigitOne := 11 - (lSum mod 11);
  if lDigitOne > 9 then
    lDigitOne := 0;
  { 2° digito }
  lSum := 0;
  for lIndex := 1 to 13 do begin
    if lIndex < 6 then
      Inc(lSum, StrToIntDef(Copy(lCnpjNumbers, lIndex, 1), 0) * (7 - lIndex))
    else
      Inc(lSum, StrToIntDef(Copy(lCnpjNumbers, lIndex, 1), 0) * (15 - lIndex))
  end;
  lDigitTwo := 11 - (lSum mod 11);
  if lDigitTwo > 9 then
    lDigitTwo := 0;
  { Checa os dois dígitos }
  if (lDigitOne = StrToIntDef(Copy(lCnpjNumbers, 13, 1), 0)) and (lDigitTwo = StrToIntDef(Copy(lCnpjNumbers, 14, 1), 0)) then
    Result := True
  else
    Result := False;

end;

class function TDocumentUtils.ValidCPF(const AValue: String): Boolean;
var
  lCpfDigits: string;
  lDigito: Integer;
  lCpf: String;
  lSum: Integer;
  lIndex: Integer;
  lDigit1: Integer;
  lDigit2: Integer;
begin
  lCpfDigits := TStringUtils.NumberOnly(AValue);
  if (TStringUtils.NumberOnly(lCpfDigits).Trim.IsEmpty) then
    Exit(True);
  if lCpfDigits.Length <> 11 then
    Exit(False);

  for lDigito := 0 to 9 do begin
    lCpf := StringOfChar(lDigito.ToString.Chars[0], 11);
    if (lCpfDigits.Equals(lCpf)) then begin
      Exit(False);
    end;
  end;
  Result := False;
  lSum := 0;
  for lIndex := 1 to 9 do
    Inc(lSum, StrToIntDef(Copy(lCpfDigits, 10 - lIndex, 1), 0) * (lIndex + 1));
  lDigit1 := 11 - (lSum mod 11);
  if lDigit1 > 9 then
    lDigit1 := 0;
  { 2° digito }
  lSum := 0;
  for lIndex := 1 to 10 do
    Inc(lSum, StrToIntDef(Copy(lCpfDigits, 11 - lIndex, 1), 0) * (lIndex + 1));
  lDigit2 := 11 - (lSum mod 11);
  if lDigit2 > 9 then
    lDigit2 := 0;
  { Checa os dois dígitos }
  if (lDigit1 = StrToIntDef(Copy(lCpfDigits, 10, 1), 0)) and (lDigit2 = StrToIntDef(Copy(lCpfDigits, 11, 1), 0)) then
    Result := True;
end;

class function TDocumentUtils.ValidEmail(const AValue: String): Boolean;
const
  EMAIL_REGEX = '^((?>[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+\x20*|"((?=[\x01-\x7f])' + '[^"\\]|\\[\x01-\x7f])*"\x20*)*(?<angle><))?((?!\.)' +
    '(?>\.?[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+)+|"((?=[\x01-\x7f])' + '[^"\\]|\\[\x01-\x7f])*")@(((?!-)[a-zA-Z\d\-]+(?<!-)\.)+[a-zA-Z]' +
    '{2,}|\[(((?(?<!\[)\.)(25[0-5]|2[0-4]\d|[01]?\d?\d))' + '{4}|[a-zA-Z\d\-]*[a-zA-Z\d]:((?=[\x01-\x7f])[^\\\[\]]|\\' +
    '[\x01-\x7f])+)\])(?(angle)>)$';
begin
  Result := TRegEx.IsMatch(AValue, EMAIL_REGEX);
end;

class function TDocumentUtils.ValidIE(const AValue: String): Boolean;
begin
  Result := True;
end;

class function TDocumentUtils.ValidIp(const AValue: String): Boolean;
const
  EMAIL_EMAIL = '\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' + '\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.' +
    '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.' + '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b';
begin
  Result := TRegEx.IsMatch(AValue, EMAIL_EMAIL);
end;

end.
