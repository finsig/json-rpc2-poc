//
//  Created by Steven Boynes on 2/9/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import JSONRPC2

class ResponseTests: XCTestCase {
    
    func testJSONRPCVersionEqualsTwo() throws {
        let response = try! JSONDecoder().decode(Response.self, from: .jsonRPC2)
        
        XCTAssertEqual( response.jsonRPCVersion, JSONRPCVersion.jsonRPC2 )
    }
    
    func testJSONRPCVersionEqualsOne() throws {
        XCTAssertThrowsError( try JSONDecoder().decode(Response.self, from: .jsonRPC1) )
    }
    
    func testJSONRPCVersionIsMissing() throws {
        XCTAssertThrowsError( try JSONDecoder().decode(Response.self, from: .jsonRPCVersionMissing) )
    }
    
    func testSuccess() throws {
        let response = try! JSONDecoder().decode(Response.self, from: .result)
        
        switch response.result {
        case .success(_):
            XCTAssertTrue(true)
        case .failure(_):
            XCTAssertFalse(true)
        }
    }
    
    func testFailure() throws {
        let response = try! JSONDecoder().decode(Response.self, from: .error)
        
        switch response.result {
        case .success(_):
            XCTAssertFalse(true)
        case .failure(_):
            XCTAssertTrue(true)
        }
    }
    
    func testResultAndError() throws {
        XCTAssertThrowsError( try JSONDecoder().decode(Response.self, from: .resultAndError) )
    }
}

fileprivate extension Data {
    static var jsonRPC1 = """
        {"jsonrpc": "1.0", "result": 19, "id": 1}
    """.data(using: .utf8)!

    static var jsonRPC2 = """
        {"jsonrpc": "2.0", "result": 19, "id": 1}
    """.data(using: .utf8)!

    static var jsonRPCVersionMissing = """
        {"result": 19, "id": 1}
    """.data(using: .utf8)!
    
    static var result = """
        {"jsonrpc": "2.0", "result": -19, "id": 2}
    """.data(using: .utf8)!
    
    static var error = """
        {"jsonrpc": "2.0", "error": {"code": -32601, "message": "Method not found"}, "id": "1"}
    """.data(using: .utf8)!
    
    static var resultAndError = """
        {"jsonrpc": "2.0", "result": -19, "error": {"code": -32601, "message": "Method not found"}, "id": "1"}
    """.data(using: .utf8)!
}
