class Fire extends Actor placeable; 


var(MyParticleSystem) ParticleSystemComponent Flame; 
var(MyParticleSystem) float scaleSpeed; 
var() vector scaleVector; 
var(MyParticleSystem) float maxScaleSize; 
var() float sleepTime; 
var bool EXTINGUISH; 
var int maxHealth; 




event Tick(float DeltaTime)
{

   local vector v; 
   local float scale; 
  
   v = DrawScale3D;
   if(v.x <= 0.1)Destroy(); 
   if(v.x >= maxScaleSize && !EXTINGUISH) return; 
   
   scale = (DeltaTime) * scaleSpeed; 
   
   if(EXTINGUISH){

	v.X -= scale;
	v.Z -= scale;
	v.Y -= scale;
   }else{
	v.X += scale;
	v.Z += scale;
	v.Y += scale;
   }
   
  
   
   //scaleVector = v;
  // WorldInfo.Game.Broadcast(self, scaleSpeed);
  // WorldInfo.Game.Broadcast(self,scale);
  // WorldInfo.Game.Broadcast(self,v.X);
   
   SetDrawScale3D(v);
   
   
} 

function take(int damage){

 WorldInfo.Game.Broadcast(self,"TAKEN HIT");
 GotoState('Scale');
 
 //based on extinghuisher
 //scaleSpeed = damage; 
 
 scaleSpeed = 0.8; 
}

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	super.TakeDamage(DamageAmount,EventInstigator, HitLocation,Momentum,DamageType,HitInfo,DamageCauser);
	 WorldInfo.Game.Broadcast(self,"TAKEN HIT");
    GotoState('Scale');
}

auto state Idle
{

Begin:
	EXTINGUISH=false;
    WorldInfo.Game.Broadcast(self,"Idle state");
    scaleSpeed = 0.1;  
}

state Scale
{

Begin:
    WorldInfo.Game.Broadcast(self, "Scale state");
	EXTINGUISH=true;
	Sleep(sleepTime); 
	GotoState('Idle');
}


DefaultProperties
{
   

EXTINGUISH=false;

Begin Object Class=CylinderComponent Name=CollisionCylinder0
		CollisionRadius=64.0
		CollisionHeight=64.0
		BlockNonZeroExtent=true
		BlockZeroExtent=true
		BlockActors=true
		CollideActors=true
		BlockRigidBody=true
End Object
	
Begin Object Class=ParticleSystemComponent Name=MyParticleSystemComponent
	Template=ParticleSystem'Castle_Assets.FX.P_FX_Fire_SubUV_01'
	bAutoActivate=true
End Object 

Flame=MyParticleSystemComponent 
Components.Add(MyParticleSystemComponent)
Components.Add(CollisionCylinder0)
CollisionComponent=CollisionCylinder0
bCollideActors=true
bBlockActors=true
scaleSpeed=0.1
maxScaleSize=5; 
sleepTime=1.0; 



}