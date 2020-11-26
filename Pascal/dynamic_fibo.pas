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
  lower:= (menor+0.382*diff);
  higher:= (menor+0.618*diff);
  SetPlotColor(1,clLime);
  SetPlotColor(2,clRed);
  SetPlotColor(3,clRed);
  SetPlotColor(4,clLime);
  Plot(maior);
  Plot2(menor);
  Plot3(lower);
  Plot4(higher);


end;
