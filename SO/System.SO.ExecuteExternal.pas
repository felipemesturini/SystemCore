unit System.SO.ExecuteExternal;

interface

uses
  Winapi.Windows,
  System.Generics.Collections;

type
  TExecuteExternal = class sealed
  private
    FExecName: String;
    FArgs: TQueue<String>;
//    FProcessInfo: TProcessInformation;
    function Execute(var AExitCode: Cardinal): Boolean;
    function ParamValues: String;
  public
    function AsyncExec(): Boolean;
    function SyncExec(): Boolean;
    constructor Create(const AExecName: String); reintroduce;
    destructor Destroy; override;

    property Args: TQueue<String> read FArgs write FArgs;
  end;

implementation

uses
  System.SysUtils,
  CodeSiteLogging;

{ TExecuteExternal }

function TExecuteExternal.AsyncExec(): Boolean;
var
  lExitCode: Cardinal;
begin
  if FExecName.Trim.IsEmpty then
    raise EArgumentException.Create('FExecName não foi informado');
  if not FileExists(FExecName) then
    raise EArgumentOutOfRangeException.CreateFmt('"%s" não é um valor valido',
      [FExecName]);

  Result := Execute(lExitCode);
  Result := (Result) and (lExitCode = STILL_ACTIVE)
end;

constructor TExecuteExternal.Create(const AExecName: String);
begin
  inherited Create();
  FExecName := AExecName;
  FArgs := TQueue<String>.Create;
end;

destructor TExecuteExternal.Destroy;
begin
  FArgs.Free;
  inherited;
end;

function TExecuteExternal.Execute(var AExitCode: Cardinal): Boolean;
var
  lStartupInfo: TStartupInfo;
  lProcessInfo: TProcessInformation;
//  lDirectory: string;
  lApplicationName: PChar;
  lApplicationDir: PChar;
  lParams: string;
  lCommandLine: string;
begin
  lApplicationName := Pchar(FExecName);
  // Full path & name of Your App.
  lApplicationDir := PChar(ExtractFileDir(lApplicationName));

  lParams := ParamValues();
  lCommandLine := lParams;//' /p "C:\Users\Felipe\AppData\Local\Temp\zip9B88.tmp" "D:\workspace\Delphi\SmartGin\bin" "SmartGin.exe"';
  CmdLine := PWideChar(lCommandLine);

  ZeroMemory(@lStartupInfo, SizeOf(TStartupInfo));
//  FillChar(lStartupInfo, SizeOf(TStartupInfo), 0);
//  lStartupInfo.dwX := 0;
//  lStartupInfo.dwY := 0;
  lStartupInfo.cb := SizeOf(TStartupInfo);
  lStartupInfo.dwFlags := STARTF_FORCEONFEEDBACK or STARTF_FORCEOFFFEEDBACK;
  CodeSite.Send( csmLevel1, 'lApplicationName', lApplicationName );
  CodeSite.Send( csmLevel1, 'lParams', lParams );
  Result := CreateProcess(
    lApplicationName,
    CmdLine,
    nil, nil, False,
    CREATE_DEFAULT_ERROR_MODE or CREATE_NEW_PROCESS_GROUP,
    nil,
    lApplicationDir,
    lStartupInfo,
    lProcessInfo);
//  Result := CreateProcess( PChar(lApplicationName), CmdLine, nil, nil, False,
//    CREATE_DEFAULT_ERROR_MODE or
//    CREATE_NEW_PROCESS_GROUP or
//    NORMAL_PRIORITY_CLASS,
//    nil, nil, lStartupInfo, lProcessInfo);

  if lProcessInfo.hProcess <> 0 then
    GetExitCodeProcess(lProcessInfo.hProcess, AExitCode);
  if lProcessInfo.hThread <> 0 then
    GetExitCodeThread(lProcessInfo.hThread, AExitCode);
  if lProcessInfo.hProcess <> 0 then
    CloseHandle(lProcessInfo.hProcess);
  if lProcessInfo.hThread <> 0 then
    CloseHandle(lProcessInfo.hThread);
end;

function TExecuteExternal.ParamValues: String;
begin
  Result := '';
  while FArgs.Count > 0 do
    Result := Result + ' "' + FArgs.Extract + '"' ;

  if not Result.Trim.IsEmpty then
    Result := ' /p ' + Result.Trim;
end;

function TExecuteExternal.SyncExec(): Boolean;
var
  lStatusCode: Cardinal;
  AppName: PWideChar;
  AppWDir: PWideChar;
  CLine: PWideChar;
  sInfo: TStartupInfo;
  pInfo: TProcessInformation;
  lParams: string;
//  lStatus: Boolean;
begin
  AppName := PChar(FExecName);
  // Full path & name of Your App.
  AppWDir := PWideChar(ExtractFileDir(AppName));

  lParams := ParamValues();
  CLine := PWideChar(lParams);// ' /p "C:\Users\DevVM\AppData\Local\Temp\zip9556.tmp" "C:\smartgin\bin" "SmartGin.exe"';
  CmdLine := PChar(CLine);

  FillChar(sInfo, SizeOf(TStartupInfo), 0);

  sInfo.cb := SizeOf(TStartupInfo);

  sInfo.dwFlags := STARTF_FORCEONFEEDBACK or STARTF_FORCEOFFFEEDBACK;

  Result := CreateProcess(AppName, CmdLine, nil, nil, False,
    CREATE_DEFAULT_ERROR_MODE or
    CREATE_NEW_PROCESS_GROUP or
    NORMAL_PRIORITY_CLASS,
    nil, AppWDir, sInfo, pInfo);

  if not Result then
    Exit;

  // Result := Execute;

  Result := GetExitCodeProcess(pInfo.hProcess, lStatusCode);

//  if not Result then
//    Exit

//   while lStatusCode = STILL_ACTIVE  do begin
//      Han
//   end;
//
//   WaitForSingleObject(pInfo.hProcess, 500000)

end;

end.
