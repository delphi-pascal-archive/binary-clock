unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;
  
type
  THelpFrm = class(TForm)
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    private
    { Private declarations }
    public
    { Public declarations }
  end;
  
var
  HelpFrm: THelpFrm;
  
implementation

{$R *.dfm}

procedure THelpFrm.FormCreate(Sender: TObject);
begin
  Label4.Caption:='Hours:'+#9+'010100'+#13+'Min.:'+#9+'001010'+#13+'Sec.:'+#9+'011110';
end;

end.
