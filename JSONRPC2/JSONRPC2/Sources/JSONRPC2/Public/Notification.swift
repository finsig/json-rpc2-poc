//
//  Created by Steven Boynes on 2/11/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/**
 A Notification is a Request without an identifier.

 [JSON-RPC 2.0](https://www.jsonrpc.org/specification)
 
*/
public enum Notification {
    case request(Request)
}

public extension Notification {
    init(method: String, parameters: Request.Parameters?) {
        self = .request( Request(method: method, parameters: parameters, identifier: nil) )
    }
}

extension Notification: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(Request.self) {
            self = .request(value)
        }
        else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Failed to decode Request value.")
            throw DecodingError.typeMismatch(Notification.self, context)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .request(let value):
            try container.encode(value)
        }
    }
}
