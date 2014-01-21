class ExtinguisherProjectileWater extends ExtinguisherProjectile; 
var ParticleSystemComponent particle; 

simulated singular event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local FireA fire; 
	local vector decalSpawnLocation; 
	fire = FireA ( Other ); 
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

type="Water"
Begin Object Name=MyParticleSystemComponent
	Template=ParticleSystem'wooop.Effects.P_WaterSplash_01'
	bAutoActivate=true
End Object 

Components.Add(MyParticleSystemComponent)
bBlockedByInstigator=false

}