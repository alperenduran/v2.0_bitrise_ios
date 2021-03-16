//
//  ApplicationDetailStore.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 20.07.2020.
//

import Foundation
import Combine

class ApplicationDetailStore: ObservableObject {
    @Published var builds: [Build] = []
    @Published var errorMessage = ""
    @Published var showError = false
    
    func fetchApplications(
        slug: String,
        completion: @escaping (
            Result<[Build], Error>
        ) -> Void
    ) {
        let endpoint = "https://api.bitrise.io/v0.1/apps/\(slug)/builds?sort_by=running_first"
        let req = createGetRequest(endpoint: endpoint, headers: [:])
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let data = try JSONDecoder().decode(ApplicationDetailsResponse.self, from: data!)
                let builds = data.data
                completion(.success(builds))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
