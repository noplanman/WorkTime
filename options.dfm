object Frm_Options: TFrm_Options
  Left = 573
  Top = 413
  BorderIcons = []
  BorderStyle = bsNone
  BorderWidth = 1
  Caption = 'Options'
  ClientHeight = 370
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imgTitle: TImage
    Left = 0
    Top = 0
    Width = 266
    Height = 30
    Align = alTop
    Picture.Data = {
      0A544A504547496D61676570010000FFD8FFE000104A46494600010200006400
      640000FFEC00114475636B7900010004000000640000FFEE000E41646F626500
      64C000000001FFDB008400010101010101010101010101010101010101010101
      0101010101010101010101010101010101010101010102020202020202020202
      0203030303030303030303010101010101010201010202020102020303030303
      0303030303030303030303030303030303030303030303030303030303030303
      030303030303030303030303FFC0001108001E000A03011100021101031101FF
      C4005A0001010101000000000000000000000000000807090101000000000000
      000000000000000000001000010205050100000000000000000000010016A1D1
      920353025213D35405110100000000000000000000000000000000FFDA000C03
      010002110311003F00EEA38346F8892038346F889209D1DC321AC4D01DC321AC
      4D04B2ED3944501DA7288A0C3B93EB79EE576BB10393EB79EE576BB107FFD9}
    Stretch = True
    OnMouseMove = _MouseMove
  end
  object btnClose: TJvSpeedButton
    Left = 250
    Top = 5
    Width = 10
    Height = 10
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000360000002800000008000000080000000100
      180000000000C0000000120B0000120B0000000000000000000031261F31261F
      31261F31261F31261F31261F31261F31261F31261FFFFFFFFFFFFF31261F3126
      1FFFFFFFFFFFFF31261F31261F31261FFFFFFF31261F31261FFFFFFF31261F31
      261F31261F31261F31261FFFFFFFFFFFFF31261F31261F31261F31261F31261F
      31261FFFFFFFFFFFFF31261F31261F31261F31261F31261FFFFFFF31261F3126
      1FFFFFFF31261F31261F31261FFFFFFFFFFFFF31261F31261FFFFFFFFFFFFF31
      261F31261F31261F31261F31261F31261F31261F31261F31261F}
    GrayedInactive = False
    GrayNewStyle = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ModalResult = 2
    Transparent = True
  end
  object lblTitle: TLabel
    Left = 5
    Top = 5
    Width = 45
    Height = 13
    Caption = 'lblTitle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
    OnMouseMove = _MouseMove
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 346
    Width = 266
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object gradButtons: TJvGradient
      Left = 0
      Top = 0
      Width = 266
      Height = 24
      Style = grVertical
      StartColor = clSilver
      EndColor = clGray
    end
    object btnOk: TJvSpeedButton
      Left = 240
      Top = 2
      Width = 20
      Height = 20
      Flat = True
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        20000000000000080000120B0000120B00000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0025B0460049D869005EE37C005EE37C0049D8
        690026B04600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF006A6A6A0090909000A0A0A000A0A0A0009090
        90006B6B6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0050DC690098F9A800B3FFC200B7FFC400B3FFBD00AFFE
        BC0098F9A80050DC6900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0096969600C8C8C800D9D9D900DBDBDB00D9D9D900D6D6
        D600C8C8C80096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0057DD6C0094FDB0008EFFB20067DC810062D77B0086FFAA0081FF
        A20089FFA90094FEB00057DD6B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009A9A9A00C8C8C800C6C6C600A1A1A1009C9C9C00C2C2C200C0C0
        C000C4C4C400C9C9C9009A9A9A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0034C9450072FD9E0062FF980046D76E0067A96D0073AB780047D36D0062FF
        96005FFE8F005EFF900072FD9F0034C94400FF00FF00FF00FF00FF00FF00FF00
        FF007E7E7E00B7B7B700B0B0B0008E8E8E00888888008F8F8F008D8D8D00B0B0
        B000AEAEAE00AEAEAE00B7B7B7007E7E7E00FF00FF00FF00FF00FF00FF000A8C
        10004CE46C0051FF8D0032D25D005BA56300F0EEEC00FDF9FB006FAE750031CB
        5B004BFA82004AF07D004EF887004BE56C000A8B0F00FF00FF00FF00FF004B4B
        4B0098989800A8A8A8008282820080808000EEEEEE00FBFBFB008E8E8E007E7E
        7E00A2A2A2009D9D9D00A3A3A300989898004A4A4A00FF00FF00FF00FF0014A3
        190042E7740029C5530059A36100EFEDEA00FFFFFF00FFFFFF00F9F4F4006FAE
        760027BD4E003DE471003EDE6F0041DF6F0014A51A00FF00FF00FF00FF005B5B
        5B0094949400777777007E7E7E00ECECEC00FFFFFF00FFFFFF00F6F6F6008E8E
        8E0072727200909090008E8E8E00909090005C5C5C00FF00FF00FF00FF0017B2
        280026B74F0063A76B00F2EFEE00FFFFFF00EDF0EC00EDEEE900FFFFFF00F9F6
        F6006BAA71001AAE41002FD0610034CD650016B02600FF00FF00FF00FF006464
        64006E6E6E0085858500F0F0F000FFFFFF00EEEEEE00EBEBEB00FFFFFF00F7F7
        F7008A8A8A00646464007F7F7F008080800063636300FF00FF00FF00FF0015B6
        2D0014942D0093B58F00FFFFFF00F2F2EF0043974D0036924200E8EAE500FFFF
        FF00FEF9FA006AA87100119E310021BC480015B12C00FF00FF00FF00FF006565
        650054545400A2A2A200FFFFFF00F0F0F0006D6D6D0064646400E7E7E700FFFF
        FF00FBFBFB0089898900575757006E6E6E0063636300FF00FF00FF00FF0018B3
        31000FA62600158B23008DB38C00519A550006971C00059C1D003C904200E3E9
        E200FFFFFF00FAF8F80071AB74000D931F0017B63000FF00FF00FF00FF006565
        65005A5A5A00505050009F9F9F00757575004E4E4E005050500066666600E5E5
        E500FFFFFF00F9F9F9008E8E8E005050500066666600FF00FF00FF00FF001FAF
        41000EA11C00008F0800037C0600008606000797100007971000008600003B8B
        3B00ECEDEC00FFFFFF008BAF8600088912001EB14100FF00FF00FF00FF006767
        670057575700474747003F3F3F00434343004F4F4F004F4F4F00434343006363
        6300ECECEC00FFFFFF009A9A9A004848480067676700FF00FF00FF00FF00FF00
        FF0024C74500007A000000800000008400000080000000800000008400000075
        0000448E44007AA87A00086D070020C94100FF00FF00FF00FF00FF00FF00FF00
        FF00757575003D3D3D0040404000424242004040400040404000424242003A3A
        3A0069696900919191003A3A3A0074747400FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0023BD3B00006A000000660000006D0000006F0000006E0000006F
        0000005F0000005E000020BE3800FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF007070700035353500333333003636360037373700373737003737
        37002F2F2F002F2F2F006F6F6F00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF003AD85C001285190002610300005A0000005A00000261
        03001287180038D95A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00898989004B4B4B00313131002D2D2D002D2D2D003131
        31004C4C4C0088888800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0064E5890067DC790061CA680062CA680068DC
        7B0065E58A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00A4A4A400A1A1A1009595950096969600A2A2
        A200A5A5A500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      GrayedInactive = False
      GrayNewStyle = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      Transparent = True
      OnClick = btnOkClick
    end
    object btnCancel: TJvSpeedButton
      Left = 220
      Top = 2
      Width = 20
      Height = 20
      Flat = True
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        20000000000000080000120B0000120B00000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000203A1002528AF004446B8004446B8002528
        AF000203A100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00515151006A6A6A007E7E7E007E7E7E006A6A
        6A0051515100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF002939D1008AAAF000C0E1FD00CBE8FE00CBE7FE00BFE0
        FD008AABF000283AD100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF007D7D7D00BDBDBD00DEDEDE00E4E4E400E4E4E400DEDE
        DE00BDBDBD007C7C7C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF002A52F3007DC5FF006CA2E700659DEA007CC2FF007DC1FF006BA8
        F2006DA5E9007DC3FF002A53F300FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF008E8E8E00BEBEBE00A9A9A900A7A7A700BDBDBD00BEBEBE00AEAE
        AE00ABABAB00BEBEBE008E8E8E00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000E41FF003F9CFF002F78E2007173C400636DC2002578E8002883F0004F65
        C400696BC100327BE3003E9CFF000E41FF00FF00FF00FF00FF00FF00FF00FF00
        FF00868686009F9F9F00888888009A9A9A0092929200868686008C8C8C008989
        8900959595008A8A8A009E9E9E0086868600FF00FF00FF00FF00FF00FF001034
        F6002772FF001A64E0007074C500FFFFFE00EDE6F1004B5EC1003550BD00DBD4
        EA00FFFFFD00676DC0001966E2002773FF001034F600FF00FF00FF00FF008383
        8300939393007D7D7D009A9A9A00FEFEFE00EBEBEB008686860079797900DFDF
        DF00FEFEFE00939393007D7D7D009393930083838300FF00FF00FF00FF002754
        FF003276FF00235BE8006268C200EDE9F200FFFFFF00EAE6F300E2DDEE00FFFF
        FF00DED9EB004C5CC3002764EE003276FF002754FF00FF00FF00FF00FF009393
        9300989898008585850092929200EDEDED00FFFFFF00ECECEC00E5E5E500FFFF
        FF00E2E2E200878787008A8A8A009898980093939300FF00FF00FF00FF003866
        FF003868FF003A6EFF002250E900525AC100E5E3F100FFFFFF00FFFFFF00DFDC
        ED003D4ABD002559F2003A6EFF003868FF003866FF00FF00FF00FF00FF009B9B
        9B009B9B9B009C9C9C008585850089898900EAEAEA00FFFFFF00FFFFFF00E4E4
        E4007D7D7D008B8B8B009C9C9C009B9B9B009B9B9B00FF00FF00FF00FF003A6D
        FF003057FF00335CFF001E48F2003D49BD00DFDCED00FFFFFF00FFFFFF00E5E4
        F100525BC1001B42E900315CFF003058FF003A6CFF00FF00FF00FF00FF009C9C
        9C009797970099999900888888007D7D7D00E4E4E400FFFFFF00FFFFFF00EAEA
        EA00898989008282820098989800979797009C9C9C00FF00FF00FF00FF003271
        FF001E47FF001339EE004853C300DEDBEB00FFFFFF00E4E2EE00EBEAF200FFFF
        FF00EDEAF2005F64C2001135E8001D47FF003270FF00FF00FF00FF00FF009898
        98008E8E8E008080800085858500E3E3E300FFFFFF00E8E8E800EEEEEE00FFFF
        FF00EEEEEE00909090007C7C7C008E8E8E0098989800FF00FF00FF00FF002C77
        F5001348FF000017E5006C6DC400FFFFFF00E0DDED00363BC0004C50C500F4F0
        F400FFFFFF007575C7000017E2001347FF002C77F500FF00FF00FF00FF009090
        9000898989007272720098989800FFFFFF00E5E5E5007B7B7B0088888800F2F2
        F200FFFFFF009E9E9E00717171008989890090909000FF00FF00FF00FF00FF00
        FF002579FF00001DF2000113D6006C6DC1004349C000000FE800000EE0005F5E
        C1007575C5000010D600001CF200257AFF00FF00FF00FF00FF00FF00FF00FF00
        FF0092929200797979006B6B6B00969696008181810074747400707070008F8F
        8F009D9D9D006B6B6B007979790092929200FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF003B78F100010ECA000000AE000008BD000015CA000014CB000005
        B8000000AE00010ECA003B78F100FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF009696960065656500575757005E5E5E0065656500656565005C5C
        5C00575757006565650096969600FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0079AAEF003241C200090FA4000001990000029A00080E
        A5003141C10079AAEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00B4B4B4007A7A7A00565656004C4C4C004D4D4D005656
        560079797900B4B4B400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00B5D8F600B3C7EE00A5ADDE00A5ADDE00B2C8
        EE00B5D8F600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00D5D5D500D0D0D000C1C1C100C1C1C100D0D0
        D000D5D5D500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      GrayedInactive = False
      GrayNewStyle = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      Transparent = True
    end
  end
  object npOptions: TJvNavigationPane
    Left = 0
    Top = 30
    Width = 266
    Height = 316
    ActivePage = npVarious
    Align = alClient
    AutoHeaders = True
    Background.Stretch = False
    Background.Proportional = False
    Background.Center = False
    Background.Tile = False
    Background.Transparent = False
    ButtonHeight = 20
    ButtonWidth = 20
    Colors.ButtonColorFrom = clWhite
    Colors.ButtonColorTo = clSilver
    Colors.ButtonHotColorFrom = clSilver
    Colors.ButtonHotColorTo = clGray
    Colors.ButtonSelectedColorFrom = clGray
    Colors.ButtonSelectedColorTo = clSilver
    Colors.SplitterColorFrom = clSilver
    Colors.SplitterColorTo = clGray
    Colors.DividerColorFrom = clSilver
    Colors.DividerColorTo = clGray
    Colors.HeaderColorFrom = clGray
    Colors.HeaderColorTo = clGray
    Colors.FrameColor = clGray
    Colors.ToolPanelHeaderColorFrom = clWhite
    Colors.ToolPanelHeaderColorTo = clGray
    StyleManager = npStyleManager
    ParentStyleManager = False
    SplitterHeight = 0
    MaximizedCount = 2
    NavPanelFont.Charset = DEFAULT_CHARSET
    NavPanelFont.Color = clWindowText
    NavPanelFont.Height = -11
    NavPanelFont.Name = 'Verdana'
    NavPanelFont.Style = [fsBold]
    NavPanelHotTrackFont.Charset = DEFAULT_CHARSET
    NavPanelHotTrackFont.Color = clWindow
    NavPanelHotTrackFont.Height = -11
    NavPanelHotTrackFont.Name = 'Verdana'
    NavPanelHotTrackFont.Style = [fsBold]
    Resizable = False
    object npNotifications: TJvNavPanelPage
      Left = 0
      Top = 0
      Width = 264
      Height = 254
      Background.Stretch = False
      Background.Proportional = False
      Background.Center = False
      Background.Tile = False
      Background.Transparent = False
      Color = clGray
      Caption = 'Notification'
      object lblWtSeconds: TLabel
        Left = 160
        Top = 85
        Width = 42
        Height = 13
        Caption = 'Seconds'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblWtMinutes: TLabel
        Left = 160
        Top = 60
        Width = 37
        Height = 13
        Caption = 'Minutes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblWtHours: TLabel
        Left = 160
        Top = 35
        Width = 28
        Height = 13
        Caption = 'Hours'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblWt: TLabel
        Left = 5
        Top = 35
        Width = 90
        Height = 13
        AutoSize = False
        Caption = 'Working Time:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNotifyWtBtMessageCounter: TLabel
        Left = 220
        Top = 165
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = '0 / 250'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNotifyWtBtMessage: TLabel
        Left = 5
        Top = 165
        Width = 90
        Height = 13
        AutoSize = False
        Caption = 'Notification:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object seWtSeconds: TSpinEdit
        Left = 105
        Top = 80
        Width = 49
        Height = 22
        MaxValue = 59
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object seWtMinutes: TSpinEdit
        Left = 105
        Top = 55
        Width = 49
        Height = 22
        MaxValue = 59
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object seWtHours: TSpinEdit
        Left = 105
        Top = 30
        Width = 49
        Height = 22
        MaxValue = 23
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object memoNotifyWtBtMessage: TMemo
        Left = 5
        Top = 180
        Width = 250
        Height = 65
        MaxLength = 250
        TabOrder = 4
        OnChange = memoNotifyWtBtMessageChange
      end
      object cbNotifyWt: TCheckBox
        Left = 5
        Top = 53
        Width = 90
        Height = 17
        Hint = 
          'If this is checked, a BallonTip will appear when this amount of ' +
          'time has passed.'
        Caption = 'Notify Me!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = cbNotifyWtClick
      end
      object editNotifyWtBtTitle: TLabeledEdit
        Left = 5
        Top = 136
        Width = 250
        Height = 21
        EditLabel.Width = 79
        EditLabel.Height = 13
        EditLabel.Caption = 'Notification Title:'
        EditLabel.Color = clGray
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWhite
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Transparent = True
        TabOrder = 6
      end
    end
    object npVarious: TJvNavPanelPage
      Left = 0
      Top = 0
      Width = 264
      Height = 254
      Background.Stretch = False
      Background.Proportional = False
      Background.Center = False
      Background.Tile = False
      Background.Transparent = False
      Color = clGray
      Caption = 'Various'
      object lblHotKeyNoon: TLabel
        Left = 5
        Top = 140
        Width = 250
        Height = 13
        AutoSize = False
        Caption = 'HotKey Noon:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblFadeSpeed: TLabel
        Left = 5
        Top = 50
        Width = 61
        Height = 13
        Caption = 'Fade Speed:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblFadeSlow: TLabel
        Left = 90
        Top = 50
        Width = 21
        Height = 13
        Caption = 'slow'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblFadeFast: TLabel
        Left = 230
        Top = 50
        Width = 17
        Height = 13
        Alignment = taRightJustify
        Caption = 'fast'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnBrowse: TSpeedButton
        Left = 237
        Top = 206
        Width = 20
        Height = 20
        Caption = '...'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cbAutoRun: TCheckBox
        Left = 5
        Top = 110
        Width = 250
        Height = 17
        Caption = 'Launch Automatically With Windows'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object tbFadeSpeed: TTrackBar
        Left = 120
        Top = 40
        Width = 105
        Height = 30
        Min = 1
        Position = 1
        TabOrder = 1
        ThumbLength = 10
        TickMarks = tmBoth
      end
      object hcNoon: THotKey
        Left = 5
        Top = 160
        Width = 250
        Height = 19
        HotKey = 57376
        InvalidKeys = []
        Modifiers = [hkShift, hkCtrl, hkAlt, hkExt]
        TabOrder = 4
      end
      object cbStartMinimized: TCheckBox
        Left = 5
        Top = 80
        Width = 250
        Height = 17
        Caption = 'Start Minimized'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object cbFade: TCheckBox
        Left = 5
        Top = 30
        Width = 250
        Height = 17
        Caption = 'Fade In/Out on Show/Hide'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = cbFadeClick
      end
      object editLogFilePath: TLabeledEdit
        Left = 5
        Top = 206
        Width = 228
        Height = 21
        EditLabel.Width = 56
        EditLabel.Height = 13
        EditLabel.Caption = 'Logfile Path'
        EditLabel.Color = clGray
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWhite
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        EditLabel.Transparent = True
        TabOrder = 6
      end
    end
  end
  object npStyleManager: TJvNavPaneStyleManager
    Colors.ButtonColorFrom = clWhite
    Colors.ButtonColorTo = clSilver
    Colors.ButtonHotColorFrom = clSilver
    Colors.ButtonHotColorTo = clGray
    Colors.ButtonSelectedColorFrom = clGray
    Colors.ButtonSelectedColorTo = clSilver
    Colors.SplitterColorFrom = clSilver
    Colors.SplitterColorTo = clGray
    Colors.DividerColorFrom = clSilver
    Colors.DividerColorTo = clGray
    Colors.HeaderColorFrom = clGray
    Colors.HeaderColorTo = clGray
    Colors.FrameColor = clGray
    Colors.ToolPanelHeaderColorFrom = clWhite
    Colors.ToolPanelHeaderColorTo = clGray
    Fonts.NavPanelFont.Charset = DEFAULT_CHARSET
    Fonts.NavPanelFont.Color = clWindowText
    Fonts.NavPanelFont.Height = -11
    Fonts.NavPanelFont.Name = 'Verdana'
    Fonts.NavPanelFont.Style = [fsBold]
    Fonts.NavPanelHotTrackFont.Charset = DEFAULT_CHARSET
    Fonts.NavPanelHotTrackFont.Color = clWindow
    Fonts.NavPanelHotTrackFont.Height = -11
    Fonts.NavPanelHotTrackFont.Name = 'Verdana'
    Fonts.NavPanelHotTrackFont.Style = [fsBold]
    Fonts.DividerFont.Charset = DEFAULT_CHARSET
    Fonts.DividerFont.Color = clWindowText
    Fonts.DividerFont.Height = -11
    Fonts.DividerFont.Name = 'Verdana'
    Fonts.DividerFont.Style = []
    Fonts.HeaderFont.Charset = DEFAULT_CHARSET
    Fonts.HeaderFont.Color = clWindow
    Fonts.HeaderFont.Height = -16
    Fonts.HeaderFont.Name = 'Arial'
    Fonts.HeaderFont.Style = [fsBold]
    Theme = nptCustom
    Left = 65521
    Top = 65521
  end
end
