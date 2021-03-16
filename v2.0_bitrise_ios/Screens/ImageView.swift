//
//  ImageView.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 9.07.2020.
//

import SwiftUI
import KingfisherSwiftUI

struct ImageView: View {
    let url: URL
    var body: some View {
        KFImage(url)
            .placeholder {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: URL(string: "")!)
    }
}
