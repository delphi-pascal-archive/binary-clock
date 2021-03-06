

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Buttons;
  
type
  TForm1 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BgImgMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    private
    { Private declarations }
    
    HrImg: Array [1..6] of TImage;
    MinImg: Array [1..6] of TImage;
    SecImg: Array [1..6] of TImage;
    Procedure FindHour(hr: Word);
    Procedure FindMin(Min: Word);
    Procedure FindSec(Sec: Word);
    public
    { Public declarations }
  end;
  
var
  Form1: TForm1;
  Hr,Min,sec,mSec: Word;
  
Const
  
  Nr1: Array [1..60] of String = ('100000','010000','110000','001000',  //1,2,3,4
  '101000','011000','111000','000100',   //5,6,7,8
  '100100','010100','110100','001100',  //9,10,11,12
  '101100','011100','111100','000010',  //13-
  '100010','010010','110010','001010',
  '101010','011010','111010','000110',
  '100110','010110','110110','001110',
  '101110','011110','111110','000001',
  '100001','010001','110001','001001', //36
  '101001','011001','111001','000101', //40
  '100101','010101','110101','001101', //44
  '101101','011101','111101','000011', //48
  '100011','010011','110011','001011', //52
  '101011','011011','111011','000111', //56
  '100111','010111','110111','001111'); //60
  
implementation

uses Unit2;
  
{$R *.dfm}
{$R images.res}


Procedure TForm1.FindHour(hr: Word);
Var i:Byte;
begin
  if hr>12 then hr:=hr-12;
  For i:=1 to 6 do
    if Nr1[hr,i]='1' then HrImg[i].Picture.Bitmap.LoadFromResourceName(hinstance,'ledOn')
  else HrImg[i].Picture.Bitmap.LoadFromResourceName(hinstance,'ledOff');
end;

Procedure TForm1.FindMin(min: Word);
Var i:Byte;
begin
  For i:=1 to 6 do
    if Nr1[Min,i]='1' then MinImg[i].Picture.Bitmap.LoadFromResourceName(hinstance,'ledOn')
  else MinImg[i].Picture.Bitmap.LoadFromResourceName(hinstance,'ledOff');
end;

Procedure TForm1.FindSec(Sec: Word);
Var i:Byte;
begin
  For i:=1 to 6 do
    if Nr1[sec,i]='1' then SecImg[i].Picture.Bitmap.LoadFromResourceName(hinstance,'ledOn')
  else SecImg[i].Picture.Bitmap.LoadFromResourceName(hinstance,'ledOff');
end;

procedure TForm1.FormCreate(Sender: TObject);
Var i: Byte;
  L,T: Integer;
begin
  Form1.AutoSize:=True;
  L:=8;
  T:=37;
  for i:=1 to 6 do begin
  HrImg[i]:=TImage.Create(Self);
  HrImg[i].Name:='HrImg'+IntToStr(i);
  HrImg[i].Parent:=Form1;
  HrImg[i].Left:=L;
  HrImg[i].Top:=T;
  HrImg[i].Width:=16;
  HrImg[i].Height:=16;
  HrImg[i].OnMouseDown:=BgImgMouseDown;
  L:=L+16;
end;
L:=8;
T:=T+16;

for i:=1 to 6 do begin
MinImg[i]:=TImage.Create(Self);
MinImg[i].Name:='MinImg'+IntToStr(i);
MinImg[i].Parent:=Form1;
MinImg[i].Left:=L;
MinImg[i].Top:=T;
MinImg[i].Width:=16;
MinImg[i].Height:=16;
MinImg[i].OnMouseDown:=BgImgMouseDown;
L:=L+16;
end;
L:=8;
T:=T+16;

for i:=1 to 6 do begin
SecImg[i]:=TImage.Create(Self);
SecImg[i].Name:='SecShape'+IntToStr(i);
SecImg[i].Parent:=Form1;
SecImg[i].Left:=L;
SecImg[i].Top:=T;
SecImg[i].Width:=16;
SecImg[i].Height:=16;
SecImg[i].OnMouseDown:=BgImgMouseDown;
L:=L+16;
end;
Label1.Caption:=FormatDateTime('hh:mm:ss',Time);
Label2.Caption:=FormatDateTime('dd.mm.yyyy',Date);
DecodeTime(TIme,hr,min,sec,msec);
FindHour(hr);
FindMin(min);
FindSec(Sec);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
Var i:Byte;
begin
  
  for i:=Low(HrImg) to High(HrImg) do begin
  HrImg[i].Free;
  MinImg[i].Free;
  SecImg[i].Free;
end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Label1.Caption:=FormatDateTime('hh:mm:ss',Time);
  Sec:=Sec+1;
  if Sec>60 then begin
  sec:=1;
  Min:=Min+1;
  FindMin(Min);
  if Min>60 then begin
  Min:=1;
  Hr:=Hr+1;
  FindHour(Hr);
end;
end;
FindSec(Sec);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BgImgMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
  
  ReleaseCapture;
  Form1.Perform(WM_SysCommand,$f012,1);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  HelpFrm.ShowModal;
end;

end.
