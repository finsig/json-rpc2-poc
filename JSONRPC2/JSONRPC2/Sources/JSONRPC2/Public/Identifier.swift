//
//  Created by Steven Boynes on 2/9/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/**
 An enumeration of value types for identifiers.
 
 - [JSON-RPC 2.0](https://www.jsonrpc.org/specification)

 */
public enum Identifier {
    case string(String)
    case int(Int)
    case nsNull(NSNull)
}

extension Identifier {
    public var value: Any {
        switch self {
        case .string(let value):
            return value
        case .int(let value):
            return value
        case .nsNull(_):
            return NSNull()
        }
    }
}

extension Identifier {
    public init(_ value: String) {
        self = .string(value)
    }
    
    public init(_ value: Int) {
        self = .int(value)
    }
    
    public init(_ value: NSNull) {
        self = .nsNull(value)
    }
}

extension Identifier: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(String.self) {
            self = .string(value)
        }
        else if let value = try? container.decode(Int.self) {
            self = .int(value)
        }
        else {
            self = .nsNull(NSNull())
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .nsNull(_):
            try container.encodeNil()
        }
    }
}

extension Identifier: CustomStringConvertible {
    public var description: String {
        switch self {
        case .string(let value):
            return value
        case .int(let value):
            return String(value)
        case .nsNull(_):
            return String("NSNULL")
        }
    }
}
