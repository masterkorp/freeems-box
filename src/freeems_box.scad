include <jaguar.scad>;
include <BOLTS/BOLTS.scad>;
include <molex_mount.scad>;
include <usb_mount.scad>;


// Units are milimeters

//Assembly mode
ASSEMBLY=false;

//GLOBALS
HEIGHT=60; // Z
WIDTH=150; // Y
LENGTH=200; // X
THICKNESS=5;

// The size that connector occupies inside the case
molex_non_thread_size = (46.9 - 26.2);

difference() {
  cube(size = [LENGTH, WIDTH, HEIGHT], center = true);
  translate([0, 0,  THICKNESS]) {
    cube(size = [(LENGTH - THICKNESS),  WIDTH - THICKNESS, HEIGHT + 1], center=true);
  }
  // Jaguar slice to fit one side of the board
  translate([0,76.2/2 - (THICKNESS - 2) , 0]) {
    jaguar();
  }

  // Molex mounting
  translate([-(LENGTH/3),0, 0] ){
    translate([0, -(WIDTH/2 - molex_non_thread_size + 1), 0]) {
      molex_mount();
    }
  }
  translate([0, -(WIDTH/2 - molex_non_thread_size + 1), 0]) {
    molex_mount();
  }
  translate([(LENGTH/3),0, 0] ){
    translate([0, -(WIDTH/2 - molex_non_thread_size + 1), 0]) {
      molex_mount();
    }
  }

  // Usb mounting
  translate([-(LENGTH/2 + 1),0,0]) {
    rotate([0,90, 90]) {
      usb_mount();
    }
  }
}

// Inner mounting device for the jaguar
difference() {
  translate([0, -5, -HEIGHT/4]) {
    cube(size = [127 + 20, 10, HEIGHT/2], center = true);
  }
  // Jaguar slice to fit the center side of the board
  translate([0,76.2/2 - (THICKNESS - 2) , 0]) {
    jaguar();
  }

}


if (ASSEMBLY == true) {
  translate([0,76.2/2 - (THICKNESS - 2) , 0]) {
    jaguar();
  }
  molex_receptor();
  translate([LENGTH/3, 0, 0]) {
    molex_receptor();
  }
  translate([LENGTH * (2/3), 0, 0]) {
    molex_receptor();
  }
  translate([-(LENGTH/2 - 5), 0, 0]) {
    rotate([-90,0,90]) {
      usb_receptor();
      translate([0,0,2]) {
        usb_gasket();
      }
      usb_hex_nut();
    }
  }
}
