object Form1: TForm1
  Left = 192
  Top = 124
  Width = 530
  Height = 418
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 32
    Top = 48
    Width = 257
    Height = 257
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
  end
  object Label1: TLabel
    Left = 32
    Top = 0
    Width = 63
    Height = 13
    Caption = 'COM port no:'
  end
  object BitBtn1: TBitBtn
    Left = 48
    Top = 344
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkClose
  end
  object Memo1: TMemo
    Left = 304
    Top = 48
    Width = 193
    Height = 257
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 424
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Send'
    Default = True
    ModalResult = 2
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 296
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 32
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '9'
  end
  object Button2: TButton
    Left = 168
    Top = 16
    Width = 75
    Height = 25
    Caption = 'ReInit'
    TabOrder = 5
    OnClick = FormCreate
  end
  object Button3: TButton
    Left = 360
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Start/Stop'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 312
    Top = 336
  end
end
