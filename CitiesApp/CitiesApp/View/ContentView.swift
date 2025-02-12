//
//  ContentView.swift
//  CitiesApp
//
//  Created by Aaisha Asif on 11/02/25.
//

import SwiftUI

struct CitiesListView: View {
    @EnvironmentObject var viewModel: CitiesViewModel
    @State private var expandedStates: Set<String> = []
    
    var body: some View {
        NavigationView {
            List {
                Button("Reverse Order") {
                    viewModel.toggleOrder()
                }
                .padding()
                
                Button("Refresh Data") {
                    viewModel.refreshData()
                }
                .padding()
                
                ForEach(viewModel.citiesByState.keys.sorted(), id: \ .self) { state in
                    Section(header: Text(state).onTapGesture {
                        if expandedStates.contains(state) {
                            expandedStates.remove(state)
                        } else {
                            expandedStates.insert(state)
                        }
                    }) {
                        if expandedStates.contains(state) {
                            ForEach(viewModel.citiesByState[state] ?? []) { city in
                                Text("\(city.city) - Population: \(city.population)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Australian Cities")
        }
    }
}

// Preview
struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesListView().environmentObject(CitiesViewModel())
    }
}
