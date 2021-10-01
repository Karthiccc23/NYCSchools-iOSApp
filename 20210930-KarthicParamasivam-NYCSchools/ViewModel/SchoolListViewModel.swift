//
//  SchoolListViewModel.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation


class SchoolListViewModel {
    
    private let title = "NYC Schools"
    
    private let coordinator: SchoolListCoordinator
    
    private let schoolApiService: SchoolApiServiceProtocol
    
    private var schools: [School] = [School]()
    
    init(coordinator: SchoolListCoordinator, schoolApiService: SchoolApiServiceProtocol = SchoolApiService()) {
        self.coordinator = coordinator
        self.schoolApiService = schoolApiService
    }
    
    func showSchoolDetails(for school: String) {
        print("school \(school)")
        coordinator.showSchoolDetails(for: school)
    }
    
    func getScreenTitle() -> String {
        return title
    }
    
    func fetchSchools() {
        schoolApiService.fetchSchools() { (success, response, error) in
            print(success)
            print(response)
            print(error)
        }
    }
}
