//
// DragonFrame Motor Unit box
//
//TODO:
// -supply sink
// -box mount
// -LED hole
// -Bridges/Hole
// -box lip lock
// -box vent

$fn=50;

drawTop=0;
drawBottom=0;
drawAll=1;
drawBridgePart=0;

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
        color("darkgreen")
        translate([0,0,0]) cube([driverX,driverY,driverZ]);    
        translate([driverX/2,4,-1]) cylinder(h=driverZ+2,d=3);
        translate([driverX/2,driverY-4,-1]) cylinder(h=driverZ+2,d=3);
    }
    color("black") {
        translate([0,driverY/4,driverZ]) cube([5,22,5]);// header M/PWR
        translate([driverX-5,driverY-11-driverY/8,driverZ]) cube([5,11,5]);// header
    }
    color("silver")
    translate([driverX-20,driverY-8,driverZ]) cylinder(h=5.5,d=6);// header
}

module uno() {
    unoX=53.3;
    unoY=68.6;
    unoZ=1.6;

    difference() {
        color("darkgreen")
        translate([0,0,0]) cube([unoX,unoY,unoZ]);    
        translate([unoX-2.5-5.1-27.9-15.2,14+1.3,-1]) cylinder(h=unoZ+2,d=3);// Mount Hole
        translate([unoX-2.5-5.1-27.9,14+1.3+50.8,-1]) cylinder(h=unoZ+2,d=3);
        translate([unoX-2.5-5.1,14+1.3+50.8,-1]) cylinder(h=unoZ+2,d=3);
        translate([unoX-2.5,14,-1]) cylinder(h=unoZ+2,d=3);
    }
    color("black") {
        translate([9.6,-6.2,unoZ]) cube([12,15,10.9]);// USB-B
        translate([unoX-2.5-5.1-27.9-15.2-2.54/2,25,unoZ]) cube([2.54,40,10]);// Header
        translate([unoX-2.5-2.54/2,35,unoZ]) cube([2.54,30,10]);
    }
}

module supply() {
    supplyX=51;
    supplyY=78;
    supplyZ=28;
    
        color("silver")
        translate([0,0,0]) cube([supplyX,supplyY,supplyZ]);
        color("black") {
        translate([0,supplyY,supplyZ/4]) cube([51,14,14]);// Header
        translate([25.4,10.5,-3]) cylinder(h=4,d=3);// Screw Hole
        translate([25.4,10.5+55,-3]) cylinder(h=4,d=3);
        translate([-3,2.75,14]) rotate([0,90,0]) cylinder(h=4,d=3);
        translate([-3,2.75+66.5,14]) rotate([0,90,0]) cylinder(h=4,d=3);
        }
}

bottomX=65;
bottomY=125;
bottomZ=35;
bottomThick=2;

module bottom() {
    difference() {
        translate([0,0,0]) rounded_rect(bottomX,bottomY,bottomZ,bottomThick);// BASE
        translate([0,0,bottomThick]) cube([bottomX,bottomY,bottomZ]);// FILL
        translate([+1,10,bottomThick+1]) supply();// Supply
        translate([bottomX/2+4,bottomY+2,bottomThick+7]) rotate([90,0,0]) cylinder(h=4,d=5);// Supply Hole
        translate([bottomX/2+21,bottomY+2,bottomThick+5.5]) rotate([90,0,0]) cube([5,3,4]);// Motor Hole
    }
    translate([25.4+1,10.5+10,bottomThick]) mount(3,1);// Supply mount
    translate([25.4+1,10.5+55+10,bottomThick]) mount(3,1);
    translate([0,2.75+10,14+bottomThick+1]) rotate([0,90,0]) mount(3,1);
    translate([0,2.75+66.5+10,14+bottomThick+1]) rotate([0,90,0]) mount(3,1);
    translate([bottomX,60+4,16+bottomThick+5]) rotate([0,90,180]) mount(2,3);// Driver mount
    translate([bottomX,60+38-4,16+bottomThick+5]) rotate([0,90,180]) mount(2,3);
    translate([45,bottomY-10,bottomThick]) rotate([0,0,90]) bridge();// Supply Bridge
    translate([65,bottomY-10,bottomThick]) rotate([0,0,90]) bridge();// Motor Bridge
}

topX=65;
topY=125;
topZ=17.5;
topThick=2;
topUnoXOffset=(topX-53.3)/2;

module top() {
    difference() {
        translate([0,0,0]) rounded_rect(topX,topY,topZ,topThick);// BASE
        translate([0,0,-topThick]) cube([topX,topY,topZ]);// FILL
        translate([53.3+(topX-53.3)/2,6.2-topThick,topZ-topThick-3]) rotate([180,0,180]) uno();// Uno
    }
    translate([2.5+topUnoXOffset,14+6.2-topThick,topZ-topThick]) rotate([0,180,0]) mount(2,3);// Uno Mount
    translate([2.5+5.1+topUnoXOffset,14+1.3+50.8+6.2-topThick,topZ-topThick]) rotate([0,180,0]) mount(2,3);
    translate([2.5+5.1+27.9+topUnoXOffset,14+1.3+50.8+6.2-topThick,topZ-topThick]) rotate([0,180,0]) mount(2,3);
    translate([2.5+5.1+27.9+15.2+topUnoXOffset,14+1.3+6.2-topThick,topZ-topThick]) rotate([0,180,0]) mount(2,3);
}

//--------------------------

if (drawTop) { translate([topX+topThick,topThick,topZ]) rotate([0,180,0]) top(); }

if (drawBottom) { translate([bottomThick,bottomThick,0]) bottom(); }

if (drawAll) {
    bottom();
    translate([1,10,bottomThick+1]) supply();
    translate([bottomX-3,60,bottomThick+5]) rotate([0,0,0]) rotate([0,-90,0]) driver();
    translate([53.3+(topX-53.3)/2,6.2-bottomThick,bottomZ+topZ-topThick-3]) rotate([180,0,180]) uno();
    translate([0,0,bottomZ]) top();
}
