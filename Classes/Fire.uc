class Fire extends Actor placeable; 


var(MyParticleSystem) ParticleSystemComponent Flame; 
var(MyParticleSystem) float scaleSpeed; 
var() vector scaleVector; 
var(MyParticleSystem) float maxScaleSize; 
var() float sleepTime; 
var bool EXTINGUISH; 
var int maxHealth; 
var(MyParticleSystem) string type; 
var bool VALID; 
var array<string> valid_extinguisher;

event Tick(float DeltaTime)
{

   local vector v; 
   local float scale; 
  
   v = DrawScale3D;
   if(v.x <= 0.1)Destroy(); 
   if(v.x >= maxScaleSize && !EXTINGUISH) return; 
   
   scale = (DeltaTime) * scaleSpeed; 
   
   if(EXTINGUISH && VALID){

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

//checking if it is a valid fireextinguisher
function validExtinguisher(string extinguisher){
	local int i; 
	for(i=0;i<valid_extinguisher.Length;i++){
		if(valid_extinguisher[i] == extinguisher) VALID = true; 
	}
}

//handling damage taken 
function take(int damage, string extinguisherType){

 validExtinguisher(extinguisherType); 
 
 if(VALID)
	scaleSpeed = 0.8; 
 else
	scaleSpeed = 0.6; 
 
 GotoState('Scale');
 
}

auto state Idle
{

Begin:
	EXTINGUISH=false;
    WorldInfo.Game.Broadcast(self,"Idle state");
	scaleSpeed=0.1;
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
type="default"; 


}