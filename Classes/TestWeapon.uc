class TestWeapon extends UTWeapon;

defaultproperties
{
   Begin Object class=AnimNodeSequence Name=MeshSequenceA
      bCauseActorAnimEnd=true
   End Object

   // Weapon SkeletalMesh
   Begin Object Name=FirstPersonMesh
      SkeletalMesh=SkeletalMesh'WP_LinkGun.Mesh.SK_WP_Linkgun_1P'
      AnimSets(0)=AnimSet'WP_LinkGun.Anims.K_WP_LinkGun_1P_Base'
      Animations=MeshSequenceA
      Scale=0.9
      FOV=60.0
   End Object
   
   // Pickup SkeletalMesh
   Begin Object Name=PickupMesh
      SkeletalMesh=SkeletalMesh'WP_LinkGun.Mesh.SK_WP_LinkGun_3P'
   End Object

   WeaponFireTypes(0)=EWFT_Projectile
   WeaponProjectiles(0)=class'UTProj_LinkPlasma'
   
   WeaponEquipSnd=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_RaiseCue'
   WeaponPutDownSnd=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_LowerCue'
   WeaponFireSnd(0)=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_FireCue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_Link.Cue.A_Weapon_Link_AltFireCue'
   PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Link_Cue'

   MuzzleFlashSocket=MuzzleFlashSocket
   MuzzleFlashPSCTemplate=ParticleSystem'WP_LinkGun.Effects.P_FX_LinkGun_MF_Primary'
   
   CrosshairImage=Texture2D'UI_HUD.HUD.UTCrossHairs'
   CrossHairCoordinates=(U=384,V=0,UL=64,VL=64)
}