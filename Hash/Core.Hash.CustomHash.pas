unit Core.Hash.CustomHash;

interface

type
  TCustomHash = record
  public
    class function EncodeValue(const AValue: String; const AKey: String = '12dc56de5007d4569efe558a83a3b0c1'): String; static;
    class function DecodeValue(const AValue: String; const AKey: String = '12dc56de5007d4569efe558a83a3b0c1'): String; static;
  end;

implementation

uses
  System.Math,
  System.Hash,
  JvCipher, System.SysUtils;

{ TCustomHash }

class function TCustomHash.DecodeValue(const AValue: String; const AKey: String = '12dc56de5007d4569efe558a83a3b0c1'): String;
var
  lCipher: TJvVigenereCipher;
begin
  Result := '';
  if (AKey = '') then
    raise EInvalidArgument.Create('AKey must have a value');
  lCipher := TJvVigenereCipher.Create(nil);
  try
    lCipher.Key := AnsiString(AKey);
    lCipher.Encoded := AnsiString(AValue);
    Result := String(lCipher.Decoded);
  finally
    FreeAndNil(lCipher);
  end;

end;

class function TCustomHash.EncodeValue(const AValue: String; const AKey: String = '12dc56de5007d4569efe558a83a3b0c1'): String;
var
  lCipher: TJvVigenereCipher;
begin
  Result := '';
  if (AKey = '') then
    raise EInvalidArgument.Create('AKey must have a value');

  lCipher := TJvVigenereCipher.Create(nil);
  try
    lCipher.Key := AnsiString(AKey);
    lCipher.Decoded := AnsiString(AValue);
    Result := String(lCipher.Encoded);
  finally
    FreeAndNil(lCipher);
  end;

end;

end.
