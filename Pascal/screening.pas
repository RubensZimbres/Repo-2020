begin

  if (Media(13,Close)[1]<Media(3,Close)[1]) and (MACD(35,26,9)[1]>MACD(35,26,9)[2])  Then 
  begin 
    PaintBar(clLime);// ALTA
  end
  else if (Media(13,Close)[1]>Media(3,Close)[1]) and (MACD(35,26,9)[1]<MACD(35,26,9)[2])  Then 
  begin
    PaintBar(clRed);// ALTA
  end
  else Select
end;
