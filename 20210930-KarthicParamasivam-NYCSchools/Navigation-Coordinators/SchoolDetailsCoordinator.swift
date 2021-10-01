//
//  SchoolDetailsCoordinator.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation
import UIKit


final class SchoolDetailsCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    private let school: String
    
    init(navigationController: UINavigationController, school: String) {
        self.navigationController = navigationController
        self.school = school
    }
    
    func start() {
        let schoolDetailsViewModel = SchoolDetailsViewModel(coordinator: self, school: self.school)
        let schoolDetailsViewController = SchoolDetailsViewController(viewModel: schoolDetailsViewModel)
        navigationController.present(schoolDetailsViewController, animated: true, completion: nil)
    }
}
