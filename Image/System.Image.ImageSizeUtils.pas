unit System.Image.ImageSizeUtils;

interface

uses
  dxGDIPlusClasses,
  System.IOUtils,
  System.SysUtils;

type
  TImageSizeUtils = class sealed
  private
    class function ExtractImageType(const AExtension: string): TdxImageDataFormat;
  public
    class function RedimensionarImagem(
      const AArquivo: string;
      ALargura, AAltura: Integer;
      APreserveFileName: Boolean): string;

    class function RedimensionarLarguraImagem(
      const AArquivo: string;
      ALargura: Integer;
      APreserveFileName: Boolean): string;

    class function RedimensionarAlturaImagem(
      const AArquivo: string;
      AAltura: Integer;
      APreserveFileName: Boolean): string;
  end;

implementation

{ TImageSizeUtils }

class function TImageSizeUtils.RedimensionarImagem(
  const AArquivo: string;
  ALargura, AAltura: Integer;
  APreserveFileName: Boolean): string;
var
  lImagem: TdxSmartImage;
  lLargura: Integer;
  lAltura: Integer;
  lFileName: string;
  lExtension: string;
begin
  lImagem := TdxSmartImage.Create();
  try
    lImagem.LoadFromFile(AArquivo);

    lLargura := ALargura;
    lAltura := AAltura;

    lImagem.Resize(
      lLargura,
      lAltura);

    if APreserveFileName then
      Result := AArquivo
    else
    begin
      lExtension := ExtractFileExt(AArquivo);
      lImagem.ImageDataFormat := ExtractImageType(lExtension);

      lFileName := TPath.GetTempFileName();
      lFileName := ChangeFileExt(
        lFileName,
        lExtension);

      Result := lFileName;
    end;

    lImagem.SaveToFile(Result);
  finally
    lImagem.Free;
  end;
end;

class function TImageSizeUtils.RedimensionarLarguraImagem(
  const AArquivo: string;
  ALargura: Integer;
  APreserveFileName: Boolean): string;
var
  lImagem: TdxSmartImage;
  lLargura: Integer;
  lAltura: Integer;
begin
  lImagem := TdxSmartImage.Create();
  try
    lImagem.LoadFromFile(AArquivo);
    lLargura := ALargura;
    if (lImagem.Width < ALargura) then
      Exit(AArquivo);
    lAltura := Trunc((lLargura / lImagem.Width) * lImagem.Height);
  finally
    lImagem.Free;
  end;

  Result := RedimensionarImagem(
    AArquivo,
    lLargura,
    lAltura,
    APreserveFileName);
end;

class function TImageSizeUtils.ExtractImageType(const AExtension: string): TdxImageDataFormat;
var
  lExtension: string;
begin
  lExtension := AExtension;
  if lExtension.ToLower.Equals('.png') then
    Result := dxImagePng
  else if lExtension.ToLower.Equals('.jpg') then
    Result := dxImageJpeg
  else if lExtension.ToLower.Equals('.jpeg') then
    Result := dxImageJpeg
  else if lExtension.ToLower.Equals('.gif') then
    Result := dxImageGif
  else if lExtension.ToLower.Equals('.bmp') then
    Result := dxImageBitmap
  else if lExtension.ToLower.Equals('.ico') then
    Result := dxImageIcon
  else
    raise ENotSupportedException.Create('Extenção nao suportada para o arquivo');

end;

class function TImageSizeUtils.RedimensionarAlturaImagem(
  const AArquivo: string;
  AAltura: Integer;
  APreserveFileName: Boolean): string;
var
  lImagem: TdxSmartImage;
  lLargura: Integer;
  lAltura: Integer;
begin
  lImagem := TdxSmartImage.Create();
  try
    lImagem.LoadFromFile(AArquivo);
    lAltura := AAltura;
    if (lImagem.Height < AAltura) then
      Exit(AArquivo);
    lLargura := Trunc((lAltura / lImagem.Height) * lImagem.Width);
  finally
    lImagem.Free;
  end;

  Result := RedimensionarImagem(
    AArquivo,
    lLargura,
    lAltura,
    APreserveFileName);
end;

end.
