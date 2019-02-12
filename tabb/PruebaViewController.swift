//
//  PruebaViewController.swift
//  tabb
//
//  Created by Mac17 on 30/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit

class PruebaViewController: UIViewController {

    var rutas:[Transporte]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        rutas = []


        
        
        //  TABLE: transporte
        //
        // 0 - id
        // 1 - nombre
        // 2 - costo
        // 3 - descripcion
        // 4 - costo_max
        // 5 - costo_min
        //
        
        
        
        let database:COpaquePointer = self.Connect_DB_Sqlite("Routemaps", type: "sqlite")
        
        let statement:COpaquePointer = Training_Select("SELECT * FROM transporte", database: database);

        var i = 0
    
        while sqlite3_step(statement) == SQLITE_ROW {
            
            
            let id = Int(sqlite3_column_int(statement, 0))
            //println(id)
            
            
            let nombre = sqlite3_column_text(statement, 1) //obtiene el valor en crudo
            let nombreString = String.fromCString(UnsafePointer<CChar>(nombre)) //convierte el valor a String
            
            
            let costo = sqlite3_column_text(statement, 2) //obtiene el valor en crudo
            let costoString = String.fromCString(UnsafePointer<CChar>(costo)) //convierte el valor a String
            //println(costoString!)
            
            
            let descripcion = sqlite3_column_text(statement, 3) //obtiene el valor en crudo
            let descripcionString = String.fromCString(UnsafePointer<CChar>(descripcion)) //convierte el valor a String
            //println(descripcionString!)
            
            
            let costoMax = Float(sqlite3_column_double(statement, 4)) //obtiene el valor y lo convierte a float
            //print("Costo MAX: ")
            //println(costoMax)
            
            
            let costoMin = Float(sqlite3_column_double(statement, 5)) //obtiene el valor y lo convierte a float
            //print("Costo MIN: ")
            //println(costoMin)
            
            
            
            
            
            
            
            rutas.append(Transporte()) //apendiza un nuevo objeto Transporte
            rutas[i].id = id
            rutas[i].nombre = nombreString!
            rutas[i].costo = costoString!
            rutas[i].descripcion = descripcionString!
            rutas[i].costo_max = costoMax
            rutas[i].costo_min = costoMin

            print("id: \(rutas[i].id)")
            print("Nombre: " + rutas[i].nombre)
            print("Costo: " + rutas[i].costo)
            print("Descripcion: " + rutas[i].descripcion)
            print("Costo máximo: \(rutas[i].costo_max)")
            print("Costo mínimo: \(rutas[i].costo_min)")
            
            print("")
            print("")
            
            i++
        }
        sqlite3_finalize(statement)
        sqlite3_close(database)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func Training_Select(query:String,  database:COpaquePointer)->COpaquePointer{
        var statement:COpaquePointer = nil
        sqlite3_prepare_v2(database, query, -1, &statement, nil)
        return statement
    }
    
    
    func Connect_DB_Sqlite(dbName:String, type:String)->COpaquePointer{
        var database:COpaquePointer = nil
        var dbPath:String = ""
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        var defaultStorePath:NSString = ""
        let storePath : NSString = documentsPath.stringByAppendingPathComponent(dbName)
        let fileManager : NSFileManager = NSFileManager.defaultManager()
        //var fileCopyError:NSError? = NSError()
        dbPath = NSBundle.mainBundle().pathForResource(dbName , ofType:type)!
        do {
            try fileManager.copyItemAtPath(dbPath, toPath: storePath as String)
        } catch let error as NSError {
            //fileCopyError = error
            print("HUBO UN ERROR")
        }
        let result = sqlite3_open(dbPath, &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
        }
        return database
    }
}
