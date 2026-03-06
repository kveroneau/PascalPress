unit fragman;

{$mode ObjFPC}

interface

uses
  Classes, SysUtils, htmlfragment;

var
  CurrentFragment: THTMLFragment;

procedure HideCurFragment;

implementation

procedure HideCurFragment;
begin
  if Assigned(CurrentFragment) then
  begin
    WriteLn('Hiding current fragment: ',CurrentFragment.Name);
    CurrentFragment.Hide;
    CurrentFragment:=Nil;
  end;
end;

initialization
  CurrentFragment:=Nil;

end.

