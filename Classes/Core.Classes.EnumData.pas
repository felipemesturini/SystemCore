unit Core.Classes.EnumData;

interface

{$ALIGN ON}
type
  TEnumData = packed record
  public
    class function AsString<T: record>(AEnum: T): string; static;
    class function AsInteger<T: record>(AEnum: T): integer; static;
  end;

{$ALIGN OFF}

implementation

uses
  System.TypInfo;

{ TEnumData }

class function TEnumData.AsInteger<T>(AEnum: T): integer;
var
  lSize: integer;
begin
  lSize := SizeOf(T);
  case lSize of
    1:
      Result := PByte(@AEnum)^;
    2:
      Result := PWord(@AEnum)^;
    4:
      Result := PCardinal(@AEnum)^;
  end;
end;

class function TEnumData.AsString<T>(AEnum: T): string;
begin
  Result := GetEnumName(TypeInfo(T), AsInteger<T>(AEnum))
end;

end.
