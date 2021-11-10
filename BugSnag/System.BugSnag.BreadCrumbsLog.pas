unit System.BugSnag.BreadCrumbsLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types,
  System.BugSnag.MetaDataLog;

type
  TBreadCrumbsLog = class
  private
    FMetaData: TMetaDataLog;
    FName: string;
    FTimestamp: string;
    FType: string;
  public
    property MetaData: TMetaDataLog read FMetaData write FMetaData;
    property Name: string read FName write FName;
    property Timestamp: string read FTimestamp write FTimestamp;
    property &Type: string read FType write FType;
    constructor Create; overload;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

{ TBreadCrumbsLog }

constructor TBreadCrumbsLog.Create;
begin
  inherited;
  FMetaData := TMetaDataLog.Create;
end;

destructor TBreadCrumbsLog.Destroy;
begin
  FreeAndNil(FMetaData);
  inherited;
end;

end.
