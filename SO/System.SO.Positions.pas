unit System.SO.Positions;

interface

uses
  System.Types;


type
  TScreenSize = packed record
  private
    FHeight: Integer;
    FWidth: Integer;

    function GetHeight: Integer;
    procedure SetHeight(const AValue: Integer);
    function GetWidth: Integer;
    procedure SetWidth(const AValue: Integer);
  public
    property Height: Integer read GetHeight write SetHeight;
    property Width: Integer read GetWidth write SetWidth;

    constructor Create(AHeight, AWidth: Integer);
  end;

type
  TPositions = class sealed
  public
    class function ScreenSize: TScreenSize;
    class function CalculatePosition(AScreenSize, AElementSize: TScreenSize): TPoint;
  end;

implementation

uses
  Winapi.Windows;

{ TPositions }

class function TPositions.CalculatePosition(AScreenSize, AElementSize: TScreenSize): TPoint;
begin
  Result := TPoint.Zero;
  Result.Y := Abs((AScreenSize.Height div 2) - (AElementSize.Height div 2));
  Result.X := Abs((AScreenSize.Width div 2) - (AElementSize.Width div 2));
end;

class function TPositions.ScreenSize: TScreenSize;
var
  lHeight: Integer;
  lWidth: Integer;
begin
  lHeight := GetSystemMetrics(SM_CYFULLSCREEN);
  lWidth := GetSystemMetrics(SM_CXFULLSCREEN);
  Result := TScreenSize.Create(lHeight, lWidth);
end;

{ TScreenSize }

constructor TScreenSize.Create(AHeight, AWidth: Integer);
begin
  SetHeight(AHeight);
  SetWidth(AWidth);
end;

function TScreenSize.GetHeight: Integer;
begin
  Result := FHeight;
end;

function TScreenSize.GetWidth: Integer;
begin
  Result := FWidth;
end;

procedure TScreenSize.SetHeight(const AValue: Integer);
begin
  if AValue >= 0 then
    FHeight := AValue;
end;

procedure TScreenSize.SetWidth(const AValue: Integer);
begin
  if AValue >= 0 then
    FWidth := AValue;

end;

end.
