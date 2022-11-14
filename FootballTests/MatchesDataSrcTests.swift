//
//  MatchesDataSrcTests.swift
//  FootballTests
//
//  Created by Shorouk Mohamed on 11/9/22.
//

import XCTest
@testable import Football

 class MatchesDataSrcTests: XCTestCase {
     var sut : MatchesDataSrc?
     var apiServiceSpy : ApiServiceSpy?
     
    override func setUp() {
        super.setUp()
        apiServiceSpy = MatchHandler.Spies.apiService
        sut = MatchesDataSrc(apiService: apiServiceSpy!)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        apiServiceSpy = nil
    }

     func testDataSrc() async {

         do{
           try await sut?.getAllMatches()
             // Assert
             XCTAssertEqual(apiServiceSpy?.isRequestCalled,true,"")
         }catch{
             // Assert
             XCTAssertEqual(apiServiceSpy?.isRequestCalled,false,"")
         }

     }
}
