//
//  CitiesAppApp.swift
//  CitiesApp
//
//  Created by Aaisha Asif on 11/02/25.
//

import SwiftUI

@main
struct CitiesAppApp: App {
    @StateObject private var viewModel = CitiesViewModel()

    var body: some Scene {
        WindowGroup {
            CitiesListView().environmentObject(viewModel)
        }
    }
}
