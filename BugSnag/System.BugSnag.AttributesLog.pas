unit System.BugSnag.AttributesLog;

interface

uses
  System.Generics.Collections,
  REST.Json.Types;

type
  TAttributesLog = class
  private
    FErrorClass: string;
    FErrorType: string;
    FExceptionClass: string;
    FFramework: string;
    FLevel: string;
    FSignalType: string;
    FViolationType: string;
  public
    property ErrorClass: string read FErrorClass write FErrorClass;
    property ErrorType: string read FErrorType write FErrorType;
    property ExceptionClass: string read FExceptionClass write FExceptionClass;
    property Framework: string read FFramework write FFramework;
    property Level: string read FLevel write FLevel;
    property SignalType: string read FSignalType write FSignalType;
    property ViolationType: string read FViolationType write FViolationType;
  end;

implementation

end.
