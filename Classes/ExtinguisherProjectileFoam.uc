class ExtinguisherProjectileFoam extends ExtinguisherProjectile; 
var ParticleSystemComponent particle; 

simulated singular event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local Fire fire; 
	local vector decalSpawnLocation; 
	fire = Fire ( Other ); 
	particle = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'Wooop.Effects.FX_IMPACT_FOAM',HitLocation);
	
	fire.take(0, type); 
	
	decalSpawnLocation = HitLocation; 
	decalSpawnLocation.z = 1;
	WorldInfo.Game.BroadCast(self, decalSpawnLocation); 
	WorldInfo.MyDecalManager.SpawnDecal (   DecalMaterial'HU_Deck.Decals.M_Decal_GooLeakjj', // UMaterialInstance used for this decal.
                        HitLocation, // Decal spawned at the hit location.
                        rotator(-HitNormal), // Orient decal into the surface.
                        128, 128, // Decal size in tangent/binormal directions.
                        256, // Decal size in normal direction.
                        false, // If TRUE, use "NoClip" codepath.
                        FRand() * 360, // random rotation
                        None // If non-NULL, consider this component only.
    );
	
	
	
	Destroy(); 
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	WorldInfo.Game.Broadcast(self,"HIT - PRO");
}



simulated singular event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp)
{
	WorldInfo.Game.Broadcast(self,"HITWALL");
		WorldInfo.MyDecalManager.SpawnDecal (   DecalMaterial'HU_Deck.Decals.M_Decal_GooLeakjj', // UMaterialInstance used for this decal.
                        HitLocation, // Decal spawned at the hit location.
                        rotator(-HitNormal), // Orient decal into the surface.
                        128, 128, // Decal size in tangent/binormal directions.
                        256, // Decal size in normal direction.
                        false, // If TRUE, use "NoClip" codepath.
                        FRand() * 360, // random rotation
                        None // If non-NULL, consider this component only.
	Destroy();
}

DefaultProperties
{
type="Foam"; 
Begin Object Name=MyParticleSystemComponent
	Template=ParticleSystem'Wooop.Effects.FX_DRY_FOAM'
	bAutoActivate=true
End Object 

Components.Add(MyParticleSystemComponent)
}