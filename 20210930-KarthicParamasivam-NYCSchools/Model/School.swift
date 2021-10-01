//
//  School.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation


struct School: Codable {
    let dbn: String
    let name: String
    let website: String
    let location: String
    let totalStudents: String
    let summary: String
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case website
        case location
        case totalStudents = "total_students"
        case summary = "overview_paragraph"
        case phoneNumber = "phone_number"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        name = try values.decode(String.self, forKey: .name)
        website = try values.decode(String.self, forKey: .website)
        location = try values.decode(String.self, forKey: .location)
        totalStudents = try values.decode(String.self, forKey: .totalStudents)
        summary = try values.decode(String.self, forKey: .summary)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
    }
}
