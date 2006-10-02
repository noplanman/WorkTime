object Frm_options: TFrm_options
  Left = 542
  Top = 177
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 226
  ClientWidth = 232
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gbtc: TGroupBox
    Left = 0
    Top = 66
    Width = 111
    Height = 123
    Align = alLeft
    Caption = 'Text Color'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object cgtext: TColorGrid
      Left = 13
      Top = 30
      Width = 80
      Height = 80
      ForegroundIndex = 10
      BackgroundEnabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object gblogdir: TGroupBox
    Left = 0
    Top = 0
    Width = 232
    Height = 66
    Align = alTop
    Caption = 'Directory to save log.txt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btnlogdirectory: TButton
      Left = 171
      Top = 13
      Width = 51
      Height = 19
      Caption = 'Browse...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnlogdirectoryClick
    end
    object editlog: TEdit
      Left = 7
      Top = 33
      Width = 215
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object pnlbuttons: TPanel
    Left = 0
    Top = 189
    Width = 232
    Height = 37
    Align = alBottom
    BevelInner = bvLowered
    Color = clWhite
    TabOrder = 2
    object btnok: TButton
      Left = 111
      Top = 7
      Width = 52
      Height = 20
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btncancel: TButton
      Left = 169
      Top = 7
      Width = 53
      Height = 20
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object btndefault: TButton
      Left = 7
      Top = 7
      Width = 60
      Height = 20
      Caption = 'Default'
      TabOrder = 2
      OnClick = btndefaultClick
    end
  end
  object rgposition: TRadioGroup
    Left = 111
    Top = 66
    Width = 121
    Height = 123
    Align = alClient
    Caption = 'Position'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 3
    Items.Strings = (
      'Top - Left'
      'Top - Right'
      'Bottom - Left'
      'Bottom - Right')
    ParentFont = False
    TabOrder = 3
  end
end
