    import XCTest
    @testable import Hupi

    final class HupiTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            XCTAssertEqual(Hupi().text, "Hello, World!")
        }
        
        func testSearchBridgeEndpoint() {
            let expectation = expectation(description: ".searchBridge")
            let ipToFind = "192.168.2.23"
            var bridgesFinded: [Bridge]? = nil
            var errorFinded: Error? = nil
            
            HueHubNetworkDiscover("testapp").retriveHueBridgeInNetwork { result in
                expectation.fulfill()
                switch result {
                case .success(let bridges):
                    bridgesFinded = bridges
                case .failure(let error):
                    errorFinded = error
                }
            }
            
            wait(for: [expectation], timeout: 2)
            XCTAssertNil(errorFinded)
            XCTAssertNotNil(bridgesFinded)
            
            guard let bridges = bridgesFinded else {
                XCTAssertTrue(false, "nil value for bridge")
                return
            }
            
            let findedBridge = bridges.first(where: { $0.internalIpAddress == ipToFind })
            
            XCTAssertNotNil(findedBridge)
        }
    }
