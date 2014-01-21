class ExtinguisherProjectilePowder extends ExtinguisherProjectile; 
var ParticleSystemComponent particle; 

simulated singular event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local Fire fire; 
	local vector decalSpawnLocation; 
	fire = Fire ( Other ); 
	particle = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'Wooop.Effects.FX_IMPACT_FOAM',HitLocation);
	
	fire.take(0, type); 
	
	
	
	
	
	Destroy(); 
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	WorldInfo.Game.Broadcast(self,"HIT - PRO");
}



simulated singular event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp)
{
	WorldInfo.Game.Broadcast(self,"HITWALL");
	Destroy();
}

DefaultProperties
{


type="Powder"

Begin Object Name=MyParticleSystemComponent
	Template=ParticleSystem'Wooop.Effects.FX_DRY_POWDER'
	bAutoActivate=true
End Object 

Components.Add(MyParticleSystemComponent)


}