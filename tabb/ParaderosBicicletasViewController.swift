//
//  ParaderosBicicletasViewController.swift
//  tabb
//
//  Created by Mac17 on 19/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ParaderosBicicletasViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var theMapView: MKMapView!


    @IBAction func informacionParaderos(sender: AnyObject) {
        
        print("Se ha precionado el camioncito!")
    }


    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        }
        self.locationManager.startUpdatingLocation()
        theMapView.showsUserLocation = true
        
        theMapView.delegate = self
        
        let lati:CLLocationDegrees = 19.047517
        let longi:CLLocationDegrees = -98.204713
        
        let Span:MKCoordinateSpan = MKCoordinateSpanMake(0.025, 0.025)
        let ch:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lati, longi)
        let Region:MKCoordinateRegion = MKCoordinateRegionMake(ch, Span)
        self.theMapView.setRegion(Region, animated: true)
        
        
        var latitudes = [Double]()
        latitudes.append(19.047340)
        latitudes.append(19.050637)
        latitudes.append(19.043694)
        latitudes.append(19.047535)
        latitudes.append(19.043557)
        latitudes.append(19.046020)
        
        var longitudes = [Double]()
        longitudes.append(-98.210133)
        longitudes.append(-98.206331)
        longitudes.append(-98.202924)
        longitudes.append(-98.200772)
        longitudes.append(-98.198839)
        longitudes.append(-98.197742)
        
        
        var subtitulos = [String]()
        subtitulos.append("CE1 - Av. Juarez y 15 sur")
        subtitulos.append("CE2 - Av. 4 Poniente y 13 Norte")
        subtitulos.append("CE3 - 7 Poniente y 5 Sur")
        subtitulos.append("CE4 - 4 Poniente y 5 Norte")
        subtitulos.append("CE5 - 3 Oriente y 16 de Septiembre")
        subtitulos.append("CE6 - 5 de Mayo y 4 Poniente")
        
        let noDeParaderos : Int = latitudes.count-1
        var locations = [CLLocationCoordinate2D]()
        
        
        for index in 0...noDeParaderos {
            locations.append(CLLocationCoordinate2D(latitude: latitudes[index], longitude: longitudes[index]))
        }
        
        
        var pinAnnotations = [PinAnnotation]()
        for index in 0...noDeParaderos {
            pinAnnotations.append(PinAnnotation())
            pinAnnotations[index].setCoordinate(locations[index])
        //    pinAnnotations[index].setTitle("SmartBike")
            pinAnnotations[index].setSubtitule(subtitulos[index])
            
            self.theMapView.addAnnotation(pinAnnotations[index])
        }
    }
    
    

    
    
    
    
    func ColocaPunto(Lati:CLLocationDegrees, Longi:CLLocationDegrees, titulo:String, sub:String){
        let latDelta:CLLocationDegrees = 0.015
        let lonDelta:CLLocationDegrees = 0.015
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let churchLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Lati, Longi)
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(churchLocation, theSpan)
        var desc: String
        desc = "Esto es una descrpcion"
        let theUlmMinsterAnnotation = MKPointAnnotation()
        theUlmMinsterAnnotation.coordinate = churchLocation
        theUlmMinsterAnnotation.title=titulo
        theUlmMinsterAnnotation.subtitle=sub
        
        self.theMapView.addAnnotation(theUlmMinsterAnnotation)
    }
    
    
    class PinAnnotation : NSObject, MKAnnotation {
        private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
        var coordinate: CLLocationCoordinate2D {
            get {
                return coord
            }
        }
        
        var title: String? = ""
        var subtitle: String? = ""
        
        
        
        
        
        
        func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
            self.coord = newCoordinate
        }
        
      /*  func setTitle(tit: String){
            self.title = tit
        }*/
        
        func setSubtitule(subt: String){
            self.subtitle = subt
        }
    }
    

    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView! {
        if annotation is PinAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinColor = MKPinAnnotationColor.Purple
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.accessibilityLabel=""
            
            let deleteButton = UIButton(type: UIButtonType.Custom)
            deleteButton.frame.size.width = 44
            deleteButton.frame.size.height = 44
            deleteButton.backgroundColor = UIColor.whiteColor()
            deleteButton.setImage(UIImage(named: "bicle"), forState: .Normal)
            
            pinAnnotationView.leftCalloutAccessoryView = deleteButton
            
            return pinAnnotationView as MKAnnotationView
        }
        else{
            return nil
        }
    }
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? PinAnnotation {
            self.theMapView.sizeToFit()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

