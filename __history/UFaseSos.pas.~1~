unit UFaseSos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Math, UClasses;


type
(*
Описание класса TFazeSost.

1) Поля:
   F: double - общий мольный расход, моль/ч;
   G: double - газовый мольный расход, моль/ч;
   L: double - жидкостный мольный расход, моль/ч;
   e: double - доля отгона мольная;
   T: double - температура, С;
   P: double - давление, Па;
   NComp: integer - количество компонентов;
   Kf: TArrOfDouble - константа фазового равновесия;
   Pc: TArrOfDouble - критические давления, Па;
   Tc: TArrOfDouble - критические температуры, С;
   omega: TArrOfDouble - Ацентрические факторы;
   ro: TArrOfDouble - Ацентрические факторы;
   Mr: TArrOfDouble - Ацентрические факторы;
   Ps: TArrOfDouble - парциальные давления, Па
   zF: TArrOfDouble - мольная доля компонентов в исходном потоке;
   xL: TArrOfDouble - мольная доля компонентов в жидком потоке;
   yG: TArrOfDouble - мольная доля компонентов в газовом потоке;
   Temp_Vol_e_5_proc: double - температура при доли отгона объемной 5 %;
   iter: integer - количество итераций;
   sglazh: boolean - сглаживание доли отгона;
   ParamKoef.aTFP: double - поправочный коэффициент (не используется);
   ParamKoef.bTFP: double - поправочный коэффициент для критических температур;

2) Методы:
     procedure Wilson - расчет констант фазового равновесия по Вильсону;
     function FazeCalc: integer - расчет на фазовое состояние (одна или две фазы)0- две фазы, 1- 1 одна жидкая, 2- одна газовая, 3 - точка начала кипения, 4- точка начала росы;
     procedure Rashford_Rice(_fc: integer) - расчет мольной доли отгона;
     procedure Calculation(T, P: double; zF: TArrOfDouble; F: double;  var _L, _G: double;
       var _xL, _yG: TArrOfDouble; _Pc, _Tc, _omega, _ro, _Mr: TArrOfDouble; Param:TArrOfDouble) - температура в цельсиях, давление в паскалях;
     procedure SetParam(T, P: double; zF: TArrOfDouble; F: double; _Pc, _Tc, _omega, _ro, _Mr: TArrOfDouble; Param:TArrOfDouble) - задать параметры, температура в цельсиях, давление в паскалях;
     function GetProcFromTemp(Temp: double{цельсия}): double - объемный процент по выпарившемуся веществу, %;

     function GetTempFromProc(Proc: double{% мольн}; var _MyTemp: double): double - температура по проценту выпарившегося вещества, С;


*)
   TFazeSost = class
      F: double;  // общий мольный расход моль/ч
      G: double;  // газовый мольный расход моль/ч
      L: double;  // жидкостный мольный расход моль/ч
      e: double;  // доля отгона мольная

      T: double;  // температура, С
      P: double;  // давление, Па
      NComp: integer; //  количество компонентов
      Kf: TArrOfDouble; //константа фазового равновесия
      Pc: TArrOfDouble; // критические давления Па
      Tc: TArrOfDouble; // критические температуры, С
      omega: TArrOfDouble; // Ацентрические факторы
      ro: TArrOfDouble; // Ацентрические факторы
      Mr: TArrOfDouble; // Ацентрические факторы

      Ps: TArrOfDouble; // парциальные давления Па
      zF: TArrOfDouble;  // мольная доля компонентов в исходном потоке
      xL: TArrOfDouble;  // мольная доля компонентов в жидком потоке
      yG: TArrOfDouble;  // мольная доля компонентов в газовом потоке
      Temp_Vol_e_5_proc: double;  // температура при доли отгона объемной 5 %

      iter: integer;  // количество итераций
      sglazh: boolean; //сглаживание доли отгона
      ParamKoef: record
        aTFP: double;
        bTFP: double;

      end;

      constructor Create; overload;
      procedure Wilson;  // расчет констант равновесия по Вильсону
      function FazeCalc: integer; // расчет на фазовое состояние (одна или две фазы)0- две фазы, 1- 1 одна жидкая, 2- одна газовая
                                  // 3 - точка начала кипения, 4- точка начала росы
      procedure Rashford_Rice(_fc: integer); // расчет мольной доли отгона
      procedure Calculation(T, P: double; zF: TArrOfDouble; F: double;  var _L, _G: double;
            var _xL, _yG: TArrOfDouble; _Pc, _Tc, _omega, _ro, _Mr: TArrOfDouble; Param:TArrOfDouble);   //температура в цельсиях, давление в паскалях


      procedure SetParam(T, P: double; zF: TArrOfDouble; F: double; _Pc, _Tc, _omega, _ro, _Mr: TArrOfDouble; Param:TArrOfDouble); // задать параметры
                                                                                                     //температура в цельсиях, давление в паскалях
      function GetProcFromTemp(Temp: double{цельсия}): double;  // процент по выпарившемуся веществу (е)

      function GetTempFromProc(Proc: double{% мольн}; var _MyTemp: double): double;  // температура по проценту выпарившегося вещества

      function GetVol_e(var _e: double): double;

      procedure Inizial(zF: TArrOfDouble; F: double; var _L, _G: double;
         var _xL, _yG: TArrOfDouble; _Pc, _Tc, _omega, _ro, _Mr: TArrOfDouble; Param:TArrOfDouble);
   end;




implementation

{ TFazeSost }

procedure TFazeSost.Wilson;

var
  i: integer;
  _P, _T: extended; // Давление и температура в системе
begin
  // Инитциализация параметров
  _P:= P / 100000; // Перевод в бары
  _T:= T + 273;    // Перевод в кельвины
  // Расчет парциальных давлений и коэффициентов распределения
  SetLength(Ps, NComp);
  SetLength(Kf, NComp);

  for I := 0 to NComp-1 do
  begin
    Ps[i]:= Pc[i] * exp(5.372697 * (1 + omega[i]) * (1 - Tc[i]*ParamKoef.bTFP / _T));
    Kf[i]:= Ps[i] / _P;
  end;
end;

procedure TFazeSost.Calculation(T, P: double; zF: TArrOfDouble; F: double; var _L, _G: double;
         var _xL, _yG: TArrOfDouble; _Pc, _Tc, _omega, _ro, _Mr: TArrOfDouble; Param:TArrOfDouble);
var
  fc, i: integer;
  e_old: double;

begin
  SetParam(T, P, zF, F, _Pc, _Tc, _omega, _ro, _Mr, Param);
  Wilson;
  fc:=FazeCalc;
  e_old:=e;
  case fc of
    0, 3, 4:
      begin
        Rashford_Rice(fc);
        if e>=1 then
        begin
          e:=1;
          for I := 0 to NComp-1 do
          begin
            xL[i]:=0;
            yG[i]:=zF[i];
          end;
        end;
        if e<=0 then
        begin
          e:=0;
          for I := 0 to NComp-1 do
          begin
            xL[i]:=zF[i];
            yG[i]:=0;
          end;
        end;
      end;
    1: begin
         e:=0;
         for I := 0 to NComp-1 do
         begin
           xL[i]:=zF[i];
           yG[i]:=0;
         end;
       end;
    2:begin
        e:=1;
        for I := 0 to NComp-1 do
         begin
           xL[i]:=0;
           yG[i]:=zF[i];
         end;
      end;
  end;

  //inc(iter);
  if sglazh then
  begin
    if e_old>e then
      e:=e_old-(e_old-e)/100;
    if e_old<T then
      e:=e_old+(e-e_old)/100;

    if e>1 then e:=1;
    if e<0 then e:=0;
    
  end;
  G:=F*e;
  L:=F-G;
  _L:=L;
  _G:=G;
  for I := 0 to NComp-1 do
  begin
    _xL[i]:=xL[i];
    _yG[i]:=yG[i];
  end;

end;

constructor TFazeSost.Create;
begin
  inherited;
  G:=0;
  L:=0;
  e:=0;
  sglazh:=false;
end;

function TFazeSost.FazeCalc: integer;
var
  S1, S2: double;
  i: integer;
begin
  result:=-1;
  S1:=0;
  S2:=0;

  for I := 0 to NComp-1 do
    begin
      S1:=S1+zF[i]*Kf[i];
      if Kf[i]>0 then
        S2:=S2+zF[i]/Kf[i];
    end;
  if (S1>1) and (S2>1) then result:=0; // 2 фазы
  if (S1<1) then result:=1;  //жидкая
  if (S2<1) then result:=2;  //газовая
  if S1=1 then result:=3;    //точка кипения
  if S2=1 then result:=4;    //точка росы
end;

function TFazeSost.GetProcFromTemp(Temp: double): double;
var
  a: TArrOfDouble;
  _temp: double;
  _Proc: double;
  i: double;
begin
  //тут нужно сделать цикл по процентам и выдавать его, когда температура првысится
  _temp:=Temp-10;
  _Proc:=0;
  i:=0;
  while (Temp>_temp) and (_Proc<=100) do
  begin
    _Proc:=_Proc+0.1;
    _temp:=GetTempFromProc(_Proc, i);

  end;

  result:=roundto(_Proc,-1);
  if result>100 then result:=100;


end;

function TFazeSost.GetVol_e(var _e: double): double;
var
  i: integer;
  MrsrF, MrsrG, MrsrL: double;
  roZ, roL, roG: double;
begin
  if (_e=0) or (_e=1) then
  begin
    result:=_e;
    exit;
  end;

  roZ:=0;
  roL:=0;
  roG:=0;
  MrsrF:=0;
  MrsrG:=0;
  MrsrL:=0;

  for i := 0 to Length(zF)-1 do
  begin
    MrsrF:=MrsrF+zF[i]*Mr[i];
    MrsrG:=MrsrG+yG[i]*Mr[i];
    MrsrL:=MrsrL+xL[i]*Mr[i];
  end;
  if MrsrL=0 then MrsrL:=MrsrF;
  if MrsrG=0 then MrsrG:=MrsrF;


  for i := 0 to Length(zF)-1 do
  begin
    roZ:=roZ+Mr[i]*zF[i]/(ro[i]*MrsrF);
    roL:=roL+Mr[i]*xL[i]/(ro[i]*MrsrL);
    roG:=roG+Mr[i]*yG[i]/(ro[i]*MrsrG);  // так как потом газ конденсируем
  end;
  roZ:=1/roZ;
  roL:=1/roL;
  roG:=1/roG;
  result:=_e*roZ*MrsrG/(roG*MrsrF);

end;

procedure TFazeSost.Inizial(zF: TArrOfDouble; F: double; var _L, _G: double;
         var _xL, _yG: TArrOfDouble; _Pc, _Tc, _omega, _ro, _Mr: TArrOfDouble; Param:TArrOfDouble);
var
  MyTemp: double;
begin
  Temp_Vol_e_5_proc:=0;
  MyTemp:=0;
  Calculation(50, 101325, zF, F, L, G, xL, yG, _Pc, _Tc, _Omega, _ro, _Mr, Param);
  Temp_Vol_e_5_proc:=GetTempFromProc(5, MyTemp);
  Temp_Vol_e_5_proc:=GetTempFromProc(5, MyTemp);
end;

function TFazeSost.GetTempFromProc(Proc: double; var _MyTemp: double): double; //выдает в цельсиях
var
  temp, pr, d: double;
  i: integer;
  a: TArrOfDouble;
  Vol_e: double;
begin
  // берем температуру от процентов
  //предполагаем, что при температуре -200 С все будет в жидкости - тогда е=0
  pr:=Proc/100;
  temp:=-200;
  if _MyTemp<>0 then temp:=_MyTemp;

  SetLength(a, 1);
  a[0]:=-1;
  Calculation(Temp, 101325, self.zF, self.F, self.L, self.G, self.xL, self.yG, self.Pc, self.Tc, self.omega, self.ro, self.Mr, a);
  Vol_e:=GetVol_e(self.e);

  while (Vol_e<pr) and (Vol_e<1) do
  begin
    Calculation(Temp, 101325, self.zF, self.F, self.L, self.G, self.xL, self.yG, self.Pc, self.Tc, self.omega, self.ro, self.Mr, a);

    temp:=temp+0.01;
    Vol_e:=GetVol_e(self.e);
  end;
  d:=0;

  _MyTemp:=temp;
  result:=roundto(temp+d, -3);


end;

procedure TFazeSost.Rashford_Rice(_fc: integer); // Решение уравнения Рашфорда-Райса
const
  eps = 1e-9;
var
  a, b, _e: extended;
  I: Integer;
function fn (_e: extended): extended;
var
  s: extended;
  i: integer;
begin
  s:= 0;
  for I := 0 to NComp-1 do
    if (Kf[i] > 0) and (1 + _e * (Kf[i] - 1)<>0) then
      s:= s + zF[i] * (Kf[i] - 1) / (1 + _e * (Kf[i] - 1));
  result:= s;
end;

begin
  a:= 0;
  b:= 1;
  _e:= (a + b) / 2;
  if _fc=3 then _e:=0;
  if _fc=4 then _e:=1;

  if fn(a) * fn(b) < 0 then
    begin
      repeat
        _e:= (a + b) / 2;
        if fn(a) * fn(_e) > 0 then
          a:= _e
        else
          b:= _e;
      until abs(a - b) <= eps;
      _e:= (a + b) / 2
    end; (*e:= 0.8680;*)
  //showmessage(floattostr(e));
  for I := 0 to NComp-1 do
    begin
      xL[i]:= zF[i] / (1 + _e * (Kf[i] - 1));
      yG[i]:= Kf[i] * xL[i]
    end;
  self.e:=_e;
end;




procedure TFazeSost.SetParam(T, P: double; zF: TArrOfDouble; F: double; _Pc, _Tc, _omega, _ro, _Mr: TArrOfDouble; Param:TArrOfDouble);

var
  i: integer;
begin
  Self.F:= F;
  Self.T:=T;
  Self.P:=P;
  NComp:=Length(zF);
  if (NComp<>Length(_Pc))
     or
     (NComp<>Length(_Tc))
     or
     (NComp<>Length(_omega))
     then
  begin
    ShowMessage('Ошибка');
    exit;
  end;

  SetLength(Pc, NComp);
  SetLength(Tc, NComp);
  SetLength(omega, NComp);
  SetLength(ro, NComp);
  SetLength(Mr, NComp);
  SetLength(Self.zF, NComp);
  SetLength(Self.xL, NComp);
  SetLength(Self.yG, NComp);

  for i:= 0 to NComp-1 do
  begin
    Pc[i]:= _Pc[i]; // критические давления Па
    Tc[i]:= _Tc[i]; // критические температуры, С
    omega[i]:= _omega[i]; // Ацентрические факторы
    ro[i]:= _ro[i]; // плотности жидкостей
    Mr[i]:= _Mr[i]; // молекулярные массы

    Self.zF[i]:= zF[i];  // мольная доля компонентов в исходном потоке
    Self.xL[i]:= 0;  // мольная доля компонентов в жидком потоке
    Self.yG[i]:= 0;  // мольная доля компонентов в газовом потоке
  end;

  // если хотим перезагрузить коэффициенты
  if Param[0]>-1 then
  begin
    ParamKoef.aTFP:= Param[1];
    ParamKoef.bTFP:= Param[2];

  end;

end;


end.
