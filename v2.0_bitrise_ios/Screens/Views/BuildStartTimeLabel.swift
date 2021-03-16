//
//  BuildStartTimeLabel.swift
//  Bitrise
//
//  Created by Alperen Duran on 27.11.2019.
//  Copyright © 2019 Alperen Duran. All rights reserved.
//

import SwiftUI

struct BuildStartTimeLabel: View {
    let time: String
    var body: some View {
        HStack {
            Image(systemName: "clock.fill")
            .imageScale(.small)
            Text(time)
                .font(.footnote)
        }
    }
}

struct BuildStartTimeLabel_Previews: PreviewProvider {
    static var previews: some View {
        BuildStartTimeLabel(time: "14:26")
    }
}
