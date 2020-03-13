unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UBaseConzRecalc, UClasses, URasp, Math;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IniDefRasp(var Rasp: TRasp; M_exp, ro_exp: double);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  Ncomp = 47;
  NGr = 6;
  NFr = 5;
  NGen = 19;
  //����������
  ArName: array [0..NComp-1] of string =(
     '�9 �����',	'�10 �����',	'�11 �-�������',	'�12 �-�������',	'�13 �-��������',	'�14 �-����������',	'�15 �-����������',	'�16 �-����������',	'�17 �-����������',	'�18',	'�19 �-����������',	'�20 �-�������',	'�21 �-����������',	'�22 �-������� ',	'�23 �-��������',
     '�9 1-�����',	'�10 1- �����',	'�11 1-�������',	'�12 1-�������',	'�13 1-��������',	'�14 1-����������',	'�15 1-����������',	'�16 1-����������',	'�17 1-����������',	'�18 1-���������',
     '�������������������� �9�18',	'�-���������������� �10�20',	'�-����������������� �11�22',	'�-���������������� �12�24',	'�-���������������� �13�26',	'�-��������������� �14�28',	'�-��������������� �15�30',	'�-���������������� �16�32',	'�-������������������� C18H36',
     '�����������',	'������������',	'������������',	'�����������',	'�����������',	'2-����������',	'1,4-������������',	'1-�����-4-��������������',
     '��������',	'1-�������������',	'�������',	'������������',
     '��������'

  );
  ArIdGroup: array [0..NComp-1] of integer =(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  1,1,1,1,1,1,1,1,1,1,
  2,2,2,2,2,2,2,2,2,
  3,3,3,3,3,3,3,3,
  4,4,4,4,
  5
  );
  ArSelfId: array [0..NComp-1] of integer =(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
  1,2,3,4,5,6,7,8,9,10,
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,
  1,2,3,4,
  1
  );
  ArTc: array [0..NComp-1] of double =(
  594.6,617.6,638.8,658.3,508.6,694,707,717,733,745,756,767,778,786,790,
  592,615,637,657,674,689,704,717,733,739,
  640,667,660.1,679,694,710.5,723.8,750,761,
  660.5,675,695,725,752,651,657.9,653,
  748.4,772,789,767,
  614.4

  );
  ArPc: array [0..NComp-1] of double =(
  22.5,20.8,19.4,18,17,16,15,14,13,11.9,11,11,10.3,9.91,8.71,
  23.1,21.8,19.7,18.3,16.8,15.4,14.4,13.2,12.4,11.2,
  28,31.1,21.1,19.2,17.7,16.3,15,13.4,11.9,
  28.5,25.8,23.5,19.8,17.2,30,27.7,27.9,
  40,35.2,38,29.4,
  40  //�

  );
  Aromega: array [0..NComp-1] of double =(
  0.444,0.49,0.535,0.562,0.623,0.679,0.706,0.742,0.77,0.79,0.827,0.907,0.924229060982171,0.985293356536483,0.990092141267566,
  0.43,0.491,0.518,0.558,0.598,0.644,0.682,0.721,0.748,0.807,
  0.237,0.362,0.476,0.515,0.564,0.61,0.654,0.583,0.755,
  0.392,0.434787433405184,0.485406371453209,0.564772654413352,0.65836235809412,0.294,0.403,0.371,
  0.302,0.334,0.364,0.471,
  0.471 // �

  );
  Arro: array [0..NComp-1] of double =(0.718,0.73,0.74,0.748,0.7568,0.763,0.7685,0.7734,0.778,0.777,0.789,0.755,0.7919,0.7994,0.7785,
  0.7293,0.7408,0.751,0.758,0.7658,0.786,0.791,0.788,0.7852,0.789,
  0.802,0.799, {�} 0.751,0.751,0.751,0.751,0.751,0.751,0.751, {�}
  0.8601,0.8585,0.8575,0.8562,0.8555,0.881,0.862,0.857,
  0.9625,1.02,0.99,1.006,
  1.25
  );
  ArMr: array [0..NComp-1] of double =(
  128.2,142.3,156.31,170.34,184.4,198.39,212.42,226.44,240.48,254.5,268.52,282.55,296.57,310.6,324.637,
  126.3,140.3,154.3,168.3,182.4,196.4,210.4,224.4,238.5,252.5,
  126.243,140.27,154.3,168.3,182.4,196.4,210.4,224.43,252.5,
  134.2,148.3,162.3,190.3,218.4,120.2,134.2,134.22,
  128.2,142.2,154.2,168.2,
  178.23
  );
  ArConzMol: array [0..NComp-1] of double =(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,
  0,0,0,0,
  0
  );
  ArConzVol: array [0..NComp-1] of double =(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,
  0,0,0,0,
  0
  );
  ArConzMas: array [0..NComp-1] of double =(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,
  0,0,0,0,
  0
  );
  //������
  ArGrName: array [0..NGr-1] of string =('��������', '�������', '�������',
  '�������������', '�����������', '�������������'
  );
  ArGrsigma: array [0..NGr-1] of double =(0.5, 0.5, 0.5, 0.5, 0.5, 0.5
  );
  ArGrM: array [0..NGr-1] of integer =(7, 5, 4, 4, 2, 1           // ��� ��������

  );
  ArGrGrConzMol:array [0..NGr-1] of double =(0.35, 0.06, 0.2, 0.2, 0.09, 0.1      // ����� ������������ ������
  );
  //����������
  ArProc: array [0..NFr-1] of double =(
    0.001, 10, 50, 90, 95
  );
  ArTemp: array [0..NFr-1] of double =(
    152,	204,	271,	330,	345
  );

var
  Form1: TForm1;
  Rasp: TRasp;
implementation

uses GenMethod;



{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Cin, Cout, M, Ro, x, w, V, C: TArrOfDouble;
  i: integer;
begin
  SetLength(Cin, 3);
  SetLength(Cout, 3);
  SetLength(M, 3);
  SetLength(Ro, 3);
  SetLength(x, 3);
  SetLength(w, 3);
  SetLength(V, 3);
  SetLength(C, 3);
  x[0]:=0.2;
  x[1]:=0.3;
  x[2]:=0.5;
  M[0]:=0.02;
  M[1]:=0.03;
  M[2]:=0.04;
  Ro[0]:=700;
  Ro[1]:=800;
  Ro[2]:=900;
  MolToMass(x, w, M);
  MolToVol(x, V, M, Ro);
  MolToMolar(x, C, M, Ro);

  for i := 0 to 2 do
  begin
    ShowMessage(FloatTOStr(w[i]));
    ShowMessage(FloatTOStr(V[i]));
    ShowMessage(FloatTOStr(C[i]));
  end;
end;

function GetFitness(Gens: TArrOfDouble; target, eps: double; var fitness: double; var success: boolean): double;
var
  i: integer;
begin
  for i:=0 to Length(Rasp.Groups)-1 do
    Rasp.Groups[i].GrConzMol:=Gens[i];
  Rasp.fs.ParamKoef.bTFP:=Gens[6];
  for i:=7 to 12 do
    Rasp.Groups[i-7].sigma:=Gens[i];
  for i:=13 to 18 do
    Rasp.Groups[i-13].M:=Gens[i];
  //��� ���� ������ ��� ��������� �������� � �����������

  result:=roundto(Rasp.Calculation,-14);

  Success:=false;
  fitness:=result;
  if result<=eps then Success:=true;
end;
procedure TForm1.Button2Click(Sender: TObject);
var

  Population: TPopulation;
  _Bot: TBot;
  i: integer;
  s: string;
  ArMax, ArMin: TArrOfDouble;
begin
  Rasp:= TRasp.Create;
  //���� ������ ���������
  IniDefRasp(Rasp, 0, 0.843);
  // ����� ������������ - ������� �����, � ����� �������� ������
  SetLength(ArMax, NGen);
  SetLength(ArMin, NGen);
  ArMin[0]:=0.30; ArMax[0]:=0.65; //��������
  ArMin[1]:=0.05; ArMax[1]:=0.15; //�������
  ArMin[2]:=0.05; ArMax[2]:=0.35; //�������
  ArMin[3]:=0.05; ArMax[3]:=0.45; //�������������
  ArMin[4]:=0.05; ArMax[4]:=0.25; //�����������
  ArMin[5]:=0.05; ArMax[5]:=0.25; //�������������
  ArMin[6]:=1; ArMax[6]:=2; //���� ��� ����������� ����������� ���� �� ��������
  ArMin[7]:=0.1; ArMax[7]:=0.9; //�������� �����
  ArMin[8]:=0.1; ArMax[8]:=0.9; //������� �����
  ArMin[9]:=0.1; ArMax[9]:=0.9; //�������  �����
  ArMin[10]:=0.1; ArMax[10]:=0.9; //������������� �����
  ArMin[11]:=0.1; ArMax[11]:=0.9; //����������� �����
  ArMin[12]:=0.1; ArMax[12]:=0.9; //������������� �����
  ArMin[13]:=1; ArMax[13]:=15; //�������� ���
  ArMin[14]:=1; ArMax[14]:=10; //������� ���
  ArMin[15]:=1; ArMax[15]:=9; //�������  ���
  ArMin[16]:=1; ArMax[16]:=8; //������������� ���
  ArMin[17]:=1; ArMax[17]:=4; //����������� ���
  ArMin[18]:=1; ArMax[18]:=1; //������������� ���

  Population:= TPopulation.Create(1000, 100, NGen, ArMax, ArMin, 199, 0, 0.0001, GetFitness);
  _Bot:=Population.Execute;
  s:='';
  for i:=0 to Length(_Bot.Gens)-1 do
    s:=s+FloatTostr(_Bot.Gens[i])+'; ';
  s:=s+FloatTostr(_Bot._MyGetFit);
  ShowMessage(s);

end;

procedure TForm1.IniDefRasp(var Rasp: TRasp; M_exp, ro_exp: double);
var
  i, j: integer;
  Groups: TArrGroup;  // ������
  Comps: TArrComp;  // ��� ���������� � �������������� � ���������
  Frac_exp: TFrac; //����������������� ����������
begin

  SetLength(Comps, Ncomp);
  SetLength(Groups, NGr);
  Frac_exp:= TFrac.Create;
  SetLength(Frac_exp.ArrProc, NFr);
  SetLength(Frac_exp.ArrTemp, NFr);

  for I := 0 to Length(Comps) - 1 do
  begin
    Comps[i]:=TComp.Create;
    Comps[i].Initialize(ArName[i], ArIdGroup[i], ArSelfId[i], ArTc[i],ArPc[i],
      Aromega[i], Arro[i], ArMr[i], ArConzMol[i], ArConzVol[i], ArConzMas[i]);
  end;
  for I := 0 to Length(Groups) - 1 do
  begin
    Groups[i]:=TGroup.Create;
    Groups[i].Initialize(ArGrName[i], ArGrsigma[i], ArGrM[i], ArGrGrConzMol[i]);
  end;
  for I := 0 to Length(Frac_exp.ArrProc) - 1 do
  begin
    Frac_exp.ArrProc[i]:=ArProc[i];
    Frac_exp.ArrTemp[i]:=ArTemp[i];
  end;

  Rasp.Initialize(Comps, Groups, Frac_exp, ro_exp, M_exp);


end;


end.
