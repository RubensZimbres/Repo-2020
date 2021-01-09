var
  maior : Float;
  menor : Float;
  diff : Float;
  lower:Float;
  higher : Float;
  alvo : Float;
  alvo2: Float;
begin
  maior := Highest(Close,144)[22];
  menor := Lowest(Close,144);
  diff:=maior-menor;
  lower:= (menor+0.382*diff);
  higher:= (menor+0.618*diff);
  alvo:=maior*1.382;
  alvo2:=maior*1.618;
  
  SetPlotColor(1,clNavy);
  SetPlotColor(2,clNavy);
  
  SetPlotWidth(1,2);
  SetPlotWidth(2,2);
  
  Plot(alvo);
  Plot2(alvo2);

end;
