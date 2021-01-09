begin


  if (C_Doji(5)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (C_MornStar_EveStar(6,1,0)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (C_MornStar_EveStar(6,0,1)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (C_ShootingStar(10,2)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (C_ShootingStar(10,1)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (C_Hammer_HangingMan(14,2,1,0)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (C_Hammer_HangingMan(14,2,0,1)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (C_MornDoji_EveDoji(9,3,1,0)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (C_MornDoji_EveDoji(9,3,0,1)=1)  Then 
  begin
    PaintBar(clBlack);// ALTA
  end

  else if (Media(13,Close)<Media(3,Close)) and (MACD(35,26,9)>MACD(35,26,9)[1])  Then 
  begin 
    PaintBar(clGreen);// ALTA
  end
  else if (Media(13,Close)>Media(3,Close)) and (MACD(35,26,9)<MACD(35,26,9)[1])  Then 
  begin
    PaintBar(clRed);// ALTA
  end
  ///else   if ((ADX(9,9)<=ADX(9,9)[1]) e (MACD(35,26,9)<MACD(35,26,9)[1]))  Then  //PULLBACK
  ///begin
    ///PaintBar(clBlack);
  ///end


  else PaintBar(clBlue);  

end;








