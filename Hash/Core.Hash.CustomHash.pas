unit Core.Hash.CustomHash;

interface

type
  TCustomHash = record
  public
    class function EncodeValue(
      const AValue: string;
      const AKey: string = '12dc56de5007d4569efe558a83a3b0c1'): string; static;
    class function DecodeValue(
      const AValue: string;
      const AKey: string = '12dc56de5007d4569efe558a83a3b0c1'): string; static;
  end;

implementation

uses
  System.Math,
  System.Hash,
  JvCipher,
  System.SysUtils;

{ TCustomHash }

class function TCustomHash.DecodeValue(
  const AValue: string;
  const AKey: string = '12dc56de5007d4569efe558a83a3b0c1'): string;
var
  i: Byte;
  StartKey, MultKey, AddKey: Word;
begin
  Result := '';
  StartKey := Length(AKey);
  MultKey := Ord(AKey[1]);
  AddKey := 0;
  for i := 1 to Length(AKey) - 1 do
    AddKey := AddKey + Ord(AKey[i]);
  for i := 1 to Length(AValue) do
  begin
    Result := Result + CHAR(Byte(AValue[i]) xor (StartKey shr 8));
    StartKey := (Byte(Result[i]) + StartKey) * MultKey + AddKey;
  end;
end;

class function TCustomHash.EncodeValue(
  const AValue: string;
  const AKey: string = '12dc56de5007d4569efe558a83a3b0c1'): string;
var
  i: Byte;
  StartKey, MultKey, AddKey: Word;
begin
  Result := '';
  StartKey := Ord(AKey[1]);
  MultKey := Length(AKey);
  AddKey := 0;
  for i := 1 to Length(AKey) - 1 do
    AddKey := AddKey + Ord(AKey[i]);
  for i := 1 to Length(AValue) do
  begin
    Result := Result + CHAR(Byte(AValue[i]) xor (StartKey shr 8));
    StartKey := (Byte(AValue[i]) + StartKey) * MultKey + AddKey;
  end;
end;

end.
