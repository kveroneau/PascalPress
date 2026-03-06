unit status404frag;

{$mode ObjFPC}

interface

uses
  SysUtils, Classes, htmlfragment, fragman;

type

  { TStatus404 }

  TStatus404 = class(THTMLFragment)
  private

  public

  end;

var
  Status404: TStatus404;

procedure Show404;

implementation

procedure Show404;
begin
  HideCurFragment;
  Status404.Show;
  CurrentFragment:=Status404;
end;

{$R *.lfm}

end.

