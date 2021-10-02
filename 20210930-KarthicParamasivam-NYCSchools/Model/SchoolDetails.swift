//
//  SchoolDetails.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation

struct SchoolDetails: Codable {
    let dbn: String
    let name: String
    let numOfTestTakers: String
    let satReadingScore: String
    let satMathScore: String
    let satWritingScore: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case numOfTestTakers = "num_of_sat_test_takers"
        case satReadingScore = "sat_critical_reading_avg_score"
        case satMathScore = "sat_math_avg_score"
        case satWritingScore = "sat_writing_avg_score"
    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        dbn = try values.decode(String.self, forKey: .dbn)
//        name = try values.decode(String.self, forKey: .name)
//        numOfTestTakers = try values.decode(String.self, forKey: .numOfTestTakers)
//        satReadingScore = try values.decode(String.self, forKey: .satReadingScore)
//        satMathScore = try values.decode(String.self, forKey: .satMathScore)
//        satWritingScore = try values.decode(String.self, forKey: .satWritingScore)
//    }
}
