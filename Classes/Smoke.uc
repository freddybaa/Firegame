class Smoke extends Actor placeable; 

var() ParticleSystemComponent smoke; 
DefaultProperties{

Begin Object Class=ParticleSystemComponent Name=MyParticleSystemComponent
	Template=ParticleSystem'wooop.Effects.FX_DRY_POWDER
	bAutoActivate=true
End Object

smoke=MyParticleSystemComponent 
Components.Add(MyParticleSystemComponent)

}