unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    ListBox5: TListBox;
    ListBox6: TListBox;
    ListBox7: TListBox;
    ListBox8: TListBox;
    ListBox9: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ListBox7DblClick(Sender: TObject);
    procedure ListBox8DblClick(Sender: TObject);

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

function ruthin0(s:string):string;
begin
  s := StringReplace(s,'　',' ',[rfReplaceAll]);
  ruthin0 := StringReplace(s,' ',char(13),[rfReplaceAll]);
end;

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
    setchar := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz[]#$,.';
    setnumber := '#@1234567890{}"''';
    setcara := '-=~|\%+:*/!?\<>()';
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

function ruthin2:boolean;
var
  i,i1:integer;
  s,s1:string;
  set_if:TstringList;
  set_block:TstringList;
  get_command1,get_command2:string;
  get_if:TStringlist;
  get_block:TstringList;
  function get_ruthin(x:String):boolean;
  var
    i,i1,i2,i3:integer;
    s:string;
  begin
    s:= x;
    i2 := set_if.IndexOf(s);
    if i2 > -1 then begin
           get_command1 := set_if[i2];
    end;
       i3 := set_block.IndexOf(s);
    if i3 > -1 then begin
      get_command2 := set_block[i3];
    end;
  end;

begin
  set_if := TStringList.Create;
  set_if.Text := 'IF' +char(13)+ 'if' +char(13)+'THEN'+char(13)+ 'then'+char(13);
  set_block := TStringList.Create;
  set_block.Text := 'BEGIN' +char(13)+'begin' +char(13)+'END' +char(13)+'end' +char(13)+'END;'+char(13)+ 'end;' +char(13)+';'+char(13);
  get_if := TStringList.Create;
  get_block := TStringList.Create;
  get_if.Clear;
  get_block.Clear;
  s := ' ';

  for i := 0 to form1.ListBox1.Count -1 do begin
    get_command1 := '';
    get_command2 := '';
    get_ruthin(form1.listbox1.Items[i]);

    s1 := '';
    for i1 := 1 to length(get_command1) do begin
      s1 := s1 + s[1];
    end;
    if get_command1 <> s1 then
      get_if.Add(get_command1);
    s1 := '';
    for i1 := 1 to length(get_command2) do begin
      s1 := s1 + s[1];
    end;
    if get_command2 <> s1 then
      get_block.Add(get_command2);
  end;
  replace_space(get_if);
  replace_space(get_block);

  form1.ListBox4.Items.Text:= get_if.Text;
  form1.ListBox5.Items.Text:= get_block.Text;

end;

function ruthin3(L1,L2:TStringList):boolean;
var
  i,i1:integer;
begin
  for i := 0 to l2.Count -1 do begin
    i1 := l1.IndexOf(l2[i]);
    if i1 > -1 then begin
      l1.Delete(i1);
    end;
  end;
end;

function ruthin4(st1,st2,st3,st4,st5,st6,st7,st8:TStringList;s1,s2,s3,s4,s5,s6,s7:string):boolean;
var
  s:string;
  i:integer;
  st:TStringList;
  function subruthin1(st1,st2,st3:TStringList;s:string):boolean;
  var
    i,i1:integer;
  begin
    if st1.Count > 0 then
    for i := 0 to st1.Count -1 do begin
      i1 := st2.IndexOf(st1[i]);
      if i1 > -1 then begin
        st3[i] := s + ' no.' + inttostr(i1);
      end;
    end;
  end;
begin
  for i := 0 to 7 do begin
    case i of
      0:begin
        st := st2;
        s := s1;
      end;
      1:begin
        st := st3;
        s := s2;
      end;
      2:begin
        st := st4;
        s := s3;
      end;
      3:begin
        st := st5;
        s := s4;
      end;
      4:begin
        st := st6;
        s := s5;
      end;
      5:begin
        st := st7;
        s := s6;
      end;
    end;
    subruthin1(st1,st,st8,s);
  end;
end;

function ruthin5(st:TStringList):boolean;
begin
  st.Text := StringReplace(st.Text,'set_',' ',[rfReplaceAll]);
  st.Text := StringReplace(st.Text,' no.',' ',[rfReplaceAll]);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  form1.ListBox7.Items.Text := ruthin0(edit1.Text);
  ruthin1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ruthin2
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  l1,l2:TStringList;
begin
  l1 := TStringList.Create;
  l2 := TStringList.Create;
  l1.Text:= form1.ListBox1.Items.Text;
  l2.Text:= form1.ListBox4.Items.Text;
  ruthin3(l1,l2);
  l2.Text:= form1.ListBox5.Items.Text;
  ruthin3(l1,l2);
  form1.ListBox6.Items.Text := l1.Text;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  st1,st2,st3,st4,st5,st6,st7,st8:TStringList;
  s1,s2,s3,s4,s5,s6,s7:string;
  function set_string:boolean;
  var
    i:integer;
    s:string;
  begin
    for i := 0 to 7 do begin
      s := 'set_' + inttostr(i+1);
      case i of
        0:s1 := s;
        1:s2 := s;
        2:s3 := s;
        3:s4 := s;
        4:s5 := s;
        5:s6 := s;
        6:s7 := s;
      end;
    end;
  end;
begin
  st1 := TStringList.Create;
  st2 := TStringList.Create;
  st3 := TStringList.Create;
  st4 := TStringList.Create;
  st5 := TStringList.Create;
  st6 := TStringList.Create;
  st7 := TStringList.Create;
  st8 := TStringList.Create;
  st1.Text:= Listbox7.Items.Text;
  st2.Text:= Listbox1.Items.Text;
  st3.Text:= Listbox2.Items.Text;
  st4.Text:= Listbox3.Items.Text;
  st5.Text:= Listbox4.Items.Text;
  st6.Text:= Listbox5.Items.Text;
  st7.Text:= Listbox6.Items.Text;
  st8.Text:= Listbox7.Items.Text;

  set_string;
  //showmessage(st1.Text);
  ruthin4(st1,st2,st3,st4,st5,st6,st7,st8, s1,s2,s3,s4,s5,s6,s7);
  listbox8.Items.Text:= st8.Text;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  st:TStringList;
begin
  st := TStringList.Create;
  st.Text:= form1.ListBox8.Items.Text;
  ruthin5(st);
  form1.ListBox9.Items.Text:= st.Text;
  st.Free;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox7DblClick(Sender: TObject);
var
  i,i1:integer;
  s,s1:string;
  st:TStringList;
  function ruthin6(c:TListbox;i:integer):boolean;
  begin
    form1.ActiveControl := c;
    c.ItemIndex := i;
  end;

begin
  st := TStringList.Create;
  st.Clear;
  s := form1.ListBox9.Items[form1.ListBox7.ItemIndex];
  st.text := StringReplace(s,' ',char(13),[rfReplaceAll]);
  s1 := '1234567890';
  i := st.Count -1;
  while i > 0 do begin
    i1 := ansipos(st[i],s1);
    if 0 = i1 then
      st.Delete(i);
    dec(i);
  end;
  //showmessage(st.Text);
  i := strtoint(st[1]);
  i1 := strtoint(st[2]);
  case i of
    1:begin
      ruthin6(form1.ListBox1,i1);
    end;
    2:begin
      ruthin6(form1.ListBox2,i1);
    end;
    3:begin
      ruthin6(form1.ListBox3,i1);
    end;
    4:begin
      ruthin6(form1.ListBox4,i1);
    end;
    5:begin
      ruthin6(form1.ListBox5,i1);
    end;
    6:begin
      ruthin6(form1.ListBox6,i1);
    end;
  end;

end;

procedure TForm1.ListBox8DblClick(Sender: TObject);
var
  i,i1:integer;
  s,s1:string;
  st:TStringList;
  function ruthin6(c:TListbox;i:integer):boolean;
  begin
    form1.ActiveControl := c;
    c.ItemIndex := i;
  end;

begin
  st := TStringList.Create;
  st.Clear;
  s := form1.ListBox9.Items[form1.ListBox8.ItemIndex];
  st.text := StringReplace(s,' ',char(13),[rfReplaceAll]);
  s1 := '1234567890';
  i := st.Count -1;
  while i > 0 do begin
    i1 := ansipos(st[i],s1);
    if 0 = i1 then
      st.Delete(i);
    dec(i);
  end;
  //showmessage(st.Text);
  i := strtoint(st[1]);
  i1 := strtoint(st[2]);
  case i of
    1:begin
      ruthin6(form1.ListBox1,i1);
    end;
    2:begin
      ruthin6(form1.ListBox2,i1);
    end;
    3:begin
      ruthin6(form1.ListBox3,i1);
    end;
    4:begin
      ruthin6(form1.ListBox4,i1);
    end;
    5:begin
      ruthin6(form1.ListBox5,i1);
    end;
    6:begin
      ruthin6(form1.ListBox6,i1);
    end;
  end;

end;




end.

