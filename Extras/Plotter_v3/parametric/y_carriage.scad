carriage_l = 20;
carriage_h = 40;
carriage_w = 10;

/* If using bushings or bearings, this is the outer diameter of the
   bushing/bearing. If not using them, this is the outer diameter of the rod
   itself. */
y_rod_d = 5.2; // 3/16 in with fudge.

drive_hole_d = 3; // where the string/line passes through carriage
drive_hole_z_offset = 12; // how high to place the drive holes from the bottom rod hole
drive_hole_z_spacing = 5; // how far apart the drive holes are

rod_hole_z_offset = 5; // how high to place the lower rod hole from bottom of carriage
rod_hole_z_spacing = 20; // how far apart the two rod holes are

wall_thickness = 1.5; // how thick should the walls and floor be?

tension_point_d = 7;
tension_point_h = (carriage_w-wall_thickness)*0.7;
tension_point_screw_d = 3;

ff=0.1;

module rod_holes() {
  module rod_hole() {
    cylinder(d=y_rod_d, h=carriage_l+ff, center=true, $fn=32);
  }
  rotate([0,90,0]) {
    rod_hole();
    translate([-rod_hole_z_spacing,0,0]) rod_hole();
  }
}

module drive_holes() {
  rotate([0,90,0]) translate([0,0,0]) {
    for(offset=[drive_hole_z_spacing/2,-drive_hole_z_spacing/2]) {
      translate([0,offset,0]) cylinder(d=drive_hole_d, h=carriage_l+ff, center=true, $fn=32);
    }
  }
}

module tension_points() {
  module tension_point() {
    rotate([90,0,0]) difference() {
      cylinder(d=tension_point_d, h=tension_point_h, center=true, $fn=6);
      cylinder(d=tension_point_screw_d, h=tension_point_h, center=true, $fn=16);
    }
  }
  for(offset=[carriage_l/6,-carriage_l/6]) {
    translate([offset,(tension_point_h/2)+wall_thickness,(drive_hole_z_offset+rod_hole_z_offset)-(drive_hole_d*1.5)])
      tension_point();
  }
}

module complete_carriage() {
  difference() {
    translate([-carriage_l/2,0,0]) {
      difference() {
        cube([carriage_l, carriage_w, carriage_h]);
        translate([wall_thickness,wall_thickness,wall_thickness])
          cube([carriage_l-(wall_thickness*2), carriage_w-wall_thickness+ff, carriage_h-wall_thickness+ff]);
      }
    }
    translate([0,carriage_w/2,rod_hole_z_offset]) rod_holes();
    translate([0,carriage_w/2,rod_hole_z_offset+drive_hole_z_offset]) drive_holes();
  }
  tension_points();
}


/*intersection() {
  complete_carriage();
  translate([9,0,0]) cube([carriage_l, carriage_w, carriage_h]);
}*/

complete_carriage();

/*tension_points();*/
/*rod_holes();*/
/*drive_holes();*/
