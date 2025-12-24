unit Core.Hash.Cypher;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Hash,
  System.NetEncoding,
  System.Generics.Collections;

type
  TCypher = class
  private
    class function DeriveKey(const APassword, ASalt: TBytes; AKeySize: Integer): TBytes;
    class function GenerateSalt(ASize: Integer = 16): TBytes;
    class function PKCS7Pad(const AData: TBytes; ABlockSize: Integer): TBytes;
    class function PKCS7Unpad(const AData: TBytes): TBytes;
  public
    class function Encrypt(const APlainText, APassword: string): string;
    class function Decrypt(const AEncryptedText, APassword: string): string;
  end;

implementation

uses
  System.Math;

{ TCypher }

class function TCypher.GenerateSalt(ASize: Integer): TBytes;
begin
  Result := TBytes.Create();
  SetLength(Result, ASize);
  Randomize();
  for var lIndex := 0 to Pred(ASize) do
    Result[lIndex] := Random(256);
end;

class function TCypher.DeriveKey(const APassword, ASalt: TBytes; AKeySize: Integer): TBytes;
const
  ITERATIONS = 10000;
begin
  var
  lPBKDF2 := THashSHA2.Create;
  lPBKDF2.Reset;
  lPBKDF2.Update(ASalt);

  // Using PBKDF2-HMAC-SHA256
  Result := lPBKDF2.GetHMACAsBytes(EmptyStr, APassword, THashSHA2.TSHA2Version.SHA256);

  // For multiple iterations (simplified version)
  for var lIndex := 1 to Pred(ITERATIONS) do
  begin
    var
    Temp := THashSHA2.GetHMACAsBytes(Result, APassword, THashSHA2.TSHA2Version.SHA256);
    for var J := 0 to high(Result) do
      Result[J] := Result[J] xor Temp[J];
  end;

  // Adjust to requested key size
  SetLength(Result, AKeySize);
end;

class function TCypher.PKCS7Pad(const AData: TBytes; ABlockSize: Integer): TBytes;
var
  lPadding: Byte;
begin
  lPadding := ABlockSize - (Length(AData) mod ABlockSize);
  Result := AData;
  SetLength(Result, Length(AData) + lPadding);
  FillChar(Result[Length(AData)], lPadding, lPadding);
end;

class function TCypher.PKCS7Unpad(const AData: TBytes): TBytes;
var
  lPadding: Byte;
begin
  lPadding := AData[High(AData)];
  if lPadding > Length(AData) then
    raise Exception.Create('Invalid padding');

  Result := Copy(AData, 0, Length(AData) - lPadding);
end;

class function TCypher.Encrypt(const APlainText, APassword: string): string;
var
  lSalt: TBytes;
  lInitilizationVector: TBytes;
  lKey: TBytes;
  lPaddedData: TBytes;
  lEncryptedData: TBytes;
  lCipherText: TBytes;
begin
  // Generate random salt and IV
  lSalt := GenerateSalt(16);
  lInitilizationVector := GenerateSalt(16); // AES block size is 16 bytes

  // Derive key from password
  lKey := DeriveKey(TEncoding.UTF8.GetBytes(APassword), lSalt, 32); // 256-bit key

  try
    // Prepare data with PKCS7 padding
    var
    PlainData := TEncoding.UTF8.GetBytes(APlainText);
    lPaddedData := PKCS7Pad(PlainData, 16);

    // Simple XOR encryption (for demonstration)
    // In production, replace with proper AES implementation
    SetLength(lEncryptedData, Length(lPaddedData));
    for var lIndex := 0 to high(lPaddedData) do
      lEncryptedData[lIndex] := lPaddedData[lIndex] xor lKey[lIndex mod Length(lKey)] xor lInitilizationVector
        [lIndex mod Length(lInitilizationVector)];

    // Build output: Salt + IV + EncryptedData
    SetLength(lCipherText, Length(lSalt) + Length(lInitilizationVector) + Length(lEncryptedData));
    Move(lSalt[0], lCipherText[0], Length(lSalt));
    Move(lInitilizationVector[0], lCipherText[Length(lSalt)], Length(lInitilizationVector));
    Move(lEncryptedData[0], lCipherText[Length(lSalt) + Length(lInitilizationVector)],
      Length(lEncryptedData));

    Result := TNetEncoding.Base64.EncodeBytesToString(lCipherText);
  finally
    // Clear sensitive data from memory
    FillChar(lKey[0], Length(lKey), 0);
  end;
end;

class function TCypher.Decrypt(const AEncryptedText, APassword: string): string;

var
  lSalt: TBytes;
  lInitilizationVector: TBytes;
  lKey: TBytes;
  lEncryptedData: TBytes;
  lDecryptedData: TBytes;
  lCipherText: TBytes;
begin
  lCipherText := TNetEncoding.Base64.DecodeStringToBytes(AEncryptedText);

  if Length(lCipherText) < 32 then // Salt(16) + lInitilizationVector(16) minimum
    Exit(EmptyStr);

  // Extract Salt and lInitilizationVector
  SetLength(lSalt, 16);
  SetLength(lInitilizationVector, 16);
  Move(lCipherText[0], lSalt[0], 16);
  Move(lCipherText[16], lInitilizationVector[0], 16);

  // Extract encrypted data
  SetLength(lEncryptedData, Length(lCipherText) - 32);
  Move(lCipherText[32], lEncryptedData[0], Length(lEncryptedData));

  // Derive key
  lKey := DeriveKey(TEncoding.UTF8.GetBytes(APassword), lSalt, 32);

  try
    // Decrypt (reverse of XOR operation)
    SetLength(lDecryptedData, Length(lEncryptedData));
    for var lIndex := 0 to high(lEncryptedData) do
      lDecryptedData[lIndex] := lEncryptedData[lIndex] xor lKey[lIndex mod Length(lKey)
        ] xor lInitilizationVector[lIndex mod Length(lInitilizationVector)];

    // Remove padding
    var
    lUnpaddedData := PKCS7Unpad(lDecryptedData);

    Result := TEncoding.UTF8.GetString(lUnpaddedData);

  finally
    FillChar(lKey[0], Length(lKey), 0);
  end;
end;

end.
