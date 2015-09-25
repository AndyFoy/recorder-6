object dlgSurveyDataOptions: TdlgSurveyDataOptions
  Left = 427
  Top = 294
  BorderStyle = bsDialog
  Caption = 'Display Options'
  ClientHeight = 134
  ClientWidth = 171
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblDisplay: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 13
    Caption = 'Display...'
  end
  object bbOK: TImageListButton
    Left = 8
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 1
    ImageList = dmFormActions.ilButtons
    ImageIndex = 0
  end
  object bbCancel: TImageListButton
    Left = 88
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    ImageList = dmFormActions.ilButtons
    ImageIndex = 1
  end
  object rgOptions: TRadioGroup
    Left = 8
    Top = 24
    Width = 153
    Height = 73
    Items.Strings = (
      'Survey Events'
      'Survey Samples')
    TabOrder = 0
    OnClick = rgOptionsClick
  end
end
