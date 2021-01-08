unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, StdCtrls, Buttons, Mask, ComCtrls, ExtCtrls, TeeProcs,
  Chart, sgr_def, sgr_data, sgr_mark;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    StaticText1: TStaticText;
    gen: TBitBtn;
    StaticText3: TStaticText;
    indexinput: TEdit;
    UpDown1: TUpDown;
    carrier: TEdit;
    save: TBitBtn;
    XYPLOT: Tsp_XYPlot;
    sinplot: Tsp_XYLine;
    pwmplot: Tsp_XYLine;
    triplot: Tsp_XYLine;
    Label1: TLabel;
    Label2: TLabel;
    Mode: TComboBox;
    SaveDialog: TSaveDialog;
    pluseinput: TEdit;
    ptime: TEdit;
    Label3: TLabel;
    outperiod: TComboBox;
    Label4: TLabel;
    procedure genClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure saveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mypath:string;
  tab,Ptab:array[0..1024] of integer;
  pointmax,pluse,plusetime:integer;

implementation

{$R *.DFM}

procedure TForm1.genClick(Sender: TObject);
const
  tri:array[0..3] of single=(1,0,-1,0);
var
  scale,counter:integer;
  index,value,P,D,lastD:real;
begin
  save.Enabled:=false;
  index:=strtofloat(indexinput.text)/100;
  scale:=strtoint(carrier.text);
  pluse:=strtoint(pluseinput.text);
  plusetime:=strtoint(ptime.text);
  pwmplot.Clear;
  sinplot.Clear;
  triplot.Clear;
  pointmax:=0;
  if mode.ItemIndex=0 then
  begin
    XYPLOT.BottomAxis.Max:=scale*2;
    for counter:=0 to scale*2 do
    begin
      value:=sin(2*pi*counter/(scale*2))*index;
      sinplot.AddXY(counter,value);
      if value>=0 then triplot.AddXY(counter,tri[counter mod 2])
        else triplot.AddXY(counter,tri[counter mod 2]*-1);
      if counter mod 2 =1 then
      begin
        if mode.ItemIndex=0 then
        begin
          P:=2*value;
          D:=2*(1-value)/2;
          if counter=1 then lastD:=D;
          tab[counter div 2]:=trunc(P*pluse/2);
          Ptab[counter div 2]:=trunc((P+D+lastD)*pluse/2);
          lastD:=D;
          inc(pointmax);
          pwmplot.AddXY(counter-P/2,0);
          pwmplot.AddXY(counter-P/2,value);
          pwmplot.AddXY(counter+P/2,value);
          pwmplot.AddXY(counter+P/2,0);
        end;
      end;
    end;
  end;
  if mode.itemindex=1 then
  begin
    XYPLOT.BottomAxis.Max:=scale*4;
    for counter:=0 to scale*4 do
    begin
      value:=sin(2*pi*counter/(scale*4))*index;
      sinplot.AddXY(counter,value);
      triplot.AddXY(counter,tri[counter mod 4]);
      if counter mod 4 =2 then
      begin
        P:=4*(1+value)/2;
        tab[counter div 4]:=trunc(P*pluse/4);
        inc(pointmax);
        pwmplot.AddXY(counter-P/2,-1);
        pwmplot.AddXY(counter-P/2,value);
        pwmplot.AddXY(counter+P/2,value);
        pwmplot.AddXY(counter+P/2,-1);
      end;
    end;
  end;
  save.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  mypath:=extractfilepath(application.exename);
  mode.ItemIndex:=0;
  outperiod.ItemIndex:=0;
end;

procedure TForm1.saveClick(Sender: TObject);
  var f:textfile;
      i:byte;
      aa:string;
begin
  savedialog.InitialDir:=mypath;
  if savedialog.Execute then
  begin
    Assignfile(f,savedialog.filename);
    rewrite(f);
    case savedialog.FilterIndex of
      1:
      begin
        showmessage('暂时不支持此格式.');
        writeln(f,'/***********************************************#$d#$a',50);
        writeln(f,'*     SPWM DATA TAB                            *#$d#$a',50);
        writeln(f,'*     Generate by SPWMGEN V1.0                 *#$d#$a',50);
        writeln(f,'*     Author:Fengjiantao                       *#$d#$a',50);
        writeln(f,'*     http://fjt.yeah.net                      *#$d#$a',50);
        writeln(f,'*     Email:fjt@371.net                        *#$d#$a',50);
        writeln(f,'***********************************************/#$d#$a',50);
      end;
      2:
      begin
      end;
      3:
      begin
        writeln(f,'//***********************************************');
        writeln(f,'//     SPWM DATA TAB                            ');
        writeln(f,'//     Generate by SPWMGEN V1.0                 ');
        writeln(f,'//     Author:Fengjiantao                       ');
        writeln(f,'//     http://fjt.yeah.net                      ');
        writeln(f,'//     Email:fjt@371.net                        ');
        writeln(f,'//     Carrier Index:'+carrier.text);
        writeln(f,'//     Modulation Index:'+indexinput.text);
        writeln(f,'//     Pluse number:'+pluseinput.text);
        writeln(f,'//     MODE:'+Mode.text);
        writeln(f,'//************************************************');
        writeln(f,'unsigned char SPWMTAB(unsigned char tabindex)');
        writeln(f,'{');
//        writeln(f,'	#pragma computedgoto 1');
        writeln(f,'     PCL+=W;');
        case outperiod.ItemIndex of
          0:
          begin
            for i:=0 to (pointmax div 4)-1 do
            begin
              aa:=inttostr(tab[i]);
              writeln(f,'          return '+aa+';');
            end;
          end;
          1:
          begin
            for i:=0 to (pointmax div 2)-1 do
            begin
              aa:=inttostr(tab[i]);
              Writeln(f,'          return '+aa+';');
            end;
          end;
          2:
          begin
            for i:=0 to pointmax-1 do
            begin
              aa:=inttostr(tab[i]);
              writeln(f,'          return '+aa+';');
            end;
          end;
        end;
//        writeln(f,'	#pragma computedgoto 0');
        writeln(f,'}');
        writeln(f,'');
        writeln(f,'unsigned char PERIODTAB(unsigned char tabindex)');
        writeln(f,'{');
//        writeln(f,'	#pragma computedgoto 1');
        writeln(f,'     PCL+=W;');
        for i:=0 to (pointmax div 4)-1 do
        begin
          aa:=inttostr(Ptab[i]);
          writeln(f,'          return '+aa+';');
        end;
//        writeln(f,'	#pragma computedgoto 0');
        writeln(f,'}');
      end;
      4:
      begin
        writeln(f,'* by Stimulus Editor -- Serial Number: 0 -- Version 9.1');
        writeln(f,';!Stimulus Get');
        writeln(f,';! pwm Analog');
        writeln(f,';!Ok');
        writeln(f,';!Plot Axis_Settings');
        aa:=floattostr((pointmax div 4)*plusetime/1000);
        writeln(f,';!Xrange 0s '+aa+'ms');
        writeln(f,';!Yrange 0 1');
        writeln(f,';!AutoUniverse');
        writeln(f,';!XminRes 1us');
        writeln(f,';!YminRes 1');
        writeln(f,';!Ok');
//      writeln(f,'.STIMULUS pwm PWL');
//      writeln(f,'+ TIME_SCALE_FACTOR = 1');
//      writeln(f,'+ VALUE_SCALE_FACTOR = 1');
        writeln(f,'+   ( 0, 0 )');
        writeln(f,'+   ( 0.000001, 10 )');
        if Mode.ItemIndex=0 then
        begin
          for i:=0 to (pointmax div 4)-1 do
          begin
            aa:=floattostr((plusetime*i+plusetime*tab[i]/Pluse)/1000000);
            writeln(f,'+   ( ' +aa+',10 )');
            aa:=floattostr((plusetime*i+plusetime*tab[i]/Pluse+1)/1000000);
            writeln(f,'+   ( ' +aa+',0.001 )');
            aa:=floattostr((plusetime*(i+1))/1000000);
            writeln(f,'+   ( ' +aa,',0.001 )');
            aa:=floattostr((plusetime*(i+1)+1)/1000000);
            writeln(f,'+   ( ' +aa,',10 )');
          end;
          for i:=0 to (pointmax div 4)-1 do
          begin
            aa:=floattostr((plusetime*(i+pointmax div 4)+plusetime*tab[(pointmax div 4)-1-i]/Pluse)/1000000);
            writeln(f,'+   ( ' +aa+',10 )');
            aa:=floattostr((plusetime*(i+pointmax div 4)+plusetime*tab[(pointmax div 4)-1-i]/Pluse+1)/1000000);
            writeln(f,'+   ( ' +aa+',0.001 )');
            aa:=floattostr((plusetime*(i+1+pointmax div 4))/1000000);
            writeln(f,'+   ( ' +aa,',0.001 )');
            aa:=floattostr((plusetime*(i+1+pointmax div 4)+1)/1000000);
            writeln(f,'+   ( ' +aa,',10 )');
          end;
          for i:=0 to (pointmax div 4)-1 do
          begin
            aa:=floattostr((plusetime*(i+pointmax div 2)+plusetime*tab[i]/Pluse)/1000000);
            writeln(f,'+   ( ' +aa+',-10 )');
            aa:=floattostr((plusetime*(i+pointmax div 2)+plusetime*tab[i]/Pluse+1)/1000000);
            writeln(f,'+   ( ' +aa+',-0.001 )');
            aa:=floattostr((plusetime*(i+1+pointmax div 2))/1000000);
            writeln(f,'+   ( ' +aa,',-0.001 )');
            aa:=floattostr((plusetime*(i+1+pointmax div 2)+1)/1000000);
            writeln(f,'+   ( ' +aa,',-10 )');
          end;
          for i:=0 to (pointmax div 4)-1 do
          begin
            aa:=floattostr((plusetime*(i+pointmax*3 div 4)+plusetime*tab[(pointmax div 4)-1-i]/Pluse)/1000000);
            writeln(f,'+   ( ' +aa+',-10 )');
            aa:=floattostr((plusetime*(i+pointmax*3 div 4)+plusetime*tab[(pointmax div 4)-1-i]/Pluse+1)/1000000);
            writeln(f,'+   ( ' +aa+',-0.001 )');
            aa:=floattostr((plusetime*(i+1+pointmax*3 div 4))/1000000);
            writeln(f,'+   ( ' +aa,',-0.001 )');
            aa:=floattostr((plusetime*(i+1+pointmax*3 div 4)+1)/1000000);
            writeln(f,'+   ( ' +aa,',-10 )');
          end;
        end;
        if mode.ItemIndex=1 then
        begin
          for i:=0 to pointmax-1 do
          begin
            aa:=floattostr((plusetime*i+plusetime*tab[i]/Pluse)/1000000);
            writeln(f,'+   ( ' +aa+',10 )');
            aa:=floattostr((plusetime*i+plusetime*tab[i]/Pluse+1)/1000000);
            writeln(f,'+   ( ' +aa+',-10 )');
            aa:=floattostr((plusetime*(i+1))/1000000);
            writeln(f,'+   ( ' +aa,',-10 )');
            aa:=floattostr((plusetime*(i+1)+1)/1000000);
            writeln(f,'+   ( ' +aa,',10 )');
          end;
        end;
      end;
    end;
    closefile(f);
  end;
end;

end.
