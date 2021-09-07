//
//  Simples.swift
//  JYModelTool
//
//  Created by black on 2021/9/7.
//

import Foundation
import SwiftUI

enum SimpleViewType: Int, CaseIterable {
    case tile
    case naviBar
    case normalHeader
}
extension SimpleViewType {
    var title: String {
        switch self {
        case .tile: return "Tile"
        case .naviBar: return "NaviBar"
        case .normalHeader: return "NormalHeader"
        }
    }
    var content: AnyView {
        return AnyView(Text(title))
    }
}
class Simples: ObservableObject {
    @Published var simples: [SimpleViewType] = SimpleViewType.allCases
    @Published var currentSelectedIndex: SimpleViewType = .tile
    
    
}

#if ios
import UIKit
class TempView: UIView {
    
    
}
#endif
