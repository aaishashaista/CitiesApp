//
//  CitiesViewModel.swift
//  CitiesApp
//
//  Created by Aaisha Asif on 11/02/25.
//

import Foundation
class CitiesViewModel: ObservableObject {
    @Published var citiesByState: [String: [City]] = [:]
    @Published var reversed = false
   // private var cancellables = Set<AnyCancellable>()
    private let cacheKey = "cachedCities"
    
    init() {
        loadCities()
    }
    
    func loadCities() {
        if let cachedData = UserDefaults.standard.data(forKey: cacheKey),
           let cachedCities = try? JSONDecoder().decode([City].self, from: cachedData) {
            citiesByState = Dictionary(grouping: cachedCities, by: { $0.admin_name })
        } else {
            fetchCitiesFromLocalJSON()
        }
    }
    
    func fetchCitiesFromLocalJSON() {
        guard let url = Bundle.main.url(forResource: "au_cities", withExtension: "json") else {
            print("Error: JSON file not found in bundle")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let cities = try JSONDecoder().decode([City].self, from: data)
            DispatchQueue.main.async {
                self.citiesByState = Dictionary(grouping: cities, by: { $0.admin_name })
                if let encodedData = try? JSONEncoder().encode(cities) {
                    UserDefaults.standard.set(encodedData, forKey: self.cacheKey)
                }
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func toggleOrder() {
        reversed.toggle()
        citiesByState = citiesByState.mapValues { reversed ? $0.reversed() : $0 }
    }
    
    func refreshData() {
        fetchCitiesFromLocalJSON()
    }
}
