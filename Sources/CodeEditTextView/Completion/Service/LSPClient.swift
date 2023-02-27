//
//  STTextViewController+Completion.swift
//
//
//  Created by MetaSky on 2023/2/24.
//

import Foundation
import LanguageClient
import LanguageServerProtocol
import ProcessEnv

class LSPClient {
    let server: InitializingServer
    
    init() {
        let fileURL = URL(fileURLWithPath: "/Users/metasky/ROOT/codes/company/cross/EditorSpace/DocDemo/demo.swift")
        let projectURL = fileURL.deletingLastPathComponent()
        server = LSPClient.createServer(from: projectURL)
    }
    
    static func createServer(from projectURL: URL) -> InitializingServer {
        let userEnv = ProcessInfo.processInfo.userEnvironment
        print("the user environment = \(userEnv)")

        let executionParams = Process.ExecutionParameters(
            path: "/Users/metasky/.swiftenv/shims/sourcekit-lsp",
            arguments: ["--help"],
            environment: [:],
            currentDirectoryURL: nil
        )

        let localServer = LocalProcessServer(executionParameters: executionParams)

        let config = InitializingServer.Configuration(initializeParamsProvider: {
            // you may need to fill in more of the textDocument field for completions
            // to work, depending on your server
            let capabilities = ClientCapabilities(workspace: nil,
                                                  textDocument: nil,
                                                  window: nil,
                                                  general: nil,
                                                  experimental: nil)
           
            // pay careful attention to rootPath/rootURI/workspaceFolders, as different servers will
            // have different expectations/requirements here
           
            return InitializeParams(processId: Int(ProcessInfo.processInfo.processIdentifier),
                                    locale: nil,
                                    rootPath: nil,
                                    rootUri: projectURL.absoluteString,
                                    initializationOptions: nil,
                                    capabilities: capabilities,
                                    trace: nil,
                                    workspaceFolders: nil)
        })
        let server = InitializingServer(server: localServer, configuration: config)
        return server
    }
    
    func getCompletions() {
        let docURL = URL(fileURLWithPath: "/Users/metasky/ROOT/codes/company/cross/EditorSpace/DocDemo/demo.swift")
//        let projectURL = docURL.deletingLastPathComponent()

        Task {
            let docContent = try String(contentsOf: docURL)

            let doc = TextDocumentItem(uri: docURL.absoluteString,
                                       languageId: .swift,
                                       version: 1,
                                       text: docContent)
            let docParams = DidOpenTextDocumentParams(textDocument: doc)

            try await server.didOpenTextDocument(params: docParams)

            // make sure to pick a reasonable position within your test document
            let pos = Position(line: 5, character: 2)
            let completionParams = CompletionParams(uri: docURL.absoluteString,
                                                    position: pos,
                                                    triggerKind: .invoked,
                                                    triggerCharacter: nil)
            if let completions = try await server.completion(params: completionParams) {
                print("completions: ", completions.items)
            }
        }
    }
}

