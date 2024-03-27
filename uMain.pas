unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TfMain = class(TForm)
    StatusBar1: TStatusBar;
    gboxScript: TGroupBox;
    edtScriptFile: TEdit;
    Button1: TButton;
    gboxUdl: TGroupBox;
    edtUdlFile: TEdit;
    Button2: TButton;
    mmoScript: TMemo;
    mLogs: TMemo;
    Button3: TButton;
    ADOEngine: TADOConnection;
    qCommand: TADOQuery;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;
  exepath:string;
const
  UDLFile:string='Driver.udl';
implementation

{$R *.dfm}
function timeGetTime: DWord; stdcall; external 'winmm.dll' name 'timeGetTime';

procedure TfMain.Button1Click(Sender: TObject);
var s:string;
    et :TEdit;
begin
  s := TButton(Sender).Parent.Name;
  s := Copy(s,5,High(s));
  OpenDialog1.FileName := '';
  if s = 'Script' then
    OpenDialog1.Filter := 'Script File|*.sql;*.txt'
  else
    OpenDialog1.Filter := 'UDL Connection File|*.udl';
  et := TEdit(fMain.FindComponent('edt'+s+'File'));
  et.Text := '';
  OpenDialog1.Execute();
  if FileExists(OpenDialog1.FileName) then
    TEdit(fMain.FindComponent('edt'+s+'File')).text := OpenDialog1.FileName;

  if edtScriptFile.Text <> '' then
  begin
    mmoScript.Lines.Clear;
    mmoScript.Lines.LoadFromFile(edtScriptFile.Text);
  end;
end;

procedure TfMain.Button3Click(Sender: TObject);
var colTime:DWORD;
    rColTime:real;
begin
  if (mmoScript.Lines.Count = 0) or (edtUdlFile.Text = '') then
    mLogs.Lines.Add('--ERROR: Nessecery parameter is empty!');

  mLogs.Lines.Clear;
  ADOEngine.Close;
  ADOEngine.ConnectionString := 'FILE NAME='+ edtUdlFile.Text;
  mLogs.Lines.Add('--Open UDL  file!');
  try
    ADOEngine.Open;
    mLogs.Lines.Add('--Connection has successfully!');
  except on e:Exception do
    mLogs.Lines.Add('--ERROR: ' + e.Message);
  end;
  if ADOEngine.Connected then
  begin
    colTime:=timeGetTime;
    Screen.Cursor := crSQLWait;
    try
      StatusBar1.Panels[1].Text := 'Total Line: ' + IntToStr(mmoScript.Lines.Count);
      try
        qCommand.SQL.LoadFromFile(edtScriptFile.Text);
        mLogs.Lines.Add('--Begin runs script.');
        Application.ProcessMessages;
        qCommand.ExecSQL;
        mLogs.Lines.Add('--Script runs end.');
      except on e:Exception do
        mLogs.Lines.Add('--ERROR: ' + e.Message);
      end;
    finally
      colTime:=timeGetTime-colTime;
      rColTime := colTime / 1000;
      mLogs.Lines.Add('@@ Total operation time: '+FloatToStr(rColTime)+' second(s). @@');
      mLogs.Lines.Add('@@@@ Have good moment @@@@');
      mLogs.Lines.Add('@@@@@@@@@@@@@@@@@@');
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  exepath := extractfilepath(application.exename);
  if not FileExists(exepath + UDLFile) then
  begin
    CreateUDLFile(exepath + UDLFile, 'MSOLEDBSQL.1', '');
  end;
end;

end.
