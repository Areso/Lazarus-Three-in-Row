unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Image00: TImage;
    background: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image30: TImage;
    Image01: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Image35: TImage;
    Image40: TImage;
    Image41: TImage;
    Image42: TImage;
    Image43: TImage;
    Image44: TImage;
    Image02: TImage;
    Image45: TImage;
    Image50: TImage;
    Image51: TImage;
    Image52: TImage;
    Image53: TImage;
    Image54: TImage;
    Image55: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    res0: TImage;
    ImageOne: TImage;
    Image03: TImage;
    Image04: TImage;
    Image05: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Memo1: TMemo;
    res1: TImage;
    res2: TImage;
    res3: TImage;
    res4: TImage;
    procedure backgroundClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image00Click(Sender: TObject);
    procedure Image01Click(Sender: TObject);
    procedure Image02Click(Sender: TObject);
    procedure Image03Click(Sender: TObject);
    procedure Image04Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image14Click(Sender: TObject);
    procedure Image20Click(Sender: TObject);
    procedure Image21Click(Sender: TObject);
    procedure Image22Click(Sender: TObject);
    procedure Image23Click(Sender: TObject);
    procedure Image24Click(Sender: TObject);
    procedure Image30Click(Sender: TObject);
    procedure Image31Click(Sender: TObject);
    procedure Image32Click(Sender: TObject);
    procedure Image33Click(Sender: TObject);
    procedure Image34Click(Sender: TObject);
    procedure Image40Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
end;

var
  Form1: TForm1;
  figures_otb:array[0..5,0..5] of integer; //array of cards
  first_click_x: integer;
  first_click_y: integer;
  second_click_x: integer;
  second_click_y: integer;

implementation

{$R *.lfm}
procedure load_theme();
begin
   //load first theme //!!!default theme
   try
       begin
       Form1.background.picture.LoadFromFile(application.Location+'/resources/theme01/background_1920x1080.png');
       Form1.res0.picture.LoadFromFile(application.Location+'/resources/theme01/res0.png');
       Form1.res1.picture.LoadFromFile(application.Location+'/resources/theme01/res1.png');
       Form1.res2.picture.LoadFromFile(application.Location+'/resources/theme01/res2.png');
       Form1.res3.picture.LoadFromFile(application.Location+'/resources/theme01/res3.png');
       Form1.res4.picture.LoadFromFile(application.Location+'/resources/theme01/res4.png');
       end
   except
       begin
       ShowMessage('Error on reading files. Please, reinstall the app');
       Application.Terminate;
       end;
   end;
end;

procedure init_seq();
label //labels
   truerandomx, truerandomy, truerandomxy;
var //variables
   ix: integer; //i..x counter
   iy: integer; //i..y counter
   flag_mixed: boolean; //flag of mixed. false = not mixed, true = mixed.
   rnd_cnt: integer; //cnt of rnd functions (for debug use only)
   image_index: string;
   image_string:string;
begin
   //create an array
   ix:=0;
   iy:=0;
   Randomize;
   for ix:=0 to 5 do
   begin
       for iy:=0 to 5 do
       begin
           figures_otb[ix,iy]:=trunc(random()*4);
           Form1.Memo1.Lines[ix]:=Form1.Memo1.Lines[ix]+' '+IntToStr(figures_otb[ix,iy]);
       end;
       Form1.memo1.Lines.Append(' ');
   end;

   rnd_cnt:=0;
   //check is there any 3-in-row already. If yes, then mix it.
   truerandomxy:
   flag_mixed:=false;
   ix:=0;
   iy:=0;
   for ix:=2 to 5 do
   begin
       for iy:=0 to 5 do
       begin
           if (figures_otb[ix,iy]=figures_otb[ix-1,iy]) and (figures_otb[ix,iy]=figures_otb[ix-2,iy]) then
           begin
               //ShowMessage('Hello man, there a three in row on X!'); //debug use only
               truerandomx:
               flag_mixed:=true;
               rnd_cnt:=rnd_cnt+1;
               figures_otb[ix-1,iy]:=trunc(random*4);
               if (figures_otb[ix-1,iy]=figures_otb[ix-2,iy]) and (figures_otb[ix-1,iy]=figures_otb[ix,iy]) then
               begin
                   goto truerandomx;
               end;
           end
           else
           begin
               rnd_cnt := rnd_cnt;
               //
           end;
       end;
   end;

   ix:=0;
   iy:=0;
   for ix:=0 to 5 do
   begin
       for iy:=2 to 5 do
       begin
           if (figures_otb[ix,iy]=figures_otb[ix,iy-1]) and (figures_otb[ix,iy]=figures_otb[ix,iy-2]) then
           begin
               //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
               truerandomy:
               flag_mixed:=true;
               rnd_cnt:=rnd_cnt+1;
               figures_otb[ix,iy-1]:=trunc(random*4);
               if (figures_otb[ix,iy-1]=figures_otb[ix,iy-2]) and (figures_otb[ix,iy-1]=figures_otb[ix,iy]) then
               begin
                   goto truerandomy;
               end;
           end;
       end;
   end;
   if flag_mixed = true then
   begin
      goto truerandomxy;
   end;


   Form1.edit1.text:=IntToStr(rnd_cnt);
   //init seq complete
end;
procedure appear();
var ix, iy: integer;
    image_index, image_string:string;
begin
   //rewrite array output
   Form1.Memo1.Lines[0]:='';
   Form1.Memo1.Lines[1]:='';
   Form1.Memo1.Lines[2]:='';
   Form1.Memo1.Lines[3]:='';
   Form1.Memo1.Lines[4]:='';
   ix:=0;
   iy:=0;
   for ix:=0 to 5 do
   begin
       for iy:=0 to 5 do
       begin
           image_index :=IntToStr(ix)+IntToStr(iy);
           image_string:='Image'+image_index;
           Form1.Memo1.Lines[ix]:=Form1.Memo1.Lines[ix]+' '+IntToStr(figures_otb[ix,iy]);
           //Form1.image_string.Picture := Form1.res0.Picture;   //doesn't work. Why I am not surprised?
       end;
       Form1.Memo1.Lines.Append(' ');
   end;

   //appearment
   //china code-style here... you should acquire how to access objects in array to get this trash away.
   if figures_otb[0,0]=0 then
   Form1.Image00.Picture := Form1.res0.Picture;
   if figures_otb[0,0]=1 then
   Form1.Image00.Picture := Form1.res1.Picture;
   if figures_otb[0,0]=2 then
   Form1.Image00.Picture := Form1.res2.Picture;
   if figures_otb[0,0]=3 then
   Form1.Image00.Picture := Form1.res3.Picture;
   if figures_otb[0,0]=4 then
   Form1.Image00.Picture := Form1.res4.Picture;

   if figures_otb[0,1]=0 then
   Form1.Image01.Picture := Form1.res0.Picture;
   if figures_otb[0,1]=1 then
   Form1.Image01.Picture := Form1.res1.Picture;
   if figures_otb[0,1]=2 then
   Form1.Image01.Picture := Form1.res2.Picture;
   if figures_otb[0,1]=3 then
   Form1.Image01.Picture := Form1.res3.Picture;
   if figures_otb[0,1]=4 then
   Form1.Image01.Picture := Form1.res4.Picture;

   if figures_otb[0,2]=0 then
   Form1.Image02.Picture := Form1.res0.Picture;
   if figures_otb[0,2]=1 then
   Form1.Image02.Picture := Form1.res1.Picture;
   if figures_otb[0,2]=2 then
   Form1.Image02.Picture := Form1.res2.Picture;
   if figures_otb[0,2]=3 then
   Form1.Image02.Picture := Form1.res3.Picture;
   if figures_otb[0,2]=4 then
   Form1.Image02.Picture := Form1.res4.Picture;

   if figures_otb[0,3]=0 then
   Form1.Image03.Picture := Form1.res0.Picture;
   if figures_otb[0,3]=1 then
   Form1.Image03.Picture := Form1.res1.Picture;
   if figures_otb[0,3]=2 then
   Form1.Image03.Picture := Form1.res2.Picture;
   if figures_otb[0,3]=3 then
   Form1.Image03.Picture := Form1.res3.Picture;
   if figures_otb[0,3]=4 then
   Form1.Image03.Picture := Form1.res4.Picture;

   if figures_otb[0,4]=0 then
   Form1.Image04.Picture := Form1.res0.Picture;
   if figures_otb[0,4]=1 then
   Form1.Image04.Picture := Form1.res1.Picture;
   if figures_otb[0,4]=2 then
   Form1.Image04.Picture := Form1.res2.Picture;
   if figures_otb[0,4]=3 then
   Form1.Image04.Picture := Form1.res3.Picture;
   if figures_otb[0,4]=4 then
   Form1.Image04.Picture := Form1.res4.Picture;

   if figures_otb[1,0]=0 then
   Form1.Image10.Picture := Form1.res0.Picture;
   if figures_otb[1,0]=1 then
   Form1.Image10.Picture := Form1.res1.Picture;
   if figures_otb[1,0]=2 then
   Form1.Image10.Picture := Form1.res2.Picture;
   if figures_otb[1,0]=3 then
   Form1.Image10.Picture := Form1.res3.Picture;
   if figures_otb[1,0]=4 then
   Form1.Image10.Picture := Form1.res4.Picture;

   if figures_otb[1,1]=0 then
   Form1.Image11.Picture := Form1.res0.Picture;
   if figures_otb[1,1]=1 then
   Form1.Image11.Picture := Form1.res1.Picture;
   if figures_otb[1,1]=2 then
   Form1.Image11.Picture := Form1.res2.Picture;
   if figures_otb[1,1]=3 then
   Form1.Image11.Picture := Form1.res3.Picture;
   if figures_otb[1,1]=4 then
   Form1.Image11.Picture := Form1.res4.Picture;

   if figures_otb[1,2]=0 then
   Form1.Image12.Picture := Form1.res0.Picture;
   if figures_otb[1,2]=1 then
   Form1.Image12.Picture := Form1.res1.Picture;
   if figures_otb[1,2]=2 then
   Form1.Image12.Picture := Form1.res2.Picture;
   if figures_otb[1,2]=3 then
   Form1.Image12.Picture := Form1.res3.Picture;
   if figures_otb[1,2]=4 then
   Form1.Image12.Picture := Form1.res4.Picture;

   if figures_otb[1,3]=0 then
   Form1.Image13.Picture := Form1.res0.Picture;
   if figures_otb[1,3]=1 then
   Form1.Image13.Picture := Form1.res1.Picture;
   if figures_otb[1,3]=2 then
   Form1.Image13.Picture := Form1.res2.Picture;
   if figures_otb[1,3]=3 then
   Form1.Image13.Picture := Form1.res3.Picture;
   if figures_otb[1,3]=4 then
   Form1.Image13.Picture := Form1.res4.Picture;

   if figures_otb[1,4]=0 then
   Form1.Image14.Picture := Form1.res0.Picture;
   if figures_otb[1,4]=1 then
   Form1.Image14.Picture := Form1.res1.Picture;
   if figures_otb[1,4]=2 then
   Form1.Image14.Picture := Form1.res2.Picture;
   if figures_otb[1,4]=3 then
   Form1.Image14.Picture := Form1.res3.Picture;
   if figures_otb[1,4]=4 then
   Form1.Image14.Picture := Form1.res4.Picture;

   if figures_otb[2,0]=0 then
   Form1.Image20.Picture := Form1.res0.Picture;
   if figures_otb[2,0]=1 then
   Form1.Image20.Picture := Form1.res1.Picture;
   if figures_otb[2,0]=2 then
   Form1.Image20.Picture := Form1.res2.Picture;
   if figures_otb[2,0]=3 then
   Form1.Image20.Picture := Form1.res3.Picture;
   if figures_otb[2,0]=4 then
   Form1.Image20.Picture := Form1.res4.Picture;

   if figures_otb[2,1]=0 then
   Form1.Image21.Picture := Form1.res0.Picture;
   if figures_otb[2,1]=1 then
   Form1.Image21.Picture := Form1.res1.Picture;
   if figures_otb[2,1]=2 then
   Form1.Image21.Picture := Form1.res2.Picture;
   if figures_otb[2,1]=3 then
   Form1.Image21.Picture := Form1.res3.Picture;
   if figures_otb[2,1]=4 then
   Form1.Image21.Picture := Form1.res4.Picture;

   if figures_otb[2,2]=0 then
   Form1.Image22.Picture := Form1.res0.Picture;
   if figures_otb[2,2]=1 then
   Form1.Image22.Picture := Form1.res1.Picture;
   if figures_otb[2,2]=2 then
   Form1.Image22.Picture := Form1.res2.Picture;
   if figures_otb[2,2]=3 then
   Form1.Image22.Picture := Form1.res3.Picture;
   if figures_otb[2,2]=4 then
   Form1.Image22.Picture := Form1.res4.Picture;

   if figures_otb[2,3]=0 then
   Form1.Image23.Picture := Form1.res0.Picture;
   if figures_otb[2,3]=1 then
   Form1.Image23.Picture := Form1.res1.Picture;
   if figures_otb[2,3]=2 then
   Form1.Image23.Picture := Form1.res2.Picture;
   if figures_otb[2,3]=3 then
   Form1.Image23.Picture := Form1.res3.Picture;
   if figures_otb[2,3]=4 then
   Form1.Image23.Picture := Form1.res4.Picture;

   if figures_otb[2,4]=0 then
   Form1.Image24.Picture := Form1.res0.Picture;
   if figures_otb[2,4]=1 then
   Form1.Image24.Picture := Form1.res1.Picture;
   if figures_otb[2,4]=2 then
   Form1.Image24.Picture := Form1.res2.Picture;
   if figures_otb[2,4]=3 then
   Form1.Image24.Picture := Form1.res3.Picture;
   if figures_otb[2,4]=4 then
   Form1.Image24.Picture := Form1.res4.Picture;

   if figures_otb[3,0]=0 then
   Form1.Image30.Picture := Form1.res0.Picture;
   if figures_otb[3,0]=1 then
   Form1.Image30.Picture := Form1.res1.Picture;
   if figures_otb[3,0]=2 then
   Form1.Image30.Picture := Form1.res2.Picture;
   if figures_otb[3,0]=3 then
   Form1.Image30.Picture := Form1.res3.Picture;
   if figures_otb[3,0]=4 then
   Form1.Image30.Picture := Form1.res4.Picture;

   if figures_otb[3,1]=0 then
   Form1.Image31.Picture := Form1.res0.Picture;
   if figures_otb[3,1]=1 then
   Form1.Image31.Picture := Form1.res1.Picture;
   if figures_otb[3,1]=2 then
   Form1.Image31.Picture := Form1.res2.Picture;
   if figures_otb[3,1]=3 then
   Form1.Image31.Picture := Form1.res3.Picture;
   if figures_otb[3,1]=4 then
   Form1.Image31.Picture := Form1.res4.Picture;

   if figures_otb[3,2]=0 then
   Form1.Image32.Picture := Form1.res0.Picture;
   if figures_otb[3,2]=1 then
   Form1.Image32.Picture := Form1.res1.Picture;
   if figures_otb[3,2]=2 then
   Form1.Image32.Picture := Form1.res2.Picture;
   if figures_otb[3,2]=3 then
   Form1.Image32.Picture := Form1.res3.Picture;
   if figures_otb[3,2]=4 then
   Form1.Image32.Picture := Form1.res4.Picture;

   if figures_otb[3,3]=0 then
   Form1.Image33.Picture := Form1.res0.Picture;
   if figures_otb[3,3]=1 then
   Form1.Image33.Picture := Form1.res1.Picture;
   if figures_otb[3,3]=2 then
   Form1.Image33.Picture := Form1.res2.Picture;
   if figures_otb[3,3]=3 then
   Form1.Image33.Picture := Form1.res3.Picture;
   if figures_otb[3,3]=4 then
   Form1.Image33.Picture := Form1.res4.Picture;

   if figures_otb[3,4]=0 then
   Form1.Image34.Picture := Form1.res0.Picture;
   if figures_otb[3,4]=1 then
   Form1.Image34.Picture := Form1.res1.Picture;
   if figures_otb[3,4]=2 then
   Form1.Image34.Picture := Form1.res2.Picture;
   if figures_otb[3,4]=3 then
   Form1.Image34.Picture := Form1.res3.Picture;
   if figures_otb[3,4]=4 then
   Form1.Image34.Picture := Form1.res4.Picture;

   if figures_otb[4,0]=0 then
   Form1.Image40.Picture := Form1.res0.Picture;
   if figures_otb[4,0]=1 then
   Form1.Image40.Picture := Form1.res1.Picture;
   if figures_otb[4,0]=2 then
   Form1.Image40.Picture := Form1.res2.Picture;
   if figures_otb[4,0]=3 then
   Form1.Image40.Picture := Form1.res3.Picture;
   if figures_otb[4,0]=4 then
   Form1.Image40.Picture := Form1.res4.Picture;

   if figures_otb[4,1]=0 then
   Form1.Image41.Picture := Form1.res0.Picture;
   if figures_otb[4,1]=1 then
   Form1.Image41.Picture := Form1.res1.Picture;
   if figures_otb[4,1]=2 then
   Form1.Image41.Picture := Form1.res2.Picture;
   if figures_otb[4,1]=3 then
   Form1.Image41.Picture := Form1.res3.Picture;
   if figures_otb[4,1]=4 then
   Form1.Image41.Picture := Form1.res4.Picture;

   if figures_otb[4,2]=0 then
   Form1.Image42.Picture := Form1.res0.Picture;
   if figures_otb[4,2]=1 then
   Form1.Image42.Picture := Form1.res1.Picture;
   if figures_otb[4,2]=2 then
   Form1.Image42.Picture := Form1.res2.Picture;
   if figures_otb[4,2]=3 then
   Form1.Image42.Picture := Form1.res3.Picture;
   if figures_otb[4,2]=4 then
   Form1.Image42.Picture := Form1.res4.Picture;

   if figures_otb[4,3]=0 then
   Form1.Image43.Picture := Form1.res0.Picture;
   if figures_otb[4,3]=1 then
   Form1.Image43.Picture := Form1.res1.Picture;
   if figures_otb[4,3]=2 then
   Form1.Image43.Picture := Form1.res2.Picture;
   if figures_otb[4,3]=3 then
   Form1.Image43.Picture := Form1.res3.Picture;
   if figures_otb[4,3]=4 then
   Form1.Image43.Picture := Form1.res4.Picture;

   if figures_otb[4,4]=0 then
   Form1.Image44.Picture := Form1.res0.Picture;
   if figures_otb[4,4]=1 then
   Form1.Image44.Picture := Form1.res1.Picture;
   if figures_otb[4,4]=2 then
   Form1.Image44.Picture := Form1.res2.Picture;
   if figures_otb[4,4]=3 then
   Form1.Image44.Picture := Form1.res3.Picture;
   if figures_otb[4,4]=4 then
   Form1.Image44.Picture := Form1.res4.Picture;
end;

procedure click(Sender:TObject);
begin
   //click
end;

procedure movement();
label
   truerandomxy, truerandomx, truerandomy;
var
   cache_v:integer;
   mvt_flag:boolean;
   ix, iy:integer;
   rnd_cnt:integer;
   flag_mixed:boolean;
begin
   rnd_cnt:=0;
   mvt_flag:=false;
   //check conditions
   if (first_click_x = second_click_x) and (first_click_y - second_click_y=1) then
   mvt_flag:=true;
   if (first_click_x = second_click_x) and (first_click_y - second_click_y=-1) then
   mvt_flag:=true;
   if (first_click_x - second_click_x=1) and (first_click_y = second_click_y) then
   mvt_flag:=true;
   if (first_click_x - second_click_x=-1) and (first_click_y = second_click_y) then
   mvt_flag:=true;
   //checking - is there 3 in row?

   truerandomxy:
   flag_mixed:=false;
   ix:=0;
   iy:=0;
   for ix:=2 to 5 do
   begin
       for iy:=0 to 5 do
       begin
           if (figures_otb[ix,iy]=figures_otb[ix-1,iy]) and (figures_otb[ix,iy]=figures_otb[ix-2,iy]) then
           begin
               //ShowMessage('Hello man, there a three in row on X!'); //debug use only
               truerandomx:
               flag_mixed:=true;
               rnd_cnt:=rnd_cnt+1;
               figures_otb[ix-1,iy]:=trunc(random*4);
               if (figures_otb[ix-1,iy]=figures_otb[ix-2,iy]) and (figures_otb[ix-1,iy]=figures_otb[ix,iy]) then
               begin
                   goto truerandomx;
               end;
           end
           else
           begin
               rnd_cnt := rnd_cnt;
               //
           end;
       end;
   end;

   ix:=0;
   iy:=0;
   for ix:=0 to 5 do
   begin
       for iy:=2 to 5 do
       begin
           if (figures_otb[ix,iy]=figures_otb[ix,iy-1]) and (figures_otb[ix,iy]=figures_otb[ix,iy-2]) then
           begin
               //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
               truerandomy:
               flag_mixed:=true;
               rnd_cnt:=rnd_cnt+1;
               figures_otb[ix,iy-1]:=trunc(random*4);
               if (figures_otb[ix,iy-1]=figures_otb[ix,iy-2]) and (figures_otb[ix,iy-1]=figures_otb[ix,iy]) then
               begin
                   goto truerandomy;
               end;
           end;
       end;
   end;
   if flag_mixed = true then
   begin
      goto truerandomxy;
   end;

   //mvt
   if mvt_flag = true then
   begin
      cache_v     := figures_otb[first_click_x, first_click_y];
      figures_otb[first_click_x, first_click_y]   := figures_otb[second_click_x, second_click_y];
      figures_otb[second_click_x, second_click_y] := cache_v;
      appear();
   end;

   //after mvt
   first_click_x  :=-1;
   first_click_y  :=-1;
   second_click_x :=-1;
   second_click_y :=-1;
   //Form1.Label1.Caption :=IntToStr(first_click_x);
   //Form1.Label2.Caption :=IntToStr(first_click_y);
   //Form1.Label3.Caption :=IntToStr(second_click_x);
   //Form1.Label4.Caption :=IntToStr(second_click_y);
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
   first_click_x  :=-1;
   first_click_y  :=-1;
   second_click_x :=-1;
   second_click_y :=-1;
   Label1.Caption :=IntToStr(first_click_x);
   Label2.Caption :=IntToStr(first_click_y);
   Label3.Caption :=IntToStr(second_click_x);
   Label4.Caption :=IntToStr(second_click_y);
   load_theme();
   init_seq();
   appear();
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
  //load another theme
end;

procedure TForm1.backgroundClick(Sender: TObject);
begin

end;

procedure TForm1.Image00Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 0;
      first_click_y := 0;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 0;
      second_click_y := 0;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image01Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 0;
      first_click_y := 1;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 0;
      second_click_y := 1;
  end;

  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     movement();
  end;
end;

procedure TForm1.Image02Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 0;
      first_click_y := 2;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 0;
      second_click_y := 2;
  end;

  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     movement();
  end;
end;

procedure TForm1.Image03Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 0;
      first_click_y := 3;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 0;
      second_click_y := 3;
  end;

  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     movement();
  end;
end;

procedure TForm1.Image04Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 0;
      first_click_y := 4;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 0;
      second_click_y := 4;
  end;

  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     movement();
  end;
end;

procedure TForm1.Image10Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 1;
      first_click_y := 0;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 1;
      second_click_y := 0;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image11Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 1;
      first_click_y := 1;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 1;
      second_click_y := 1;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image12Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 1;
      first_click_y := 2;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 1;
      second_click_y := 2;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image13Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 1;
      first_click_y := 3;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 1;
      second_click_y := 3;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image14Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 1;
      first_click_y := 4;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 1;
      second_click_y := 4;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image20Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 2;
      first_click_y := 0;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 2;
      second_click_y := 0;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image21Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 2;
      first_click_y := 1;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 2;
      second_click_y := 1;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image22Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 2;
      first_click_y := 2;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 2;
      second_click_y := 2;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image23Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 2;
      first_click_y := 3;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 2;
      second_click_y := 3;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image24Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 2;
      first_click_y := 4;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 2;
      second_click_y := 4;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image30Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 3;
      first_click_y := 0;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 3;
      second_click_y := 0;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image31Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 3;
      first_click_y := 1;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 3;
      second_click_y := 1;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image32Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 3;
      first_click_y := 2;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 3;
      second_click_y := 2;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image33Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 3;
      first_click_y := 3;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 3;
      second_click_y := 3;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image34Click(Sender: TObject);
begin
  click();
  if (first_click_x = -1) and (first_click_y = -1) then
  begin
      showmessage('1st click');
      first_click_x := 3;
      first_click_y := 4;
  end
  else
  begin
      showmessage('2nd click');
      second_click_x := 3;
      second_click_y := 4;
  end;
  if (first_click_x <> -1) and (second_click_x <> -1) then
  begin
     //ShowMessage('Hello man, there a three in row on Y!'); //debug use only
     movement();
  end;
end;

procedure TForm1.Image40Click(Sender: TObject);
begin

end;

procedure TForm1.Label5Click(Sender: TObject);
begin

end;

end.

