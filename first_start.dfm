object Frm_First: TFrm_First
  Left = 493
  Top = 313
  BorderIcons = []
  BorderStyle = bsNone
  BorderWidth = 1
  Caption = 'First Run'
  ClientHeight = 269
  ClientWidth = 265
  Color = clSilver
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
  PixelsPerInch = 96
  TextHeight = 13
  object imgTitle: TImage
    Left = 0
    Top = 0
    Width = 265
    Height = 24
    Align = alTop
    Picture.Data = {
      0A544A504547496D6167659A010000FFD8FFE000104A46494600010200006400
      640000FFEC00114475636B7900010004000000640000FFEE000E41646F626500
      64C000000001FFDB008400010101010101010101010101010101010101010101
      0101010101010101010101010101010101010101010102020202020202020202
      0203030303030303030303010101010101010201010202020102020303030303
      0303030303030303030303030303030303030303030303030303030303030303
      030303030303030303030303FFC00011080018001403011100021101031101FF
      C400690000020300000000000000000000000000000108090A01010100000000
      0000000000000000000000011000000207050900000000000000000000000301
      D10253D3041792A2D25416112141514293346494110101010101000000000000
      000000000000112141B1FFDA000C03010002110311003F00D81547977A5DD500
      75225F81AC5DC2070AA44B3D2F9F4E10C36D5585749B708DFEDA60002BA4DB94
      7D698000AE936E11F5A600080DAD4BCD176D958406B52F6F945DB65629E9EB52
      B345F71958891FFFD9}
    Stretch = True
    OnMouseMove = _MouseMove
  end
  object lblTitle: TLabel
    Left = 5
    Top = 5
    Width = 45
    Height = 13
    Caption = 'lblTitle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
    OnMouseMove = _MouseMove
  end
  object btnClose: TJvTransparentButton
    Left = 250
    Top = 7
    Width = 10
    Height = 10
    BorderWidth = 0
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    FrameStyle = fsNone
    ShowPressed = False
    OnClick = _Close
    Glyph.Data = {
      42010000424D4201000000000000420000002800000010000000080000000100
      10000300000000010000120B0000120B00000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C007C007C1F7C1F7C007C007C1F7C1F7C104210421F7C1F7C
      104210421F7C1F7C1F7C007C1F7C1F7C007C1F7C1F7C1F7C1F7C10421F7C1F7C
      10421F7C1F7C1F7C1F7C1F7C007C007C1F7C1F7C1F7C1F7C1F7C1F7C10421042
      1F7C1F7C1F7C1F7C1F7C1F7C007C007C1F7C1F7C1F7C1F7C1F7C1F7C10421042
      1F7C1F7C1F7C1F7C1F7C007C1F7C1F7C007C1F7C1F7C1F7C1F7C10421F7C1F7C
      10421F7C1F7C1F7C007C007C1F7C1F7C007C007C1F7C1F7C104210421F7C1F7C
      104210421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    NumGlyphs = 2
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 245
    Width = 265
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object gradButtons: TJvGradient
      Left = 0
      Top = 0
      Width = 265
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
      OnClick = _Close
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 24
    Width = 265
    Height = 221
    Align = alClient
    BevelOuter = bvNone
    Color = clGray
    TabOrder = 1
    object lblMessage: TLabel
      Left = 5
      Top = 6
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object btnBrowse: TJvTransparentButton
      Left = 240
      Top = 44
      Width = 20
      Height = 20
      AutoGray = False
      BorderWidth = 0
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      FrameStyle = fsNone
      ShowPressed = False
      OnClick = btnBrowseClick
      Glyph.Data = {
        36080000424D3608000000000000360000002800000020000000100000000100
        20000000000000080000120B0000120B00000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF5D
        3100FF572500FF572500FF572500FF572500FF572500FF572500FF572500FF57
        2500FF572500FF572500FF572500FF572500FF5D3100FF00FF00FF00FF009898
        9800929292009292920092929200929292009292920092929200929292009292
        92009292920092929200929292009292920098989800FF00FF00FF00FF00FF57
        2500E8C1AC00E2DACD00E1D8C700E1D5C100E1D5C100E0D3BC00DFD0B600DFD0
        B600DECEB000DECBAA00DECBAA00E5B59200FF572500FF00FF00FF00FF009292
        9200CACACA00D7D7D700D4D4D400D1D1D100D1D1D100CECECE00CACACA00CACA
        CA00C7C7C700C4C4C400C4C4C400BBBBBB0092929200FF00FF00FF00FF00FF57
        2500E3DDD300E2DACD00E2DACD00E1D8C700E1D5C100E1D5C100E0D3BC00E0D3
        BC00DFD0B600DECEB000DECEB000DECEB000FF572500FF00FF00FF00FF009292
        9200DBDBDB00D7D7D700D7D7D700D4D4D400D1D1D100D1D1D100CECECE00CECE
        CE00CACACA00C7C7C700C7C7C700C7C7C70092929200FF00FF00FF00FF00FF57
        2500C4D6D20000A0AA0000A0AA0000A0AA0000A0AA0000A0AA0000A0AA0000A0
        AA0000A0AA006CBAB300DFD0B600DECEB000FF572500FF00FF00FF00FF009292
        9200CDCDCD005555550055555500555555005555550055555500555555005555
        55005555550093939300CACACA00C7C7C70092929200FF00FF00FF00FF00FF57
        250000A0AA000BADBA0043E4F50042E3F40040DFF1003EDAEE003CD7EB003BD3
        E9003AD2E800049EA800DFD0B600DECEB000FF572500FF00FF00FF00FF009292
        920055555500626262009C9C9C009B9B9B009898980096969600939393009292
        92009191910056565600CACACA00C7C7C70092929200FF00FF00FF00FF00FF57
        250004A9B4000CAFBB0025C9D60044E7F60041DFF20040DFF1003FDBEE003CD6
        EB003BD3E9000EACB90044ADAE00DFD0B600FF572500FF00FF00FF00FF009292
        92005C5C5C00636363007D7D7D009D9D9D009999990098989800969696009393
        9300929292006363630079797900CACACA0092929200FF00FF00FF00FF00FF57
        250004A9B40014CAD7000CAFBB0063DFEB0043E4F50042E3F40040DFF1003EDA
        EE003CD7EB0021BFCE009EC3B4007ABBB300FF572500FF00FF00FF00FF009292
        92005C5C5C007575750063636300A7A7A7009C9C9C009B9B9B00989898009696
        96009393930077777700B0B0B0009A9A9A0092929200FF00FF00FF00FF00FF57
        250008B1BC0022F1FE0017D1DF0015BDC9000CAFBB000CAFBB000BADBA0009AA
        B80008A7B600039BA50012A0A7002FAAAF00FF572500FF00FF00FF00FF009292
        920062626200909090007B7B7B006F6F6F006363630063636300626262006060
        60005F5F5F00545454005C5C5C006F6F6F0092929200FF00FF00FF00FF00FF57
        25000BB9C40065F0F90022F1FE0020EDFB001DE8F7001AE2F3001AE2F30018DC
        F00015D6EC0003A6B000AECEC400C6D0C000FF572500FF00FF00FF00FF009292
        920067676700AFAFAF00909090008D8D8D008A8A8A0086868600868686008484
        84008080800059595900BEBEBE00C8C8C80092929200FF00FF00FF00FF00FF57
        25000DBFCB0094EFF70048F1FB0022F1FE0034D9E30015C6D00019C5CF0019C4
        CE0018C3CE0003A6B000E2DACD00E1D8C700FF572500FF00FF00FF00FF009292
        92006C6C6C00C5C5C500A1A1A100909090008B8B8B0072727200747474007373
        73007373730059595900D7D7D700D4D4D40092929200FF00FF00FF00FF00FF57
        2500D9DDD80011C8D3000FC2CD0009B5C00060BBBE00E4E0DA00E4DFD800E4DF
        D800E3DDD300E2DACD00E2DACD00E2DACD00FF572500FF00FF00FF00FF009292
        9200DADADA00727272006E6E6E00646464008F8F8F00DFDFDF00DEDEDE00DEDE
        DE00DBDBDB00D7D7D700D7D7D700D7D7D70092929200FF00FF00FF00FF00FF67
        3A00FFBCA700E9CEC600E9CEC600E9CEC600E9CEC600E9CEC500E9CEC600E8CC
        BF00E7CBBA00E7CBBA00E6C9B600FCBFAC00E7481C00FF00FF00FF00FF009C9C
        9C00D3D3D300D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D7D7D700D3D3
        D300D0D0D000D0D0D000CECECE00D4D4D40081818100FF00FF00FF00FF00FF77
        5200FF714A00FF6E4700FF6B4300FF694100FF653C00FF603700FE5A3000F859
        3000F4583000F25830000000FD00413EE700F25E3800FF00FF00FF00FF00A8A8
        A800A4A4A400A3A3A300A1A1A100A0A0A0009D9D9D009B9B9B00979797009494
        940092929200919191007E7E7E009292920095959500FF00FF00FF00FF00FF00
        FF00FF775200FF775200FF744F00FF714B00FF6F4900FF6B4400FF663F00FE60
        3800F85F3800F45F3800B473A6006625A600FF00FF00FF00FF00FF00FF00FF00
        FF00A8A8A800A8A8A800A7A7A700A5A5A500A4A4A400A1A1A1009F9F9F009B9B
        9B0098989800969696009393930065656500FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      NumGlyphs = 2
    end
    object editLogFilePath: TLabeledEdit
      Left = 5
      Top = 44
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
      ReadOnly = True
      TabOrder = 0
    end
    object cbDesktopShortcut: TCheckBox
      Left = 5
      Top = 74
      Width = 250
      Height = 17
      Caption = 'Create Desktop Shortcut'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
end
