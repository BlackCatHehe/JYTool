//
//  SimpleView.swift
//  JYModelTool
//
//  Created by black on 2021/9/7.
//

import SwiftUI

struct SimpleView: View {
    @ObservedObject var simples = Simples()
    
    let scale: CGFloat = 0.7
    var body: some View {
        GeometryReader(content: { geometry in
            HStack {
                RenderView(content: simples.currentSelectedIndex.content)
                    .frame(width: geometry.size.width * scale)
                    .frame(maxHeight: .infinity)
                
                ScrollView{
                    VStack(spacing: 10) {
                        ForEach(simples.simples, id: \.rawValue) { simple in
                            Text(simple.title)
                                .foregroundColor(simple == simples.currentSelectedIndex ? .white : .primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .border(Color.black, width: 3)
                                .cornerRadius(5)
                                .background(simple == simples.currentSelectedIndex ? Color.blue : .gray)
                                .onTapGesture {
                                    simples.currentSelectedIndex = simple
                                }
                        }
                    }
                }
                .frame(width: geometry.size.width * (1 - scale))
                .frame(maxHeight: .infinity)
                .background(Color.white)
            }
        })
    }
}

struct SimpleView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleView()
    }
}
