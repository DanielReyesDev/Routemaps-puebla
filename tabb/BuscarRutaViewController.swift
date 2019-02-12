//
//  BuscarRutaViewController.swift
//  tabb
//
//  Created by Mac16 on 6/22/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit

class BuscarRutaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var rutasArray = [RutaItem]()
    var rutasFiltradas = [RutaItem]()
    var rutas:[Transporte]!
    
    var rutaParaEnviar : RutaItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.tableView.reloadData()
        
        
        //Viene de PruebaViewController
        rutas = []
        
        var aux: String
        
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
            
            aux=nombreString!
            //println("Imprime aux")
            //println(aux)
            
            self.rutasArray += [RutaItem(nombre: aux)]
            
            //self.rutas += [Transporte(id: rutas[i].id,nombre: rutas[i].nombre, costo: rutas[i].costo,descripcion: rutas[i].descripcion,costo_max: rutas[i].costo_max,costo_min: rutas[i].costo_min)]
            
            i += 1
        }
        sqlite3_finalize(statement)
        sqlite3_close(database)
        //Viene de PruebaViewController
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Viene de PruebaViewController
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
            print("Hubo un error")
        }
        let result = sqlite3_open(dbPath, &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
        }
        return database
    }
    
    
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            return self.rutasFiltradas.count
        }
        else
        {
            return self.rutasArray.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        
        var ruta : RutaItem
        
        
        
        
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            ruta = self.rutasFiltradas[indexPath.row]
            rutaParaEnviar = ruta
        }
        else
        {
            ruta = self.rutasArray[indexPath.row]
        }
        
        cell.textLabel?.text = ruta.nombre
        
        return cell
        
        
        
    }
    
    
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var ruta : RutaItem
        
        
        if (tableView == self.searchDisplayController?.searchResultsTableView)
        {
            ruta = self.rutasFiltradas[indexPath.row]
        }
        else
        {
            ruta = self.rutasArray[indexPath.row]
        }
        
        
        print(ruta.nombre)
        rutaParaEnviar = ruta
        performSegueWithIdentifier("toShowRoute", sender: self)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Search Methods
    func filterContenctsForSearchText(searchText: String, scope: String = "Title")
    {
        
        self.rutasFiltradas = self.rutasArray.filter({( ruta : RutaItem) -> Bool in
            
            let categoryMatch = (scope == "Title")
            let stringMatch = ruta.nombre.rangeOfString(searchText)
            
            return categoryMatch && (stringMatch != nil)
            
        })
        
        
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool
    {
        
        self.filterContenctsForSearchText(searchString!, scope: "Title")
        
        return true
        
        
    }
    
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool
    {
        
        self.filterContenctsForSearchText(self.searchDisplayController!.searchBar.text!, scope: "Title")
        
        return true
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toShowRoute" {
            
            print("AQUIIIIIIIIII")
            var k = 0
            let rutaBuscada = rutaParaEnviar.nombre
            
            while (k < rutas.count) && (rutaBuscada != rutas[k].nombre) {
                k += 1
            }
            print("Ruta encontrada! " + rutas[k].nombre)
            
            print("AQUIIIIII" + rutaParaEnviar.nombre)
            (segue.destinationViewController as! RutaViewController).selectedRoute = rutas[k].id
            /*
            (segue.destinationViewController as
            RutaViewController).selectedCategories = puntosInteresSeleccionados
            */
        }
        
    }
    
    
}