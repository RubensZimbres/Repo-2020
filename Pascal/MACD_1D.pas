parâmetro
  PeriodoRapido(9);
  PeriodoLento(26);
  PeriodoLento2(35);
  Sinal(9);

  MediaRapida(26);
  MediaLenta(35);                
var
  ZeroLAG_MACD: Real;
  ZeroLAG_MACD_Sinal : Real;
  sZeroLAG_MACD : Real;
  sZeroLAG_MACD_Sinal : Real;

begin

  ZeroLAG_MACD_Sinal := MACD(11,9,9)|1|;
  
  ///Plot2(ZeroLAG_MACD_Sinal);
  if (ZeroLAG_MACD_Sinal > -0.013)  Then PaintBar(clLime) else PaintBar(clGreen);
  //t:=0;
  
  // BBAS3F

  se (isBought = false) e (MACD(11,9,9)|0|>-0.12) e (MACD(11,9,9)|1|>0) e ((ZeroLAG_MACD-ZeroLAG_MACD_Sinal) > 0) então
    
    inicio
      ClosePosition;  
      BuyAtMarket;
      SellToCoverStop(High[1]*0.9, High[1]*0.9);

    Fim
   
  senão se ((ZeroLAG_MACD-ZeroLAG_MACD_Sinal) < 0) e (MACD(35,26,9)|1|<0.21) então
    inicio
      
      se (isBought = true) então
        ClosePosition;
        SellToCoverAtMarket;
       
    fim;
     
end;
