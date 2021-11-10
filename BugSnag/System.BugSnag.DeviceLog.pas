unit System.BugSnag.DeviceLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types;

type
  TDeviceLog = class
  private
    FBrowserName: string;
    FBrowserVersion: string;
    FCpuAbi: TArray<string>;
    FFreeDisk: UInt64;
    FFreeMemory: UInt64;
    FHostname: string;
    FId: string;
    FJailbroken: Boolean;
    FManufacturer: string;
    FModel: string;
    FModelNumber: Boolean;
    FOrientation: string;
    FOsName: string;
    FOsVersion: string;
    FTime: TDateTime;
    FTotalMemory: UInt64;
  public
    property Id: string read FId write FId;
    property BrowserName: string read FBrowserName write FBrowserName;
    property BrowserVersion: string read FBrowserVersion write FBrowserVersion;
    property CpuAbi: TArray<string> read FCpuAbi write FCpuAbi;
    property FreeDisk: UInt64 read FFreeDisk write FFreeDisk;
    property FreeMemory: UInt64 read FFreeMemory write FFreeMemory;
    property Hostname: string read FHostname write FHostname;
    property Jailbroken: Boolean read FJailbroken write FJailbroken;
    property Manufacturer: string read FManufacturer write FManufacturer;
    property Model: string read FModel write FModel;
    property ModelNumber: Boolean read FModelNumber write FModelNumber;
    property Orientation: string read FOrientation write FOrientation;
    property OsName: string read FOsName write FOsName;
    property OsVersion: string read FOsVersion write FOsVersion;
    property Time: TDateTime read FTime write FTime;
    property TotalMemory: UInt64 read FTotalMemory write FTotalMemory;
    procedure AddCepApi(const AValue: String);
  end;

implementation

{ TDeviceLog }

procedure TDeviceLog.AddCepApi(const AValue: String);
var
  lIndex: Integer;
begin
  lIndex := Length(FCpuAbi) + 1;
  SetLength(FCpuAbi, Length(FCpuAbi) + 1);
  FCpuAbi[lIndex - 1] := AValue;
end;

end.
