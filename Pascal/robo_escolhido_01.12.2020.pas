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
  
  se (isBought = false) e (hist>0) e (diff>0) então
    
    inicio
      ClosePosition;  
      BuyAtMarket;
      SellToCoverStop(High[1]*0.9, High[1]*0.9);

    Fim
   
  senão se (diff<0) então
    inicio
      
      se (isBought = true) então
        ClosePosition;
        SellToCoverAtMarket;
    fim;
     
end;
