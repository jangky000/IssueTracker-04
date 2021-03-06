//
//  IssueListDataSourceManager.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/01.
//

import Foundation

class IssueListDataSourceManager {
    
    var items: [IssueListCellData] = []
    var networkManager: IssueListNetworkManager
    var itemCount: Int {
        items.count
    }
    
    init(networkManager: IssueListNetworkManager) {
        self.networkManager = networkManager
    }
    
    subscript(indexPath: IndexPath) -> IssueListCellData {
        items[indexPath.row]
    }
    
    subscript(indexPaths: [IndexPath]) -> [IssueListCellData] {
        indexPaths.map { self[$0] }
    }
    
    func add(issue: IssueAddRequest, completion: @escaping (Bool) -> Void) {
        networkManager.requestIssueAdd(issue: issue) { [weak self] result in
            switch result {
            case .success(let response):
                let issue = IssueListCellData(issueNo: response.newIssueNo, issueTitle: issue.issueTitle, issueContent: issue.issueContent, milestoneTitle: "", labels: [])
                self?.items.insert(issue, at: 0)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
            completion(true)
        }
    }
    
    func loadIssueList(completion: @escaping  (Bool) -> Void) {
        networkManager.requestIssueList { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let issues):
                    self?.items = issues.map { $0.cellData() }
                    completion(true)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        }
    }
    
    func deleteIssue(by issueNo: Int, completion: (IndexPath) -> Void) {
        guard let index = (items.firstIndex { $0.issueNo == issueNo}) else {
            return
        }
        items.remove(at: index)
        let indexPath = IndexPath(row: index, section: 0)
        completion(indexPath)
    }
    
    func deleteIssues(indexPaths: [IndexPath]) {
        //let issueNoList = self[indexPaths].map { $0.issueNo }
        let deleteIndex = indexPaths.map { $0.row }
        items = items.indices
            .filter { !deleteIndex.contains($0) }
            .map { items[$0] }
    }
    
    func indexPath(of issueNo: Int) -> IndexPath {
        var firstIndex = 0
        items.enumerated().forEach { index, item in
            if item.issueNo == issueNo {
                firstIndex = index
            }
        }
        return IndexPath(row: firstIndex, section: 0)
    }
    
    func closeIssue(indexPath: IndexPath) {
        //let issueNo = self[indexPath].issueNo
    }
    
    func closeIssues(indexPaths: [IndexPath]) {
        //let issueNoList = self[indexPaths].map { $0.issueNo }
    }
    
}
