class MyDroppedPickup extends DroppedPickup
      placeable;

var (Custom) StaticMeshComponent TheMesh;
var (Custom) String type; 
var DynamicLightEnvironmentComponent LightEnvironment;

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
	  
		if(type=="Foam"){
			fe = Spawn(Class'FireExtinguisherFoam'); 
		}else if(type=="Water"){
			fe = Spawn(Class'FireExtinguisherWater'); 
		}else{
			//default 
			fe = Spawn(Class'FireExtinguisherFoam'); 
		}
		
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
		StaticMesh=StaticMesh'Wooop.Fireextinguisher_static'
	 End Object
    
	TheMesh=MyStaticMesh
    Components.add( MyStaticMesh )  
	

}