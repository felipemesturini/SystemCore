unit System.BugSnag.EventsLog;

interface

uses
  System.BugSnag.AppLog,
  System.BugSnag.DeviceLog,
  System.BugSnag.UserLog,
  System.BugSnag.RequestLog,
  System.BugSnag.SessionLog,
  System.BugSnag.MetaDataLog,
  System.BugSnag.BreadCrumbsLog,
  System.BugSnag.ExceptionLog,
  System.BugSnag.ServerityReasonLog,
  System.BugSnag.ThreadLog,
  REST.Json.Types;

type
  TEventsLog = class
  private
    FApp: TAppLog;
    [JSONName('breadcrumbs')]
    FBreadCrumbs: TArray<TBreadCrumbsLog>;
    FContext: string;
    FDevice: TDeviceLog;
    [JSONName('exceptions')]
    FExceptions: TArray<TExceptionLog>;
    FGroupingHash: string;
    FMetaData: TMetaDataLog;
    FRequest: TRequestLog;
    FSession: TSessionLog;
    FSeverity: string;
    FSeverityReason: TServerityReasonLog;
    [JSONName('threads')]
    FThreads: TArray<TThreadLog>;
    FUnhandled: Boolean;
    FUser: TUserLog;
  public
    property App: TAppLog read FApp write FApp;
    property Breadcrumbs: TArray<TBreadCrumbsLog> read FBreadCrumbs;
    property Context: string read FContext write FContext;
    property Device: TDeviceLog read FDevice write FDevice;
    property Exceptions: TArray<TExceptionLog> read FExceptions;
    property GroupingHash: string read FGroupingHash write FGroupingHash;
    property MetaData: TMetaDataLog read FMetaData write FMetaData;
    property Request: TRequestLog read FRequest write FRequest;
    property Session: TSessionLog read FSession write FSession;
    property Severity: string read FSeverity write FSeverity;
    property SeverityReason: TServerityReasonLog read FSeverityReason write FSeverityReason;
    property Threads: TArray<TThreadLog> read FThreads;
    property Unhandled: Boolean read FUnhandled write FUnhandled;
    property User: TUserLog read FUser write FUser;
  public
    constructor Create;
    destructor Destroy; override;

    function AddException: Integer;
    function AddThread: Integer;
    function AddBreadCrumb: Integer;
  end;

implementation

uses
  System.Generics.Collections,
  System.SysUtils;

{ TEventsLog }

function TEventsLog.AddBreadCrumb: Integer;
var
  lIndex: Integer;
begin
  lIndex := Length(FBreadCrumbs) + 1;
  SetLength(FBreadCrumbs, Length(FBreadCrumbs) + 1);
  FBreadCrumbs[lIndex - 1] := TBreadCrumbsLog.Create();
  Result := lIndex - 1;
end;

function TEventsLog.AddException: Integer;
var
  lIndex: Integer;
begin
  lIndex := Length(FExceptions) + 1;
  SetLength(FExceptions, Length(FExceptions) + 1);
  FExceptions[lIndex - 1] := TExceptionLog.Create();
  Result := lIndex - 1;
end;

function TEventsLog.AddThread: Integer;
var
  lIndex: Integer;
begin
  lIndex := Length(FThreads) + 1;
  SetLength(FThreads, Length(FThreads) + 1);
  FThreads[lIndex - 1] := TThreadLog.Create();
  Result := lIndex - 1;
end;

constructor TEventsLog.Create;
begin
  inherited;
  FApp := TAppLog.Create;
  FUser := TUserLog.Create;
  FDevice := TDeviceLog.Create;
  FSession := TSessionLog.Create;
  FSeverityReason := TServerityReasonLog.Create;
  FMetaData := TMetaDataLog.Create;
  FRequest := TRequestLog.Create;
end;

destructor TEventsLog.Destroy;
var
  lItem: TObject;
begin
  FreeAndNil(FApp);
  FreeAndNil(FUser);
  FreeAndNil(FDevice);
  FreeAndNil(FSeverityReason);
  FreeAndNil(FSession);
  FreeAndNil(FMetaData);
  FreeAndNil(FRequest);
  for lItem in FBreadCrumbs do
    lItem.Free;
  for lItem in FExceptions do
    lItem.Free;
  for lItem in FThreads do
    lItem.Free;
  SetLength(FBreadCrumbs, 0);
  SetLength(FThreads, 0);
  SetLength(FExceptions, 0);
  inherited;
end;

end.
