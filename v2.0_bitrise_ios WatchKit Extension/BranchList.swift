//
//  BranchList.swift
//  v2.0_bitrise_ios WatchKit Extension
//
//  Created by Alperen Duran on 21.07.2020.
//

import SwiftUI

struct BranchList: View {
    let app: Application
    @ObservedObject var store = TriggerBuildStore()
    var body: some View {
        ScrollView {
            ForEach(store.branches, id: \.self) { branch in
                NavigationLink(destination: WorkflowList(
                    app: app,
                    store: store,
                    branch: branch
                )) {
                    Text(branch)
                }
            }
        }.onAppear {
            store.getBranches(slug: app.id)
            store.getWorkflows(slug: app.id)
        }
//        .navigationTitle("Select Branch")
    }
}

struct WorkflowList: View {
    let app: Application
    var store: TriggerBuildStore
    let branch: String
    var body: some View {
        ScrollView {
            ForEach(store.workflows, id: \.self) { workflow in
                NavigationLink(
                    destination: BuildSummaryView(
                        app: app,
                        branch: branch,
                        workflow: workflow,
                        store: store
                    )) {
                    Text(workflow)
                }
            }
        }
//        .navigationTitle("Select Workflow")
    }
}

struct BuildSummaryView: View {
    let app: Application
    let branch: String
    let workflow: String
    let store: TriggerBuildStore
    @State var isPresented = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10.0) {
                Text("Branch\n\(branch)")
                Text("Workflow\n\(workflow)")
                Button(action: {
                        store.triggerBuild(
                            slug: app.id,
                            branch: branch,
                            workflow: workflow,
                            message: ""
                        )
                    isPresented = true
                }) {
                    Text("Start Build")
                }
            }.alert(isPresented: $isPresented) {
                Alert(title: Text("Success"), message: Text("Build has been created successfully!"))
            }
        }
    }
}
