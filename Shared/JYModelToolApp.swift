//
//  JYModelToolApp.swift
//  Shared
//
//  Created by black on 2021/9/6.
//

import SwiftUI

@main
struct JYModelToolApp: App {
    var body: some Scene {
        WindowGroup {
            ToolBar()
        }
    }
}

struct SideMenu: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

struct SideMenuView: View {
    let menus = [
        SideMenu(name: "Modelizable", icon: "filemenu.and.cursorarrow"),
        SideMenu(name: "Fast generate", icon: "hand.draw")
    ]
    var body: some View {
        List {
            NavigationLink(
                destination: ContentView()
                    .frame(minWidth: 500, minHeight: 400),
                isActive: .constant(true),
                label: {
                    HStack(content: {
                        Image(systemName: "filemenu.and.cursorarrow")
                        Text("Modelizable")
                    })
                })
            NavigationLink(
                destination: SimpleView(),
                label: {
                    HStack(content: {
                        Image(systemName: "hand.draw")
                        Text("Fast generate")
                    })
                })
        }
        .listStyle(SidebarListStyle())
    }
}

struct ToolBar: View {
    var body: some View {
        NavigationView(content: {
            SideMenuView()
                .frame(maxWidth: 300)
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSideBar, label: {
                    Image(systemName: "sidebar.left")
                })
            }
        })
    }
    func toggleSideBar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
