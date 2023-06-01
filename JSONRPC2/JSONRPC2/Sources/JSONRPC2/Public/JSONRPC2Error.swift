//
//  Created by Steven Boynes on 2/12/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation
import JSON

/**
 A struct representing an error.

 [JSON-RPC 2.0](https://www.jsonrpc.org/specification)
 
*/
public struct JSONRPC2Error: Error {
    let code: Int
    let message: String
    let errorInfo: JSON?
}

extension JSONRPC2Error: Codable {
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
        case errorInfo = "data"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        errorInfo = try container.decodeIfPresent(JSON.self, forKey: .errorInfo)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code, forKey: .code)
        try container.encode(message, forKey: .message)
        try container.encodeIfPresent(errorInfo, forKey: .errorInfo)
    }
}

extension JSONRPC2Error: CustomStringConvertible {
    public var description: String {
        return "[code: \(code), message: \(message), errorInfo: \(String(describing: errorInfo))]"
    }
}
