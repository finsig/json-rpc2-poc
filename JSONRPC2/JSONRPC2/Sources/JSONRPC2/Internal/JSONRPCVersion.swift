//
//  Created by Steven Boynes on 2/10/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/**
 A String type alias for specifying the version of the JSON-RPC protocol.

 JSON-RPC 2.0 Request objects and Response objects **MAY NOT WORK** with existing JSON-RPC 1.0 clients or servers.
 
 [JSON-RPC 2.0](https://www.jsonrpc.org/specification)
 
*/
internal typealias JSONRPCVersion = String

extension JSONRPCVersion {
    static let jsonRPC2 = "2.0"
}
