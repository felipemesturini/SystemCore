unit System.SO.Machine;

interface

type
  TMachine = class sealed
  public
    class function HostName: String;
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils;

{ TMachine }

class function TMachine.HostName: String;
var
  lBuffer: Array [0 .. MAX_PATH] of Char;
  lSize: Cardinal;
begin
  Result := EmptyStr;
  lSize := MAX_PATH;
  if GetComputerName(lBuffer, lSize) then
  begin
    Result := lBuffer;
  end;
end;

end.
