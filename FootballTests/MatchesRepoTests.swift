//
//  MatchesRepoTests.swift
//  FootballTests
//
//  Created by Shorouk Mohamed on 11/13/22.
//

import XCTest
@testable import Football

class MatchesRepoTests: XCTestCase {
    var sut : MatchesRepo?
    var matchesDataSrcProtocolSpy : MatchesDataSrcProtocolSpy?
    
   override func setUp() {
       super.setUp()
       matchesDataSrcProtocolSpy = MatchHandler.Spies.matchesDataSrcProtocolSpy
       sut = MatchesRepo(src: matchesDataSrcProtocolSpy!)
   }
   
   override func tearDown() {
       super.tearDown()
       sut = nil
       matchesDataSrcProtocolSpy = nil
   }

    func testGetAllMatches() async {
        do{
            try await sut?.getMatches()
            // Assert
            XCTAssertEqual(matchesDataSrcProtocolSpy?.isGetAllMatchesCalled,true,"")
         } catch (let error) {
            debugPrint("Error",error.localizedDescription)
        }
    }
}
