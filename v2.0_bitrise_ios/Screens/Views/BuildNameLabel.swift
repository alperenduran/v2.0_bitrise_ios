//
//  BuildNameLabel.swift
//  Bitrise
//
//  Created by Alperen Duran on 16.11.2019.
//  Copyright © 2019 Alperen Duran. All rights reserved.
//

import SwiftUI

struct BuildNameLabel: View {
    let application: Application
    var body: some View {
        ApplicationListItemView(application: application)
    }
}

struct ApplicationListItemView: View {
    let application: Application
    var body: some View {
        HStack {
            ImageView(url: application.url)
                .frame(width: 50, height: 50, alignment: .center)
                .cornerRadius(5)
            VStack(alignment: .leading) {
                Text(application.title)
                    .fontWeight(.bold)
                Text(application.projectType ?? "Not Specified")
                    .fontWeight(.regular)
            }
        }
    }
}

struct BuildNameLabel_Previews: PreviewProvider {
    static var previews: some View {
        BuildNameLabel(application: mockData.data[2])
    }
}
