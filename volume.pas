
var
  vol:Real;

begin
  vol:=2.4*Media(31,VolumeD(31));
  if (Close>Open) and (VolumeD(0)<vol) Then 
  begin 
    PaintBar(clGreen);// ALTA
  end

  else if (Close>Open) and (VolumeD(0)>vol) Then 
  begin 
    PaintBar(clBlack);// ALTA
  end

  else if (Close<Open) and (VolumeD(0)<vol) Then 
  begin 
    PaintBar(clRed);// ALTA
  end

  else if (Close<Open) and (VolumeD(0)>vol) Then 
  begin 
    PaintBar(clBlack);// ALTA
  end;
end;
