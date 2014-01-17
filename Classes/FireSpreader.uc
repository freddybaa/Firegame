class FireSpreader extends Actor placeable; 

var int fires;
var() vector newLocation; 
var() int spreadDelay; 
var() int maxFires; 
var()int spreadRadius; 

event PostBeginPlay()
{
	//spawning new fire every 'spreadDelay'
    SetTimer(spreadDelay, true, 'createFire');    
   
}

function createFire()
{
	local vector loc; 
	local int spawnXorY; 
	local int spawnDirection; 

	
	if(fires==0){
		newLocation = self.Location; 
		
	}else{
		
		//0 or 1
		spawnXorY  = Rand(2); 
		spawnDirection = Rand(2); 
		
		
		if(spawnDirection==0){
			//random spawning of fire
			if(spawnXorY==0) newLocation.x += Rand(spreadRadius); 
			else newLocation.y += Rand(spreadRadius); 
		}else{
				if(spawnXorY==0) newLocation.x -= Rand(spreadRadius); 
			else newLocation.y -= Rand(spreadRadius); 
		}
		
	}
	
	loc = newLocation; 

	 Spawn(class'Fire', , , loc);
	

    fires++;    
	
    if( fires >= maxFires )
    {
        ClearTimer('createFire');        
    }    
}

DefaultProperties
{
spreadRadius = 75; 
spreadDelay = 5; 
fires=0; 
maxFires = 10;  
}