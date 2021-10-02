//
//  SchoolListViewModelTest.swift
//  20210930-KarthicParamasivam-NYCSchoolsTests
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import XCTest
@testable import _0210930_KarthicParamasivam_NYCSchools

class SchoolApiServiceTest: XCTestCase {
    
    var mockSchoolApiService: SchoolApiServiceProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockSchoolApiService =  MockSchoolApiService()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSchoolListApi() {
        mockSchoolApiService.fetchSchools() { (completion, response, error) in
            XCTAssert(completion)
            XCTAssert(!response.isEmpty)
            XCTAssertEqual(response.count, 2)
        }
    }
    
    func testSchoolDetailsApi() {
        mockSchoolApiService.fetchSchoolDetails(schoolId: "21K728") { (completion, response, error) in
            XCTAssert(completion)
            XCTAssert(!response.isEmpty)
            XCTAssertEqual(response.count, 1)
            XCTAssertEqual("21K728", response[0].dbn)
        }
    }
}

class MockSchoolApiService: SchoolApiServiceProtocol {
    func fetchSchools(completion: @escaping (Bool, [School], Error?) -> ()) {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "SchoolListResponse", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let schoolList = try! decoder.decode([School].self, from: data)
        completion(true,schoolList,nil)
    }
    
    func fetchSchoolDetails(schoolId: String, completion: @escaping (Bool, [SchoolDetails], Error?) -> ()) {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "SchoolDetailsResponse", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let schoolDetails = try! decoder.decode([SchoolDetails].self, from: data)
        completion(true,schoolDetails,nil)
    }
}
