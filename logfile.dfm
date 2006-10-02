object Frm_logdir: TFrm_logdir
  Left = 211
  Top = 149
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Log Directory'
  ClientHeight = 216
  ClientWidth = 243
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 243
    Height = 216
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    TabOrder = 0
    object dlb: TDirectoryListBox
      Left = 8
      Top = 32
      Width = 225
      Height = 145
      ItemHeight = 16
      TabOrder = 0
    end
    object dcb: TDriveComboBox
      Left = 8
      Top = 8
      Width = 225
      Height = 22
      DirList = dlb
      TabOrder = 1
    end
    object btnok: TButton
      Left = 88
      Top = 184
      Width = 67
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 2
      OnClick = btnokClick
    end
    object btncancel: TButton
      Left = 168
      Top = 184
      Width = 67
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 3
      OnClick = btncancelClick
    end
  end
end
