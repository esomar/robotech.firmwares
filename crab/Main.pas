unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unComPort, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Timer1: TTimer;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Label1: TLabel;
    Button3: TButton;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    TrackBar2: TTrackBar;
    Label3: TLabel;
    TrackBar3: TTrackBar;
    Label4: TLabel;
    TrackBar4: TTrackBar;
    Label5: TLabel;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    OpenDialog1: TOpenDialog;
    Button8: TButton;
    Timer2: TTimer;
    Button9: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  s:string;
  ComPort:TComPort;
h,vl,vh,hand:integer;
  overmode:boolean=false;
  recording:boolean=false;
  MacroFilename:string='log.cmr';
  TimerState:boolean;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
ComPort := TComPort.Create;
h:=TrackBar1.Position;
vl:=TrackBar2.Position;
vh:=TrackBar3.Position;
hand:=TrackBar4.Position;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ComPort.Close; // �������

ComPort.Free;
end;



procedure TForm1.Timer1Timer(Sender: TObject);
begin
s:='h '+inttostr(h);
if ComPort.Write(s+#10+#13)=0 then Form1.Caption:='error';
if recording then writeln(s);
if ComPort.Read(s)>0 then begin // ���� ���-�� �����������
    Memo1.Lines.Add(s);
end;

s:=' vl '+inttostr(vl);
if ComPort.Write(s+#10+#13)=0 then Form1.Caption:='error';
if recording then writeln(s);
if ComPort.Read(s)>0 then begin // ���� ���-�� �����������
    Memo1.Lines.Add(s);
end;

s:=' vh '+inttostr(vh);
if ComPort.Write(s+#10+#13)=0 then Form1.Caption:='error';
if recording then writeln(s);
if ComPort.Read(s)>0 then begin // ���� ���-�� �����������
    Memo1.Lines.Add(s);
end;

s:=' handr '+inttostr(hand);
if ComPort.Write(s+#10+#13)=0 then Form1.Caption:='error';
if recording then writeln(s);
if ComPort.Read(s)>0 then begin // ���� ���-�� �����������
    Memo1.Lines.Add(s);
end;

s:=' handl '+inttostr(180-hand);
if ComPort.Write(s+#10+#13)=0 then Form1.Caption:='error';
if recording then writeln(s);
if ComPort.Read(s)>0 then begin // ���� ���-�� �����������
    Memo1.Lines.Add(s);
end;





if memo1.Lines.Count > 10000 then memo1.Lines.Clear;

end;


procedure TForm1.Button1Click(Sender: TObject);
begin
 if ComPort.Write(Edit1.Text)=0 then Form1.Caption:='error';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Timer1.Enabled:=not Timer1.Enabled;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
h:=TrackBar1.Position;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
vl:=TrackBar2.Position;
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
vh:=TrackBar3.Position;
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
hand:=TrackBar4.Position;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

ComPort.Number := StrToIntDef(Edit2.text,9); // ����� COM ���� ���������
ComPort.Speed := cps115200; // �� � ��������� ��������� ���� ���������
if not ComPort.Open() then Form1.Caption:='error' // ���� �� ���������, �� ������
else
if ComPort.Read(s)>0 then begin // ���� ���-�� �����������
    Memo1.Lines.Add(s);
end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
if SaveDialog1.Execute() then
begin
MacroFilename:=SaveDialog1.FileName;
OpenDialog1.FileName:=MacroFilename;
end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
//������������� ������
Button5.Enabled:=false;
Button7.Enabled:=false;
Button8.Enabled:=false;
Button6.Enabled:=true;
//��������� ���� ��� ������
AssignFile(Output,MacroFilename);
Rewrite(Output);
//���������� ���� ������
Recording:=true;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
//������������� ������
Button5.Enabled:=true;
Button7.Enabled:=true;
Button8.Enabled:=true;
Button6.Enabled:=false;
//��������� ����
CloseFile(Output);
//������� ���� ������
Recording:=false;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
if OpenDialog1.Execute()then
begin
MacroFilename:=OpenDialog1.FileName;
end;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
//���������� ��������� ������� ������� ����������,��������� ���.
TimerState:=Timer1.Enabled;
Timer1.Enabled:=false;
//������������� ������
Button4.Enabled:=false;
Button5.Enabled:=false;
Button7.Enabled:=false;
Button8.Enabled:=false;
//��������� ���� ��� ������.
AssignFile(input,MacroFilename);
Reset(input);
//��������� ������ ���������������
Timer2.Enabled:=true;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var i:integer;
begin
//���������, �� �������� �� ����
if not eof(input) then
begin
//������ 5 ������ �� �����, ������� �� � ��������
  for i:=1 to 5 do
    begin
    readln(s);
    if ComPort.Write(s+#10+#13)=0 then Form1.Caption:='error';
    if ComPort.Read(s)>0 then
      begin // ���� ���-�� �����������
      Memo1.Lines.Add(s);
      end;
  end;
end
else
 begin
 //��������� ������ ���������������
 Timer2.Enabled:=False;
 //��������������� ������ ������� ����������
 Timer1.Enabled:=TimerState;
 //��������� ����
 CloseFile(input);
 //������������� ������
  Button4.Enabled:=true;
  Button5.Enabled:=true;
  Button7.Enabled:=true;
  Button8.Enabled:=true;
 end;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
TrackBar1.Position:=120;
h:=TrackBar1.Position;
TrackBar2.Position:=40;
vl:=TrackBar2.Position;
TrackBar3.Position:=50;
vh:=TrackBar3.Position;
TrackBar4.Position:=30;
hand:=TrackBar4.Position;
end;

end.
