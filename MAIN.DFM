object Form1: TForm1
  Left = 129
  Top = 115
  Width = 648
  Height = 484
  Caption = 'SPWM 数据生成'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 20
    Width = 70
    Height = 14
    Caption = '脉冲分度数'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 168
    Top = 58
    Width = 56
    Height = 14
    Caption = '调制方式'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 336
    Top = 24
    Width = 84
    Height = 14
    Caption = '脉冲周期(us)'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 336
    Top = 56
    Width = 56
    Height = 14
    Caption = '输出周期'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 438
    Width = 640
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 18
    Width = 46
    Height = 18
    Caption = '载波比'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object gen: TBitBtn
    Left = 528
    Top = 15
    Width = 89
    Height = 25
    Caption = '生成'
    Default = True
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = genClick
  end
  object StaticText3: TStaticText
    Left = 8
    Top = 56
    Width = 67
    Height = 18
    Caption = '调制比(%)'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object indexinput: TEdit
    Left = 80
    Top = 54
    Width = 65
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '80'
  end
  object UpDown1: TUpDown
    Left = 145
    Top = 54
    Width = 17
    Height = 22
    Associate = indexinput
    Min = 0
    Position = 80
    TabOrder = 9
    Wrap = False
  end
  object carrier: TEdit
    Left = 80
    Top = 16
    Width = 65
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = '20'
  end
  object save: TBitBtn
    Left = 528
    Top = 53
    Width = 89
    Height = 25
    Caption = '输出到文件'
    Enabled = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = saveClick
  end
  object XYPLOT: Tsp_XYPlot
    Left = 0
    Top = 88
    Width = 640
    Height = 350
    Color = clBtnFace
    ParentColor = False
    TabOrder = 10
    ZoomShiftKeys = [ssCtrl]
    PanShiftKeys = [ssShift]
    PanCursor = crSizeAll
    LeftAxis.Margin = 4
    LeftAxis.LineAttr.Color = clBlack
    LeftAxis.LineAttr.Visible = True
    LeftAxis.GridAttr.Color = clGray
    LeftAxis.GridAttr.Visible = True
    LeftAxis.LabelFormat = '###0.##'
    LeftAxis.SFlags = 1
    LeftAxis.SLinePos = (
      33
      328
      319)
    LeftAxis.fMin = -1
    LeftAxis.fMax = 1
    RightAxis.Margin = 4
    RightAxis.LineAttr.Color = clBlack
    RightAxis.LineAttr.Visible = True
    RightAxis.GridAttr.Color = clGray
    RightAxis.GridAttr.Visible = False
    RightAxis.LabelFormat = '###0.##'
    RightAxis.SFlags = 57
    RightAxis.SLinePos = (
      630
      328
      319)
    RightAxis.fMax = 1
    BottomAxis.Margin = 4
    BottomAxis.LineAttr.Color = clBlack
    BottomAxis.LineAttr.Visible = True
    BottomAxis.GridAttr.Color = clGray
    BottomAxis.GridAttr.Visible = True
    BottomAxis.LabelFormat = '###0.##'
    BottomAxis.SFlags = 0
    BottomAxis.SLinePos = (
      34
      329
      595)
    BottomAxis.fMax = 10
    TopAxis.Margin = 4
    TopAxis.LineAttr.Color = clBlack
    TopAxis.LineAttr.Visible = True
    TopAxis.GridAttr.Color = clGray
    TopAxis.GridAttr.Visible = False
    TopAxis.LabelFormat = '###0.##'
    TopAxis.SFlags = 56
    TopAxis.SLinePos = (
      34
      8
      595)
    TopAxis.fMax = 10
    BorderStyle = bs_None
    FieldColor = clWhite
    BufferedDisplay = True
  end
  object Mode: TComboBox
    Left = 248
    Top = 54
    Width = 73
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 4
    Items.Strings = (
      '单极性'
      '双极性')
  end
  object pluseinput: TEdit
    Left = 248
    Top = 16
    Width = 73
    Height = 22
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = '宋体'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = '256'
  end
  object ptime: TEdit
    Left = 424
    Top = 16
    Width = 81
    Height = 21
    TabOrder = 11
    Text = '256'
  end
  object outperiod: TComboBox
    Left = 424
    Top = 56
    Width = 81
    Height = 23
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = '宋体'
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 12
    Items.Strings = (
      '1/4周期'
      '半周期'
      '全周期')
  end
  object sinplot: Tsp_XYLine
    Plot = XYPLOT
    LineAttr.Color = clBlack
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = True
    Left = 592
    Top = 96
  end
  object pwmplot: Tsp_XYLine
    Plot = XYPLOT
    LineAttr.Color = clRed
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    Left = 592
    Top = 128
  end
  object triplot: Tsp_XYLine
    Plot = XYPLOT
    LineAttr.Color = clGreen
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    PointAttr.BorderColor = clGreen
    Left = 592
    Top = 160
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'H'
    Filter = 
      'PIC汇编语言|*.ASM|CC5xfree(PIC)头文件|*.H|C语言查表子程序（CC5xf' +
      'ree)|*.C|PSPICE激励文件|*.STL'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofCreatePrompt, ofEnableSizing]
    Title = '保存数据到文件'
    Left = 592
    Top = 56
  end
end
