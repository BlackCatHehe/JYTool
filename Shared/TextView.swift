//
//  TextView.swift
//  JYModelTool
//
//  Created by black on 2021/9/6.
//

import Foundation
import SwiftUI
struct TextView: NSViewRepresentable {
    typealias NSViewType = NSTextView
    
    @Binding var input: String
    @Binding var isEditable: Bool
    @Binding var isFirstResponser: Bool
    init(input: Binding<String>, isEditable: Binding<Bool> = .constant(true), isFirstResponser: Binding<Bool>) {
        _input = input
        _isEditable = isEditable
        _isFirstResponser = isFirstResponser
    }

    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView(frame: .zero)
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 20, weight: .medium)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.isEditable = isEditable
        if nsView.string == input {return}
        nsView.string = input
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    
    class Coordinator: NSObject, NSTextViewDelegate {
        let parent: TextView
        init(parent: TextView) {
            self.parent = parent
            super.init()
        }
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            parent.input = textView.string
        }
    }
}
