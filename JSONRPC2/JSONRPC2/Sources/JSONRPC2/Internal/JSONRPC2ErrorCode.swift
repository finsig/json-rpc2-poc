//
//  Created by Steven Boynes on 2/13/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension JSONRPC2Error {
    /**
     A type alias for JSON-RPC 2.0 error code values.
     
     [JSON-RPC 2.0](https://www.jsonrpc.org/specification)
     
    */
    typealias Code = Int
}

extension JSONRPC2Error.Code {
    static let parseError = -32700
    static let invalidRequest = -32600
    static let methodNotFound = -32601
    static let invalidParams = -32602
    static let internalError = -32603
}

extension JSONRPC2Error {
    static let serverError = (-32099 ... -32000)
}
