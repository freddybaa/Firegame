class ExtinguisherProjectileCo extends ExtinguisherProjectile; 
var ParticleSystemComponent particle; 

simulated singular event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	local FireA fire; 
	
	fire = FireA ( Other ); 
	particle = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'Wooop.Effects.FX_IMPACT',HitLocation);
	
	fire.take(0, type); 
	
	Destroy(); 
}


simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	WorldInfo.Game.Broadcast(self,"HIT - PRO");
}

simulated singular event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp)
{
	local FireA fire; 
	WorldInfo.Game.Broadcast(self,"HIT - WALL");
	
	
	
	fire = FireA ( Wall ) ; 
	
	fire.take(1, type); 
	
	
	

	

	Destroy();
}

DefaultProperties
{

type="CO2"

Begin Object Name=MyParticleSystemComponent
	Template=ParticleSystem'Wooop.Effects.FX_DRY_CO2'
	bAutoActivate=true
End Object 


Components.Add(MyParticleSystemComponent)


}