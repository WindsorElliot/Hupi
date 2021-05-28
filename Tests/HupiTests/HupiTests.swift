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
            let expectationSearch = expectation(description: ".searchBridge")
            let ipToFind = "192.168.2.23"
            var bridgesFinded: [Bridge]? = nil
            var errorFinded: Error? = nil
            
            HueBridgeNetworkDiscover("testapp").retriveHueBridgeInNetwork { result in
                expectationSearch.fulfill()
                switch result {
                case .success(let bridges):
                    bridgesFinded = bridges
                case .failure(let error):
                    errorFinded = error
                }
            }
            
            wait(for: [expectationSearch], timeout: 2)
            XCTAssertNil(errorFinded)
            XCTAssertNotNil(bridgesFinded)
            
            guard let bridges = bridgesFinded else {
                XCTAssertTrue(false, "nil value for bridge")
                return
            }
            
            let findedBridge = bridges.first(where: { $0.internalIpAddress == ipToFind })
            
            XCTAssertNotNil(findedBridge)
        }
        
        func testConnectBridge() {
            let expectationConnect = expectation(description: ".connectBridge")
            var response: String?
            var errorFinded: Error?
            
            HueBridgeNetworkDiscover("testapp").connectHueBridge("192.168.2.23") { res in
                expectationConnect.fulfill()
                switch res {
                case .success(let data):
                    response = data
                case .failure(let error):
                    errorFinded = error
                }
            }
            
            wait(for: [expectationConnect], timeout: 2)
            
            XCTAssertNil(errorFinded)
            XCTAssertNotNil(response)
            
            guard let username = response else {
                XCTAssertTrue(false, "nil for username")
                return
            }
            
            XCTAssertEqual(username, "1234bridgeapp")
            
        }
    }
