begin

  if (Media(13,Close)<Media(3,Close)) and (MACD(35,26,9)>MACD(35,26,9)[1])  Then 
  begin 
    PaintBar(clLime);// ALTA
  end
  else if (Media(13,Close)>Media(3,Close)) and (MACD(35,26,9)<MACD(35,26,9)[1])  Then 
  begin
    PaintBar(clRed);// ALTA
  end
  
  end;
