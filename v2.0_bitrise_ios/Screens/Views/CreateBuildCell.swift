//
//  CreateBuildCell.swift
//  Bitrise
//
//  Created by Alperen Duran on 17.11.2019.
//  Copyright © 2019 Alperen Duran. All rights reserved.
//

import SwiftUI

struct CreateBuildCell: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 75, height: 75, alignment: .center)
                .foregroundColor(Color("appPurpleColor"))
                .cornerRadius(37.5)
            Image(systemName: "plus")
                .imageScale(.large)
                .foregroundColor(.white)
        }
    }
}

struct CreateBuildCell_Previews: PreviewProvider {
    static var previews: some View {
        CreateBuildCell()
    }
}
