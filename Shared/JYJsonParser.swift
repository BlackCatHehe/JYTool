//
//  JYJsonParser.swift
//  JYModelTool
//
//  Created by black on 2021/9/6.
//

import Foundation
import Combine
import SwiftyJSON
class JYJsonParser: NSObject, ObservableObject {
    @Published var input: String = ""
    @Published var output: [String] = []
    @Published var result: ParseResult?

    struct ParseResult {
        let isSuccess: Bool
        let message: String?
    }
    
    var cancellable: [AnyCancellable] = []
    
    
    override init() {
        super.init()
        setupObservable()
    }
}

extension JYJsonParser {
    private func setupObservable() {
        $input
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { input in
                if input.isEmpty {return}
                self.parse(input)
            }
            .store(in: &cancellable)
        
    }
}

extension JYJsonParser {
    private func parse(_ string: String) {
        guard let data = string.data(using: .utf8), let json = JSON(rawValue: data) else {
            print("parse failed: json格式错误")
            return
        }
        output = generateVariables(name: "NLTestModel", json: json)
    }
    
    func format() {
        guard let data = input.data(using: .utf8), let json = JSON(rawValue: data) else {
            print("parse failed: json格式错误")
            
            return
        }
        if let result = json.rawString(.utf8, options: .prettyPrinted) {
            print(result)
            input = result
        }
    }
    
    @discardableResult
    private func generateVariables(name: String, json: JSON) -> [String] {
        var results: [String] = []
        let resultTop = "struct \(name) {\n "
        let content = json.reduce("") { result, next in
            var type = ""
            var name = next.0
            
            let value = next.1.object
            if value is Int {
                type = "Int = 0"
            } else if value is Double {
                type = "Double = 0.0"
            } else if value is String {
                type = "String = \"\""
            } else if value is Bool {
                type = "Bool = false"
            } else {
                
                let modelName = "NL\(name.camelized(lower: false))Model"
                if let _ = next.1.array {
                    type = "[\(modelName)] = []"
                    if let first = next.1.array?.first {
                        let subResults = generateVariables(name: modelName, json: first)
                        results.append(contentsOf: subResults)
                    }
                } else {
                    type = "\(modelName) = .init()"
                    let subResults = generateVariables(name: modelName, json: next.1)
                    results.append(contentsOf: subResults)
                }
                
            }
            if name == "description" || name == "default" {
                name += "Field"
            }
            type = result.appending("   var \(name): \(type)\n")
            return type
        }
        let initStr = "\ninit() {}"
        let mapInitStrTop = "\ninit(json: JSON) {\n"
        let mapContent = json.reduce("") { result, next in
            var type = ""
            var name = next.0
            
            let value = next.1.object
            if value is Int {
                type = "json[\"\(name)\"].int ?? 0"
            } else if value is Double {
                type = "json[\"\(name)\"].double ?? 0.0"
            } else if value is String {
                type = "json[\"\(name)\"].string ?? \"\""
            } else if value is Bool {
                type = "json[\"\(name)\"].bool ?? false"
            } else {
                let modelName = "NL\(name.camelized(lower: false))Model"
                if let _ = next.1.array {
                    type = "(json[\"\(name)\"].array ?? []).map{\(modelName)(json: $0)}"
                } else {
                    type = "\(modelName)(json: json[\"\(name)\"])"
                }
            }
            if name == "description" || name == "default" {
                name += "Field"
            }
            type = result.appending("   \(name) = \(type)\n")
            return type
        }
        
        let result = resultTop + content + initStr + mapInitStrTop + mapContent + "}\n}\n\n"
        results.append(result)
        return results
    }
}

extension String {
    func camelized(lower: Bool = true) -> String {
        guard self != "" else { return self }
        
        let words = lowercased().split(separator: "_").map({ String($0) })
        let firstWord: String = words.first ?? ""
        
        let camel: String = lower ? firstWord : String(firstWord.prefix(1).capitalized) + String(firstWord.suffix(from: index(after: startIndex)))
        return words.dropFirst().reduce(into: camel, { camel, word in
            camel.append(String(word.prefix(1).capitalized) + String(word.suffix(from: index(after: startIndex))))
        })
    }
}
