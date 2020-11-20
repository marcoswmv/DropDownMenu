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
                                         .init(title: "A Big workspace name")]
    
    var body: some View {
        NavigationView {
            ZStack {
                List(0 ..< 10) { _ in
                    Text("Test")
                }
                if expand {
                    VStack(alignment: .leading) {
                        DropDownMenu(selectionKeeper: $selectionKeeper, menuActions: menuActions) { action in
                            action.select()
                            $title.wrappedValue = action.title
                            self.selectionKeeper = action.id
                            self.expand = false
                        }
                        .offset(x: -78,y: -255)
                    }
                }
            }
//            .navigationBarItems(leading: DropDownHeader(title: title,
//                                                         action: { self.expand.toggle() },
//                                                         expand: expand),
//                                trailing: Spacer(minLength: 260))
            .navigationBarItems(leading:
                                    HStack {
//                                        VStack(alignment: .leading) {
                                            DropDownHeader(title: title,
                                                           action: { self.expand.toggle() },
                                                           expand: expand)
                                                .padding(.leading, -5)
//                                        }
//                                        Spacer(minLength: 120)
//                                            .frame(maxWidth: .infinity)
                                    }
//                                        VStack {
//                                            DropDownView(title: title,
//                                                         menuActions: menuActions)
//                                                .padding(.vertical, 100)
//                                        }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
