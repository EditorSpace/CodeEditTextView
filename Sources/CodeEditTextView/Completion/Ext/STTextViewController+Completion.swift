//
//  STTextViewController+Completion.swift
//  
//
//  Created by MetaSky on 2023/2/24.
//

import AppKit
import STTextView
import LanguageClient

// 1. initialize the language client

extension STTextViewController {
    public func createDefaultLspClient() {
        
    }
    
    public func textView(_ textView: STTextView, completionItemsAtLocation location: NSTextLocation) -> [Any]? {
        [
            STCompletion.Item(id: UUID().uuidString, label: "One", insertText: "one"),
            STCompletion.Item(id: UUID().uuidString, label: "Two", insertText: "two"),
            STCompletion.Item(id: UUID().uuidString, label: "Three", insertText: "three")
        ]
    }
}
