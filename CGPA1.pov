#include "colors.inc"
#include "textures.inc"

camera {
    location <20, 40, -70>
    look_at  <0, 20,  0>
}

light_source { <100, 45, 45> White }

// -------------------- Background --------------------
 
#declare stars =    
    sphere { 
        <0, 0, 0>, 1
        texture {
            pigment {
                granite  
                color_map {
                    [0.72 rgb 0.00 ] // No Stars in this area
                    [0.72 rgb 0.20 ] // Very Very Faint Stars
                    [0.75 rgb 0.40 ] // Very Very Faint Stars
                    [0.78 rgb 0.60 ] // Very Faint Stars
                    [0.81 rgb 0.80 ] // Faint Stars
                    [0.85 rgb 0.95 ] // Medium White Stars
                    [0.91 rgb 1.00 ] // White Stars 
                    [0.91 rgb 0.00 ] // No Stars in this area
                }
            scale .015
            }
            finish { ambient 1 }
        }
        scale 1000 
    } 

#declare table =
    plane { 
        y, -1.5
        texture { Tom_Wood }
        finish {ambient 0.1 diffuse 0.8}
    }

// ----------------------------------------------------

// --------------------   Planet   --------------------

#macro planet(pColor)
    sphere {
        <0, 0, 0> 2
        texture {
            pigment { color pColor }
            normal { bumps 0.1 scale 0.2 }
            finish { phong 1 }
        }
    }
#end

#macro planetRing(pColor)
union {
    sphere {
        <0, 0, 0> 2
        texture {
            pigment { color pColor }
            normal { bumps 0.1 scale 0.2 }
            finish { phong 1 }
        }
    }
    torus {
        3.0, 0.2
        pigment { color Khaki }
        normal { bumps 0.4 scale 0.6 }
        finish { phong 1 }
    }
}
#end

#declare planetStick = union {
    cylinder  { <0, 0, -50> <0, 0, 5>, 0.2 }
    pigment { DMFWood4 scale 4 }
    finish { phong 1 }
    rotate 90 * x
}

#declare planetKebab = union {
    merge {
        object { planet(Brown) scale <0.3, 0.3, 0.3> }
        object { planet(Copper) scale <0.6, 0.6, 0.6> translate <0, 2, 0> }
        object { planet(MediumBlue) scale <0.7, 0.7, 0.7> translate <0, 5, 0> }
        object { planet(Maroon) scale <0.6, 0.6, 0.6> translate <0, 8, 0> }
        object { planet(Coral) scale <3.0, 3.0, 3.0> translate <0, 16, 0> }
        object { planetRing(Sienna) scale <2.5, 2.5, 2.5> translate <0, 28, 0> }
        object { planet(SummerSky) scale <1.2, 1.2, 1.2> translate <0, 36.5, 0> }
        object { planet(Blue) scale <1.2, 1.2, 1.2> translate <0, 42.5, 0> }
        object { planetStick }
    }
    translate <0, -25, 0>
    rotate 20 * z
    rotate 360 * clock * y
    translate <0, 25, 0>
}

// ----------------------------------------------------

// --------------------    Case    --------------------

#declare caseSide =
    box {
        <-3, 0, -3>,
        <3, 50, 3>
        texture { White_Marble }
    }

#declare caseFace =
    box {
        <-23, 0, -23>,
        <23, 3, 23>
        texture { White_Marble }
    }

#declare glass =
    texture {
        pigment { rgbf <0.98, 1.0, 0.99, 0.75> }
        finish {
            ambient 0.05
            diffuse 0.05
            reflection .05
            specular 1
            roughness .001
        }
    }

#declare planetCase = union {
    box {
        <-20, 0, -20>,
        <20, 50, 20>
        texture { glass }
        hollow
    }
    object { caseSide translate <-20, 0, -20> }
    object { caseSide translate <-20, 0, 20> }
    object { caseSide translate <20, 0, -20> }
    object { caseSide translate <20, 0, 20> }
    object { caseFace }
    object { caseFace translate <0, 50, 0> }
    object { planetKebab translate <0 , 6, 0> } 
}

// ----------------------------------------------------

object { stars }
object { table }
object { planetCase translate <0, -2, 0> } 
