//
//  GooglePlacesViewController.swift
//  tabb
//
//  Created by Daniel Reyes on 25/06/15.
//  Copyright (c) 2015 iLab. All rights reserved.
//

import UIKit

class GooglePlacesViewController: UIViewController {
    let gpaViewController = GooglePlacesAutocomplete(
        apiKey: "AIzaSyDi17xy-hqyIazzuEumoVD1-2wZq9lf2ao",
        placeType: .Address
    )
    var latLon = [Double]()
    
    var lon: Double = 0.0
    var lat: Double = 0.0
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        gpaViewController.placeDelegate = self
        

        presentViewController(gpaViewController, animated: true, completion: nil)
        
        
        gpaViewController.navigationBar.barStyle = UIBarStyle.Black
        gpaViewController.navigationBar.translucent = false
        gpaViewController.navigationBar.barTintColor = UIColor(red:0.27, green:0.23, blue:0.06, alpha:1)
        gpaViewController.navigationBar.tintColor = UIColor.whiteColor()
        gpaViewController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 20.0)!]
        
        
        gpaViewController.deshabilitar()
        
        
        if gpaViewController.searchDisplayController?.searchBar.text != "" {
            gpaViewController.habilitar()
        }
        
        
        /*
        if gpaViewController.searchDisplayController?.searchBar.text != "" && gpaViewController.gpaViewController.descripcion?.text != nil {
                println(gpaViewController.gpaViewController.descripcion)
                gpaViewController.habilitar()
        }
        */
        print(gpaViewController.gpaViewController.descripcionText)
        
        //println(lon)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToInseguridad" {
            
            (segue.destinationViewController as!
                ZonasInseguridadViewController).latLong = latLon
        }
    }
}




extension GooglePlacesViewController: GooglePlacesAutocompleteDelegate {
    func placeSelected(place: Place) {
        print(place.description)
        
        place.getDetails { details in
            self.lon = details.longitude
            self.lat = details.latitude
            self.latLon.append(self.lat)
            self.latLon.append(self.lon)
            //println(self.latLon)
            //println(details)

        }
        performSegueWithIdentifier("backToInseguridad", sender: nil)
        
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
        //performSegueWithIdentifier("backToInseguridad", sender: self)
    }
    
    
    
    
    
}