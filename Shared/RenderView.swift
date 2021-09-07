//
//  RenderView.swift
//  JYModelTool
//
//  Created by black on 2021/9/7.
//

import SwiftUI

struct RenderView: View {
    let content: AnyView
    init(content: AnyView) {
        self.content = content
    }
    var body: some View {
        content
    }
}

struct RenderView_Previews: PreviewProvider {
    static var previews: some View {
        RenderView(content: AnyView(Text("hello")))
    }
}
