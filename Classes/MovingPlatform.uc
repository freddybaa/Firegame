class MovingPlatform extends Actor 
placeable;
 
var(CUSTOM) StaticMeshComponent TheMesh;
var(CUSTOM) float MovementSpeed;


event Tick(float DeltaTime)
{
    local float delta_distance;
    local vector d;
    delta_distance = (DeltaTime) * MovementSpeed;
	
    d.Z = delta_distance;
    Move(d);
} 



state Moving
{
ignores TakeDamage;

Begin:
    WorldInfo.Game.Broadcast(self, "Moving state");
    Sleep(5.0);
    MovementSpeed = -MovementSpeed;
    GotoState('Idle');
}
 
auto state Idle
{
    ignores Tick;
Begin:
    WorldInfo.Game.Broadcast(self,"Idle state");
}
 
DefaultProperties
{

	Begin Object Class=StaticMeshComponent Name=MyStaticMeshComponent
	End Object
	
	TheMesh=MyStaticMeshComponent
	Components.Add(MyStaticMeshComponent)
    CollisionComponent=MyStaticMeshComponent
    MovementSpeed=16
	bCollideActors=true
    bBlockActors=true
}