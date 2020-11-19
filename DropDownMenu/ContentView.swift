//
//  ContentView.swift
//  DropDownMenu
//
//  Created by Marcos Vicente on 18.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack {
            DropDownView(title: "Select a workspace",
                         menuActions: [.init(title: "Komitet", action: {}),
                                       .init(title: "iOS Developers", action: {}),
                                       .init(title: "Killers", action: {}),
                                       .init(title: "A Big workspace name", action: {})])
                .padding(100)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
