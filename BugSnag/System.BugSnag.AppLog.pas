unit System.BugSnag.AppLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types;

type
  TAppLog = class
  private
    FBinaryArch: string;
    FBuildUUID: string;
    FBundleVersion: string;
    FDsymUUIDs: TArray<string>;
    FDuration: Integer;
    FDurationInForeground: Integer;
    FId: string;
    FInForeground: Boolean;
    FReleaseStage: string;
    FType: string;
    FVersion: string;
    FVersionCode: Integer;
  public
    property BinaryArch: string read FBinaryArch write FBinaryArch;
    property BuildUUID: string read FBuildUUID write FBuildUUID;
    property BundleVersion: string read FBundleVersion write FBundleVersion;
    property DsymUUIDs: TArray<string> read FDsymUUIDs write FDsymUUIDs;
    property Duration: Integer read FDuration write FDuration;
    property DurationInForeground: Integer read FDurationInForeground write FDurationInForeground;
    property Id: string read FId write FId;
    property InForeground: Boolean read FInForeground write FInForeground;
    property ReleaseStage: string read FReleaseStage write FReleaseStage;
    property &Type: string read FType write FType;
    property Version: string read FVersion write FVersion;
    property VersionCode: Integer read FVersionCode write FVersionCode;
  end;

implementation

end.
