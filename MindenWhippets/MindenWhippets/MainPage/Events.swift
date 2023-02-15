//
//  Events.swift
//  MindenWhippets
//
//  Created by Levi Loseke on 2/13/23.
//
import MapKit
import Foundation
import UIKit

class Event {
    var name: String
    var address: String
    var location: CLLocationCoordinate2D
    
    init(name: String, address: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.address = address
        self.location = location
    }
}
let events = [
    Event(name: "Event 1", address: "123 Main St, Anytown USA", location: CLLocationCoordinate2D(latitude: 37.3318, longitude: -122.0312)),
    Event(name: "Event 2", address: "456 Main St, Anytown USA", location: CLLocationCoordinate2D(latitude: 37.3323, longitude: -122.0311)),
    Event(name: "Event 3", address: "789 Main St, Anytown USA", location: CLLocationCoordinate2D(latitude: 37.3324, longitude: -122.0308))
]



