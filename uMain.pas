unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.MPlayer,
  Vcl.ComCtrls, Vcl.Buttons, RzCommon;

type
  TForm1 = class(TForm)
    edMinute: TEdit;
    edSecond: TEdit;
    btnPlay: TButton;
    Timer1: TTimer;
    btnStop: TButton;
    Panel1: TPanel;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    edFileName: TEdit;
    btBrowse: TSpeedButton;
    ckRepeat: TCheckBox;
    btnReset: TButton;
    ini: TRzRegIniFile;
    Label4: TLabel;
    Label5: TLabel;
    edHour: TEdit;
    UpDown3: TUpDown;
    ckMessage: TCheckBox;
    mTextMessage: TMemo;
    ckWeekend: TCheckBox;
    procedure BtBrowseClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure btnStopClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ckRepeatClick(Sender: TObject);
  private
    { Private declarations }
    procedure loadSetting();
    procedure saveSetting();
    procedure sendNotif();
    function isWeekend(): boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.StrUtils, Winapi.MMSystem, System.Math, Winapi.ShellAPI;

procedure TForm1.btnPlayClick(Sender: TObject);
var
  hour, minute, second: Integer;
begin
  hour := edHour.Tag;
  minute := edMinute.Tag;
  second := edSecond.Tag;
  Timer1.Tag := (hour * 3600) + (minute * 60) + second;
  Timer1.Enabled := True;
  btnPlay.Enabled := false;
  btnReset.Enabled := false;
  btnStop.Enabled := True;
  UpDown1.Enabled := false;
  UpDown2.Enabled := false;
  UpDown3.Enabled := false;
  saveSetting;
end;

function TForm1.isWeekend(): boolean;
var
  d: Integer;
begin
  d := DayOfWeek(now());
  Result := (d = 1) or (d = 7);
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  btnPlay.Enabled := True;
  btnReset.Enabled := True;
  btnStop.Enabled := false;
  Timer1.Enabled := false;
  UpDown1.Enabled := True;
  UpDown2.Enabled := True;
  UpDown3.Enabled := True;
  UpDown1.Position := edMinute.Tag;
  UpDown2.Position := edSecond.Tag;
  UpDown3.Position := edHour.Tag;
  sndPlaySound(nil, 0);
  saveSetting;
end;

procedure TForm1.ckRepeatClick(Sender: TObject);
begin
  saveSetting;
end;

procedure TForm1.saveSetting;
begin
  ini.WriteInteger('app', 'runminute', UpDown1.Position);
  ini.WriteInteger('app', 'runsecond', UpDown2.Position);
  ini.WriteInteger('app', 'runhour', UpDown3.Position);
  ini.WriteInteger('app', 'minute', edMinute.Tag);
  ini.WriteInteger('app', 'second', edSecond.Tag);
  ini.WriteInteger('app', 'hour', edHour.Tag);
  ini.WriteBool('app', 'repeat', ckRepeat.Checked);
  ini.WriteBool('app', 'sendmessage', ckMessage.Checked);
  ini.WriteBool('app', 'includeweekend', ckWeekend.Checked);
  ini.WriteString('app', 'soundfile', edFileName.Text);
  ini.WriteBool('app', 'resume', btnStop.Enabled);
  mTextMessage.Lines.SaveToFile(ExtractFileDir(Application.ExeName) +
    '\message.txt');
end;

procedure TForm1.loadSetting;
begin
  edHour.Tag := ini.ReadInteger('app', 'hour', 0);
  edMinute.Tag := ini.ReadInteger('app', 'minute', 0);
  edSecond.Tag := ini.ReadInteger('app', 'second', 0);
  UpDown3.Position := ini.ReadInteger('app', 'runhour', 0);
  UpDown1.Position := ini.ReadInteger('app', 'runminute', 0);
  UpDown2.Position := ini.ReadInteger('app', 'runsecond', 0);
  edFileName.Text := ini.ReadString('app', 'soundfile', '');
  ckRepeat.Checked := ini.ReadBool('app', 'repeat', false);
  ckMessage.Checked := ini.ReadBool('app', 'sendmessage', false);
  ckWeekend.Checked := ini.ReadBool('app', 'includeweekend', false);
  mTextMessage.Lines.LoadFromFile(ExtractFileDir(Application.ExeName) +
    '\message.txt');
  if ini.ReadBool('app', 'resume', false) then
    btnPlayClick(self);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveSetting;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ini.Path := ExtractFileDir(Application.ExeName) + '\setting.ini';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  loadSetting();
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  Timer1.Tag := 0;
  edMinute.Tag := 0;
  edSecond.Tag := 0;
  edHour.Tag := 0;
  UpDown1.Position := 0;
  UpDown2.Position := 0;
  UpDown3.Position := 0;
  saveSetting;
end;

procedure TForm1.sendNotif();
var
  params: string;
begin
  if isWeekend() and not ckWeekend.Checked then
    exit;

  if edFileName.Text <> '' then
    sndPlaySound(PWideChar(edFileName.Text), SND_NODEFAULT Or SND_ASYNC);
  if ckMessage.Checked then
  begin
    params := 'send ALL "' + mTextMessage.Text + '"';
    // need PATH variable set to ipmsg folder
    ShellExecute(0, nil, 'ipcmd', PWideChar(params),
      nil, SW_HIDE);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  hour, minute, second: Integer;
begin

  if Timer1.Tag > 0 then
  begin
    Timer1.Tag := Timer1.Tag - 1;
    hour := floor(Timer1.Tag / 3600);
    minute := floor((Timer1.Tag - (hour * 3600)) / 60);
    second := Timer1.Tag - (minute * 60) - (hour * 3600);
    UpDown1.Position := minute;
    UpDown2.Position := second;
    UpDown3.Position := hour;
  end
  else
  begin
    sendNotif;
    if ckRepeat.Checked then
      btnPlayClick(self)
    else
      btnStopClick(self);
  end;
end;

procedure TForm1.BtBrowseClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edFileName.Text := OpenDialog1.FileName;
    saveSetting;
  end;
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  // use tag to save original value
  edMinute.Tag := UpDown1.Position;
  saveSetting;
end;

procedure TForm1.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
  // use tag to save original value
  edSecond.Tag := UpDown2.Position;
  saveSetting;
end;

procedure TForm1.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
  edHour.Tag := UpDown3.Position;
  saveSetting;
end;

end.
