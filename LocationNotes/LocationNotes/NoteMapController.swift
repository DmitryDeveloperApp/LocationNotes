//
//  NoteMapController.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 03.06.2022.
//

import UIKit
import MapKit

class NoteAnnotetion: NSObject, MKAnnotation {
    var note: Note
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var subtitle: String?
    
    init(note: Note) {
        self.note = note
        title = note.name
        if note.locationActual != nil {
            coordinate = CLLocationCoordinate2D(latitude: note.locationActual!.lat, longitude: note.locationActual!.lon)
        } else {
            coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        
    }
}

class NoteMapController: UIViewController {

    var note: Note?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mapView.delegate = self
        if note?.locationActual != nil {
            mapView.addAnnotation(NoteAnnotetion(note: note!))
            mapView.centerCoordinate = CLLocationCoordinate2D(latitude: note!.location!.lot, longitude: note!.location!.lon)
        }
        
       let longTapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
         
        mapView.gestureRecognizers = [longTapRecognizer]
   
    }
    
    @objc func handleLongTap(recongnizer: UIGestureRecognizer) {
        if recongnizer.state != .began {
            return
        }
       let point = recongnizer.location(in: mapView)
       let cordinat2D =  mapView.convert(point, toCoordinateFrom: mapView)
       
        
       note?.locationActual = LocationCoordinate(lat: cordinat2D.latitude, lon: cordinat2D.longitude)
       CoreDataManager.sharedInstance.saveContext()
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(NoteAnnotetion(note: note!))
        
    }
}

extension NoteMapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
       let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        pin.isDraggable = true
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState){
        
        if newState == .ending {
           let newLocation = LocationCoordinate(lat: (view.annotation?.coordinate.latitude)!, lon: (view.annotation?.coordinate.longitude)!)
            note?.locationActual = newLocation
            CoreDataManager.sharedInstance.saveContext()
        }
    }
}
