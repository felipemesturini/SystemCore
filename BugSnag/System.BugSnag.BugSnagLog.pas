unit System.BugSnag.BugSnagLog;

interface

uses
  System.BugSnag.BaseJson,
  REST.Json.Types,
  System.Generics.Collections,
  System.BugSnag.EventsLog,
  System.BugSnag.NotifierLog;

type
  TBugSnagLog = class(TBaseJson)
  private
    FApiKey: string;
    FPayloadVersion: string;
    [JSONName('events')]
    FEvents: TArray<TEventsLog>;
    [JSONName('notifier')]
    FNotifier: TNotifierLog;
  public
    property ApiKey: string read FApiKey write FApiKey;
    property Events: TArray<TEventsLog> read FEvents;
    property Notifier: TNotifierLog read FNotifier write FNotifier;
    property PayloadVersion: string read FPayloadVersion write FPayloadVersion;
  public
    constructor Create; override;
    destructor Destroy; override;

    function AddEvent: Integer;
    function FirstExceptionEvent(): string;
    function FirstMessageExceptionEvent(): string;
  end;

implementation

uses
  System.SysUtils;

{ TBugSnagLog }

function TBugSnagLog.AddEvent: Integer;
var
  lIndex: Integer;
begin
  lIndex := Length(FEvents) + 1;
  SetLength(FEvents, Length(FEvents) + 1);
  FEvents[lIndex - 1] := TEventsLog.Create();
  Result := lIndex - 1;
end;

constructor TBugSnagLog.Create;
begin
  inherited;
  FNotifier := TNotifierLog.Create;
  SetLength(FEvents, 0);
end;

destructor TBugSnagLog.Destroy;
var
  lEvent: TObject;
begin
  FreeAndNil(FNotifier);
  for lEvent in FEvents do
    lEvent.Free;
  SetLength(FEvents, 0);
  inherited;
end;


function TBugSnagLog.FirstExceptionEvent: string;
begin
  Result := EmptyStr;
  if Length(Self.Events) = 0 then
    Exit;

  if Length(Self.Events[0].Exceptions) = 0 then
    Exit;

  Result := Self.Events[0].Exceptions[0].ErrorClass;
end;

function TBugSnagLog.FirstMessageExceptionEvent: string;
begin
  Result := EmptyStr;
  if Length(Self.Events) = 0 then
    Exit;

  if Length(Self.Events[0].Exceptions) = 0 then
    Exit;

  Result := Self.Events[0].Exceptions[0].Message;
end;

end.
