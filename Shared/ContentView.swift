//
//  ContentView.swift
//  Shared
//
//  Created by black on 2021/9/6.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var parser = JYJsonParser()

    var body: some View {
        HStack(spacing: 10) {
            
            Group {
                ZStack {
                    TextView(input: $parser.input)
                        .padding(10)
                }
                ZStack {
                    TextView(input: $parser.output, isEditable: .constant(false))
                        .padding(10)
                }
            }
            .background(Color.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
