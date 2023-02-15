//
//  CalendarViewController.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/7/23.
//
import MapKit
import FSCalendar
import UIKit

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var eventLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var openInMapsButton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var events = [String: String]()
    var addresses = [String: String]()
    var selectedAddress: String?
    
    
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Events and their addresses
        events["2023-02-14"] = "V Girls Subdistrict BB"
        addresses["2023-02-14"] = "1090 S Adams Central Ave, Hastings, NE 68901, USA"
        
        events["2023-02-16"] = "Girls & Boys State Wrestling Meet"
        addresses["2023-02-16"] = "455 N 10th St, Omaha, NE 68102, USA"
        
        events["2023-02-17"] = "Girls & Boys State Wrestling Meet"
        addresses["2023-02-17"] = "455 N 10th St, Omaha, NE 68102, USA"
        
        events["2023-02-18"] = "Boys JV & Varsity vs Omaha Roncalli Catholic"
        addresses["2023-02-18"] = "6401 Sorensen Pkwy, Omaha, NE 68152, USA"
        
        events["2023-02-18"] = "Boys Varsity Basketball Subdistricts"
        addresses["2023-02-18"] = "1090 S Adams Central Ave, Hastings, NE 68901, USA"
        
        
        //displaying the event when clicked
        
        
        
        
        
        locationManager.requestWhenInUseAuthorization()
        
        if let address = selectedAddress {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if let error = error {
                    print("Geocode failed with error: \(error)")
                } else if let placemarks = placemarks, let location = placemarks.first?.location {
                    let mark = MKPlacemark(placemark: MKPlacemark(coordinate: location.coordinate))
                    self.mapView.addAnnotation(mark)
                    self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                }
            }
        } else {
            print("Selected address is nil")
        }
        
        
        //enter the calender style
        setUpElements()
        
        //style the calendar
        calendar.appearance.titleFont = UIFont.boldSystemFont(ofSize: 17.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 22)
        calendar.appearance.headerTitleColor = UIColor.init(red: 105/255, green: 4/255, blue: 164/255, alpha: 1)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16)
        calendar.appearance.weekdayTextColor = UIColor.init(red: 105/255, green: 4/255, blue: 164/255, alpha: 1)
        calendar.appearance.todayColor = UIColor.init(red: 105/255, green: 4/255, blue: 164/255, alpha: 1)
        calendar.appearance.selectionColor = .systemGray
        calendar.appearance.eventDefaultColor = .systemRed
        calendar.appearance.eventSelectionColor = .systemGray
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    
    @IBAction func openMapsButtonTapped(_ sender: Any) {
        if let selectedAddress = selectedAddress {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(selectedAddress) { (placemarks, error) in
                if let error = error {
                    print("Geocode failed with error: \(error)")
                } else if let placemark = placemarks?.first, let location = placemark.location {
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
                    mapItem.name = selectedAddress
                    mapItem.openInMaps(launchOptions: nil)
                }
            }
        }
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            
            // Remove any existing pin from the map
            mapView.removeAnnotations(mapView.annotations)

            // Retrieve and store the selected address
            selectedAddress = addresses[dateString]
            
            if let selectedAddress = selectedAddress {
                geocoder.geocodeAddressString(selectedAddress) { (placemarks, error) in
                    if let error = error {
                        print("Geocode failed with error: \(error)")
                    } else if let placemarks = placemarks, let location = placemarks.first?.location {
                        let mark = MKPlacemark(placemark: MKPlacemark(coordinate: location.coordinate))
                        self.mapView.addAnnotation(mark)
                        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                    }
                }
            }

            let event = events[dateString]
            if let event = event {
                eventLabel.text = event
            } else {
                eventLabel.text = "There are no events on this day"
            }
            
            // Update the addressLabel to display the selected address
            if let selectedAddress = selectedAddress {
                addressLabel.text = selectedAddress
            } else {
                addressLabel.text = "No address found for this day"
            }
        }
    

    
    
    //displaying the dots, showing there is an event for that date
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        if let events = events[dateString] {
            return events.count
        }
        return 0
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)
            eventLabel.text = "Selected date: \(dateString)\nEvent: \(events[dateString] ?? "No event")"
        }
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(openInMapsButton)
    }
}



    
        
    
