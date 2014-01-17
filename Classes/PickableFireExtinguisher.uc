class PickableFireExtinguisher extends Actor
      placeable;

var (Custom) StaticMeshComponent TheMesh;
var (Custom) String type; 


event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
   local MyPawn pawnLocal;
   local FireExtinguisher fe; 
	
   pawnLocal = MyPawn( Other ); 
   
   if(pawnLocal != None)
   {
        //test if it is the Player
      if( pawnLocal.controller.bIsPlayer ) 
      {

		fe = Spawn(Class'FireExtinguisher');
		fe.setType(type); 
		if(fe != None)
			fe.GiveTo(pawnLocal);
		

        self.Destroy();
      }
   }
}    
defaultproperties
{

    bCollideActors=true    
    bBlockActors=false

    Begin Object Class=StaticMeshComponent Name=MyStaticMesh
		StaticMesh=StaticMesh'wooop.fireextinguisherwithskeleton_STATIC'
    End Object
    
	TheMesh=MyStaticMesh
    Components.add( MyStaticMesh )                
}