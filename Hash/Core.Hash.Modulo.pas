unit Core.Hash.Modulo;

interface

type
  TModulo = record
  public
    class function Modulo10(const AValue: string): string; static;
    class function Modulo11(const AValue: string): string; static;
  end;

implementation

uses
  System.Math,
  System.Hash,
  System.SysUtils;

{ TModulo }

class function TModulo.Modulo10(const AValue: string): string;
const
  BASE = 9;
var
  lSoma: integer;
  lContador, lPeso, lDigito: integer;
begin
  lSoma := 0;
  lPeso := 2;

  for lContador := Length(AValue) downto 1 do
  begin
    lSoma := lSoma + (StrToInt(AValue[lContador]) * lPeso);
    if lPeso < BASE then
      lPeso := lPeso + 1
    else
      lPeso := 2;
  end;

  lDigito := 10 - (lSoma mod 10);

  if (lDigito > 9) then
    lDigito := 0;

  Result := IntToStr(lDigito);
end;

class function TModulo.Modulo11(const AValue: string): string;
const
  BASE = 9;
var
  lSoma: integer;
  lContador, lPeso, lDigito: integer;
begin
  lSoma := 0;
  lPeso := 2;

  for lContador := Length(AValue) downto 1 do
  begin
    lSoma := lSoma + (StrToInt(AValue[lContador]) * lPeso);
    if lPeso < BASE then
      lPeso := lPeso + 1
    else
      lPeso := 2;
  end;

  lDigito := 11 - (lSoma mod 11);

  if (lDigito > 9) then
    lDigito := 0;

  Result := IntToStr(lDigito);
end;

end.
