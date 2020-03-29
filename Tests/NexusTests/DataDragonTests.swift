//
//  File.swift
//
//
//  Created by André Vants Soares de Almeida on 09/03/20.
//

import XCTest
@testable import Nexus


final class DataProviderMock: Provider {
    
    func send<T>(_ apiRequest: APIRequest, completion: @escaping (Response<T>) -> Void) where T : Decodable {
        
        var data: Data?
        if T.self is Realm.Type {
            data = StubService.stubData(Realm.self)
        }
        
        let response = HTTPURLResponse(url: apiRequest.url, statusCode: 200, httpVersion: nil, headerFields: nil)
        DispatchQueue.global().async {
            completion(Response(request: try! apiRequest.asURLRequest(), data: data, response: response))
        }
    }
}

final class DataDragonTests: XCTestCase {
    
    let region: Region = .na
    var dataDragon: DataDragon!
    
    override func setUp() {
        super.setUp()
        dataDragon = DataDragon(region: region, api: DataDragonAPI(provider: DataProviderMock()))
    }
    
    override func tearDown() {
        dataDragon = nil
        super.tearDown()
    }
    
    func executeSampleCall() {
        let expectation = self.expectation(description: "sample call should complete")
        dataDragon.getChampions { _ in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func verifyOverriddenCall(matching override: String) {
        let expectation = self.expectation(description: "overriden call should succeed")
        dataDragon.getChampions { response in
            if let requestURL = response.request?.url?.absoluteString {
                XCTAssert(requestURL.contains(override), "target parameter passed in URL path must match the override")
            } else {
                XCTFail("request URL must exist")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testInitState() {
        XCTAssertNil(dataDragon.autoversion)
        XCTAssertNil(dataDragon.currentVersion)
        XCTAssertNil(dataDragon.currentLocale)
    }
    
    func testFirstCallSetsAutomanagedVersionInfo() {
        executeSampleCall()
        XCTAssertNotNil(dataDragon.autoversion)
        XCTAssert(dataDragon.currentVersion == dataDragon.autoversion?.version)
        XCTAssert(dataDragon.currentLocale == dataDragon.autoversion?.locale)
    }
    
    func testChangeRegionResetsManagedInfo() {
        executeSampleCall()
        dataDragon.selectRegion(.br)
        XCTAssertNil(dataDragon.autoversion)
        XCTAssertNil(dataDragon.currentVersion)
        XCTAssertNil(dataDragon.currentLocale)
    }
    
    func testChangeRegionDontResetWhenIdentical() {
        executeSampleCall()
        dataDragon.selectRegion(dataDragon.region)
        XCTAssertNotNil(dataDragon.autoversion)
        XCTAssertNotNil(dataDragon.currentVersion)
        XCTAssertNotNil(dataDragon.currentLocale)
    }
    
    func testSelectLocaleOverridesManagedLocale() {
        let targetLocale = "pt_BR"
        executeSampleCall()
        dataDragon.selectLocale(targetLocale)
        XCTAssert(dataDragon.currentLocale != dataDragon.autoversion?.locale)
        verifyOverriddenCall(matching: targetLocale)
    }
    
    func testSelectVersionOverridesManagedVersion() {
        let targetVersion = "/1.0/"
        executeSampleCall()
        dataDragon.selectVersion(targetVersion)
        XCTAssert(dataDragon.currentVersion != dataDragon.autoversion?.version)
        verifyOverriddenCall(matching: targetVersion)
    }
}
