unit System.BugSnag.ExceptionLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types,
  System.BugSnag.StackTraceLog;

type
  TExceptionLog = class
  private
    FErrorClass: string;
    FMessage: string;
    [JSONName('stacktrace')]
    FStacktrace: TArray<TStackTraceLog>;
    FType: string;
  public
    property ErrorClass: string read FErrorClass write FErrorClass;
    property Message: string read FMessage write FMessage;
    property Stacktrace: TArray<TStackTraceLog> read FStacktrace;
    property &Type: string read FType write FType;
    constructor Create; overload;
    destructor Destroy; override;

    function AddStack: Integer;
  end;

implementation

{ TExceptionLog }

constructor TExceptionLog.Create;
begin
  inherited;
  SetLength(FStacktrace, 0);
end;

destructor TExceptionLog.Destroy;
var
  lItem: TObject;
begin
  for lItem in FStacktrace do
    lItem.Free;
  SetLength(FStacktrace, 0);
  inherited;
end;

function TExceptionLog.AddStack: Integer;
var
  lIndex: Integer;
begin
  lIndex := Length(FStacktrace) + 1;
  SetLength(FStacktrace, Length(FStacktrace) + 1);
  FStacktrace[lIndex - 1] := TStackTraceLog.Create();
  Result := lIndex - 1;
end;

end.
