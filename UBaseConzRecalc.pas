(*
09.12.2019
�����������: �������� �.�.

������ ��������������� � �������� �� ���� �����-�� ������������� ��������
Mass - �������� ����
Vol - �������� ����
Mol - ������� ����
Molar - �������� ������������, ����/�3

��������� Ro - ��/�3
������������ ����� - ��/����


� ���� ������ �������� ������������ - ������� ���� Mol.
� ��� ��� ���������������, � ����� �� ��� � ������� ������������.
*)
unit UBaseConzRecalc;


interface

uses
   Math, UClasses;

  procedure MassToMol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble);
  procedure VolToMol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
  procedure MolToMass(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble);
  procedure MolToVol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
  procedure MolarToMol(Cin: TArrOfDouble; var Cout: TArrOfDouble);
  procedure MolToMolar(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);

  procedure CoutINCin(Cout: TArrOfDouble; var Cin: TArrOfDouble);
  //������ ������ �����������
  procedure MassToVol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
  procedure VolToMass(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
  procedure MolarToVol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
  procedure VolToMolar(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
  procedure MolarToMass(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble);
  procedure MassToMolar(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);

implementation


{�� �������� ����� � �������}
procedure MassToMol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble);
var
  i: integer;
  sum: double;
begin
  sum:=0;
  for i := 0 to Length(Cin) - 1 do
  begin
    sum:=sum+Cin[i]/M[i];
  end;

  for i := 0 to Length(Cin) - 1 do
  begin
    Cout[i]:=Cin[i]/M[i]/sum;
  end;

end;

{�� ������� ����� � ��������}
procedure MolToMass(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble);
var
  i: integer;
  sum: double;
begin
  sum:=0;
  for i := 0 to Length(Cin) - 1 do
  begin
    sum:=sum+Cin[i]*M[i];
  end;

  for i := 0 to Length(Cin) - 1 do
  begin
    Cout[i]:=Cin[i]*M[i]/sum;
  end;

end;

{�� �������� ����� � �������}
procedure VolToMol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
var
  i: integer;
  sum: double;
begin
  sum:=0;
  for i := 0 to Length(Cin) - 1 do
  begin
    sum:=sum+Cin[i]/M[i]*Ro[i];
  end;

  for i := 0 to Length(Cin) - 1 do
  begin
    Cout[i]:=Cin[i]*Ro[i]/M[i]/sum;
  end;

end;

{�� ������� ����� � ��������}
procedure MolToVol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
var
  i: integer;
  sum: double;
begin
  sum:=0;
  for i := 0 to Length(Cin) - 1 do
  begin
    sum:=sum+Cin[i]*M[i]/Ro[i];
  end;

  for i := 0 to Length(Cin) - 1 do
  begin
    Cout[i]:=Cin[i]/Ro[i]*M[i]/sum;
  end;

end;

{�� �������� ������������ [����/�3] � �������}
procedure MolarToMol(Cin: TArrOfDouble; var Cout: TArrOfDouble);
var
  i: integer;
  sum: double;
begin
  sum:=0;
  for i := 0 to Length(Cin) - 1 do
  begin
    sum:=sum+Cin[i];
  end;

  for i := 0 to Length(Cin) - 1 do
  begin
    Cout[i]:=Cin[i]/sum;
  end;

end;

{�� ������� � �������� ������������ [����/�3]}
procedure MolToMolar(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
var
  i: integer;
  sum: double;
begin
  sum:=0;
  for i := 0 to Length(Cin) - 1 do
  begin
    sum:=sum+Cin[i]*M[i]/Ro[i];
  end;

  for i := 0 to Length(Cin) - 1 do
  begin
    Cout[i]:=Cin[i]/sum;
  end;

end;

//�������������� ������������ �������� �� �������
procedure CoutINCin(Cout: TArrOfDouble; var Cin: TArrOfDouble);
var
  i: integer;
begin
  for I := 0 to Length(Cin) - 1 do
  begin
    Cin[i]:=Cout[i];
  end;
end;

{�� �������� ����� � ��������}
procedure MassToVol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
begin
  MassToMol(Cin, Cout, M);
  CoutINCin(Cout, Cin);
  MolToVol(Cin, Cout, M, Ro);
end;

{�� �������� ����� � ��������}
procedure VolToMass(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
begin
  VolToMol(Cin, Cout, M, Ro);
  CoutINCin(Cout, Cin);
  MolToMass(Cin, Cout, M);
end;

{�� �������� ������������ [����/�3] � ��������}
procedure MolarToVol(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
begin
  MolarToMol(Cin, Cout);
  CoutINCin(Cout, Cin);
  MolToVol(Cin, Cout, M, Ro);
end;

{�� �������� � �������� ������������ [����/�3]}
procedure VolToMolar(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
begin
  VolToMol(Cin, Cout, M, Ro);
  CoutINCin(Cout, Cin);
  MolToMolar(Cin, Cout, M, Ro);
end;

{�� �������� ������������ [����/�3] � ��������}
procedure MolarToMass(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble);
begin
  MolarToMol(Cin, Cout);
  CoutINCin(Cout, Cin);
  MolToMass(Cin, Cout, M);
end;

{�� �������� � �������� ������������ [����/�3]}
procedure MassToMolar(Cin: TArrOfDouble; var Cout: TArrOfDouble; M:TArrOfDouble; Ro:TArrOfDouble);
begin
  MassToMol(Cin, Cout, M);
  CoutINCin(Cout, Cin);
  MolToMolar(Cin, Cout, M, Ro);
end;

end.
