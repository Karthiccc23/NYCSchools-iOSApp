//
//  SchoolListVIewModel.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation


class SchoolListVIewModel {
    
    private let title = "NYC Schools"
    
    private var coordinator: SchoolListCoordinator
    
    init(coordinator: SchoolListCoordinator) {
        self.coordinator = coordinator
    }
    
    func showSchoolDetails(for school: String) {
        print("school \(school)")
        coordinator.showSchoolDetails()
    }
    
    func getScreenTitle() -> String {
        return title
    }
}
