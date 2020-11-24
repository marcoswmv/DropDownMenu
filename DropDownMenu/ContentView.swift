//
//  ContentView.swift
//  DropDownMenu
//
//  Created by Marcos Vicente on 18.11.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectionKeeper: UUID?
    @State var expand: Bool = false
    @State var title: String = "Select a workspace"
    
    var menuActions: [DropDownAction] = [.init(title: "Komitet"),
                                         .init(title: "iOS Developers"),
                                         .init(title: "Killers"),
                                         .init(title: "Killers"),
                                         .init(title: "A Big workspace name")]
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack(alignment: .topLeading) {
                    List(0 ..< 10) { _ in
                        Text("Test")
                    }
                    if expand {
                            DropDownMenu(selectionKeeper: $selectionKeeper, menuActions: menuActions) { action in
                                action.select()
                                $title.wrappedValue = action.title
                                self.selectionKeeper = action.id
                                self.expand = false
                            }
                            .padding([.top, .leading], 8)
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading:
                                        HStack {
                                            DropDownHeader(title: title,
                                                           action: { self.expand.toggle() },
                                                           expand: expand)
                                                .frame(minWidth: 240, alignment: .leading)
                                        }
                                    , trailing:
                                        Button("Test") { print("I'm just being tested") }
                    )
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12")
            ContentView()
                .previewDevice("iPhone SE (1st generation)")
        }
    }
}
