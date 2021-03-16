//
//  Models.swift
//  v2.0_bitrise_ios
//
//  Created by Alperen Duran on 9.07.2020.
//

import SwiftUI

struct ApplicationListResponse: Decodable {
    let data: [Application]
}

struct Application: Decodable, Identifiable {
    let id: String
    let title: String
    let projectType: String?
    let owner: String
    let avatar: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "slug"
        case title
        case projectType = "project_type"
        case owner = "repo_owner"
        case avatar = "avatar_url"
    }
    
    var url: URL {
        guard let url = avatar else {
            return URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Ficon-library.com%2Ficon%2Ficon-for-link-25.html&psig=AOvVaw1ny1DyBOKi5S34VkMM8NSM&ust=1594380038512000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJCp1dCGwOoCFQAAAAAdAAAAABAD")!
        }
        return url
    }
}

struct ApplicationDetailsResponse: Decodable {
    let data: [Build]
}

struct Build: Decodable, Identifiable {
    let id: String
    let triggeredAt: String
    let status: Status
    let statusName: String
    let branch: String
    let buildNumber: Int
    let workflow: String
    
    enum CodingKeys: String, CodingKey {
        case id = "slug"
        case triggeredAt = "triggered_at"
        case status
        case statusName = "status_text"
        case branch
        case buildNumber = "build_number"
        case workflow = "triggered_workflow"
        
    }
}
//MARK: -Date
extension Build {
    var startTime: String {
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatterGet.timeZone = .current
            
            let dateFormatterSet = DateFormatter()
            dateFormatterSet.dateFormat = "HH:mm"
        
            guard let date = dateFormatterGet.date(from: triggeredAt) else { return "" }
            let dateString = dateFormatterSet.string(from: date)

            return dateString
    }
}
//MARK: -Color
extension Build {
    var statusColor: Color {
        switch status {
        case .failed:
            return Color("failedRed")
        case .abortedWithFailure, .abortedWithSuccess:
            return Color("abortedYellow")
        case .inProgress:
            return Color("inProgressPurple")
        case .successful:
            return Color("successfulGreen")
        }
    }
}

//MARK: -Status
extension Build {
    var statusLabel: String {
        switch status {
        case .failed:
            return "Failed"
        case .abortedWithFailure, .abortedWithSuccess:
            return "Aborted"
        case .inProgress:
            return "In Progress"
        case .successful:
            return "Successful"
        }
    }
}

struct BuildAbortBody: Encodable {
    let abort: Bool
    
    enum CodingKeys: String, CodingKey {
        case abort = "abort_with_success"
    }
}

struct BuildRequestParams: Encodable {
    let branch: String
    let workflow: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case branch
        case workflow = "workflow_id"
        case message = "commit_message"
    }
}

struct BuildRequestBody: Encodable {
    let params: BuildRequestParams
    let hookInfo: HookType
    
    enum CodingKeys: String, CodingKey {
        case params = "build_params"
        case hookInfo = "hook_info"
    }
}

struct HookType: Encodable {
    let type: String
}

struct BranchesResponse: Decodable {
    let data: [String]
}

struct WorkflowsResponse: Decodable {
    let data: [String]
}

enum Status: Int, Decodable {
    case inProgress = 0
    case successful = 1
    case failed = 2
    case abortedWithFailure = 3
    case abortedWithSuccess = 4
}

func createGetRequest(
        endpoint: String,
        headers: [String: Any]
    ) -> URLRequest {
        let url = URL(string: endpoint)
        var request = URLRequest.init(url: url!)
        let token = getToken()
        print("token: \(token)")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        headers.forEach { (key, value) in
            request.addValue(value as! String, forHTTPHeaderField: key)
        }
        return request
    }
    
    func createPostRequest(
        endpoint: String,
        headers: [String: Any]
    ) -> URLRequest {
        let url = URL(string: endpoint)
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        let token = getToken()
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach { (key, value) in
            request.addValue(value as! String, forHTTPHeaderField: key)
        }
        return request
    }
