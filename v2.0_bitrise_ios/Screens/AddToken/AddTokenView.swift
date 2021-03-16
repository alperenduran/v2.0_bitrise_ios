//
//  AddTokenView.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 9.07.2020.
//

import SwiftUI

struct AddTokenView: View {
    @State var token = ""
    @Binding var reason: Reason
    @State var alert = false
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Token")) {
                    TextField(
                        "Paste your token here",
                        text: $token
                    )
                }
                Section {
                    Button(action: {
                        saveToken(token)
                        alert.toggle()
                        
                    }) {
                        Text(getNavBarTitle(reason))
                            .foregroundColor(Color("appPurpleColor"))
                    }
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                }
            )
            .alert(isPresented: $alert) {
                return Alert(
                    title: Text("Success"),
                    message: Text("Token has been saved successfully!"),
                    dismissButton: .destructive(Text("OK"), action: { isPresented = false })
                )
                
            }
            .navigationBarTitle(
                getNavBarTitle(reason)
            )
        }
    }
}

private func getNavBarTitle(
    _ reason: Reason
) -> String {
    if reason == .add {
        return "Add Token"
    } else {
        return "Change Token"
    }
}

enum Reason {
    case add
    case change
}

struct AddTokenView_Previews: PreviewProvider {
    static var previews: some View {
        AddTokenView(
            token: "",
            reason: .constant(.add),
            isPresented: .constant(false)
        )
    }
}
