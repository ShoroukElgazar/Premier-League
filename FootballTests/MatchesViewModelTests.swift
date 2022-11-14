//
//  MatchesViewModelTests.swift
//  FootballTests
//
//  Created by Shorouk Mohamed on 11/13/22.
//

import XCTest
@testable import Football

class MatchesViewModelTests: XCTestCase {
    var sut : MatchesViewModel?
    var matchesRepoProtocolSpy : MatchesRepoProtocolSpy?
    
    override func setUp() {
        super.setUp()
        matchesRepoProtocolSpy = MatchHandler.Spies.matchesRepoProtocolSpy
        sut = MatchesViewModel(repo: matchesRepoProtocolSpy!)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        matchesRepoProtocolSpy = nil
    }
    
    func testGetMatches() async {
        await sut?.getMatches()
        // Assert
        XCTAssertEqual(matchesRepoProtocolSpy?.isGetMatchesCalled,true,"")
        
    }
}
