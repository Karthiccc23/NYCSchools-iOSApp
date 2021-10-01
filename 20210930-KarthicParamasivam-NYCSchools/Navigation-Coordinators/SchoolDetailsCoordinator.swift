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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let schoolDetailsViewModel = SchoolDetailsViewModel(coordinator: self)
        let schoolDetailsViewController = SchoolDetailsViewController(viewModel: schoolDetailsViewModel)
        navigationController.present(schoolDetailsViewController, animated: true, completion: nil)
    }
}
