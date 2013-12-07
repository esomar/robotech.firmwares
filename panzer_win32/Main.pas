unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unComPort, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Timer1: TTimer;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Label1: TLabel;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  s:string;
  ComPort:TComPort;
  xs:integer;
  ys:integer;
  overmode:boolean=false;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
ComPort := TComPort.Create;

ComPort.Number := StrToIntDef(Edit2.text,9); // какой COM порт открывать
ComPort.Speed := cps115200; // ну и остальные параметры тоже настроить
if not ComPort.Open() then Form1.Caption:='error' // если не открылось, то ошибка
else
if ComPort.Read(s)>0 then begin // если что-то прочиталось
    Memo1.Lines.Add(s);
end;
xs:=0;
ys:=127;

PaintBox1.Canvas.MoveTo(0,127);
PaintBox1.Canvas.LineTo(255,127);
PaintBox1.Canvas.MoveTo(127,0);
PaintBox1.Canvas.LineTo(127,255);

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ComPort.Close; // закрыть

ComPort.Free;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
If Button=mbLeft then begin
PaintBox1.Canvas.MoveTo(0,127);
PaintBox1.Canvas.LineTo(255,127);
PaintBox1.Canvas.MoveTo(127,0);
PaintBox1.Canvas.LineTo(127,255);
PaintBox1.Canvas.MoveTo(127,127);
PaintBox1.Canvas.LineTo(X,Y);
xs:=(127-x);
ys:=(256-y);
end else if Button=mbRight then overmode:=not overmode;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
s:='l '+inttostr(ys - xs)+#10+#13;
if ComPort.Write(s)=0 then Form1.Caption:='error';

if ComPort.Read(s)>0 then begin // если что-то прочиталось
    Memo1.Lines.Add(s);
end;

s:='r '+inttostr(ys + xs)+#10+#13;
if ComPort.Write(s)=0 then Form1.Caption:='error';

if ComPort.Read(s)>0 then begin // если что-то прочиталось
    Memo1.Lines.Add(s);
end;
{
if(ys>150) then ys:=ys-5;
if(ys<110) then ys:=ys+5;
if(xs>10) then xs:=xs-5;
if(xs<-10) then xs:=xs+5;
}
form1.Caption:= 'd '+inttostr(xs) + ' f '+inttostr(ys);

if memo1.Lines.Count > 10000 then memo1.Lines.Clear;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if ComPort.Write(Edit1.Text)=0 then Form1.Caption:='error';
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if overmode then
begin
PaintBox1.Canvas.MoveTo(0,127);
PaintBox1.Canvas.LineTo(255,127);
PaintBox1.Canvas.MoveTo(127,0);
PaintBox1.Canvas.LineTo(127,255);
PaintBox1.Canvas.MoveTo(127,127);
PaintBox1.Canvas.LineTo(X,Y);
xs:=(127-x);
ys:=(256-y);
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Timer1.Enabled:=not Timer1.Enabled;
end;

end.
