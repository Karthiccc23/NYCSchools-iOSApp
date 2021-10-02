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
    
    var schools: [School] = [School]()
    
    init(coordinator: SchoolListCoordinator, schoolApiService: SchoolApiServiceProtocol = SchoolApiService()) {
        self.coordinator = coordinator
        self.schoolApiService = schoolApiService
    }
    
    func showSchoolDetails(for school: School) {
        coordinator.showSchoolDetails(for: school)
    }
    
    func getScreenTitle() -> String {
        return title
    }
    
    func fetchSchools(completion: @escaping (_ success: Bool,_ error: Error?)->()) {
        schoolApiService.fetchSchools() { (success, response, error) in
            if let error = error {
                completion(false,error)
            }
            
            if success {
                self.schools = response
                
                if !response.isEmpty {
                    completion(success,nil)
                } else {
                    completion(success,apiError(errorId: 502, description: "No Data Found", errorKind: .noDataFound))
                }
            }
        }
    }
}
