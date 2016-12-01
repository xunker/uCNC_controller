module pen_holder(pen_d=12) { // pen_d 12 or 13 depending on placement
  tab_h = 8;
  tab_l = 10;
  tab_w = 1.6;

  pen_h = 2;
  pen_t = 3;

  pen_offset = 3;

  ff = 0.1;

  translate([-tab_l/2,0,0]) cube([tab_l, tab_w, tab_h]);
  difference() {
    hull() {
      translate([-tab_l/2,0,0]) cube([tab_l, ff, tab_h]);
      translate([0,(-(pen_d+pen_t)/2)-pen_offset,0]) cylinder(d=pen_d+pen_t, h=pen_h, $fn=32);
    }
    translate([0,(-(pen_d+pen_t)/2)-pen_offset,-ff]) cylinder(d=pen_d, h=tab_h+(ff*2), $fn=32);
  }
}

module pen_ring() {

  pen_d = 11; // deliberately too small
  pen_h = 4;
  pen_t = 6;

  ff = 0.1;

  difference() {
    cylinder(d=pen_d+pen_t, h=pen_h, center=true, $fn=32);
    cylinder(d=pen_d, h=pen_h+ff, center=true, $fn=32);
    translate([pen_d/2,0,0]) cube([pen_t*2,2,pen_h+ff], center=true);
  }

}

pen_ring();
/*pen_holder(pen_d=13);*/
