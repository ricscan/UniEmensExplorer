unit UUtilFunz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

Function CurrToStrPt(c:currency):String;
Function IntToStr2(i:Integer):String;

implementation

Function CurrToStrPt(c:currency):String;
begin
  if c=0 then CurrToStrPt:=''
         else CurrToStrPt:=Format('%n',[C]);
end;

Function IntToStr2(i:Integer):String;
begin
  if i=0 then IntToStr2:=''
         else IntToStr2:=IntToStr(i);
end;
end.

