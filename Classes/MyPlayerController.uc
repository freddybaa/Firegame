class MyPlayerController extends UDKPlayerController;


  
var Actor archetypeReference;

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

// exec function Use()
// {
	
	// local vector HitLocation, HitNormal, EndTrace, Aim, StartTrace;
	// local TraceHitInfo hitInfo;
	// local Actor traceHit;
	// local FireExtinguisher w;
	// local rotator AimRot;
	
	// Instigator.Controller.GetPlayerViewPoint( StartTrace, AimRot );
	// Aim = vector(AimRot);
	// EndTrace = StartTrace + Aim * 500;
	// tracehit = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true);
	// w =  FireExtinguisher ( Instigator.InvManager.PendingWeapon ); 
	
	// ClientMessage("");
	
	// if (traceHit == none)
	// {
		// ClientMessage("Trace failed.");
		// DrawDebugLine (HitLocation, EndTrace, 0, 255, 0, false);
		// return;
	// }
	// else
	// {
		
		// ClientMessage(w.type);
		// ClientMessage(Instigator.Location);
		// ClientMessage(pawn.Location);
		// ThrowWeapon();
		// Spawn(archetypeReference.Class, , , Location, , archetypeReference);
		// DrawDebugLine (Location, end, 0, 255, 0, false);
		// Play a sound to confirm the information
		//ClientPlaySound(SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_TargetLock');

		// By default only 4 console messages are shown at the time
 		// ClientMessage("Hit: "$traceHit$"  class: "$traceHit.class.outer.name$"."$traceHit.class);
 		// ClientMessage("Location: "$loc.X$","$loc.Y$","$loc.Z);
 		// ClientMessage("Material: "$hitInfo.Material$"  PhysMaterial: "$hitInfo.PhysMaterial);
		// ClientMessage("Component: "$hitInfo.HitComponent);
		
	// }
	
	
//}



defaultproperties
{

archetypeReference=PickableFireExtinguisher'MyPackage.testarch';
}