import XCTest
@testable import Toast_Catalog

class MockNetworking: Networking {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return MockURLSessionDataTask()
    }
}
class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
    }
}
class NetworkClientTests: XCTestCase {
    var sut: NetworkClient!
    var mockNetworking: MockNetworking!
    
    override func setUp() {
        super.setUp()
        mockNetworking = MockNetworking()
        sut = NetworkClient(networking: mockNetworking)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworking = nil
        super.tearDown()
    }
    
    func testGetItemsSuccessReturnsItems() {
        let jsonString = """
            [
                {
                    "name": "Avocado Toast",
                    "price": "5.99",
                    "id": 1,
                    "currency": "EUR",
                    "last_sold": "2020-11-28T15:14:22Z"
                  }
            ]
            """
        mockNetworking.data = jsonString.data(using: .utf8)
        mockNetworking.response = HTTPURLResponse(url: URL(string: "https://my-json-server.typicode.com/sumup-challenges/mobile-coding-challenge-data/items/")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = self.expectation(description: "Completion handler invoked")
        var responseItems: [Item]?
        var responseError: Error?
        
        sut.getItems { result in
            switch result {
            case .success(let items):
                responseItems = items
            case .failure(let error):
                responseError = error
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(responseItems)
        XCTAssertNil(responseError)
        XCTAssertEqual(responseItems?.first?.id, 1)
        XCTAssertEqual(responseItems?.first?.name, "Avocado Toast")
    }
}
