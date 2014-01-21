class FireExtinguisher extends UDKWeapon placeable;

var Actor droppedWeapon;
var int Damage; 
var int ammo; 
var()int weaponOffset; 
var rotator playerRotation; 
var () SkeletalMeshComponent myMesh;
var StaticMeshComponent mMesh; 
var bool isShooting; 
var vector startPoint; 
var rotator startRotation; 
var ParticleSystemComponent particleBeam; 
var ParticleSystem myParticle; 
var AnimNodeSlot fire_animation; 
var bool pinPulled; 
var string type; 

simulated event SetPosition(UDKPawn Holder)
{

	local SkeletalMeshComponent compo;
    local SkeletalMeshSocket socket;
	local Vector FinalLocation;	
    local vector X,Y,Z;
	
	// Holder.mesh.AttachComponentToSocket(myMesh, 'WeaponPoint');
	
    compo = Holder.Mesh;
 
    if (compo != none)
    {
        socket = compo.GetSocketByName('WeaponPoint');
        if (socket != none)
        {
            FinalLocation = compo.GetBoneLocation(socket.BoneName);
			//WorldInfo.Game.Broadcast(self,FinalLocation);
        }
    } 
 
    // SetLocation(FinalLocation);
	// SetBase(Holder);
    // SetRotation(Holder.Controller.Rotation);
	// startPoint = FinalLocation; 
	// startRotation = Holder.Controller.Rotation; 
	
	//Y = position 
	//Z = height 
   Holder.GetAxes(Holder.Controller.Rotation,X,Y,Z);
   FinalLocation = FinalLocation - Y * 5 - Z ; 
    // FinalLocation= Holder.GetPawnViewLocation(); //this is in world space.
    // FinalLocation= FinalLocation - Y * 15 - Z * 55; // Rough position adjustment
	// WorldInfo.Game.Broadcast(self,FinalLocation);
	// WorldInfo.Game.BroadCast(self, Holder.GetPawnViewLocation()); 
    SetHidden(False);
    SetLocation(FinalLocation);
    SetBase(Holder);
    SetRotation(Holder.Controller.Rotation);
	playerRotation = Holder.Controller.Rotation; 
	
	//WorldInfo.Game.Broadcast(self,playerRotation);
}

exec function placeObject(){
	local vector objectPosition, StartTrace, Aim; 
	local rotator AimRot;
	local rotator defaultRotation; 
	local MyPawn P; 
	
	P = MyPawn( Instigator ); 
	P.Controller.GetPlayerViewPoint( StartTrace, AimRot );
	Aim = vector(AimRot); 
	objectPosition = StartTrace + Aim * 100; 
	defaultRotation.yaw = AimRot.roll; 
	
	P.InvManager.DiscardInventory();
	//objectPosition.y += 200; 
	objectPosition.z = 0; 
	
	
	Spawn(droppedWeapon.Class , , , objectPosition , defaultRotation , droppedWeapon);
}

event Tick(float DeltaTime)
{

	SetPosition(MyPawn(Instigator)); 
	//WorldInfo.Game.Broadcast(self,type);
}

simulated function vector GetWeaponLocation()
{
	local vector SocketLoc;
	local rotator SocketRot;

		if(myMesh != none)
		{
			//getting the vector
			myMesh.GetSocketWorldLocationAndRotation('MuzzleFlashSocket', SocketLoc, SocketRot);
			return SocketLoc;
		}

	return vect(0,0,0);
}




simulated function Projectile ProjectileFire()
{
	local vector		StartTrace, EndTrace, RealStartLoc, AimDir;
	local ImpactInfo	TestImpact;
	local Projectile	SpawnedProjectile;

	if(!pinPulled)return None; 
	
	// tell remote clients that we fired, to trigger effects
	IncrementFlashCount();

	if( Role == ROLE_Authority )
	{
		// This is where we would start an instant trace. (what CalcWeaponFire uses)
		StartTrace = Instigator.GetWeaponStartTraceLocation();
		AimDir = Vector(GetAdjustedAim( StartTrace ));

		// this is the location where the projectile is spawned.
		RealStartLoc = GetWeaponLocation();

		if( StartTrace != RealStartLoc )
		{
			// if projectile is spawned at different location of crosshair,
			// then simulate an instant trace where crosshair is aiming at, Get hit info.
			EndTrace = StartTrace + AimDir * GetTraceRange();
			TestImpact = CalcWeaponFire( StartTrace, EndTrace );

			// Then we realign projectile aim direction to match where the crosshair did hit.
			AimDir = Normal(TestImpact.HitLocation - RealStartLoc);
		}

		// Spawn projectile
		SpawnedProjectile = Spawn(GetProjectileClass(), Self,, RealStartLoc);
		if( SpawnedProjectile != None && !SpawnedProjectile.bDeleteMe )
		{
			
			
			
			
			SpawnedProjectile.Init( AimDir );
		}

		// Return it up the line
		return SpawnedProjectile;
	}

	return None;
}

simulated state WeaponFiring
{
	simulated event bool IsFiring()
	{
		if(!pinPulled)return false; 
		myMesh.PlayAnim('Fireextinguisher_Idle',,true, False); 
		return true;
	}
	
	simulated event BeginState( Name PreviousStateName )
	{
		
		FireAmmunition();
		TimeWeaponFiring( CurrentFireMode );
		if(!pinPulled)return;
		myMesh.PlayAnim('Fireextinguisher_StartShoot',,false, False); 
		
	}

	simulated event EndState( Name NextStateName )
	{
		if(!pinPulled)return; 
		`LogInv("NextStateName:" @ NextStateName);
		// Set weapon as not firing
		ClearFlashCount();
		ClearFlashLocation();
		ClearTimer( nameof(RefireCheckTimer) );
	
		NotifyWeaponFinishedFiring( CurrentFireMode );
		

		
		myMesh.PlayAnim('Fireextinguisher_StopShoot',,false, False); 
	}
}

//testing the pin animation 

exec function pullPin(){
	myMesh.PlayAnim('Fireextinguisher_Pull',,false, False); 
	pinPulled=true; 
}

simulated function ProcessInstantHit(byte FiringMode, ImpactInfo Impact, optional int NumHits)
{


	local vector startLoc; 
	
	
	if(!pinPulled)return; 
	if(isShooting==false)return;
	
	//if(ammo==0)return; 
	ammo--;

 
	startLoc = GetWeaponLocation(); 
	
	//WorldInfo.Game.Broadcast(self,ammo);

	DrawDebugLine( startLoc,  Impact.HitLocation, 255, 0 , 255);
	
	//idleanimation 
	
	// particleBeam = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'wooop.Effects.FX_DRY_POWDER',startLoc);
	
	 particleBeam = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'Wooop.Effects.FX_DRY_POWDER',startLoc);
	 particleBeam.bUpdateComponentInTick = true;
	 particleBeam.SetTickGroup(TG_EffectsUpdateWork);
	 
	 myMesh.PlayAnim('FIRE_EXTINGUISHER_WITH_ANIMATION_Idle',,true, False); 
	


    WorldInfo.MyDecalManager.SpawnDecal (   DecalMaterial'HU_Deck.Decals.M_Decal_GooLeakjj', // UMaterialInstance used for this decal.
                        Impact.HitLocation, // Decal spawned at the hit location.
                        rotator(-Impact.HitNormal), // Orient decal into the surface.
                        128, 128, // Decal size in tangent/binormal directions.
                        256, // Decal size in normal direction.
                        false, // If TRUE, use "NoClip" codepath.
                        FRand() * 360, // random rotation
                        Impact.HitInfo.HitComponent // If non-NULL, consider this component only.
    );

	
   //Impact.HitActor.TakeDamage(Damage, InstigatorController,  Impact.HitActor.HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
	
	
	
	
	
}

DefaultProperties
{

	pinPulled = false; 
	isShooting=false;
	ammo = 100; 
	//weaponOffset = 15; 
	FiringStatesArray(0)=WeaponFiring
    WeaponFireTypes(0)=EWFT_Projectile
    FireInterval(0)=0.1
    Spread(0)=0.2

	Begin Object class=AnimNodeSequence Name=myAnim
	End Object
	
	//WeaponProjectiles(0)=class'ExtinguisherProjectile'

	Begin Object class=SkeletalMeshComponent Name=MyStaticMesh
	
		 SkeletalMesh=SkeletalMesh'Wooop.FireExtinguisher'
		 Animsets(0)=AnimSet'wooop.Effects.Armature'
		 Animations=myAnim
		
		
		Scale=0.70
	End Object
	myMesh=MyStaticMesh
    Components.Add(MyStaticMesh)
	
	
}