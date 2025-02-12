
//  CitiesViewModelTests.swift
//  CitiesApp
//
//  Created by Aaisha Asif on 11/02/25.

//import Foundation
//import XCTest
//
//final class CitiesViewModelTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
//}
import XCTest


class CitiesViewModelTests: XCTestCase {
    
    var viewModel: CitiesViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CitiesViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitializationLoadsCities() {
        XCTAssertNotNil(viewModel.citiesByState, "Cities dictionary should not be nil")
    }

    func testToggleOrderReversesCities() {
        let city1 = City(city: "Sydney", admin_name: "New South Wales", population: "4840600")
        let city2 = City(city: "Melbourne", admin_name: "Victoria",population: "4529500")
        let city3 = City(city: "Brisbane", admin_name: "Queensland", population: "2360241")

        viewModel.citiesByState = [
            "New South Wales": [city1],
            "Victoria": [city2],
            "Queensland": [city3]
        ]
        
        viewModel.toggleOrder()
        
        XCTAssertTrue(viewModel.reversed, "Reversed flag should be true")
        XCTAssertEqual(viewModel.citiesByState["New South Wales"], [city1].reversed(), "Cities should be reversed")
    }

    func testFetchCitiesFromLocalJSONUpdatesData() {
        viewModel.fetchCitiesFromLocalJSON()
        XCTAssertFalse(viewModel.citiesByState.isEmpty, "Cities should be loaded from JSON")
    }
    
    func testRefreshDataCallsFetchCities() {
        viewModel.refreshData()
        XCTAssertFalse(viewModel.citiesByState.isEmpty, "Cities should be refreshed")
    }
}
