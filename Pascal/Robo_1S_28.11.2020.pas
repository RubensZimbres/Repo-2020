parâmetro
  PeriodoRapido(9);
  PeriodoLento(15);
  PeriodoLento2(15);
  Sinal(9);

  MediaRapida(9);
  MediaLenta(15);  
var
  ZeroLAG_MACD: Real;
  ZeroLAG_MACD_Sinal : Real;
  sZeroLAG_MACD : Real;
  sZeroLAG_MACD_Sinal : Real;

begin

  ZeroLAG_MACD := (MediaExp(PeriodoRapido,Close) - (MediaExp(PeriodoLento,Close)));
  ZeroLAG_MACD_Sinal := 2*MediaExp(Sinal,ZeroLAG_MACD) - MediaExp(Sinal,MediaExp(Sinal,ZeroLAG_MACD));
  
  sZeroLAG_MACD := ZeroLAG_MACD[1];
  sZeroLAG_MACD_Sinal  := ZeroLAG_MACD_Sinal[1];
      
  Plot(ZeroLAG_MACD-ZeroLAG_MACD_Sinal);
  Plot2(ZeroLAG_MACD_Sinal);
  Plot3(ZeroLAG_MACD);
  if ((ZeroLAG_MACD-ZeroLAG_MACD_Sinal) > 0)  Then PaintBar(clLime) else PaintBar(clGreen);
  ///if (IFR(9) < 25)  Then PaintBar(clBlack);
  ///if (IFR(9) > 75)  Then PaintBar(clBlack);
 //t:=0;
  
  // BBAS3F

  se (isBought = false) e (Media(9,Close)>Media(11,Close)) e ((ZeroLAG_MACD-ZeroLAG_MACD_Sinal) > 0) e (MACD(11,9,9)|1|>-0.04) então
    
    inicio
      ClosePosition;  
      BuyAtMarket;
      SellToCoverStop(High[1]*0.9, High[1]*0.9);

    Fim
   
  senão se (MACD(11,9,9)|1|<0) e ((ZeroLAG_MACD-ZeroLAG_MACD_Sinal) < 0) então
    inicio
      
      se (isBought = true) então
        ClosePosition; 
        SellToCoverAtMarket;
       
    fim;
     
end;
