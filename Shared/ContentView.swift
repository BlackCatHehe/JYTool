//
//  ContentView.swift
//  Shared
//
//  Created by black on 2021/9/6.
//

import SwiftUI
import AppKit
struct ContentView: View {
    @ObservedObject var parser = JYJsonParser()
    
    var body: some View {
        HStack(spacing: 10) {
            Group {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                    TextView(input: $parser.input, isFirstResponser: .constant(true))
                    if !parser.input.isEmpty {
                        Button(action: {
                            parser.format()
                        }, label: {
                            Image(systemName: "doc.plaintext.fill")
                        })
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                    }
                })
                
                
                ScrollView {
                    VStack {
                        ForEach(parser.output, id: \.self) { output in
                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                                Text(output)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(5)
                                
                                Button(action: {
                                    NSPasteboard.general.setString(output, forType: .string)
                                }, label: {
                                    Image(systemName: "doc.on.doc.fill")
                                })
                                .padding(.trailing, 20)
                                .padding(.top, 10)
                            })
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
