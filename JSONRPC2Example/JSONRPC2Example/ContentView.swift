//
//  Created by Steven Boynes on 2/11/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//


import JSONRPC2
import SwiftUI

struct ContentView: View {
    
    fileprivate var url: URL
    fileprivate var task: URLSessionWebSocketTask
    
    init() {
        url = URL(string: "wss://rpc.polkadot.io")!
        task = URLSession.shared.webSocketTask(with: url)
    }
    
    var body: some View {
        Button(action: {
            let request = Request(method: "rpc_methods", parameters: nil, identifier: Identifier(Int.zero) )

            let json = try! JSONEncoder().encode(request)
            let jsonString = String(data: json, encoding: .utf8)!
            
            let message = URLSessionWebSocketTask.Message.string(jsonString)
            
            task.send(message, completionHandler: { (error) in
                if let error = error {
                    logger.fault("received:\n \(error.localizedDescription)")
                    return
                }
                print("sent:\n \(message)")
            })
            task.resume()
            task.receive(completionHandler: {(result) in
                print("received:\n \(result)")
            })
            
        }, label: {
            Text(verbatim: "Send Request")
        })
            .padding()
    }
}
