//
//  String+.swift
//  IssueTracker
//
//  Created by Byoung-Hwi Yoon on 2020/11/03.
//

import UIKit

extension String {
    func estimatedLabelHeight(width: CGFloat, fontSize: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let estimatedSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil)
        return estimatedSize.height
    }
}
