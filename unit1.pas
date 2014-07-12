unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    procedure Button1Click(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
function ruthin1:boolean;
var
  i:integer;
  h,j,k:TstringList;
  s,s0,s1,x:string;
  st1,st2,st3:TStringList;
  sw1,sw2,sw3:boolean;
  sw_number:boolean;
  function subruthin1(count:integer;x:String):boolean;
  var
    number,Str,chara,find_char:string;
    i,i1,i2,chek_spqace:integer;

    function set_words(s:string;st1,st2,st3:TStringList):boolean;
    var
      s1,s2,s3,setchar,setcara,setnumber:string;
      i,i1,i2:integer;

    function set_st(s:string;st:TStringList;sw:boolean):boolean;
    begin
      if sw then begin
        if st.Count > 0 then begin
          if st[st.Count -1] <> '' then begin
            st.Text:= st.Text + char(13);
          end;
        end;
        sw := false;
      end else if st.Count > 0 then begin
        st[st.Count-1]:= st[st.Count-1] + s;
      end else begin
        st.Add(s);
      end;
    end;
  begin
    setchar := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz[]()#$"",."';
    setnumber := '1234567890';
    setcara := '-=~|\{+:*}/?\';
    //sw_number := false;
    for i := 0 to length(setchar) -1 do begin
      if s = ' ' then begin
        sw1:=true;
      end;
      if s = setchar[i] then begin
      //英字
        s1 := s;
      end;
      if st1.count > 0 then begin
        if length(st1[st1.Count -1]) >= 1 then begin
          for i1 := 0 to length(setchar) do begin
            if 0 < ansipos(setchar[i1],st1[st1.Count -1]) then
              s1 := s;
            end;
          end;
        end;
        if (setchar[i] = s) then begin
        //errar
        end;
     end;


     for i1 := 0 to length(setnumber) do begin
       for i2 := 0 to length(setchar) do begin
         if s = setchar[i2] then begin
           sw_number := true;
         end else begin
           if (s = ' ') then begin
            sw2:=true;
           end;
           //number
           if not sw_number then begin
             if s = setnumber[i1] then begin
               s2 := s;
             end;
           end;
         end;

         if (s = ' ') or  ((not sw_number) and (s = setnumber[i1])) then  begin
           sw_number := false;
         end;
       end;
     end;


    for i1 := 0 to length(setcara) do begin
      if s = ' ' then begin
        sw3:=true;
      end;
      if (setcara[i1] = s) then begin
      //cara
        s3 := s3 + s;
      end;
    end;
    if st3.count > 0 then begin
      if length(st3[st3.Count -1]) >= 1 then begin
        for i1 := 0 to length(setcara) do begin
          if 0 < ansipos(setcara[i1],st3[st3.Count -1]) then
            s3 := s;
          end;
        end;
      end;
    set_st(s1,st1,sw1);
    sw1 := false;
    set_st(s2,st2,sw2);
    sw2 := false;
    set_st(s3,st3,sw3);
    sw3 := false;
  end;
  begin
    set_words(x,st1,st2,st3);
  end;

  function replace_space(st:TStringList):boolean;
  var
    i,i1:integer;
    sw:boolean;
  begin
    sw := true;
    st.Text := StringReplace(st.Text,'　',' ',[rfReplaceAll]);
    st.Text := StringReplace(st.Text,' ',char(13),[rfReplaceAll]);
    if st.count > 1 then begin
      i := st.Count -1;
      if st.Text <> '' then
      while i >= st.Count -1 do begin
        if (st[i] = char(13)) or (st[i] = ' ') or (st[i] = '') or (st[i] = char(0)) then begin
          st.Delete(i);
        end;
        dec(i);
        if i = 0 then
          exit;
      end;
    end;
  end;

begin
  s := form1.Edit1.Text;
  sw1 := false;
  sw2 := false;
  sw3 := false;
  st1 := TStringList.Create;
  st1.Clear;
  st2 := TStringList.Create;
  st2.Clear;
  st3 := TStringList.Create;
  st3.Clear;
  sw_number := false;
  for i := 1 to length(s) do begin;
    subruthin1(i,s[i]);
  end;
  replace_space(st1);
  replace_space(st2);
  replace_space(st3);
  form1.ListBox1.Items.Text:= st1.Text;
  form1.ListBox2.Items.Text:= st2.Text;
  form1.ListBox3.Items.Text:= st3.Text;
  st1.Free;
  st2.Free;
  st3.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ruthin1
end;




end.

