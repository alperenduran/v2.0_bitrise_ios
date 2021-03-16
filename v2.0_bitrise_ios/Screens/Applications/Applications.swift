//
//  Applications.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 9.07.2020.
//

import SwiftUI
import KingfisherSwiftUI

struct Applications: View {
    @ObservedObject var store = ApplicationStore()
    private var columns = [
        GridItem(.flexible()), GridItem(.flexible())
    ]
    @State var showTokenPage = false
    @State var reason: Reason = .change
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(store.applications) { app in
                            NavigationLink(destination: Builds(app: app)) {
                                AppCell(app: app)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Applications")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        reason = .change
                        showTokenPage.toggle()
                    }
                ) {
                    Text("Change Token")
                }
            )
            .sheet(isPresented: $showTokenPage, onDismiss: { store.refresh() }) {
                AddTokenView(reason: $reason, isPresented: $showTokenPage)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            let token = getToken()
            if token.isEmpty {
                reason = .add
                showTokenPage.toggle()
            } else {
                store.refresh()
            }
        }
    }
}

struct Applications_Previews: PreviewProvider {
    static var previews: some View {
        Applications()
    }
}

struct AppCell: View {
    let app: Application
    var body: some View {
        VStack {
            ImageView(url: app.url)
                .frame(width: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            Text(app.title)
        }
    }
}
