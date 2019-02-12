//
//  PuntosInteresViewController.swift
//  tabb
//
//  Created by Mac17 on 19/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PuntosInteresViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var locationManager = CLLocationManager() //para la ubicación del usuario
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    
    var categoriasSeleccionadas: [NSString] = []
    
    
    var selectedCategories: [NSString] = [] { //condicion sobre ese objeto
        didSet { //alguien le puso un valor
            self.configureView() //se manda a llamar la funcion
        }
    }
    
    func configureView() {
        
        if !selectedCategories.isEmpty {
            categoriasSeleccionadas = selectedCategories
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView() //ya habia algo??
        print(categoriasSeleccionadas)
        
        
        if (CLLocationManager.locationServicesEnabled())
        {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if #available(iOS 8.0, *) {
                self.locationManager.requestWhenInUseAuthorization()
            } else {
                // Fallback on earlier versions
            }
            self.locationManager.startUpdatingLocation()
            
            mapa.showsUserLocation = true
            
        }
        
        
        
        performSearch()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error!!")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let userLocation: CLLocation = locations[0] 
        locationManager.stopUpdatingLocation()
        
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapa.setRegion(region, animated: true)
        
        
        
        
        
        /* ESTE TAMBIEN SIRVE, ES UNA FORMA MUY PARECIDA DE HACERLO
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapa.setRegion(region, animated: true)

        */
    }
    
    
    
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = categoriasSeleccionadas[0] as String
        request.region = mapa.region
        
        let search = MKLocalSearch(request: request)
        
        
        /*
            antes:      search.startWithCompletionHandler({(response: MKLocalSearchResponse!, error: NSError!) in
            despues:    search.startWithCompletionHandler({(response: MKLocalSearchResponse?, error: NSError?) in
        
        */
        
        
        search.startWithCompletionHandler({(response:
            MKLocalSearchResponse?,
            error: NSError?) in
            
            if error != nil {
                print("Error occured in search: \(error?.localizedDescription)")
            } else if response?.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                
                for item in (response?.mapItems)! {
                    print("Name = \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapa.addAnnotation(annotation)
                }
            }
        })
    }
    
    
}
