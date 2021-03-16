//
//  WorkflowLabel.swift
//  Bitrise
//
//  Created by Alperen Duran on 16.11.2019.
//  Copyright © 2019 Alperen Duran. All rights reserved.
//

import SwiftUI

struct WorkflowLabel: View {
    let workflow: String
    var body: some View {
        HStack {
            Image(systemName: "flowchart.fill")
                .imageScale(.small)
            Text(workflow)
                .font(.footnote)
        }
    }
}

struct WorkflowLabel_Previews: PreviewProvider {
    static var previews: some View {
        WorkflowLabel(workflow: mockDetail.data[1].workflow)
    }
}
