//
//  v2_0_bitrise_iosApp.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 9.07.2020.
//

import SwiftUI

@main
struct v2_0_bitrise_iosApp: App {
    @State var reason: Reason = .add
    
    var body: some Scene {
        WindowGroup {
            Applications()
        }
    }
}
