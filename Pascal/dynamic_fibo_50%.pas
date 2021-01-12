var
  maior : Float;
  menor : Float;
  diff : Float;
  lower:Float;
  higher : Float;
begin
  maior := Highest(Close,144);
  menor := Lowest(Close,144);
  diff:=maior-menor;
  lower:= (menor+0.5*diff);
  SetPlotColor(1,clWhite);
  SetPlotWidth(1,2);
  Plot3(lower);


end;
