/// 1 SEMANA

parâmetro
  PeriodoRapido(12);
  PeriodoLento(35);
  PeriodoLento2(35);
  Sinal(9);

  MediaRapida(25);
  MediaLenta(80);  
var
  ZeroLAG_MACD: Real;
  ZeroLAG_MACD_Sinal : Real;
  sZeroLAG_MACD : Real;
  sZeroLAG_MACD_Sinal : Real;

begin

  ZeroLAG_MACD := (2*MediaExp(PeriodoRapido,Close) - MediaExp(PeriodoRapido,MediaExp(PeriodoRapido,Close)) - (2*MediaExp(PeriodoLento,Close) - MediaExp(PeriodoLento,MediaExp(PeriodoLento,Close))));
  ZeroLAG_MACD_Sinal := 2*MediaExp(Sinal,ZeroLAG_MACD) - MediaExp(Sinal,MediaExp(Sinal,ZeroLAG_MACD));
  
  sZeroLAG_MACD := ZeroLAG_MACD[1];
  sZeroLAG_MACD_Sinal  := ZeroLAG_MACD_Sinal[1];
      
  Plot(ZeroLAG_MACD-ZeroLAG_MACD_Sinal);
  Plot2(ZeroLAG_MACD_Sinal);
  Plot3(ZeroLAG_MACD);
  if ((ZeroLAG_MACD-ZeroLAG_MACD_Sinal) > 0)  Then PaintBar(clLime) else PaintBar(clGreen);
  //t:=0;
  
  // BBAS3F

  se (isBought = false) e (MACD(11,9,9)|0|>-0.15) e (MACD(11,9,9)|1|>0) e ((ZeroLAG_MACD-ZeroLAG_MACD_Sinal) > 0) então
    
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
