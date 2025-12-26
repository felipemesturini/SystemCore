unit System.SO.ProcessPrivileges;

interface

uses
  Winapi.ShellAPI,
  Winapi.Windows;

type
  TProcessPrivileges = class sealed
  public
    class function HasAdminAccess(): Boolean;
  end;

  // function IsUserAnAdmin(): BOOL; external shell32;

implementation

{ TProcessPrivileges }

class function TProcessPrivileges.HasAdminAccess: Boolean;
var
  lProcess: THandle;
  lToken: THandle;
  lTokenInformation: TTokenElevation;
  lPointerTokenInformation: Pointer;
  lReturnLength: DWORD;
begin
  Result := False;
  lProcess := GetCurrentProcess;

  try
    if OpenProcessToken(lProcess, TOKEN_QUERY, lToken) then
      try
        FillChar(lTokenInformation, SizeOf(lTokenInformation), 0);
        lPointerTokenInformation := @lTokenInformation;
        GetTokenInformation(lToken, TokenElevation,
          lPointerTokenInformation, SizeOf(lTokenInformation),
          lReturnLength);
        Result := (lTokenInformation.TokenIsElevated <> 0);
      finally
        CloseHandle(lToken);
      end;

  except

  end;
end;

end.
