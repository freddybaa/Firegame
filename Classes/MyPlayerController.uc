class MyPlayerController extends UDKPlayerController;


  


function DrawHUD( HUD H )
{
    local float CrosshairSize;
    super.DrawHUD(H);

    H.Canvas.SetDrawColor(0,255,0,255);

    CrosshairSize = 5;

    H.Canvas.SetPos(H.CenterX - CrosshairSize, H.CenterY);


    H.Canvas.DrawRect(2*CrosshairSize + 1, 1);

    H.Canvas.SetPos(H.CenterX, H.CenterY - CrosshairSize);
    H.Canvas.DrawRect(1, 2*CrosshairSize + 1);
}

exec function Use()
{
	
	local vector loc, norm, end;
	local TraceHitInfo hitInfo;
	local Actor traceHit;

	end = Location + normal(vector(Rotation))*500;
	traceHit = trace(loc, norm, end, Location, true,, hitInfo);

	ClientMessage("");
	
	if (traceHit == none)
	{
		ClientMessage("Trace failed.");
		DrawDebugLine (Location, end, 0, 255, 0, false);
		return;
	}
	else
	{
		
		DrawDebugLine (Location, end, 0, 255, 0, false);
		// Play a sound to confirm the information
		ClientPlaySound(SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_TargetLock');

		// By default only 4 console messages are shown at the time
 		ClientMessage("Hit: "$traceHit$"  class: "$traceHit.class.outer.name$"."$traceHit.class);
 		ClientMessage("Location: "$loc.X$","$loc.Y$","$loc.Z);
 		//ClientMessage("Material: "$hitInfo.Material$"  PhysMaterial: "$hitInfo.PhysMaterial);
		//ClientMessage("Component: "$hitInfo.HitComponent);
		
	}
	
	
}

defaultproperties
{
}