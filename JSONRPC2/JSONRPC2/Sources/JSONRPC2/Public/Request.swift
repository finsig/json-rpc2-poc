//
//  Created by Steven Boynes on 2/9/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/**
 A struct representing a Request.

 [JSON-RPC 2.0](https://www.jsonrpc.org/specification)
 
*/
public struct Request {
    let jsonRPCVersion: JSONRPCVersion = .jsonRPC2
    let method: String
    var parameters: Parameters?
    var identifier: Identifier?
}

public extension Request {
    #warning("fixme: synthesized default initializer is not public")
    init(method: String, parameters: Parameters? = nil, identifier: Identifier) {
        self.method = method
        self.parameters = parameters
        self.identifier = identifier
    }
}

extension Request: Codable {
    enum CodingKeys: String, CodingKey {
        case jsonRPCVersion = "jsonrpc"
        case method = "method"
        case params = "params"
        case identifier = "id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        method = try container.decode(String.self, forKey: .method)
        identifier = try container.decodeIfPresent(Identifier.self, forKey: .identifier)
        parameters = try container.decodeIfPresent(Request.Parameters.self, forKey: .params)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(jsonRPCVersion, forKey: .jsonRPCVersion)
        try container.encode(method, forKey: .method)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(parameters, forKey: .params)
    }
}
