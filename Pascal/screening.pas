var
  ave0: Real;
  diff: Real;
  hist:Real;
  ave2: Real;
  
begin
  
  hist:=MACD(21,15,9)[1]|1|;
  ave0:=MediaExp(3,Close)[1];
  ave2:=MediaExp(13,Close)[1];
  diff:=ave0-ave2;


  se (hist>0) e (diff>0) e (MACD(21,15,9)[2]|1|<=0) e (ADX(9,9)[1]>ADX(9,9)[2]) então Select;

        
end;

- - - - - - - - - - - -  - -- 

var
  ave0: Real;
  diff: Real;
  hist:Real;
  ave2: Real;
  
begin
  
  hist:=MACD(21,15,9)[1]|1|;
  ave0:=MediaExp(3,Close)[1];
  ave2:=MediaExp(13,Close)[1];
  diff:=ave0-ave2;


  se (hist<0) e (diff<0) e (MACD(21,15,9)[2]|1|>=0) e (ADX(9,9)[1]<ADX(9,9)[2]) então Select;


end;
