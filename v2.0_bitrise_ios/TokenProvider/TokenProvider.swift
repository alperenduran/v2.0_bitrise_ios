//
//  TokenProvider.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 9.07.2020.
//

import Foundation
import KeychainSwift

let keychain = KeychainSwift()

func saveToken(_ token: String) {
//    keychain.accessGroup = "com.alperenduran.v2-0-bitrise-ios"
    keychain.synchronizable = true
    keychain.set(token, forKey: "token")
}

func getToken() -> String {
//    keychain.accessGroup = ".com.alperenduran.v2-0-bitrise-ios"
    keychain.synchronizable = true
    guard
        let token = keychain.get("token")
    else { return "" }
    return token
}
