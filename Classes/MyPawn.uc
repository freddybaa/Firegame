class MyPawn extends UDKPawn;
var (Custom) SkeletalMeshComponent TheMesh;


 

// function AddDefaultInventory()
 // {
     // InvManager.CreateInventory(class'FireExtinguisher'); //InvManager is the pawn's InventoryManager
// }
defaultproperties
{
	Begin Object class=SkeletalMeshComponent Name=MyMesh
   SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
  //AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
  //AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
   HiddenGame=TRUE
   HiddenEditor=TRUE

   End Object
   Mesh=MyMesh
   Components.Add(MyMesh)
	InventoryManagerClass=class'MyInventoryManager'
}