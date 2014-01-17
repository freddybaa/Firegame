class FireExtinguisher extends UDKWeapon placeable;


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
			WorldInfo.Game.Broadcast(self,FinalLocation);
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


event Tick(float DeltaTime)
{

	SetPosition(MyPawn(Instigator)); 
	WorldInfo.Game.Broadcast(self,type);
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

// simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
// {
	// super.PostInitAnimTree(SkelComp);

	// if(SkelComp == myMesh)
		// myMesh.PlayAnim('',,True, False); 
// }

simulated state WeaponFiring
{
	simulated event bool IsFiring()
	{
		return true;
	}
	simulated event BeginState( Name PreviousStateName )
	{
		`LogInv("PreviousStateName:" @ PreviousStateName);
		// Fire the first shot right away
		FireAmmunition();
		TimeWeaponFiring( CurrentFireMode );
		isShooting=true;
		particleBeam.ActivateSystem(true);
		if(!pinPulled)return; 
		myMesh.PlayAnim('FIRE_EXTINGUISHER_WITH_ANIMATION_StartShoot',,false, False); 
		//shootanimation here
	}

	simulated event EndState( Name NextStateName )
	{
		`LogInv("NextStateName:" @ NextStateName);
		// Set weapon as not firing
		ClearFlashCount();
		ClearFlashLocation();
		ClearTimer( nameof(RefireCheckTimer) );
	
		NotifyWeaponFinishedFiring( CurrentFireMode );
		
		isShooting=false;
		particleBeam.DeactivateSystem();
		if(!pinPulled)return; 
		myMesh.PlayAnim('FIRE_EXTINGUISHER_WITH_ANIMATION_StopShoot',,false, False); 
	}
}

//testing the pin animation 

exec function pullPin(){
	myMesh.PlayAnim('FIRE_EXTINGUISHER_WITH_ANIMATION_Pull_pin',,false, False); 
	pinPulled=true; 
}
function setType(string newType){
	self.type = newType; 
}
simulated function ProcessInstantHit(byte FiringMode, ImpactInfo Impact, optional int NumHits)
{

	local Fire fire; 
	local vector startLoc; 
	
	
	if(!pinPulled)return; 
	//if(isShooting==false)return;
	
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
	
	
	
	
	fire = Fire(Impact.HitActor); 
	
	fire.take(Damage);
	isShooting=false;
}

DefaultProperties
{
	pinPulled = false; 
	isShooting=false;
	ammo = 100; 
	//weaponOffset = 15; 
	FiringStatesArray(0)=WeaponFiring
    WeaponFireTypes(0)=EWFT_Projectile
	WeaponProjectiles(0)=class'ExtinguisherProjectile'
    FireInterval(0)=0.1
    Spread(0)=0

	Begin Object class=AnimNodeSequence Name=myAnim
	End Object
	
	//WeaponProjectiles(0)=class'ExtinguisherProjectile'

	Begin Object class=SkeletalMeshComponent Name=MyStaticMesh
	
		 SkeletalMesh=SkeletalMesh'Wooop.FIRE_EXTINGUISHER_WITH_ANIMATION'
		 Animsets(0)=AnimSet'wooop.Armature'
		 Animations=myAnim
		
		
		Scale=0.75
	End Object
	myMesh=MyStaticMesh
    Components.Add(MyStaticMesh)
	
}