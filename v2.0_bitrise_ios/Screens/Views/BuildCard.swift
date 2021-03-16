//
//  BuildCard.swift
//  Bitrise
//
//  Created by Alperen Duran on 16.11.2019.
//  Copyright © 2019 Alperen Duran. All rights reserved.
//

import SwiftUI

struct BuildCard: View {
    let application: Application
    let build: Build
    @State var show = false
    var body: some View {
        HStack {
            BuildStatusView(label: build.statusLabel, color: build.statusColor)
                
            VStack(alignment: .leading) {
                BuildNameLabel(application: application)
                    .padding(.top)
                VStack {
                    HStack {
                        BranchLabel(branchName: build.branch)
                            .layoutPriority(1000)
                        Spacer()
                        BuildNumberLabel(buildNumber: build.buildNumber)
                    }
                    HStack {
                        WorkflowLabel(workflow: build.workflow)
                            .layoutPriority(1000)
                        Spacer()
                        BuildStartTimeLabel(time: build.startTime)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(build.statusColor, lineWidth: 2)
        )
    }
}


struct BuildCard_Previews: PreviewProvider {
    static var previews: some View {
        BuildCard(application: mockData.data[2], build: mockDetail.data[0])
    }
}


