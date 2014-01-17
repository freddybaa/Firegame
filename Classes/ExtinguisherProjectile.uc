class ExtinguisherProjectile extends UDKProjectile; 

simulated function ProcessTouch(Actor Other, Vector hitLocation, Vector hitNornal){
	local Fire fire; 
	
	fire = Fire(Other); 
	
	fire.take(0);
	
	

		
}


DefaultProperties
{

Speed=500
Begin Object Class=ParticleSystemComponent Name=MyParticleSystemComponent
	Template=ParticleSystem'Wooop.Effects.FX_DRY_POWDER'
	bAutoActivate=true
End Object 

Components.Add(MyParticleSystemComponent)
bBlockedByInstigator=false

}