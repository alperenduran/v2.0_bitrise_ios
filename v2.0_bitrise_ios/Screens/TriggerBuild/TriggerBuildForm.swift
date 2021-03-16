//
//  TriggerBuildForm.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 20.07.2020.
//

import SwiftUI

struct TriggerBuildForm: View {
    let app: Application
    @State var branch = ""
    @State var workflow = ""
    @State var message = ""
    @ObservedObject var store = TriggerBuildStore()
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    Picker("Branch", selection: $branch) {
                        ForEach(store.branches, id: \.self) { branch in
                            Text(branch)
                        }
                    }
                    
                    Picker("Workflow", selection: $workflow) {
                        ForEach(store.workflows, id: \.self) { workflow in
                            Text(workflow)
                        }
                    }
                    
                    TextField("Message", text: $message)
                }
                
                Section {
                    Button(action: {
                        store.triggerBuild(
                            slug: app.id,
                            branch: branch,
                            workflow: workflow,
                            message: message
                        )
                        isPresented = false
                    }) {
                        Text("Start New Build")
                    }
                }
            }.navigationBarTitle("New Build", displayMode: .inline)
            .onAppear {
                store.getBranches(slug: app.id)
                store.getWorkflows(slug: app.id)
            }
            .navigationBarItems(
                leading: Button(action: {
                                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                }
            )
        }
    }
}
