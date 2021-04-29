//
//  NetworkMangerTests.swift
//  unitTestingDay2Tests
//
//  Created by ola abaza on 4/22/21.
//

import XCTest

@testable import SportsApp

class NetworkManagerTests: XCTestCase {
    
    
    var networkManager : MockNetworkManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        networkManager = MockNetworkManager(shouldReturnError: false)
        
    }

    
    func testGetContacts()  {
        
        
       // let expecttionObj = expectation(description: "Wait for response")
        
        networkManager.getSports(url: "") { (sports, error) in
            
            if let error = error {
                XCTFail()
                
            }else{
                
               // expecttionObj.fulfill()
                XCTAssertEqual(sports?.sports?.count, 2)
                
            }
            
        }
        
       // waitForExpectations(timeout: 5)
        
        
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        networkManager = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
