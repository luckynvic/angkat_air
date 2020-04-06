object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'luckynvic@gmail.com'
  ClientHeight = 290
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 222
    Top = 69
    Width = 17
    Height = 58
    Caption = ':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 124
    Top = 48
    Width = 32
    Height = 13
    Caption = 'Minute'
  end
  object Label3: TLabel
    Left = 243
    Top = 47
    Width = 35
    Height = 13
    Caption = 'Second'
  end
  object btBrowse: TSpeedButton
    Left = 311
    Top = 170
    Width = 26
    Height = 22
    Caption = '...'
    OnClick = BtBrowseClick
  end
  object Label4: TLabel
    Left = 106
    Top = 68
    Width = 17
    Height = 58
    Caption = ':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 47
    Width = 23
    Height = 13
    Caption = 'Hour'
  end
  object edMinute: TEdit
    Tag = 30
    Left = 124
    Top = 67
    Width = 80
    Height = 66
    TabStop = False
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Text = '30'
  end
  object edSecond: TEdit
    Left = 243
    Top = 67
    Width = 78
    Height = 66
    TabStop = False
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = '0'
  end
  object btnPlay: TButton
    Left = 287
    Top = 139
    Width = 50
    Height = 25
    Caption = 'Play'
    TabOrder = 2
    OnClick = btnPlayClick
  end
  object btnStop: TButton
    Left = 245
    Top = 139
    Width = 43
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 3
    OnClick = btnStopClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 41
    Align = alTop
    Caption = 'Angkat Air'
    Color = clWindowText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  object UpDown1: TUpDown
    Left = 204
    Top = 67
    Width = 16
    Height = 66
    Associate = edMinute
    Max = 59
    Position = 30
    TabOrder = 5
    OnClick = UpDown1Click
  end
  object UpDown2: TUpDown
    Left = 321
    Top = 67
    Width = 16
    Height = 66
    Associate = edSecond
    Max = 59
    TabOrder = 6
    OnClick = UpDown2Click
  end
  object edFileName: TEdit
    Left = 8
    Top = 170
    Width = 297
    Height = 21
    TabOrder = 7
  end
  object ckRepeat: TCheckBox
    Left = 8
    Top = 142
    Width = 84
    Height = 17
    Caption = 'Repeat more'
    TabOrder = 8
  end
  object btnReset: TButton
    Left = 178
    Top = 139
    Width = 61
    Height = 25
    Caption = 'Reset'
    TabOrder = 9
    OnClick = btnResetClick
  end
  object edHour: TEdit
    Tag = 30
    Left = 8
    Top = 66
    Width = 80
    Height = 66
    TabStop = False
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 10
    Text = '0'
  end
  object UpDown3: TUpDown
    Left = 88
    Top = 66
    Width = 16
    Height = 66
    Associate = edHour
    Max = 59
    TabOrder = 11
    OnClick = UpDown3Click
  end
  object ckMessage: TCheckBox
    Left = 8
    Top = 270
    Width = 97
    Height = 17
    Caption = 'Send Message'
    TabOrder = 12
  end
  object mTextMessage: TMemo
    Left = 8
    Top = 197
    Width = 329
    Height = 67
    TabOrder = 13
  end
  object ckWeekend: TCheckBox
    Left = 123
    Top = 270
    Width = 116
    Height = 17
    Caption = 'Include Weekend'
    TabOrder = 14
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 54
    Top = 6
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Wav Sound (*.wav)|*.wav|MP3 (*.mp3)|*.mp3|All Files (*.*)|*.*'
    Options = [ofReadOnly, ofHideReadOnly, ofEnableSizing]
    Left = 18
    Top = 6
  end
  object ini: TRzRegIniFile
    Left = 90
    Top = 6
  end
end
