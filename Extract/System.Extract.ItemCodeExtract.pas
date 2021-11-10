unit System.Extract.ItemCodeExtract;

interface

type
  TItemCodedata = record
  public
    Codigo: String;
    Quantidade: Extended;
    Balanca: Boolean;
    constructor Create(const ACodigo: String; AQuantidade: Extended; ABalanca: Boolean); reintroduce;
  end;

  TItemCodeExtract = class sealed
  private
    class function ExtractCodigoBalanca(const ACodigo: String): String;
    class function ExtractPesoBalanca(const ACodigo: String): Extended;
    class function ExtractCodigoGTIN(const ACodigo: String): String;
    class function ExtractQuantidade(const ACodigo: String): Extended; static;
  public
    class function ExtractCodigo(const ACodigo: String): TItemCodedata;
  end;

implementation

{ TItemCodeExtract }

uses
  System.SysUtils,
  System.StrUtils,
  System.AnsiStrings;

class function TItemCodeExtract.ExtractCodigo(const ACodigo: String): TItemCodedata;
var
  lCodigo: string;
  lCodigoBalanca: string;
  lQuantidade: Extended;
begin
  lCodigo := ACodigo;
  if ACodigo.ToUpper.Contains('X') then
    lCodigo := lCodigo.Remove(0, ACodigo.ToUpper.IndexOf('X') + 1);
  lCodigoBalanca := ExtractCodigoBalanca(lCodigo);
  if lCodigoBalanca <> EmptyStr then
    lCodigo := lCodigoBalanca;
  lQuantidade := ExtractQuantidade(ACodigo);
  Result := TItemCodedata.Create(lCodigo, lQuantidade, lCodigoBalanca.Trim <> EmptyStr);
end;

class function TItemCodeExtract.ExtractCodigoBalanca(const ACodigo: String): String;
var
  lCodigoBalanca: string;
begin
  Result := '';
  if (ACodigo.StartsWith('2')) and (ACodigo.Length = 13) then
  begin
    lCodigoBalanca := ACodigo.Substring(
      1,
      12);
    Result := lCodigoBalanca.Substring(
      0,
      6);
    // lValorBalanca := Copy(lCodigoBalanca, 7, 3) + ',' + Copy(lCodigoBalanca, 10, 2);
    // lCodigoProdutoBalancaString := TRotinas.OnlyNum(lCodigoProdutoBalanca);
    // PrecoBalanca := StrToFloat(lValorBalanca);
    // edtCod.Text := lCodigoProdutoBalancaString;
  end;

end;

class function TItemCodeExtract.ExtractCodigoGTIN(const ACodigo: String): String;
begin
  Result := ''
end;

class function TItemCodeExtract.ExtractPesoBalanca(const ACodigo: String): Extended;
var
  lCodigoBalanca: string;
begin
  Result := 0;
  if (ACodigo.StartsWith('2')) and (ACodigo.Length = 13) then
  begin
    lCodigoBalanca := ACodigo.Substring(
      1,
      12);
    // lValorBalanca := Copy(lCodigoBalanca, 7, 3) + ',' + Copy(lCodigoBalanca, 10, 2);
    // lCodigoProdutoBalancaString := TRotinas.OnlyNum(lCodigoProdutoBalanca);
    // PrecoBalanca := StrToFloat(lValorBalanca);
    // edtCod.Text := lCodigoProdutoBalancaString;
  end;

end;

class function TItemCodeExtract.ExtractQuantidade(const ACodigo: String): Extended;
var
  lValor: string;
//  lQuantidadeBalanca: Extended;
begin
  Result := 1.00;
//  lQuantidadeBalanca := ExtractPesoBalanca(ACodigo);

  if ACodigo.ToUpper.Contains('X') then
  begin
    lValor := System.StrUtils.LeftStr(
      ACodigo,
      ACodigo.ToUpper.IndexOf('X'));
    Result := StrToFloatDef(
      lValor,
      1.00);
  end;

end;

{ TItemCodedata }

constructor TItemCodedata.Create(const ACodigo: String; AQuantidade: Extended; ABalanca: Boolean);
begin
  Self.Codigo := ACodigo;
  Self.Quantidade := AQuantidade;
  Self.Balanca := ABalanca;
end;

end.
