parâmetro
  PeriodoRapido(12);
  PeriodoLento(35);
  PeriodoLento2(35);
  Sinal(9);

  MediaRapida(25);
  MediaLenta(80);  

var
  maior : Float;
  menor : Float;
  diff : Float;
  lower:Float;
  higher : Float;
  media_red: Float;
  media_verde:Float;
  ZeroLAG_MACD: Real;
  ZeroLAG_MACD_Sinal : Real;
  sZeroLAG_MACD : Real;
  sZeroLAG_MACD_Sinal : Real;



     
begin
  ZeroLAG_MACD := (MediaExp(PeriodoRapido,Close) - (MediaExp(PeriodoLento,Close)));
  ZeroLAG_MACD_Sinal := 2*MediaExp(Sinal,ZeroLAG_MACD) - MediaExp(Sinal,MediaExp(Sinal,ZeroLAG_MACD));
  
  sZeroLAG_MACD := ZeroLAG_MACD[1];
  sZeroLAG_MACD_Sinal  := ZeroLAG_MACD_Sinal[1];

  media_verde:= Media(15,Close);
  media_red:= Media(21,Close);

  maior := Highest(Close,144);
  menor := Lowest(Close,144);
  diff:=maior-menor;
  lower:= (menor+0.382*diff);
  higher:= (menor+0.618*diff);
  
  Plot(maior);
  Plot2(menor);
  Plot3(lower);
  Plot4(higher);

  se (isBought = false) e (media_verde>media_red) então
    
    inicio
      ClosePosition;  
      BuyAtMarket;
      SellToCoverStop(High[1]*0.9, High[1]*0.9);

    Fim
   
  senão se (media_verde<media_red) então
    inicio
      
      se (isBought = true) então
        ClosePosition; 
        SellToCoverAtMarket;
       
    fim;
     

end;
