class PickableFireExtinguisher extends Actor
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
		
		//deny pickup if pawn already got an item. 
		if(pawnLocal.InvManager.InventoryChain != None){
			WorldInfo.Game.BroadCast(self, "You already got a fire extinguisher!"); 
			return; 
		}
		
		if(type=="FireExtinguisherFoam")
			fe = Spawn(Class'FireExtinguisherFoam'); 
		else if(type=="FireExtinguisherWater")
			fe = Spawn(Class'FireExtinguisherWater'); 
		else if(type=="FireExtinguisherCo")
			fe = Spawn(Class'FireExtinguisherCo'); 
		else if(type=="FireExtinguisherPowder")
			fe = Spawn(Class'FireExtinguisherPowder'); 
		else 
			//default 
			fe = Spawn(Class'FireExtinguisherPowder'); 
			
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