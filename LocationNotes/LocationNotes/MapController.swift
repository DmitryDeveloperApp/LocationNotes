//
//  MapController.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 03.06.2022.
//

import UIKit
import MapKit

class MapController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let longTapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
          
         mapView.gestureRecognizers = [longTapRecognizer]
        
    }
    
 @objc func handleLongTap(recongnizer: UIGestureRecognizer) {
     if recongnizer.state != .began {
         return
     }
    let point = recongnizer.location(in: mapView)
    let cordinat2D =  mapView.convert(point, toCoordinateFrom: mapView)
    
    let newNote = Note.newNote(name: "", inFolder: nil)
     newNote.locationActual = LocationCoordinate(lat: cordinat2D.latitude, lon: cordinat2D.longitude)
     
     let noteController = storyboard?.instantiateViewController(withIdentifier: "noteSID") as! NoteController
     
       noteController.note = newNote
       
       navigationController?.pushViewController(noteController, animated: true)
     
 }
    
    override func viewWillAppear(_ animated: Bool) {
       
        mapView.removeAnnotations(mapView.annotations)
        for note in notes {
            if note.locationActual != nil {
                mapView.addAnnotation(NoteAnnotetion(note: note))
            }
        }
    }

}

extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            DispatchQueue.main.async {
                mapView.setCenter(annotation.coordinate, animated: true)
            }
            return nil
        }
        
       let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      let selectedNote = (view.annotation as! NoteAnnotetion).note
      let noteController = storyboard?.instantiateViewController(withIdentifier: "noteSID") as! NoteController
        noteController.note = selectedNote
        
        navigationController?.pushViewController(noteController, animated: true)
       
    }
}
