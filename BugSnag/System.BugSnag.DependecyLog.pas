unit System.BugSnag.DependecyLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types;

type
  TDependecyLog = class
  private
    [JSONName('name')]
    FName: string;
    [JSONName('url')]
    FUrl: string;
    [JSONName('version')]
    FVersion: string;
  public
    property Name: string read FName write FName;
    property Url: string read FUrl write FUrl;
    property Version: string read FVersion write FVersion;
  end;

implementation

end.
