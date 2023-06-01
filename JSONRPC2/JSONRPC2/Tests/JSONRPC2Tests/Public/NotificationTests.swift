//
//  Created by Steven Boynes on 2/11/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import JSONRPC2

class NotificationTests: XCTestCase {
    
    func testEqualsRequestWithoutIdentifier() throws {
        let method = "method"
        let parameters: Request.Parameters? = nil
        
        let notification = Notification(method: method, parameters: parameters)
        let request = Request(method: method, parameters: parameters, identifier: nil)
        
        XCTAssertEqual( try! JSONEncoder().encode(notification), try! JSONEncoder().encode(request) )
    }
}
