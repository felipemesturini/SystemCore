unit System.BugSnag.CodeLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types;

type
  TCodeLog = class
  private
    FLine: string;
  public
    property Line: string read FLine write FLine;
  end;

implementation

end.
