//
//  RecordFooterCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-10-03.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class RecordFooterCollectionViewController: UICollectionViewController {
    
    var footerData = [RecordFooterController]() {
        didSet {
            collectionView.reloadData()
        }
    }

    func setupCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        collectionView.register(RecordFooterCollectionViewCell.self, forCellWithReuseIdentifier: RecordFooterCollectionViewCell.identifier)
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
}


extension RecordFooterCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return footerData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordFooterCollectionViewCell.identifier, for: indexPath) as! RecordFooterCollectionViewCell
        categoryCell.footerData = footerData[indexPath.row]
        return categoryCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
    }
}
