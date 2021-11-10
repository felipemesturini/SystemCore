unit System.Image.ImageLoadUtils;

interface

uses
  Data.DB,
  Vcl.Graphics;

type
  TImageLoadUtils = class sealed
  public
    class procedure LoadImageFromField(AField: TBlobField; APicture: TPicture);
    class procedure LoadImageToField(APicture: TPicture; AField: TBlobField);
  end;

implementation

uses
  System.Classes,
  System.SysUtils;

{ TImageLoadUtils }

type
  TPictureAccess = class(TPicture);

class procedure TImageLoadUtils.LoadImageFromField(AField: TBlobField; APicture: TPicture);
var
  lStream: TStream;
begin
  lStream := TMemoryStream.Create;
  try
    AField.SaveToStream(lStream);
    lStream.Position := 0;
    AField.SaveToFile('C:\tmp\image.png');
    APicture.LoadFromFile('C:\tmp\image.png');
//    TPictureAccess(APicture).LoadFromStream(lStream);
  finally
    FreeAndNil(lStream);
  end;
end;

class procedure TImageLoadUtils.LoadImageToField(APicture: TPicture; AField: TBlobField);
var
  lStream: TStream;
begin
  lStream := TMemoryStream.Create;
  try
    TPictureAccess(APicture).SaveToStream(lStream);
    lStream.Position := 0;
    AField.LoadFromStream(lStream);
  finally
    FreeAndNil(lStream);
  end;

end;

end.
