class ExtinguisherProjectile extends UDKProjectile; 
var string type; 

DefaultProperties
{
type="default"; 
Speed=600;
Begin Object Name=CollisionCylinder
        CollisionRadius=15
        CollisionHeight=16
End Object

Begin Object Class=ParticleSystemComponent Name=MyParticleSystemComponent
	Template=ParticleSystem'Wooop.Effects.FX_DRY_FOAM'
	bAutoActivate=true
End Object 

Components.Add(MyParticleSystemComponent)
}