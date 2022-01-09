// Dimensions are mm
// 
// Huge shout out to http://openscad.org/cheatsheet/

screw_major_diameter = 4;
screw_minor_diameter = 2.5;
screw_hole = (screw_major_diameter + screw_minor_diameter) / 2;

screw_head_radius = 8 / 2; // 8 is diameter rounded up
screw_head_height = 3;

// This is how thick the plastic will be under the screw head.
// Too thin and it'll break, but we don't want huge feet too.
bearing_thickness = 4;

crate_radius = 6.5;
floor_radius = 10;

// Create some wiggle room around a measurement since the printer isn't that 
// precise. This just rounds up to the nearest mm, and adds 1mm.
function loose_fit(n, slop=1) = ceil(n + slop);

total_height = bearing_thickness + loose_fit(screw_head_height);

difference() {
    // body
    cylinder(
        r1=crate_radius, 
        r2=floor_radius, 
        h=total_height);

    // screw hole
    union() {
        // Screw thread hole. The translation and extra height are to make sure 
        // it completely punches through the body
        translate ([0,0,-1]) cylinder(
            r=loose_fit(screw_minor_diameter / 2),
            h=total_height + 2
        );

        // extra space for screw head
        translate ([0,0,total_height - loose_fit(screw_head_height)]) cylinder(
            r=loose_fit(screw_head_radius), 
            h=loose_fit(screw_head_height) + 1 // again to cleanly punch through the body
        );
    };
};