unit System.SO.CheckProcess;

interface

uses
  Winapi.Windows,
  Winapi.TlHelp32,
  CodeSiteLogging;

type
  TCheckProcess = class sealed
  private
    FExeFileName: String;
    function ProcessExists(var AProcessID: Integer): Boolean;
  public
    constructor Create(const AExeFileName: String); reintroduce;
    destructor Destroy; override;
    function IsRunning(var AProcessID: Integer): Boolean;
    function TerminateProcessById(const AProcessID: Integer): Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TCheckProcess }


{ TCheckProcess }

function TCheckProcess.ProcessExists(var AProcessID: Integer): Boolean;
var
  lContinueLoop: BOOL;
  lSnapshotHandle: THandle;
  lProcessEntry32: TProcessEntry32;
begin
  AProcessID := 0;
  lSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  lProcessEntry32.dwSize := SizeOf(lProcessEntry32);
  lContinueLoop := Process32First(lSnapshotHandle, lProcessEntry32);
  Result := False;
  while Integer(lContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(lProcessEntry32.szExeFile)) =
      UpperCase(FExeFileName)) or (UpperCase(lProcessEntry32.szExeFile) =
      UpperCase(FExeFileName))) then
    begin
      Result := True;
      AProcessID := lProcessEntry32.th32ProcessID;
    end;

    lContinueLoop := Process32Next(lSnapshotHandle, lProcessEntry32);
  end;
  CloseHandle(lSnapshotHandle);
end;

function TCheckProcess.TerminateProcessById(const AProcessID: Integer): Boolean;
var
  lHandle: Cardinal;
begin
  Result := False;
  lHandle := OpenProcess(PROCESS_TERMINATE, False, AProcessID);
  if lHandle <> ERROR_SUCCESS then
  begin
    try
      Result := TerminateProcess(lHandle, 0);
      Sleep(2500);
    finally
      CloseHandle(lHandle);
    end;
  end;
end;

constructor TCheckProcess.Create(const AExeFileName: String);
begin
  inherited Create();
  FExeFileName := AExeFileName;
end;

destructor TCheckProcess.Destroy;
begin

  inherited;
end;

function TCheckProcess.IsRunning(var AProcessID: Integer): Boolean;
begin
  Result := ProcessExists(AProcessID);
end;

end.
