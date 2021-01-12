begin


  if (C_Doji(5)=1)  Then 
  begin
    Select;// ALTA
  end

  else if (C_MornStar_EveStar(6,1,0)=1)  Then 
  begin
    Select;// ALTA
  end

  else if (C_MornStar_EveStar(6,0,1)=1)  Then 
  begin
    Select;// ALTA
  end


  else if (C_ShootingStar(10,1)=1)  Then 
  begin
    Select;// ALTA
  end

  else if (C_Hammer_HangingMan(7,2,1,0)=1)  Then 
  begin
    Select;// ALTA
  end

  else if (C_Hammer_HangingMan(7,2,0,1)=1)  Then 
  begin
    Select;// ALTA
  end

  else if (C_MornDoji_EveDoji(9,3,1,0)=1)  Then 
  begin
    Select;// ALTA
  end

  else if (C_MornDoji_EveDoji(9,3,0,1)=1)  Then 
  begin
    Select;// ALTA
  end ;
end;
