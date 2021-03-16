//
//  BuildStatusView.swift
//  Bitrise
//
//  Created by Alperen Duran on 16.11.2019.
//  Copyright © 2019 Alperen Duran. All rights reserved.
//

import SwiftUI

struct BuildStatusView: View {
    let label: String
    let color: Color
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(color)
                .frame(width: 100)
            Text(label)
                .foregroundColor(.white)
        }.cornerRadius(15)
    }
}

struct BuildStatusView_Previews: PreviewProvider {
    static var previews: some View {
        BuildStatusView(
            label: mockDetail.data[5].statusName,
            color: mockDetail.data[5].statusColor
        )
    }
}
