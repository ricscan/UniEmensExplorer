unit UXMLUtil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function XMLDateToDate(s:String):TDate;

implementation

function XMLDateToDate(s:String):TDate;
var
  t:Integer;
  sep:Integer;
  Y,M,D:Word;
  tmps:String;
  c:char;
begin
  s:=s+'-';
  sep:=0;
  tmps:='';
  for t:=1 to length(s) do
    begin
      c:=s[t];
      if c='-' then begin
        if sep=0 then Y:=StrToInt(tmps);
        if Sep=1 then M:=StrToInt(tmps);
        if Sep=2 then D:=StrToInt(tmps);
        sep:=Sep+1;
        tmps:='';
      end
      else tmps:=tmps+c;
    end;
  XMLDateToDate:=EncodeDate(Y,M,D);
end;
end.

