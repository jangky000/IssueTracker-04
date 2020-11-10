//
//  IssueDetailSlideViewController.swift
//  IssueTracker
//
//  Created by Oh Donggeon on 2020/11/05.
//

import UIKit

class IssueDetailSlideViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var adapter: IssueSlideVIewCollectionViewAdapter? {
        didSet {
            collectionView.dataSource = adapter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayer()
        configureCollectionView()
        
    }
    
    private func configureLayer() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        
        collectionView.registerHeader(identifier: IssueDetailSlideViewHeader.identifier)
        collectionView.registerCell(identifier: AssigneeCollectionViewCell.identifier)
        collectionView.registerCell(identifier: LabelCollectionViewCell.identifier)
        collectionView.registerCell(identifier: MileStoneCollectionViewCell.identifier)
        collectionView.registerHeader(identifier: "EmptyDetailSlideViewHeader")
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension IssueDetailSlideViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 58)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let adapter = adapter else {
            return .zero
        }
        
        switch adapter.dataManager.section(of: indexPath) {
        case .assignee, .option:
            return CGSize(width: collectionView.frame.width - 32, height: 48)
        case .label:
            let width = adapter.dataManager.labelTitle(of: indexPath).estimatedLabelWidth(height: 30, fontSize: 17)
            return CGSize(width: width + 12, height: 30)
        case .milestone:
            return CGSize(width: collectionView.frame.width - 32, height: 120)
        case.none:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

extension IssueDetailSlideViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        collectionView.contentOffset.y <= 0
    }
}