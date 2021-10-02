//
//  SchoolDetailsViewModel.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation

class SchoolDetailsViewModel {
    
    private let title = "School Details"
    
    private var school: School?
    
    var schoolDetails: [SchoolDetails] = [SchoolDetails]()
    
    private var coordinator: SchoolDetailsCoordinator
    
    private let schoolApiService: SchoolApiServiceProtocol

    let schoolDetailTitles = ["NAME","SUMMARY", "TEST TAKERS NO","SAT AVERAGE READING SCORE", "SAT AVERAGE MATH SCORE", "SAT AVERAGE WRITING SCORE"]
    
    init(coordinator: SchoolDetailsCoordinator,schoolApiService: SchoolApiServiceProtocol = SchoolApiService(), school: School) {
        self.coordinator = coordinator
        self.school = school
        self.schoolApiService = schoolApiService
    }
    
    func getScreenTitle() -> String {
        return title
    }
    
    func getSchoolSummary() -> String {
        guard let school = school else { return "Not Available"}
        return school.summary
    }
    
    func fetchSchoolDetails(completion: @escaping (_ success: Bool,_ error: Error?)->()) {
        guard let school = school
        else {
            return completion(false,apiError(errorId: 501, description: "Server not found", errorKind: .serverError))
        }
        schoolApiService.fetchSchoolDetails(schoolId: school.dbn) { (success, response, error) in
            if let error = error {
                completion(false,error)
            }
            
            if !response.isEmpty {
                self.schoolDetails = response
                completion(success,nil)
            } else {
                completion(success,apiError(errorId: 502, description: "No Data Found", errorKind: .noDataFound))
            }
        }
    }
}
