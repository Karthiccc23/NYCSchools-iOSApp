//
//  SchoolApiService.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation

protocol SchoolApiServiceProtocol {
    func fetchSchools(completion: @escaping(_ success: Bool,_ schools: [School], _ error: Error?) -> ())
    func fetchSchoolDetails(schoolId: String, completion: @escaping(_ success: Bool,_ schoolDetails: [SchoolDetails], _ error: Error?) -> () )
}

struct Constants {

    struct APIDetails {
        static let APIScheme = "https"
        static let APIHost = "data.cityofnewyork.us"
        static let APIPath = "/resource/"
    }
}

class SchoolApiService: SchoolApiServiceProtocol{
    
    private let sessionManager: URLSession = {
        let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
    }()
    
    func fetchSchools(completion: @escaping (Bool, [School], Error?) -> ()) {
        guard let url = createURLFromParameters(parameters: ["$limit": "15","$offset":"0","$order":"school_name"], pathparam: "s3k6-pzi2.json") else {
            completion(false,[], apiError(errorId: 401, description: "Invalid Url", errorKind: .invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        sessionManager.dataTask(with: request) { (data, response, error) in
            
            //Handle error case
            guard error == nil else {
                completion(false,[], apiError(errorId: 501, description: error?.localizedDescription,errorKind: .serverError))
                return
            }
            
            guard let data = data else {
                completion(true,[], nil)
                return
            }
            
            let response = try? JSONDecoder().decode([School].self, from: data)
            
            if let response = response, !response.isEmpty {
                completion(true,response, nil)
            } else {
                completion(true,[], nil)
            }
        }.resume()
    }
    
    func fetchSchoolDetails(schoolId: String, completion: @escaping (Bool, [SchoolDetails], Error?) -> ()) {
        guard let url = createURLFromParameters(parameters: ["dbn": schoolId], pathparam: "f9bf-2cp4.json") else {
            completion(false,[], apiError(errorId: 401, description: "Invalid Url", errorKind: .invalidUrl))
            return
        }
        
        
        let request = URLRequest(url: url)
        sessionManager.dataTask(with: request) { (data, response, error) in
            
            //Handle error case
            guard error == nil else {
                completion(false,[], apiError(errorId: 501, description: error?.localizedDescription,errorKind: .serverError))
                return
            }
            
            guard let data = data else {
                completion(true, [], nil)
                return
            }
            
            let response = try? JSONDecoder().decode([SchoolDetails].self, from: data)
            
            if let response = response, !response.isEmpty {
                completion(true,response, nil)
            } else {
                completion(true, [], nil)
            }
        }.resume()
    }
}


extension SchoolApiService {
    private func createURLFromParameters(parameters: [String:Any], pathparam: String?) -> URL? {

        var components = URLComponents()
        components.scheme = Constants.APIDetails.APIScheme
        components.host   = Constants.APIDetails.APIHost
        components.path   = Constants.APIDetails.APIPath
        if let paramPath = pathparam {
            components.path = Constants.APIDetails.APIPath + "\(paramPath)"
        }
        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }

        return components.url
    }
}

struct apiError: Error {
    enum ErrorKind {
        case invalidUrl
        case serverError
        case noDataFound
    }
    let errorId: Int
    let description: String?
    let errorKind: ErrorKind
}
