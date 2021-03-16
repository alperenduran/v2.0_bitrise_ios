//
//  Builds.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 20.07.2020.
//

import SwiftUI

struct Builds: View {
    @ObservedObject var store = ApplicationDetailStore()
    let app: Application
    @State var isPresented = false
    var body: some View {
        List(store.builds) { build in
            BuildCard(application: app, build: build)
        }.navigationTitle("Builds")
        .onAppear {
            store.fetchApplications(slug: app.id) { resp in
                DispatchQueue.main.async {
                    if case .success(let builds) = resp {
                        store.builds = builds
                    } else if case .failure(let error) = resp {
                        store.errorMessage = error.localizedDescription
                        store.showError = true
                    }
                }
            }
        }
        .navigationBarItems(trailing: Button(action:{
            isPresented = true
        }) {
            Image(systemName: "plus")
                .font(.title)
        })
        .sheet(isPresented: $isPresented) {
            TriggerBuildForm(app: app, isPresented: $isPresented)
        }
    }
    
    init(app: Application) {
        self.app = app
    }
}
