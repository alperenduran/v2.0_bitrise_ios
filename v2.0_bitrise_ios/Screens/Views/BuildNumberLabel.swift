//
//  BuildNumberView.swift
//  Bitrise
//
//  Created by Alperen Duran on 16.11.2019.
//  Copyright © 2019 Alperen Duran. All rights reserved.
//

import SwiftUI

struct BuildNumberLabel: View {
    let buildNumber: Int
    var body: some View {
        HStack {
            Image(systemName: "tag.fill")
                .imageScale(.small)
            Text("\(buildNumber)")
                .font(.footnote)
        }
    }
}

struct BuildNumberLabel_Previews: PreviewProvider {
    static var previews: some View {
        BuildNumberLabel(buildNumber: mockDetail.data[1].buildNumber)
    }
}
