//
//  DropDownView.swift
//  DropDownMenu
//
//  Created by Marcos Vicente on 18.11.2020.
//

import SwiftUI

struct DropDownAction: Equatable, Identifiable {
    
    var id: UUID? = UUID()
    var title: String
    var action: () -> () = {
        print("An action was called")
    }
    
    static func == (lhs: DropDownAction, rhs: DropDownAction) -> Bool {
        return lhs.title == rhs.title && lhs.action() == rhs.action()
    }
}

struct DropDownButton: View {
    
    @Binding var selectionKeeper: UUID?
    
    var actionModel: DropDownAction
    var select: (DropDownAction) -> ()
    
    var body: some View {
        HStack {
            Image("avatar")
            
            Button(actionModel.title) {
                self.select(self.actionModel)
            }
            .foregroundColor(selectionKeeper == actionModel.id ? .blue : .black)
            .font(.system(size: 14))
            
            Spacer()
            
            if selectionKeeper == actionModel.id {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.select(self.actionModel)
        }
    }
}

struct DropDownMenu: View {
    
    @Binding var selectionKeeper: UUID?
    
    var menuActions: [DropDownAction]
    var select: (DropDownAction) -> ()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Group{
                HStack {
                    Image("add-user")
                        .foregroundColor(.blue)
//                        .font(.system(size: 16))
                    Button("Invite members") { }
                        .font(.system(size: 14))
                }
                
                HStack {
                    Image("manage")
                        .foregroundColor(.blue)
//                        .font(.system(size: 16))
                    Button("Manage workspace") { }
                        .font(.system(size: 14))
                }
            }
            
            Divider()
                .padding(.leading, 26)
            
            ForEach(menuActions, id: \.id) { action in
                
                HStack {
                    DropDownButton(selectionKeeper: $selectionKeeper, actionModel: action, select: select)
                }
                .onTapGesture {
                    print("Selecting button")
                    selectionKeeper = action.id
                }
            }
            
            Divider()
                .padding(.leading, 26)
            
            HStack {
                Image("new-workspace")
                    .foregroundColor(.blue)
//                    .font(.system(size: 16))
                Button(" New workspace") { }
                    .font(.system(size: 14))
            }
        }
//        .fixedSize(horizontal: true, vertical: true)
        .frame(width: 180, alignment: .center)
        .foregroundColor(.black)
        .padding(10)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
        .shadow(radius: 7)
    }
}

struct DropDownHeader: View {
    
    var title: String
    var action: () -> ()
    var expand: Bool
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Image("avatar")
                
                Text(title + " ")
                
                Image(systemName: "chevron.\(expand ? "up" : "down")")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10)
                    .foregroundColor(.blue)
            }
            .padding(10)
        })
        .font(.system(size: 14))
        .frame(width: 150, alignment: .center)
        .foregroundColor(.black)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
        .shadow(radius: 7)
    }
}

struct DropDownView: View {
    
    @State var selectionKeeper: UUID?
    @State var expand: Bool = false
    @State var title: String
    
    var menuActions: [DropDownAction]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            DropDownHeader(title: title,
                           action: { self.expand.toggle() },
                           expand: expand)
            
            if expand {
                DropDownMenu(selectionKeeper: $selectionKeeper, menuActions: menuActions) { action in
                    action.action()
                    $title.wrappedValue = action.title
                    self.selectionKeeper = action.id
                    self.expand = false
                }
            }
        }
//        .animation(.easeInOut)
    }
}
