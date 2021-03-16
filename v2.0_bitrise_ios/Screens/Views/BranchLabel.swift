//
//  BranchLabel.swift
//  Bitrise
//
//  Created by Alperen Duran on 16.11.2019.
//  Copyright © 2019 Alperen Duran. All rights reserved.
//

import SwiftUI

struct BranchLabel: View {
    let branchName: String
    var body: some View {
        HStack {
            Image(systemName: "folder.fill.badge.person.crop")
                .imageScale(.small)
            Text(branchName)
                .font(.footnote)
        }
    }
}

struct BranchLabel_Previews: PreviewProvider {
    static var previews: some View {
        BranchLabel(branchName: mockDetail.data[0].branch)
    }
}
