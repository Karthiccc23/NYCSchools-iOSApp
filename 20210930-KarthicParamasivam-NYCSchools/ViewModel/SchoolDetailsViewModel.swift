//
//  SchoolDetailsViewModel.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation

class SchoolDetailsViewModel {
    
    private let title = "School Details"
    
    private var school: String?
    
    private var coordinator: SchoolDetailsCoordinator
    
    init(coordinator: SchoolDetailsCoordinator, school: String) {
        self.coordinator = coordinator
        self.school = school
        print("DETAILSVIEwMODEL = \(school)")
    }
    
    func getScreenTitle() -> String {
        return title
    }
}
