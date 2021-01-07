var
  ave0: Real;
  diff: Real;
  hist:Real;
  ave2: Real;
  
begin
  
  hist:=MACD(21,15,9)|1|;
  ave0:=MediaExp(3,Close);
  ave2:=MediaExp(13,Close);
  diff:=ave0-ave2;


  se (hist<0) e (hist>-0.02) e (diff<0) e (MACD(21,15,9)[1]|1|>=0) e (ADX(9,9)>ADX(9,9)[1]) então Select;

        
end;

____________________________

var
  ave0: Real;
  diff: Real;
  hist:Real;
  ave2: Real;
  
begin
  
  hist:=MACD(21,15,9)|1|;
  ave0:=MediaExp(3,Close);
  ave2:=MediaExp(13,Close);
  diff:=ave0-ave2;


  se (hist>0) e (hist<0.02) e (diff>0) e (MACD(21,15,9)[1]|1|<=0) e (ADX(9,9)>ADX(9,9)[1]) então Select;

        
end;
