unit System.BugSnag.ThreadLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types,
  System.BugSnag.StackTraceLog;

type
  TThreadLog = class
  private
    FErrorReportingThread: Boolean;
    FId: string;
    FName: string;
    [JSONName('stacktrace')]
    FStackTrace: TArray<TStackTraceLog>;
    FType: string;
  public
    property ErrorReportingThread: Boolean read FErrorReportingThread write FErrorReportingThread;
    property Id: string read FId write FId;
    property Name: string read FName write FName;
    property Stacktrace: TArray<TStackTraceLog> read FStackTrace;
    property &Type: string read FType write FType;

    function AddTrace: Integer;

    destructor Destroy; override;
  end;

implementation

{ TThreadLog }

function TThreadLog.AddTrace: Integer;
var
  lIndex: Integer;
begin
  lIndex := Length(FStackTrace) + 1;
  SetLength(FStackTrace, Length(FStackTrace) + 1);
  FStackTrace[lIndex - 1] := TStackTraceLog.Create();
  Result := lIndex - 1;
end;

destructor TThreadLog.Destroy;
var
  lItem: TObject;
begin
  for lItem in FStackTrace do
    lItem.Free;
  SetLength(FStackTrace, 0);
  inherited;
end;

end.
