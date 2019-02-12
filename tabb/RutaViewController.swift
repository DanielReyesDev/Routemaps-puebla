//
//  RutaViewController.swift
//  tabb
//
//  Created by Daniel Reyes on 18/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class RutaViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    
    @IBOutlet weak var mapa: MKMapView!
    var locationManager = CLLocationManager()
    
    var coordenadas:[Coordenadas]!
    var coordenadas2:[Coordenadas]!
    var color = UIColor.redColor().colorWithAlphaComponent(0.5)
    var colorBlue = UIColor.blueColor().colorWithAlphaComponent(0.5)
    var colorRed = UIColor.redColor().colorWithAlphaComponent(0.5)
    
    
    
    
    var rutaSeleccionada: Int!
    
    
    
    
    
    
    var selectedRoute: Int! { //condicion sobre ese objeto
        didSet { //alguien le puso un valor
            self.configureView() //se manda a llamar la funcion
        }
    }
    
    func configureView() {
        
        
        
        rutaSeleccionada = selectedRoute
        
        
        
        /*
        if !selectedRoute.isEmpty {
        rutaSeleccionada = selectedRoute
        
        }
        */
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        
        coordenadas = []
        coordenadas2 = []
        
        var corx:Double = 0.0
        var cory:Double = 0.0
        var myId:Int = 1
        
        var i = 0
        
        let database:COpaquePointer = Connect_DB_Sqlite("Routemaps", type: "sqlite")
        let query:COpaquePointer = Training_Select("SELECT * FROM transporte INNER JOIN transporte_has_coordenadas ON transporte.id = transporte_has_coordenadas.transporte_id INNER JOIN coordenadas ON coordenadas.id = transporte_has_coordenadas.coordenadas_id WHERE transporte.id = \(rutaSeleccionada) AND tipo = 0", database: database)
        
        
        while (sqlite3_step(query) == SQLITE_ROW) {
            myId = Int(sqlite3_column_int(query, 6)) //transporte_id
            print("id: \(myId)")
            
            corx = Double(sqlite3_column_double(query, 10)) //coordenada x
            print("corx: \(corx)")
            cory = Double(sqlite3_column_double(query, 11)) //coordenada y
            print("cory: \(cory)")
            
            
            coordenadas.append(Coordenadas())
            coordenadas[i].id = myId
            coordenadas[i].coordenada_x = corx
            coordenadas[i].coordenada_y = cory
            
            i++
            
        }
        sqlite3_finalize(query)
        
        
        
        
        
        
        
        
        i = 0
        
        let query2:COpaquePointer = Training_Select("SELECT * FROM transporte INNER JOIN transporte_has_coordenadas ON transporte.id = transporte_has_coordenadas.transporte_id INNER JOIN coordenadas ON coordenadas.id = transporte_has_coordenadas.coordenadas_id WHERE transporte.id = \(rutaSeleccionada) AND tipo = 1", database: database)
        
        
        while (sqlite3_step(query2) == SQLITE_ROW) {
            myId = Int(sqlite3_column_int(query2, 6)) //transporte_id
            print("id: \(myId)")
            
            corx = Double(sqlite3_column_double(query2, 10)) //coordenada x
            print("corx: \(corx)")
            cory = Double(sqlite3_column_double(query2, 11)) //coordenada y
            print("cory: \(cory)")
            
            
            coordenadas2.append(Coordenadas())
            coordenadas2[i].id = myId
            coordenadas2[i].coordenada_x = corx
            coordenadas2[i].coordenada_y = cory
            
            i++
            
        }
        sqlite3_finalize(query2)
        sqlite3_close(database)
        
        
        
        print("i vale: \(i)")
        
        
        
        
        
        
        
        
        
        mapa.delegate = self
        
        locationManager.delegate = self
        if locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization")){
            if #available(iOS 8.0, *) {
                locationManager.requestWhenInUseAuthorization()
            } else {
                // Fallback on earlier versions
            }
        }/*fin de if de autorizacion*/
        
        
        let lati:CLLocationDegrees = 19.004571
        let longi:CLLocationDegrees = -98.201762
        
        let Span:MKCoordinateSpan = MKCoordinateSpanMake(0.13, 0.13)
        let ch:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lati, longi)
        let Region:MKCoordinateRegion = MKCoordinateRegionMake(ch, Span)
        self.mapa.setRegion(Region, animated: true)
        
        
        color = colorRed
        createTestPolyline(coordenadas)
        color = colorBlue
        createTestPolyline(coordenadas2)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        print(rutaSeleccionada)
        
        
        
        
        
        
        
    }/*din de metodo viewDidLoad*/
    
    
    
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
            print("Hubo un error!")
        }
        let result = sqlite3_open(dbPath, &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
        }
        return database
    }
    
    
    /*funciones*/
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation){
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 700, 700)
        mapa.setRegion(mapa.regionThatFits(region), animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate =  userLocation.coordinate
        point.title = "Tu ubicacion"
        point.subtitle = "Aqui"
        mapa.addAnnotation(point)
    }
    
    
    
    
    
    func createTestPolyline(coordinates:[Coordenadas]){
        let numCoordinates = coordinates.count - 1
        
        var j = 0
        
        for j = 0 ; j<numCoordinates ; j++ {
            let locations = [ CLLocation(latitude: coordinates[j].coordenada_x , longitude:  coordinates[j].coordenada_y),
                CLLocation(latitude: coordinates[j+1].coordenada_x, longitude: coordinates[j+1].coordenada_y)
            ]
            addPolyLineToMap(locations)
        }
        print("Sirvió: \(coordinates[0].coordenada_x)")
        
    }
    
    
    
    
    func addPolyLineToMap(locations: [CLLocation!])
    {
        var coordinates = locations.map({ (location: CLLocation!) ->
            CLLocationCoordinate2D in return location.coordinate
        })
        
        let polyline = MKPolyline(coordinates: &coordinates, count: locations.count)
        self.mapa.addOverlay(polyline)
    }
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if (overlay is MKPolyline) {
            let pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = color
            pr.lineWidth = 3
            return pr
        }
        
        return MKPolylineRenderer()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}