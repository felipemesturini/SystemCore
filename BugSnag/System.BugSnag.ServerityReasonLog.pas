unit System.BugSnag.ServerityReasonLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types,
  System.BugSnag.AttributesLog;

type
  TServerityReasonLog = class
  private
    FAttributes: TAttributesLog;
    FType: string;
  public
    property Attributes: TAttributesLog read FAttributes write FAttributes;
    property &Type: string read FType write FType;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

{ TServerityReasonLog }

constructor TServerityReasonLog.Create;
begin
  inherited;
  FAttributes := TAttributesLog.Create;
end;

destructor TServerityReasonLog.Destroy;
begin
  FreeAndNil(FAttributes);
  inherited;
end;

end.
