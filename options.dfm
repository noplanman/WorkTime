object Frm_Options: TFrm_Options
  Left = 475
  Top = 179
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 297
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object gbOptions: TGroupBox
    Left = 0
    Top = 0
    Width = 267
    Height = 73
    Align = alTop
    Caption = 'Log File Directory'
    Color = clSilver
    ParentColor = False
    TabOrder = 0
    object lblCurrentDir: TLabel
      Left = 110
      Top = 16
      Width = 147
      Height = 13
      Hint = 'C:\'
      AutoSize = False
      Caption = 'C:\'
      ParentShowHint = False
      ShowHint = True
    end
    object lblCurrentDirText: TLabel
      Left = 8
      Top = 16
      Width = 90
      Height = 13
      AutoSize = False
      Caption = 'Current Directory:'
    end
    object editNewDir: TEdit
      Left = 104
      Top = 38
      Width = 136
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object cbNewDir: TCheckBox
      Left = 8
      Top = 40
      Width = 90
      Height = 17
      Hint = 'Check this and select a new filename to move the log file.'
      Caption = 'New Directory:'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = cbNewDirClick
    end
    object btnBrowse: TEButton
      Left = 240
      Top = 38
      Width = 20
      Height = 20
      EFont.Charset = DEFAULT_CHARSET
      EFont.Color = clWindowText
      EFont.Height = -11
      EFont.Name = 'MS Sans Serif'
      EFont.Style = []
      EFontOver.Charset = DEFAULT_CHARSET
      EFontOver.Color = clWindowText
      EFontOver.Height = -11
      EFontOver.Name = 'MS Sans Serif'
      EFontOver.Style = []
      EFontDown.Charset = DEFAULT_CHARSET
      EFontDown.Color = clWindowText
      EFontDown.Height = -11
      EFontDown.Name = 'MS Sans Serif'
      EFontDown.Style = []
      EColor = clWhite
      EColorOver = 15790320
      EColorDown = 13487565
      EColor2 = clGray
      EColorOver2 = 7434609
      EColorDown2 = 5131854
      EBrushStyle = bsSolid
      EBrushStyleOver = bsSolid
      EBrushStyleDown = bsSolid
      EPenColor = clGray
      EPenColorOver = clGray
      EPenColorDown = clGray
      ECaption = '...'
      ECaptionOver = '...'
      ECaptionDown = '...'
      EnemyleftKind = ekButton
      EGradient = egTopToBottom
      EGradientOver = goTopToBottom
      EGradientDown = gdTopToBottom
      EOnFocusedShow = False
      EOnFocusedColor = clBlack
      EOnDefaultShow = False
      EOnDefaultColor = clBlack
      EnemyRoundedWidth = 1
      EnemyRoundedHeight = 1
      Default = False
      Enabled = False
      TabOrder = 2
      TabStop = True
      OnClick = btnBrowseClick
    end
  end
  object gbNotifications: TGroupBox
    Left = 0
    Top = 73
    Width = 267
    Height = 197
    Align = alClient
    Caption = 'Notifications'
    Color = clSilver
    ParentColor = False
    TabOrder = 1
    object lblWt: TLabel
      Left = 8
      Top = 16
      Width = 90
      Height = 13
      AutoSize = False
      Caption = 'Working Time:'
    end
    object lblWtHours: TLabel
      Left = 160
      Top = 20
      Width = 28
      Height = 13
      Caption = 'Hours'
    end
    object lblWtMinutes: TLabel
      Left = 160
      Top = 44
      Width = 37
      Height = 13
      Caption = 'Minutes'
    end
    object lblWtSeconds: TLabel
      Left = 160
      Top = 68
      Width = 42
      Height = 13
      Caption = 'Seconds'
    end
    object lblNotifyWtBtTitle: TLabel
      Left = 8
      Top = 100
      Width = 90
      Height = 13
      AutoSize = False
      Caption = 'NotificationTitle:'
    end
    object lblNotifyWtBtMessage: TLabel
      Left = 8
      Top = 124
      Width = 90
      Height = 13
      AutoSize = False
      Caption = 'Notification:'
    end
    object lblNotifyWtBtMessageCounter: TLabel
      Left = 64
      Top = 170
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = '0 / 250'
    end
    object cbNotifyWt: TCheckBox
      Left = 8
      Top = 38
      Width = 90
      Height = 17
      Hint = 
        'If this is checked, a BallonTip will appear when this amount of ' +
        'time has passed.'
      Caption = 'Notify Me!'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = cbNotifyWtClick
    end
    object seWtHours: TSpinEdit
      Left = 104
      Top = 14
      Width = 49
      Height = 22
      MaxValue = 23
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object seWtMinutes: TSpinEdit
      Left = 104
      Top = 38
      Width = 49
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object seWtSeconds: TSpinEdit
      Left = 104
      Top = 62
      Width = 49
      Height = 22
      MaxValue = 59
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object editNotifyWtBtTitle: TEdit
      Left = 104
      Top = 96
      Width = 156
      Height = 21
      MaxLength = 100
      TabOrder = 4
    end
    object editNotifyWtBtMessage: TMemo
      Left = 104
      Top = 120
      Width = 156
      Height = 65
      MaxLength = 250
      TabOrder = 5
      OnChange = editNotifyWtBtMessageChange
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 270
    Width = 267
    Height = 27
    Align = alBottom
    Color = clGray
    TabOrder = 2
    object btnOk: TEButton
      Left = 192
      Top = 4
      Width = 25
      Height = 20
      EFont.Charset = DEFAULT_CHARSET
      EFont.Color = clWindowText
      EFont.Height = -11
      EFont.Name = 'MS Sans Serif'
      EFont.Style = []
      EFontOver.Charset = DEFAULT_CHARSET
      EFontOver.Color = clWindowText
      EFontOver.Height = -11
      EFontOver.Name = 'MS Sans Serif'
      EFontOver.Style = []
      EFontDown.Charset = DEFAULT_CHARSET
      EFontDown.Color = clWindowText
      EFontDown.Height = -11
      EFontDown.Name = 'MS Sans Serif'
      EFontDown.Style = []
      EColor = clWhite
      EColorOver = 15790320
      EColorDown = 13487565
      EColor2 = clGray
      EColorOver2 = 7434609
      EColorDown2 = 5131854
      EBrushStyle = bsSolid
      EBrushStyleOver = bsSolid
      EBrushStyleDown = bsSolid
      EPenColor = clGray
      EPenColorOver = clGray
      EPenColorDown = clGray
      ECaption = 'OK'
      ECaptionOver = 'OK'
      ECaptionDown = 'OK'
      EnemyleftKind = ekButton
      EGradient = egTopToBottom
      EGradientOver = goTopToBottom
      EGradientDown = gdTopToBottom
      EOnFocusedShow = False
      EOnFocusedColor = clBlack
      EOnDefaultShow = False
      EOnDefaultColor = clBlack
      EnemyRoundedWidth = 1
      EnemyRoundedHeight = 1
      Default = False
      TabOrder = 0
      TabStop = True
      OnClick = btnOkClick
    end
    object btnCancel: TEButton
      Left = 216
      Top = 4
      Width = 45
      Height = 20
      EFont.Charset = DEFAULT_CHARSET
      EFont.Color = clWindowText
      EFont.Height = -11
      EFont.Name = 'MS Sans Serif'
      EFont.Style = []
      EFontOver.Charset = DEFAULT_CHARSET
      EFontOver.Color = clWindowText
      EFontOver.Height = -11
      EFontOver.Name = 'MS Sans Serif'
      EFontOver.Style = []
      EFontDown.Charset = DEFAULT_CHARSET
      EFontDown.Color = clWindowText
      EFontDown.Height = -11
      EFontDown.Name = 'MS Sans Serif'
      EFontDown.Style = []
      EColor = clWhite
      EColorOver = 15790320
      EColorDown = 13487565
      EColor2 = clGray
      EColorOver2 = 7434609
      EColorDown2 = 5131854
      EBrushStyle = bsSolid
      EBrushStyleOver = bsSolid
      EBrushStyleDown = bsSolid
      EPenColor = clGray
      EPenColorOver = clGray
      EPenColorDown = clGray
      ECaption = 'Cancel'
      ECaptionOver = 'Cancel'
      ECaptionDown = 'Cancel'
      EnemyleftKind = ekButton
      EGradient = egTopToBottom
      EGradientOver = goTopToBottom
      EGradientDown = gdTopToBottom
      EOnFocusedShow = False
      EOnFocusedColor = clBlack
      EOnDefaultShow = False
      EOnDefaultColor = clBlack
      EnemyRoundedWidth = 1
      EnemyRoundedHeight = 1
      Default = False
      TabOrder = 1
      TabStop = True
      OnClick = btnCancelClick
    end
  end
  object saveDialog: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'Text Files|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 65520
    Top = 65520
  end
end
