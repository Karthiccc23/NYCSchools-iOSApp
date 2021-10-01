//
//  SchoolDetailsViewModel.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation

class SchoolDetailsViewModel {
    
    private let title = "School Details"
    
    private var coordinator: SchoolDetailsCoordinator
    
    init(coordinator: SchoolDetailsCoordinator) {
        self.coordinator = coordinator
    }
    
    func getScreenTitle() -> String {
        return title
    }
}
