unit System.BugSnag.StackTraceLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types,
  System.BugSnag.CodeLog;

type
  TStackTraceLog = class
  private
    FCode: TCodeLog;
    FColumnNumber: Integer;
    [JSONName('file')]
    FFileName: string;
    FInProject: Boolean;
    FLineNumber: Integer;
    FMethod: string;
  public
    property Code: TCodeLog read FCode write FCode;
    property ColumnNumber: Integer read FColumnNumber write FColumnNumber;
    property FileName: string read FFileName write FFileName;
    property InProject: Boolean read FInProject write FInProject;
    property LineNumber: Integer read FLineNumber write FLineNumber;
    property Method: string read FMethod write FMethod;
    constructor Create; overload;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

{ TStackTraceLog }

constructor TStackTraceLog.Create;
begin
  inherited;
  FCode := TCodeLog.Create;
end;

destructor TStackTraceLog.Destroy;
begin
  FreeAndNil(FCode);
  inherited;
end;

end.
