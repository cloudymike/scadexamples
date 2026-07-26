$fn=64;

projection( cut=true ) {
translate([0,0,-10])cone(0,30,0,0,0,50);
}

%translate([0,0,-10])cone(0,30,0,0,0,50);
module cone(rotx=0,roty=0,rotz=0,x=0,y=0,z=0){
    translate([x,y,z]){
    	  rotate( a=[rotx,roty,rotz] ) {
          cylinder( r1=25, r2=0, h=100, center=true );
	  }
    }
}
