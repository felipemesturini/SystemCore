unit Core.Classes.SmartPointer;

interface

type
  TSmartPointer<T: class, constructor> = record
  strict private
    FValue: T;
    FFreeTheValue: IInterface;
    function GetValue: T;
  private
    type
      TFreeTheValue = class (TInterfacedObject)
      private
        FObjectToFree: TObject;
      public
        constructor Create(AObjectToFree: TObject);
        destructor Destroy; override;
      end;
  public
    constructor Create(AValue: T); overload;
    procedure Init;
    class operator Implicit(AValue: T): TSmartPointer<T>;
    class operator Implicit(ASmart: TSmartPointer <T>): T;
    property Value: T read GetValue;
  end;


implementation

{ TSmartPointer<T> }

constructor TSmartPointer<T>.Create(AValue: T);
begin
  FValue := AValue;
  FFreeTheValue := TFreeTheValue.Create(FValue);
end;

function TSmartPointer<T>.GetValue: T;
begin
  if not Assigned(FFreeTheValue) then
    Init;
  Result := FValue;
end;

class operator TSmartPointer<T>.Implicit(ASmart: TSmartPointer<T>): T;
begin
  Result := ASmart.Value;
end;

procedure TSmartPointer<T>.Init;
begin
  TSmartPointer<T>.Create(T.Create);
end;

class operator TSmartPointer<T>.Implicit(AValue: T): TSmartPointer<T>;
begin
  Result := TSmartPointer<T>.Create(AValue);
end;

{ TSmartPointer<T>.TFreeTheValue }

constructor TSmartPointer<T>.TFreeTheValue.Create(AObjectToFree: TObject);
begin
  inherited Create();
  FObjectToFree := AObjectToFree;
end;

destructor TSmartPointer<T>.TFreeTheValue.Destroy;
begin
  FObjectToFree.Free;
  inherited;
end;

end.
