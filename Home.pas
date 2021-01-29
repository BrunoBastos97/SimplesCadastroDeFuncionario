unit Home;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, DateUtils;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    edtNome: TEdit;
    Label1: TLabel;
    edtSalario: TEdit;
    edtData: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnAdd: TSpeedButton;
    mmFuncionarios: TMemo;
    btnApagarTexto: TSpeedButton;
    btnSalario: TSpeedButton;
    mmDestacar: TMemo;
    btnTempoContratacao: TSpeedButton;
    btnSalarioMedio: TSpeedButton;
    btnSalarioTotal: TSpeedButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Label4: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure btnSalarioClick(Sender: TObject);
    procedure btnApagarTextoClick(Sender: TObject);
    procedure btnTempoContratacaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalarioMedioClick(Sender: TObject);
    procedure btnSalarioTotalClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;

    function verificarSalarioMedioFuncionario: Float64;
    function verificarSalario: Integer;
    function verificarSalarioTotal: Float64;
    function verificarTempoDeContratacao: string;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  posicao, IdFuncionario, x: Integer;
  cadastro: array[0..4,0..2] of String;
  maiorSalario: Float64;
  maiorTempo: Integer;
  dataAtual: TDateTime;

implementation

{$R *.dfm}

procedure TForm1.btnAddClick(Sender: TObject);
begin

   if posicao <= 4 then begin
     cadastro[posicao,0]      := edtNome.Text;
     cadastro[posicao,1]      := edtData.Text;
     cadastro[posicao,2]      := edtSalario.Text;

     posicao := posicao + 1;
   end;

    if posicao > 4 then
     begin
       posicao := posicao - 1;
      // verificarSalario;

       for x := 0  to posicao do
       begin
          mmFuncionarios.Lines.Add('Nome: ' + cadastro[x, 0] +
                                   ' Data da adimição: ' + cadastro[x, 1] +
                                   ' Salário: ' + cadastro[x, 2]);
       end;
     end;

   edtNome.SetFocus;
   limpar;

end;

procedure TForm1.btnApagarTextoClick(Sender: TObject);
begin
  limpar;
end;

procedure TForm1.btnSalarioClick(Sender: TObject);
begin
      posicao := Length(cadastro) - 1;

      mmDestacar.Lines.Clear;
      verificarSalario;
      for x := 0  to posicao do
        begin
        if x = IdFuncionario then begin
          mmDestacar.Lines.Add('Nome: ' + cadastro[x, 0] +
                                   ' Data da adimição: ' + cadastro[x, 1] +
                                   ' Salário: ' + cadastro[x, 2]);
        end;
      end;
end;

procedure TForm1.btnSalarioMedioClick(Sender: TObject);
var
salarioMedio: Float64;
begin
  salarioMedio := verificarSalarioMedioFuncionario;

  mmDestacar.Lines.Clear;
  mmDestacar.Lines.Add('Salario Medio a ser pago por mês: ' + salarioMedio.ToString);
end;

procedure TForm1.btnSalarioTotalClick(Sender: TObject);
var
salarioTotal: Float64;
begin

  salarioTotal := verificarSalarioTotal;

  mmDestacar.Lines.Clear;
  mmDestacar.Lines.Add('Salario total a ser pago por mês: ' + salarioTotal.ToString);
end;

procedure TForm1.btnTempoContratacaoClick(Sender: TObject);
var
  data: string;
  caucularTempo: Integer;
begin
  data := verificarTempoDeContratacao;

   mmDestacar.Lines.Clear;
   mmDestacar.Lines.Add('Nome: ' + cadastro[IdFuncionario, 0] +
                        ' Data da adimição: ' + cadastro[IdFuncionario, 1] +
                        ' Salário: ' + cadastro[IdFuncionario, 2] +
                        ' Maior tempo de empresa: ' + data);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
dataNew: TDate;
begin
  dataNew := Date();
  dataAtual := dataNew;
end;

procedure TForm1.limpar;
begin
  edtNome.Text := '';
  edtSalario.Text := '';
  edtData.Text := '';

end;

function TForm1.verificarSalario: Integer;
begin
  for x := 0 to posicao do
  begin
      if StrToFloat(cadastro[x, 2]) > maiorSalario then begin
        maiorSalario  := StrToFloat(cadastro[x, 2]);
        IdFuncionario := x;
      end;
  end;

  Result := IdFuncionario;
end;

function TForm1.verificarSalarioMedioFuncionario: Float64;
var
salarioMedio, salario: Float64;

begin
  for x := 0 to posicao do
  begin
    salario := salario + StrToFloat(cadastro[x, 2]);
  end;

  salarioMedio := salario / Length(cadastro);
  Result := salarioMedio;
end;

function TForm1.verificarSalarioTotal: Float64;
var
salarioTotal: Float64;
begin
    for x := 0  to posicao do
    begin
    salarioTotal := salarioTotal + StrToFloat(cadastro[x, 2]);
    end;

    Result := salarioTotal;
end;

function TForm1.verificarTempoDeContratacao: string;
var
maiorTempo: TDateTime;
caucularTempo: Integer;
begin


    for x := 0  to posicao do
    begin
      caucularTempo := YearOf(dataAtual) - YearOf(StrToDateTime(cadastro[x, 1]));
      if caucularTempo > maiorTempo then begin
          maiorTempo := caucularTempo;
          IdFuncionario := x;
      end;
    end;

    Result := caucularTempo.ToString;
end;

end.
