

module M2(length=10)
{
  
  difference()
  {
    cylinder(d=4,h=length,center=true, $fn=64);
    cylinder(d=2.2,h=length,center=true, $fn=64);    
  }
  
}

M2(10);