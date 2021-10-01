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
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let schoolListViewController = SchoolListViewController()
        navigationController.setViewControllers([schoolListViewController], animated: false)
    }
    
    
}
