//
//  v2_0_bitrise_iosApp.swift
//  v2.0_bitrise_ios WatchKit Extension
//
//  Created by Alperen Duran on 9.07.2020.
//

import SwiftUI

@main
struct v2_0_bitrise_iosApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
