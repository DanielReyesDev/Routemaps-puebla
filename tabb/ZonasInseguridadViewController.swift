//
//  ZonasInseguridadViewController.swift
//  tabb
//
//  Created by Mac17 on 19/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit
import MapKit


class ZonasInseguridadViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    var locationManager = CLLocationManager()
    
    var newZone = String()
    
    @IBOutlet weak var mapa: MKMapView!
    

    
    //*******************************************************************

    
    
    
    var latitudes: [Double] = []
    var longitudes: [Double] = []
    
    var numeroZonas: Int = 0
    
    var latLong: [Double] = [] { //condicion sobre ese objeto
        didSet { //alguien le puso un valor
            self.configureView() //se manda a llamar la funcion
        }
    }
    
    func configureView() {
        
        if !latLong.isEmpty {
            
            numeroZonas = latitudes.count
            print("El numero de zonas es de: \(numeroZonas)")
            
            latitudes.append(latLong[0]) //latitud
            longitudes.append(latLong[1]) //longitud
            
        }
        
    }
    
    //*******************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView() //ya habia algo??
        
        
        
        if latitudes.count >= 1 {
            print(latitudes)
            
            
            
            
            
            //var numeroZonas: Int = latitudLongitud.count - 1
            
            for index in 0...numeroZonas-1 {
                var addZonas = [CLLocation(latitude: self.latitudes[index] as CLLocationDegrees, longitude: self.longitudes[index] as CLLocationDegrees)]
                self.addRadiusCircle(addZonas[index])
            }
            
            
            
            
            let Span:MKCoordinateSpan = MKCoordinateSpanMake(0.015, 0.015)
            let ch:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitudes[0], self.longitudes[1])
            let Region:MKCoordinateRegion = MKCoordinateRegionMake(ch, Span)
            self.mapa.setRegion(Region, animated: true)
            
            
                        
        }
        
        mapa.delegate = self
        locationManager.delegate = self
        
        if #available(iOS 8.0, *) {
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        };
        
        /*
        if locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization")){
            if #available(iOS 8.0, *) {
                locationManager.requestWhenInUseAuthorization()
            } else {
                // Fallback on earlier versions
            }
        }
        */
        // Do any additional setup after loading the view.
    }

    
    func addRadiusCircle(location: CLLocation){
        self.mapa.delegate = self
        let circle = MKCircle(centerCoordinate: location.coordinate, radius: 300 as CLLocationDistance)
        self.mapa.addOverlay(circle)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.redColor()
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return nil
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
