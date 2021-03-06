//
//  MilestoneDetailView.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/08.
//

import UIKit

protocol MilestoneDetailViewData {
    var milestoneNo: Int { get }
    var milestoneTitle: String { get }
    var dueDate: Date? { get }
    var milestoneDescription: String? { get }
    var percent: Double? { get }
    var openIssueCount: Int? { get }
    var closedIssueCount: Int? { get }
}

class MilestoneDetailView: UIView {

    private var xibName: String {
        String(describing: Self.self)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closedLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        guard let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func configure(with data: Milestone) {
        titleLabel.text = data.milestoneTitle
        descriptionLabel.text = data.milestoneDescription
        percentLabel.text = "\(data.percent ?? 0)%"
        openLabel.text = "open \(data.openIssueCount ?? 0)"
        closedLabel.text = "closed \(data.closedIssueCount ?? 0)"
        progressView.progress = Float((data.percent ?? 0) / 100) 
        
        if let dueDate = data.dueDate {
            dateLabel.text = dueDate.string + " 까지"
            dateLabel.textColor = (dueDate > Date()) ? .systemGray : .systemRed
        } else {
            dateLabel.text = nil
            
        }
    }
}
