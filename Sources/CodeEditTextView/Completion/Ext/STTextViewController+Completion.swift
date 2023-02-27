//
//  STTextViewController+Completion.swift
//  
//
//  Created by MetaSky on 2023/2/24.
//

import AppKit
import STTextView

extension STTextViewController {
    public func textView(_ textView: STTextView, completionItemsAtLocation location: NSTextLocation) -> [Any]? {
        lspClient.getCompletions()
        let tempCompletions = [
            STCompletion.Item(id: UUID().uuidString, label: "One", insertText: "one"),
            STCompletion.Item(id: UUID().uuidString, label: "Two", insertText: "two"),
            STCompletion.Item(id: UUID().uuidString, label: "Three", insertText: "three")
        ]
        return tempCompletions
    }
}
