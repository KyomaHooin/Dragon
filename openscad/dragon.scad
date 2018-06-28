//
// DragonFrame Motor Unit box
//

$fn=50;

boxThick=2;
boxLength=63;
boxWidth=45;

module rounded_rect(x, y, z, radius) {
    linear_extrude(height=z)
        minkowski() {
            square([x,y]);
            circle(r = radius);
        }
}

module driver() {
    driverX=32;
    driverY=38;
    driverZ=1.3;

    difference() {
        union() {
            color("darkgreen")
            translate([0,0,0]) cube([driverX,driverY,driverZ]);    
            color("black")
            translate([0,driverY/4,driverZ]) cube([5,22,5]);// header M/PWR
            color("black")
            translate([driverX-5,driverY-11-driverY/8,driverZ]) cube([5,11,5]);// header UNO
        }
        translate([driverX/2,4,-1]) cylinder(h=driverZ+2,d=3);
        translate([driverX/2,driverY-4,-1]) cylinder(h=driverZ+2,d=3);
    }
}

module uno() {
    unoX=53.3;
    unoY=68.6;
    unoZ=1.6;

    difference() {
        union() {
            color("darkgreen")
            translate([0,0,0]) cube([unoX,unoY,unoZ]);    
            color("black")
            translate([9.6,-6.2,unoZ]) cube([12,15,10.9]);// USB-B
        }
        translate([unoX-2.5-5.1-27.9-15.2,14+1.2,-1]) cylinder(h=unoZ+2,d=3);// Mount Hole
        translate([unoX-2.5-5.1-27.9,14+51.9,-1]) cylinder(h=unoZ+2,d=3);
        translate([unoX-2.5-5.1,14+51.9,-1]) cylinder(h=unoZ+2,d=3);
        translate([unoX-2.5,14,-1]) cylinder(h=unoZ+2,d=3);
    }
}

module supply() {
    supplyX=51;
    supplyY=78;
    supplyZ=28;
    
    union() {
        color("silver")
        translate([0,0,0]) cube([supplyX,supplyY,supplyZ]);
        color("black") {
        translate([0,supplyY,supplyZ/4]) cube([51,14,14]);// header
        translate([25.4,10.5,0]) cylinder(h=2,d=3);// screwhole
        translate([25.4,10.5+55,0]) cylinder(h=2,d=3);
        translate([0,2.75,14]) rotate([0,90,0]) cylinder(h=2,d=3);
        translate([0,2.75+66.5,14]) rotate([0,90,0]) cylinder(h=2,d=3);
        }
    }
}

module bottom() {
}

module top() {
}


//supply();
//uno();
//driver();