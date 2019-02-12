//
//  Transporte.swift
//  tabb
//
//  Created by Daniel Reyes on 12/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import Foundation

class Transporte: NSObject {
    
    var id: Int = Int()            // AUTOINCREMENT
    
    var nombre: String = String()      // VARCHAR(100)
    var costo: String = String()        // VARCHAR(100)
    var descripcion: String = String() // VARCHAR(100)
    var costo_max: Float = Float()     //DECIMAL(3,2)
    var costo_min: Float = Float()     //DECIMAL(3,2)
        
    
    
}