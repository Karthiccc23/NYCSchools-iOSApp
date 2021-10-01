//
//  SchoolApiService.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation

protocol SchoolApiServiceProtocol {
    func fetchSchools(completion: @escaping(_ success: Bool,_ schools: [School], _ error: Error?) -> ())
}



class SchoolApiService: SchoolApiServiceProtocol{
    
    private let sessionManager: URLSession = {
        let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
    }()
    
    private var url: URL? {
        get {
            return URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$limit=5&$offset=0&$order=school_name")
        }
    }
    
    func fetchSchools(completion: @escaping (Bool, [School], Error?) -> ()) {
        guard let url = url else {
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
            }
        }.resume()
    }
}

struct apiError: Error {
    enum ErrorKind {
        case invalidUrl
        case serverError
    }
    let errorId: Int
    let description: String?
    let errorKind: ErrorKind
}
