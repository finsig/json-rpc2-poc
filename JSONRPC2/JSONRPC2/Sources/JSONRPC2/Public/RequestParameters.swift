//
//  Created by Steven Boynes on 2/11/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation
import JSON

public extension Request {
    /**
     An enumeration of the values that can be used for the invocation of a Request Method.

     [JSON-RPC 2.0](https://www.jsonrpc.org/specification)

    */
    enum Parameters {
        case array(Array<JSON>)
        case dictionary(Dictionary<ParameterName,JSON>)
    }
}

public extension Request {
    typealias ParameterName = String
}

extension Request.Parameters: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Array<JSON>.self) {
            self = .array(value)
        }
        else if let value = try? container.decode(Dictionary<Request.ParameterName,JSON>.self) {
            self = .dictionary(value)
        }
        else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Failed to decode value.")
            throw DecodingError.typeMismatch(Request.Parameters.self, context)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .array(let value):
            try container.encode(value)
        case .dictionary(let value):
            try container.encode(value)
        }
    }
}
