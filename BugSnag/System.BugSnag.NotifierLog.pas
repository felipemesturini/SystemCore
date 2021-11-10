unit System.BugSnag.NotifierLog;

interface

uses
  System.Generics.Collections,
  System.BugSnag.DependecyLog,
  REST.Json.Types;

type
  TNotifierLog = class
  private
    FName: string;
    FVersion: string;
    FUrl: string;
    [JSONName('dependencies')]
    FDependencies: TArray<TDependecyLog>;
  public
    property Dependencies: TArray<TDependecyLog> read FDependencies;
    property Name: string read FName write FName;
    property Url: string read FUrl write FUrl;
    property Version: string read FVersion write FVersion;

    function AddDependency: Integer;

    destructor Destroy; override;
    constructor Create;
  end;

implementation

{ TNotifierLog }

function TNotifierLog.AddDependency: Integer;
var
  lIndex: Integer;
begin
  lIndex := Length(FDependencies) + 1;
  SetLength(FDependencies, Length(FDependencies) + 1);
  FDependencies[lIndex - 1] := TDependecyLog.Create();
  Result := lIndex - 1;
end;

constructor TNotifierLog.Create;
begin
  inherited;
  SetLength(FDependencies, 0);
end;

destructor TNotifierLog.Destroy;
var
  lItem: TObject;
begin
  for lItem in FDependencies do
    lItem.Free;
  SetLength(FDependencies, 0);
  inherited;
end;

end.
