//
// DragonFrame Motor Unit box
//

//TODO:
//
// -RJ11 slot
// -uno mount
// -supply sink
// -box mount
// -box lip lock
// -box vent
// -global size check

$fn=50;

drawTop=0;
drawBottom=0;
drawAll=1;

//----------------------------

module rounded_rect(x, y, z, radius) {
    linear_extrude(height=z)
        minkowski() {
            square([x,y]);
            circle(r = radius);
        }
}

module mount(dia,thick) {
    difference() {
        cylinder(h=thick, r2=dia,r1=dia+1);
        translate([0,0,-1])cylinder(h=thick+2, d=dia);
    }
}

module bridge() {
    difference() {
        cube([5,18,7]);
        translate([-1,9,7]) rotate([0,90,0]) cylinder(h=10,d=7);
        translate([2.5,2.5,4]) cylinder(h=4,d=2);
        translate([2.5,15.5,4]) cylinder(h=4,d=2);
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
            color("black") {
            translate([0,driverY/4,driverZ]) cube([5,22,5]);// header M/PWR
            translate([driverX-5,driverY-11-driverY/8,driverZ]) cube([5,11,5]);// header
            }
            color("silver")
            translate([driverX-20,driverY-8,driverZ]) cylinder(h=5.5,d=6);// header
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
            color("black") {
            translate([9.6,-6.2,unoZ]) cube([12,15,10.9]);// USB-B
            translate([unoX-2.5-5.1-27.9-15.2-2.54/2,25,unoZ]) cube([2.54,40,10]);// Header
            translate([unoX-2.5-2.54/2,35,unoZ]) cube([2.54,30,10]);
            }
        }
        translate([unoX-2.5-5.1-27.9-15.2,14+1.3,-1]) cylinder(h=unoZ+2,d=3);// Mount Hole
        translate([unoX-2.5-5.1-27.9,14+1.3+50.8,-1]) cylinder(h=unoZ+2,d=3);
        translate([unoX-2.5-5.1,14+1.3+50.8,-1]) cylinder(h=unoZ+2,d=3);
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
        translate([25.4,10.5,-3]) cylinder(h=4,d=3);// screwhole
        translate([25.4,10.5+55,-3]) cylinder(h=4,d=3);
        translate([-3,2.75,14]) rotate([0,90,0]) cylinder(h=4,d=3);
        translate([-3,2.75+66.5,14]) rotate([0,90,0]) cylinder(h=4,d=3);
        }
    }
}

bottomX=65;
bottomY=125;
bottomZ=30;
bottomThick=2;

module bottom() {
    difference() {
        translate([0,0,0]) rounded_rect(bottomX,bottomY,bottomZ,bottomThick);// BASE
        translate([0,0,bottomThick]) cube([bottomX,bottomY,bottomZ]);// FILL
        translate([+1,10,bottomThick+1]) supply();// SUPPLY
        translate([bottomX/2+5,bottomY+2,bottomThick+7]) rotate([90,0,0]) cylinder(h=4,d=5);// SUPPLY HOLE
    }
    translate([25.4+1,10.5+10,bottomThick]) mount(3,1);// Supply mount
    translate([25.4+1,10.5+55+10,bottomThick]) mount(3,1);
    translate([0,2.75+10,14+bottomThick+1]) rotate([0,90,0]) mount(3,1);
    translate([0,2.75+66.5+10,14+bottomThick+1]) rotate([0,90,0]) mount(3,1);
    translate([bottomX,60+4,16+bottomThick+5]) rotate([0,90,180]) mount(2,3);// Driver mount
    translate([bottomX,60+38-4,16+bottomThick+5]) rotate([0,90,180]) mount(2,3);
    translate([45,bottomY-13,bottomThick]) rotate([0,0,90]) bridge();// Bridge
}

topX=65;
topY=125;
topZ=17;
topThick=2;

module top() {
    difference() {
        translate([0,0,0]) rounded_rect(topX,topY,topZ,topThick);// BASE
        translate([0,0,-topThick]) cube([topX,topY,topZ]);// FILL
        translate([topX-5,6.2-topThick,topZ-topThick]) rotate([180,0,180]) uno();// Uno
    }
}

//--------------------------

if (drawTop) {
    top();
}

if (drawBottom) {
    top();
}

if (drawAll) {
    bottom();
//    translate([1,10,bottomThick+1]) supply();
//    translate([bottomX-3,60,bottomThick+5]) rotate([0,0,0]) rotate([0,-90,0]) driver();
//    translate([bottomX-5,6.2-bottomThick,bottomZ+15]) rotate([180,0,180]) uno();
//    translate([0,0,bottomZ]) top();
}
