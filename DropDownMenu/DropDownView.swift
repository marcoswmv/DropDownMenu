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
    
    static func == (lhs: DropDownAction, rhs: DropDownAction) -> Bool {
        return lhs.title == rhs.title
    }
    
    func select() {
//        Select channel
        print("Selecting")
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
    var selectMenuItem: (DropDownAction) -> ()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Group{
                HStack {
                    Image("add-user")
                        .foregroundColor(.blue)
                    Button("Invite members") { }
                        .font(.system(size: 14))
                }
                
                HStack {
                    Image("manage")
                        .foregroundColor(.blue)
                    Button("Manage workspace") { }
                        .font(.system(size: 14))
                }
            }
            
            Divider()
                .padding(.leading, 26)
            
            ForEach(menuActions, id: \.id) { action in
                
                HStack {
                    DropDownButton(selectionKeeper: $selectionKeeper, actionModel: action, select: selectMenuItem)
                }
                .onTapGesture {
                    selectionKeeper = action.id
                }
            }
            
            Divider()
                .padding(.leading, 26)
            
            HStack {
                Image("new-workspace")
                    .foregroundColor(.blue)
                Button(" New workspace") { }
                    .font(.system(size: 14))
            }
        }
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
        HStack {
            Button(action: action, label: {
                HStack {
                    Image("avatar")
                    
                    Text(title + " ")
                        .foregroundColor(.black)
                    
                    Image(systemName: "chevron.\(expand ? "up" : "down")")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10)
                        .foregroundColor(.blue)
                }
                .padding(10)
            })
    //        .font(.system(size: 14))
    //        .frame(width: 140, alignment: .center)
            
            .background(Color(.white))
            .cornerRadius(10)
            .shadow(radius: 7)
            
//            Spacer(minLength: 100)
//                .frame(maxWidth: .infinity)
        }
    }
}

struct DropDownView: View {
    
    @State var selectionKeeper: UUID?
    @State var expand: Bool = false
    @State var title: String
    
    var menuActions: [DropDownAction]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Spacer(minLength: expand ? 250 : 0)
            DropDownHeader(title: title,
                           action: { self.expand.toggle() },
                           expand: expand)
            
//            if expand {
//                DropDownMenu(selectionKeeper: $selectionKeeper, menuActions: menuActions) { action in
//                    action.select()
//                    $title.wrappedValue = action.title
//                    self.selectionKeeper = action.id
//                    self.expand = false
//                }
//            }
        }
//        NOTE: Uncomment below line to add animation
//        .animation(.easeInOut)
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(title: "Select a workspace",
                     menuActions: [.init(title: "Komitet"),
                                   .init(title: "iOS Developers"),
                                   .init(title: "Killers"),
                                   .init(title: "A Big workspace name")])
    }
}
