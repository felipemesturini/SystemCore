unit System.Notification.MessageUtils;

interface

type
  TMessageUtils = class sealed
  public
    class procedure Info(const AMessage: String);
    class procedure Warn(const AMessage: String);
    class procedure Error(const  AMessage: String);
    class function Confirm(const AMessage: String): Boolean;
  end;

implementation

uses
  Vcl.Dialogs,
  System.UITypes,
  Vcl.Controls;

{ TMessageUtils }

class function TMessageUtils.Confirm(const AMessage: String): Boolean;
var
  lOption: Integer;
begin
  lOption := MessageDlg(
    AMessage,
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    1,
    TMsgDlgBtn.mbYes);
  Result := lOption = mrYes;
end;

class procedure TMessageUtils.Error(const  AMessage: String);
begin
  MessageDlg(
    AMessage,
    TMsgDlgType.mtError,
    [TMsgDlgBtn.mbOK], 0);
end;

class procedure TMessageUtils.Info(const AMessage: String);
begin
  MessageDlg(
    AMessage,
    TMsgDlgType.mtInformation,
    [TMsgDlgBtn.mbOK], 0);

end;

class procedure TMessageUtils.Warn(const AMessage: String);
begin
  MessageDlg(
    AMessage,
    TMsgDlgType.mtWarning,
    [TMsgDlgBtn.mbOK], 0);

end;

end.
