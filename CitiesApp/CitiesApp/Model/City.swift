//
//  City.swift
//  CitiesApp
//
//  Created by Aaisha Asif on 11/02/25.
//

import Foundation
struct City: Identifiable, Codable,Equatable {
    let id = UUID()
    let city: String
    let admin_name: String
    let population: String
    
    enum CodingKeys: String, CodingKey {
        case city, admin_name, population
    }
}
