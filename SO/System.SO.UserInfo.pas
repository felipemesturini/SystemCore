unit System.SO.UserInfo;

interface

type
  TUserInfo = class sealed
  public
    class function UserName: String;
    class function UserId: Integer;
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils;

{ TUserInfo }

class function TUserInfo.UserId: Integer;
begin
  Result := 1;
end;

class function TUserInfo.UserName: String;
var
  lBuffer: Array [0 .. MAX_PATH] of Char;
  lSize: Cardinal;
begin
  Result := EmptyStr;
  lSize := MAX_PATH;
  if GetUserName(lBuffer, lSize) then
  begin
    Result := lBuffer;
  end;
end;

end.
