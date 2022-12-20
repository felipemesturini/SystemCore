unit System.Image.ImageSizeUtils;

interface

uses
  dxGDIPlusClasses,
  System.IOUtils,
  System.SysUtils;

type
  TImageSizeUtils = class sealed
  private
    class function ExtractImageType(const AExtension: String): TdxImageDataFormat;
  public
    class function RedimensionarImagem(const pArquivo: String; pLargura, pAltura: Integer): String;
    class function RedimensionarLarguraImagem(const pArquivo: String; pLargura: Integer): String;
    class function RedimensionarAlturaImagem(const pArquivo: String; pAltura: Integer): String;
  end;

implementation

{ TImageSizeUtils }

class function TImageSizeUtils.RedimensionarImagem(const pArquivo: String; pLargura, pAltura: Integer): String;
var
  lImagem: TdxSmartImage;
  lLargura: Integer;
  lAltura: Integer;
  lFileName: string;
  lExtension: string;
begin
  lImagem := TdxSmartImage.Create();
  try
    lImagem.LoadFromFile(pArquivo);
    lLargura := pLargura;
    lAltura := pAltura;
    lImagem.Resize(lLargura, lAltura);

    lExtension := ExtractFileExt(pArquivo);
    lImagem.ImageDataFormat := ExtractImageType(lExtension);

    lFileName := TPath.GetTempFileName();
    lFileName := ChangeFileExt(lFileName, lExtension);

    Result := lFileName;
    lImagem.SaveToFile(Result);
  finally
    lImagem.Free;
  end;
end;

class function TImageSizeUtils.RedimensionarLarguraImagem(const pArquivo: String; pLargura: Integer): String;
var
  lImagem: TdxSmartImage;
  lLargura: Integer;
  lAltura: Integer;
begin
  lImagem := TdxSmartImage.Create();
  try
    lImagem.LoadFromFile(pArquivo);
    lLargura := pLargura;
    if (lImagem.Width < pLargura) then begin
      Exit(pArquivo);
    end;
    lAltura := Trunc((lLargura / lImagem.Width) * lImagem.Height);
  finally
    lImagem.Free;
  end;
  Result := RedimensionarImagem(pArquivo, lLargura, lAltura);
end;

class function TImageSizeUtils.ExtractImageType(const AExtension: String): TdxImageDataFormat;
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

class function TImageSizeUtils.RedimensionarAlturaImagem(const pArquivo: String; pAltura: Integer): String;
var
  lImagem: TdxSmartImage;
  lLargura: Integer;
  lAltura: Integer;
begin
  lImagem := TdxSmartImage.Create();
  try
    lImagem.LoadFromFile(pArquivo);
    lAltura := pAltura;
    if (lImagem.Height < pAltura) then begin
      Exit(pArquivo);
    end;
    lLargura := Trunc((lAltura / lImagem.Height) * lImagem.Width);
  finally
    lImagem.Free;
  end;
  Result := RedimensionarImagem(pArquivo, lLargura, lAltura);
end;

end.
