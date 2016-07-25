//
//  MapViewController.swift
//  capstone
//
//  Created by León Felipe Guevara Chávez on 7/21/16.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//

import UIKit
import MapKit
import CoreData

var places = [Place]()

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    private var locationManager: CLLocationManager!
    private var location: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Map setup.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        

        // Load interesting places.
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Place")

        var err: NSError?
        
        do {
            places = try context.executeFetchRequest(request) as! [Place]
        } catch let err1 as NSError {
            err = err1
        }
        
        if (err != nil) {
            print("Problem with loading data")
        } else {
            if (places.count == 0) {
                initialInterestingPlaces()
            }
            loadPlacesToMap()
        }
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alert = UIAlertController(title: "Error", message: "Error: \(error.code)", preferredStyle: .Alert)
        let actionOK = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            //..
        }
        alert.addAction(actionOK)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialInterestingPlaces() {
        savePlace("Espacio Cultural Metropolitano", latitude: 22.235865, longitude: -97.854105)
        savePlace("Parque Metropolitano", latitude: 22.227470, longitude: -97.858848)
        savePlace("Catedral de Tampico", latitude: 22.216169, longitude: -97.857451)
        savePlace("Plaza de armas de Tampico", latitude: 22.216060, longitude: -97.857638)
        savePlace("Plaza de la libertad", latitude: 22.213711, longitude: -97.856740)
        savePlace("Paseo Canal de la Cortadura", latitude: 22.214673, longitude: -97.848394)
        savePlace("Antigua aduana de Tampico", latitude: 22.211474, longitude: -97.857883)
        savePlace("Estadio Tamaulipas", latitude: 22.279725, longitude: -97.850698)
        savePlace("Centro de Convenciones de Ciudad Madero", latitude: 22.243313, longitude: -97.834550)
        savePlace("Los deflines", latitude: 22.292848, longitude: -97.807246)
        savePlace("Plaza de los gobernadores", latitude: 22.286470, longitude: -97.802533)
        savePlace("Las sirenas", latitude: 22.275235, longitude: -97.794105)
        savePlace("Escolleras", latitude: 22.266747, longitude: -97.773561)
        savePlace("Playa Miramar", latitude: 22.275515, longitude: -97.793632)
        savePlace("Plaza Isauro Alfaro Otero", latitude: 22.247183, longitude: -97.837029)
    }
    
    func savePlace(name: String, latitude: Double, longitude: Double) {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        let place = NSEntityDescription.insertNewObjectForEntityForName("Place", inManagedObjectContext: context) as! Place
        
        place.name = name
        place.latitude = latitude
        place.longitude = longitude
        
        var err: NSError?
        
        do {
            try context.save()
            places.append(place);
        } catch let err1 as NSError {
            err = err1
        }
        
        if (err != nil) {
            print("Problem with saving data")
        }
    }
    
    func loadPlacesToMap() {
        for place in places {
            let annotation = MKPointAnnotation()
            
            annotation.title = place.name
            annotation.subtitle = "Latitud: \(place.latitude!); Longitud: \(place.longitude!)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude as! Double, longitude: place.longitude as! Double)
            map.addAnnotation(annotation)
        }
    }
    

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get user current location
        let userLocation:CLLocation = locations[0]
        
        // Utilizo la posición actual para definir la región que se mostrará en el mapa, usando un
        // delta de 0.02 grados tanto en la latitud como en la longitud.  Esto hace que el zoom sobre
        // el mapa sea fijo
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.03
        let lonDelta:CLLocationDegrees = 0.03
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
    }
    
    @IBAction func readQRCodes(sender: AnyObject) {
        performSegueWithIdentifier("qrSegue2", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
