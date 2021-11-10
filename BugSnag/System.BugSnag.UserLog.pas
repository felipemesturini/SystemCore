unit System.BugSnag.UserLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types;

type
  TUserLog = class
  private
    FEmail: string;
    FId: Integer;
    FName: string;
  public
    property Id: Integer read FId write FId;
    property Email: string read FEmail write FEmail;
    property Name: string read FName write FName;
  end;

implementation

end.
