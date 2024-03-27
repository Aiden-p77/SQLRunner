object fMain: TfMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'SQL Script Runner'
  ClientHeight = 465
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 446
    Width = 649
    Height = 19
    Panels = <
      item
        Text = 'Ver 1.0.0.1'
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end>
    ExplicitLeft = 368
    ExplicitTop = 304
    ExplicitWidth = 0
  end
  object gboxScript: TGroupBox
    Left = 12
    Top = 67
    Width = 629
    Height = 233
    Caption = 'Script'
    TabOrder = 1
    object edtScriptFile: TEdit
      Left = 7
      Top = 16
      Width = 510
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 523
      Top = 14
      Width = 99
      Height = 25
      Caption = 'Open'
      TabOrder = 1
      OnClick = Button1Click
    end
    object mmoScript: TMemo
      Left = 7
      Top = 43
      Width = 615
      Height = 182
      ScrollBars = ssBoth
      TabOrder = 2
    end
  end
  object gboxUdl: TGroupBox
    Left = 12
    Top = 12
    Width = 629
    Height = 49
    Caption = 'UDL Connection'
    TabOrder = 2
    object edtUdlFile: TEdit
      Left = 7
      Top = 16
      Width = 510
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object Button2: TButton
      Left = 523
      Top = 14
      Width = 99
      Height = 25
      Caption = 'Open'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object mLogs: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 343
    Width = 643
    Height = 100
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Button3: TButton
    Left = 224
    Top = 302
    Width = 209
    Height = 35
    Caption = 'Run SQL Script'
    TabOrder = 4
    OnClick = Button3Click
  end
  object ADOEngine: TADOConnection
    LoginPrompt = False
    Provider = 'MSOLEDBSQL.1'
    Left = 24
    Top = 208
  end
  object qCommand: TADOQuery
    Connection = ADOEngine
    Parameters = <>
    Left = 24
    Top = 280
  end
  object OpenDialog1: TOpenDialog
    Left = 536
    Top = 224
  end
end
