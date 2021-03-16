//
//  Applications Store.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 9.07.2020.
//

import Foundation
import Combine

class ApplicationStore: ObservableObject {
    @Published var applications: [Application] = []
    @Published var errorMessage = ""
    @Published var showError = false
    
    func fetchApplications(
        completion: @escaping (
            Result<[Application], Error>
        ) -> Void
    ) {
        let endpoint = "https://api.bitrise.io/v0.1/apps?sort_by=created_at"
        let req = createGetRequest(endpoint: endpoint, headers: [:])
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let data = try JSONDecoder().decode(ApplicationListResponse.self, from: data!)
                let apps = data.data
                completion(.success(apps))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func refresh() {
        fetchApplications { resp in
            DispatchQueue.main.async {
                if case .success(let apps) = resp {
                    self.applications = apps
                } else if case .failure(let error) = resp {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                }
            }
        }
    }
}
