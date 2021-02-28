$fn=128;

module base(w=36, d=23, h=3) {
    // base
    difference() {
        cube([w, d, h]);
        
        // roll
        translate([w/2, d, (h + w)/2])
        rotate([90, 0, 0])
        cylinder(d=w, h=23);
        
        // hole 1
        translate([4, 5, 0])
        cube([4, 8, 3]);
        
        // hole 2
        translate([36 - 8, 5, 0])
        cube([4, 8, 3]);
    }
    
}

module holder(w=36, h=36, t=7, d=25) {
    hull() {
        // base
        cube([w, t, t]);
        
        // calculate holder top height
        z = h - d / 2;
        
        // rounded top
        translate([w/2, t, z])
        rotate([90, 0, 0])
        cylinder(d=d, h=t);
    }
}

module rollmount(d=8, h=7, tooth_count = 8) {
    cylinder(d=d, h=h);
    
    step = 360/tooth_count;
    for(i = [0 : step : 360]) {
        rotate([0, 0, i])
        translate([d/2, 0, h/2])
        cube([1.5, 1, h], center=true);
    }
}

module montage() {
    base();
    
    translate([0, 23 - 5, 0])
    holder();
    
    height = 36 - 25 / 2;
    
    translate([36/2, 23-5, height])
    rotate([90, 0, 0])
    rollmount();
}

module side_adapter() {
    difference() {
        union() {
            cylinder(d=30, h=1);
            
        }
        
        cylinder(d=10, h=10);
    }
}

//side_adapter();

montage();
