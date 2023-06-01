//
//  Created by Steven Boynes on 2/9/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation
import JSON
import SwiftUI

/**
 A struct representing a JSON-RPC 2.0 Response.

 [JSON-RPC 2.0](https://www.jsonrpc.org/specification)
 
*/
public struct Response {
    internal let jsonRPCVersion: JSONRPCVersion
    public let result: Result<JSON, JSONRPC2Error>
    public let identifier: Identifier
}

extension Response: Decodable {
    enum CodingKeys: String, CodingKey {
        case jsonRPCVersion = "jsonrpc"
        case resultValue = "result"
        case error = "error"
        case identifier = "id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        jsonRPCVersion = try container.decode(JSONRPCVersion.self, forKey: .jsonRPCVersion)
        
        if container.contains(.resultValue) && container.contains(.error) {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Response contains result and error members.")
            throw DecodingError.dataCorrupted(context)
        }
        
        let json = try container.decodeIfPresent(JSON.self, forKey: .resultValue)
        let error = try container.decodeIfPresent(JSONRPC2Error.self, forKey: .error)
        
        guard let result = Result<JSON, JSONRPC2Error>(json, error) else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid response result.")
            throw DecodingError.dataCorrupted(context)
        }
        self.result = result
        
        identifier = try container.decode(Identifier.self, forKey: .identifier)

        guard (jsonRPCVersion == .jsonRPC2) else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid JSON-RPC version.")
            throw DecodingError.dataCorrupted(context)
        }
    }
}

fileprivate extension Result where Success == JSON, Failure == JSONRPC2Error {
    init?(_ json: JSON?, _ error: JSONRPC2Error?) {
        if let json = json {
            self = .success(json)
        }
        else if let error = error {
            self = .failure(error)
        }
        else {
            return nil
        }
    }
}
