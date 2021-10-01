//
//  SchoolListCoordinator.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation
import UIKit

final class SchoolListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let schoolListViewModel = SchoolListViewModel(coordinator: self)
        let schoolListViewController = SchoolListViewController(viewModel: schoolListViewModel)
        navigationController.setViewControllers([schoolListViewController], animated: false)
    }
    
    func showSchoolDetails(for school: String) {
        let schoolDetailsCoordinator = SchoolDetailsCoordinator(navigationController: navigationController, school: school)
        childCoordinators.append(schoolDetailsCoordinator)
        schoolDetailsCoordinator.start()
    }
}
