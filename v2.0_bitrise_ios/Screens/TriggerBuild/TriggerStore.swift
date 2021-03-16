//
//  TriggerStore.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 20.07.2020.
//

import Foundation
import Combine

class TriggerBuildStore: ObservableObject {
    @Published var branches: [String] = []
    @Published var workflows: [String] = []
    @Published var errorMessage = ""
    @Published var showError = false
    
    func fetchBranches(
        slug: String,
        completion: @escaping (
            Result<[String], Error>
        ) -> Void
    ) {
        let endpoint = "https://api.bitrise.io/v0.1/apps/\(slug)/branches"
        let req = createGetRequest(endpoint: endpoint, headers: [:])
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let data = try JSONDecoder().decode(BranchesResponse.self, from: data!)
                let branches = data.data
                completion(.success(branches))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchWorkflows(
        slug: String,
        completion: @escaping (
            Result<[String], Error>
        ) -> Void
    ) {
        let endpoint = "https://api.bitrise.io/v0.1/apps/\(slug)/build-workflows"
        let req = createGetRequest(endpoint: endpoint, headers: [:])
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let data = try JSONDecoder().decode(WorkflowsResponse.self, from: data!)
                let workflows = data.data
                completion(.success(workflows))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getBranches(slug: String) {
        fetchBranches(slug: slug) { resp in
            DispatchQueue.main.async {
                if case .success(let branches) = resp {
                    self.branches = branches
                } else if case .failure(let error) = resp {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                }
            }
        }
    }
    
    func getWorkflows(slug: String) {
        fetchWorkflows(slug: slug) { resp in
            DispatchQueue.main.async {
                if case .success(let workflows) = resp {
                    self.workflows = workflows
                } else if case .failure(let error) = resp {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                }
            }
        }
    }
    
    func triggerBuild(slug: String, branch: String, workflow: String, message: String) {
        let endpoint = "https://api.bitrise.io/v0.1/apps/\(slug)/builds"
        var request = createPostRequest(endpoint: endpoint, headers: [:])
        let params = BuildRequestParams(branch: branch, workflow: workflow, message: message)
        let hookInfo = HookType(type: "bitrise")
        let build = BuildRequestBody(params: params, hookInfo: hookInfo)
        request.httpBody = try! JSONEncoder().encode(build)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                let response = response as! HTTPURLResponse
                if response.statusCode == 200 {
                    print("Success!")
                }
            }
        }.resume()
    }
}
