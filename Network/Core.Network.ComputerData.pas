unit Core.Network.ComputerData;

interface

uses
  IdStackWindows;

type
  TComputerData = packed record
  public
    class function IpByName(const AIpAddress: string): string; static;
  end;

implementation

uses
  System.SysUtils;

{ TComputerData }

class function TComputerData.IpByName(const AIpAddress: string): string;
var
  lIdStackWin: TIdStackWindows;
begin
  lIdStackWin := TIdStackWindows.Create;
  try
    Result := EmptyStr;
    if lIdStackWin.IsIP(AIpAddress) then
    begin
      try
        Result := lIdStackWin.HostByAddress(AIpAddress);
      except
        Result := AIpAddress;
      end;
    end;
  finally
    lIdStackWin.Free;
  end;
end;

end.
