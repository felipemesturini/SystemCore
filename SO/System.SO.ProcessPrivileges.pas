unit System.SO.ProcessPrivileges;

interface

uses
  Winapi.ShellAPI,
  Winapi.Windows,
  JclSecurity;

type
  TProcessPrivileges = class sealed
  public
    class function HasAdminAccess(): Boolean;
  end;

//function IsUserAnAdmin(): BOOL; external shell32;

implementation

{ TProcessPrivileges }

class function TProcessPrivileges.HasAdminAccess: Boolean;
begin
  Result := IsElevated();

end;

end.
