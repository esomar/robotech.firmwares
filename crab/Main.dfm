object Form1: TForm1
  Left = 192
  Top = 124
  Width = 747
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
  object Label1: TLabel
    Left = 32
    Top = 0
    Width = 63
    Height = 13
    Caption = 'COM port no:'
  end
  object Label2: TLabel
    Left = 24
    Top = 264
    Width = 62
    Height = 13
    Caption = 'Base rotation'
  end
  object Label3: TLabel
    Left = 24
    Top = 192
    Width = 60
    Height = 13
    Caption = 'Lower elbow'
  end
  object Label4: TLabel
    Left = 24
    Top = 120
    Width = 60
    Height = 13
    Caption = 'Upper elbow'
  end
  object Label5: TLabel
    Left = 24
    Top = 48
    Width = 26
    Height = 13
    Caption = 'Hand'
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
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 416
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Start/Stop'
    TabOrder = 6
    OnClick = Button3Click
  end
  object TrackBar1: TTrackBar
    Left = 16
    Top = 288
    Width = 273
    Height = 41
    Max = 180
    Frequency = 10
    Position = 120
    TabOrder = 7
    TickMarks = tmTopLeft
    OnChange = TrackBar1Change
  end
  object TrackBar2: TTrackBar
    Left = 16
    Top = 216
    Width = 273
    Height = 41
    Max = 180
    Frequency = 10
    Position = 40
    TabOrder = 8
    TickMarks = tmTopLeft
    OnChange = TrackBar2Change
  end
  object TrackBar3: TTrackBar
    Left = 16
    Top = 144
    Width = 273
    Height = 41
    Max = 180
    Frequency = 10
    Position = 50
    TabOrder = 9
    TickMarks = tmTopLeft
    OnChange = TrackBar3Change
  end
  object TrackBar4: TTrackBar
    Left = 16
    Top = 72
    Width = 273
    Height = 41
    Max = 180
    Frequency = 10
    Position = 30
    TabOrder = 10
    TickMarks = tmTopLeft
    OnChange = TrackBar4Change
  end
  object Button4: TButton
    Left = 520
    Top = 32
    Width = 201
    Height = 25
    Caption = 'Select file to save'
    TabOrder = 11
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 520
    Top = 64
    Width = 201
    Height = 25
    Caption = 'Start recording'
    TabOrder = 12
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 520
    Top = 96
    Width = 201
    Height = 25
    Caption = 'Stop recording'
    Enabled = False
    TabOrder = 13
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 520
    Top = 128
    Width = 201
    Height = 25
    Caption = 'Open record'
    TabOrder = 14
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 520
    Top = 160
    Width = 201
    Height = 25
    Caption = 'Play record'
    TabOrder = 15
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 312
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Retract'
    TabOrder = 16
    OnClick = Button9Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 312
    Top = 336
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Crab macros(*.cmr)|*.cmr'
    Left = 624
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Crab macros(*.cmr)|*.cmr'
    Left = 656
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer2Timer
    Left = 688
    Top = 192
  end
end
