//
//  FirstViewController.swift
//  tabb
//
//  Created by Mac17 on 01/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



//HOMESCREEN

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var gesto: UIView!

    @IBOutlet weak var theMapView: MKMapView!
    var locationManager = CLLocationManager()
    
    
    
    var coordenadas:[Coordenadas]!
    var coordenadas2:[Coordenadas]!
    
    var color = UIColor.redColor()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*
    
        coordenadas = []
        coordenadas2 = []
        
        var corx:Double = 0.0
        var cory:Double = 0.0
        var myId:Int = 1
        
        var i = 0
        
        let database:COpaquePointer = Connect_DB_Sqlite("Routemaps", type: "sqlite")
        let query:COpaquePointer = Training_Select("SELECT * FROM transporte INNER JOIN transporte_has_coordenadas ON transporte.id = transporte_has_coordenadas.transporte_id INNER JOIN coordenadas ON coordenadas.id = transporte_has_coordenadas.coordenadas_id WHERE transporte.id = 1 AND tipo = 0", database: database)
        
        
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
        
        let query2:COpaquePointer = Training_Select("SELECT * FROM transporte INNER JOIN transporte_has_coordenadas ON transporte.id = transporte_has_coordenadas.transporte_id INNER JOIN coordenadas ON coordenadas.id = transporte_has_coordenadas.coordenadas_id WHERE transporte.id = 1 AND tipo = 1", database: database)
        
        
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

*/
        
        /* BIENVENIDA CON DB INTERNA*/
        //var user: Usuario = Usuario()
        //user = ModelManager.instance.bienvenida("Daniel")
        //Util.mostrarAlerta("", strBody: user.usuario, delegate: nil)
        /* BIENVENIDA CON DB INTERNA*/
        
        
        //textfielD.becomeFristResponder()
        
        
        
        
        
        

        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        }
        self.locationManager.startUpdatingLocation()
        theMapView.showsUserLocation = true
        
        

        
        /*********  PONER PUNTOS EN EL MAPA  **********/
        
        //COORDENADAS DE LA FACULTAD
        

        let lati:CLLocationDegrees = 19.005095
        let longi:CLLocationDegrees = -98.204757
        
        let Span:MKCoordinateSpan = MKCoordinateSpanMake(0.015, 0.015)
        let ch:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lati, longi)
        let Region:MKCoordinateRegion = MKCoordinateRegionMake(ch, Span)
        self.theMapView.setRegion(Region, animated: true)
        
        
        ColocaPunto(18.996889, Longi: -98.197017 , titulo: "Estadio Olimpico", sub: "Universitario BUAP")
        ColocaPunto(19.000112, Longi: -98.203699 , titulo: "Polideportivo Ignacio", sub: "Manuel Altamirano")
        ColocaPunto(19.002999, Longi: -98.199914 , titulo: "Facultad de Administración", sub: "BUAP")

        
        /*********  PONER PUNTOS EN EL MAPA  **********/
        
        
        
        
        /*
        var latitud:CLLocationDegrees = 48.399193
        var longitud:CLLocationDegrees = 9.993341
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var churchLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud, longitud)
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(churchLocation, theSpan)
        self.theMapView.setRegion(theRegion, animated: true)
        https://www.youtube.com/watch?v=uB100xVS_Yc
        */

        
        /*
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        */
        
        
        
        
        /*
            TRADUCIDO DE:
        UISwipeGestureRecognizer *ges =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        [bottomView addGestureRecognizer:ges];
        */
        
        let gestureUp = UISwipeGestureRecognizer(target: self, action: "swipe:") //reconocedor de gestos
        let gestureDown = UISwipeGestureRecognizer(target: self, action: "swipe:") //reconocedor de gestos
        

        
        gestureUp.direction = UISwipeGestureRecognizerDirection.Up
        gestureDown.direction = UISwipeGestureRecognizerDirection.Down
        
        gesto.self.addGestureRecognizer(gestureUp)
        gesto.self.addGestureRecognizer(gestureDown)
        //gesto.addGestureRecognizer(ges)
        
        /*
        crearCamino(coordenadas)
        color = UIColor.blueColor()
        crearCamino(coordenadas2)
*/
        
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        

        
        
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
            print(error)
            print("HUBO UN ERROR!")
        }
        
        /**
        let contents: NSString?
        do {
            contents = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding)
        } catch _ {
            contents = nil
        }
        **/
        
        
        let result = sqlite3_open(dbPath, &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Failed to open database")
        }
        return database
    }
    
    
    
    
    
    func keyboardWillShow(sender: NSNotification) {
        print("Se muestra Show frame.origin.y original ", terminator: "")
        print(self.view.frame.origin.y)
        
        self.view.frame.origin.y -= 150
        
        print("Se muestra Show frame.origin.y despues ", terminator: "")
        print(self.view.frame.origin.y)
    }
    
    
    func keyboardWillHide(sender: NSNotification) {
        print("Se muestra Hide frame.origin.y original ", terminator: "")
        print(self.view.frame.origin.y)
        
        self.view.frame.origin.y += 150
        
        print("Se muestra Hide frame.origin.y despues ", terminator: "")
        print(self.view.frame.origin.y)
    }
    
    
    func ColocaPunto(Lati:CLLocationDegrees, Longi:CLLocationDegrees, titulo:String, sub:String){
        //        var latitud:CLLocationDegrees = 18.996889
        //        var longitud:CLLocationDegrees = -98.197017
        let latDelta:CLLocationDegrees = 0.015
        let lonDelta:CLLocationDegrees = 0.015
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let churchLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Lati, Longi)
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(churchLocation, theSpan)
        //q        self.theMapView.setRegion(theRegion, animated: true)
        
        let theUlmMinsterAnnotation = MKPointAnnotation()
        theUlmMinsterAnnotation.coordinate = churchLocation
        theUlmMinsterAnnotation.title=titulo
        theUlmMinsterAnnotation.subtitle=sub
        
        self.theMapView.addAnnotation(theUlmMinsterAnnotation)
        
    }
    
    
    
    func crearCamino(coordinates:[Coordenadas]){
        
        let numCoordinates = coordinates.count - 1
        
        var j = 0
        
        for j = 0 ; j<numCoordinates ; j++ {
            let locations = [ CLLocation(latitude: coordinates[j].coordenada_x , longitude:  coordinates[j].coordenada_y),
                CLLocation(latitude: coordinates[j+1].coordenada_x, longitude: coordinates[j+1].coordenada_y)
            ]
            addPolyLineToMap(locations)
        }
        print("Sirvió: \(coordinates[0].coordenada_x)")
        /*
        var locations = [ CLLocation(latitude: 37.330536, longitude: -122.030546),
            CLLocation(latitude: 51.507222, longitude: -0.1275)
        ]
        
        addPolyLineToMap(locations)
        */
    }
    
    
    func addPolyLineToMap(locations: [CLLocation!])
    {
        
        var coordinates = locations.map({ (location: CLLocation!) -> CLLocationCoordinate2D in return location.coordinate})
        
        let polyline = MKPolyline(coordinates: &coordinates, count: locations.count)
        self.theMapView.addOverlay(polyline)
    }
    
    
    
    /*
    
    func mapView(mapView: MKMapView!, viewForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if(overlay is MKPolyline)
        {
            /*
            var pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = UIColor.redColor()
            pr.lineWidth = 5
            return pr
            */
            
            var linea = MKPolylineRenderer
            
            
            
        }
        return nil
    }


    
    */
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if(overlay is MKPolyline)
        {
            
            let pr = MKPolylineRenderer(overlay: overlay)
            pr.strokeColor = color
            pr.lineWidth = 2
            return pr
        }
        return nil
        
    }
    
    
    /*
    
    
    http://stackoverflow.com/questions/21355990/show-hidden-part-of-an-view-with-pulling-it-by-gestures
    http://www.spritekitlessons.com/gesture-recognizer-with-sprite-kit-and-swift/
    http://www.ioscreator.com/tutorials/detecting-swipe-gesture-tutorial-ios8-swift
    http://mathewsanders.com/animations-in-swift-part-two/
    http://www.appcoda.com/view-animation-in-swift/
    
    
    -(void)swipe:(UISwipeGestureRecognizer *)swipeGes{
    
    if(swipeGes.direction == UISwipeGestureRecognizerDirectionUp){
    [UIView animateWithDuration:.5 animations:^{
    //set frame of bottom view to top of screen (show 100%)
    bottomView.frame = CGRectMake(0, 0, 320, bottomView.frame.size.height);
    }];
    }
    else if (swipeGes.direction == UISwipeGestureRecognizerDirectionDown){
    [UIView animateWithDuration:.5 animations:^{
    //set frame of bottom view to bottom of screen (show 60%)
    bottomView.frame = CGRectMake(0, 300, 320, bottomView.frame.size.height);
    }];
    }
    }
    */
    
    
    
    func swipe(swipeGes: UISwipeGestureRecognizer ){
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        var duracion = 0.5
        
        
        
        
        if (swipeGes.direction == UISwipeGestureRecognizerDirection.Up)
        {
            print("Swipe UP", terminator: "")
            UIView.animateWithDuration(0.5, animations: {
                    self.gesto.frame = CGRectMake(0, screenHeight/1.8, screenWidth, screenHeight*0.4 )
                
                
                })
            
            

            
            /*
                UIView.animateWithDuration(duration: , animations: { () -> Void in
                    gesto.frame = CGRectMake(0, 0, 320, gesto.frame.height)
                    // CGRectMake(0, 0, 320, gesto.frame.size.height)
                })
            */

            
            
            
            /*
            // create a 'tuple' (a pair or more of objects assigned to a single variable)
            let views = (frontView: self.redSquare, backView: self.blueSquare)
            
            // set a transition style
            let transitionOptions = UIViewAnimationOptions.TransitionCurlUp
            
            UIView.transitionWithView(self.container, duration: 1.0, options: transitionOptions, animations: {
            // remove the front object...
            views.frontView.removeFromSuperview()
            
            // ... and add the other object
            self.container.addSubview(views.backView)
            
            }, completion: { finished in
            // any code entered here will be applied
            // .once the animation has completed
            })
            */
            
            
            
            
        }
        else if swipeGes.direction == UISwipeGestureRecognizerDirection.Down
        {
            print("Swipe DOWN", terminator: "")
            UIView.animateWithDuration(0.5, animations: {
                self.gesto.frame = CGRectMake(0, screenHeight*0.85 , screenWidth, screenHeight)
            })
        }
    }
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        println("error")
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations:[AnyObject]!)
    {
        var userLocation:CLLocation = locations[0] as CLLocation
        locationManager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center:location, span: span)
        theMapView.setRegion(region, animated:true)
        
        
    }
    */

    
    
    
    /*
    func addRoute() {
        let thePath = NSBundle.mainBundle().pathForResource("PruebaLineas", ofType: "plist")
        let pointsArray = NSArray(contentsOfFile: thePath!)
        
        let pointsCount = pointsArray!.count
        
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for i in 0...pointsCount-1 {
            let p = CGPointFromString(pointsArray![i] as String)
            pointsToUse += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]

        }
        
        let myPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsCount)
        
        theMapView.addOverlay(myPolyline)
    }
*/
    
    
    
    /*
    
    func loadSelectedOptions() {
        theMapView.removeAnnotations(theMapView.annotations)
        theMapView.removeOverlays(theMapView.overlays)
        
        for option in selectedOptions {
            switch (option) {
            case .MapOverlay:
                addOverlay()
            case .MapPins:
                addAttractionPins()
            case .MapRoute:
                addRoute()
            default:
                break;
            }
        }
    }
    
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is ParkMapOverlay {
            let magicMountainImage = UIImage(named: "overlay_park")
            let overlayView = ParkMapOverlayView(overlay: overlay, overlayImage: magicMountainImage!)
            
            return overlayView
        } else if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.greenColor()
            
            return lineView
        }
        
        return nil
    }

*/
       
}

