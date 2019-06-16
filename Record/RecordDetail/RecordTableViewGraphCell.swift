//
//  GraphCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-04-12.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class RecordTableViewGraphCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    var records: [Record]? {
        didSet {
            setupGraphCellData()
            if let records = records {
                cellGraphRecords = setupCellRecords(records)
            }
        }
    }
    
    var cellGraphRecords: [[Record]]?
    
    var graphHeaderLabels = [String]()
    
    
    func setupCellRecords(_ records: [Record]) -> [[Record]] {
        var allGraphRecords: [[Record]] = []
        var threeMonthsRecords: [Record] = []
        var yearRecords: [Record] = []
        let now = Date()
        let calendar = Calendar.current
        let threeMonthsAgo = calendar.date(byAdding: .day, value: -90, to: now)
        let aYearAgo = calendar.date(byAdding: .year, value: -1, to: now)
        
        threeMonthsRecords = records.filter({ threeMonthsAgo! < ($0.date! as Date) })
        if threeMonthsRecords.count > 0 {
            graphHeaderLabels.append("Last 90 days")
            allGraphRecords.append(threeMonthsRecords)
        }
        yearRecords = records.filter({ aYearAgo! < ($0.date! as Date) })
        if yearRecords.count > 0 {
            graphHeaderLabels.append("Year")
            allGraphRecords.append(yearRecords)
        }
        graphHeaderLabels.append("Eternity")
        allGraphRecords.append(records)
        return allGraphRecords
    }
    
    
    let padding: CGFloat = 8
    
    var graphCollectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear    
    }
    
    
    
    private func setupGraphCellData() {
        
        let layout = UICollectionViewFlowLayout()
        graphCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = padding * 2
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        if let records = records {
            let recordCount: CGFloat = CGFloat(records.count)
            let height: CGFloat = bounds.height - (2 * padding)
            let totalWidth: CGFloat = (bounds.width * recordCount)
            let width: CGFloat = (totalWidth / recordCount) - (2 * padding)
            layout.itemSize = CGSize(width: width, height: height)
        }
        
        graphCollectionView.delegate = self
        graphCollectionView.dataSource = self
        graphCollectionView.register(GraphCell.self, forCellWithReuseIdentifier: GraphCell.identifier)
        graphCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(graphCollectionView)
        
        graphCollectionView.isPagingEnabled = true
        graphCollectionView.isScrollEnabled = true
        graphCollectionView.backgroundColor = UIColor.clear
        graphCollectionView.register(GraphCell.self, forCellWithReuseIdentifier: GraphCell.identifier)
        graphCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(graphCollectionView)
        
        NSLayoutConstraint.activate([
            graphCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            graphCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            graphCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            graphCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            graphCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 240)
            ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellGraphRecords?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let graphCell = collectionView.dequeueReusableCell(withReuseIdentifier: GraphCell.identifier, for: indexPath) as! GraphCell
        graphCell.headerLabel.text = graphHeaderLabels[indexPath.row]
        if let records = cellGraphRecords {
            graphCell.records = records[indexPath.row]
        }
        return graphCell
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





class GraphCell: UICollectionViewCell {
    
    var records: [Record]? {
        didSet {
            if let records = records {
                let dataPoints: [Int] = records.map({ return Int(($0.reps * $0.sets)) * (lround($0.weight)) })
                    graphView.graphPoints = dataPoints
                    updateDateLabels(records)
            }
        }
    }
    
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.alpha = 1
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.currentTheme().tintColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().invertedTextColor
        label.textAlignment = .center
        if let mediumFont = UIFont(name: "SFCompactDisplay-Medium", size: 16) {
            let myHeaderFont = UIFontMetrics.default.scaledFont(for: mediumFont)
            label.font = myHeaderFont
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var graphView = GraphView()
    
    let stroke = StrokeView()
    
    let fromDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        label.textColor = ThemeManager.currentTheme().textColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let toDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        label.textColor = ThemeManager.currentTheme().textColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let graphContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupDetailGraphCell() {
        graphView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainView)
        
        addSubview(graphContainerView)
        graphContainerView.addSubview(graphView)
        graphContainerView.addSubview(headerView)
        addSubview(headerLabel)
        addSubview(stroke)
        addSubview(fromDateLabel)
        addSubview(toDateLabel)
        
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            headerView.topAnchor.constraint(equalTo: mainView.topAnchor),
            headerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            headerView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
            
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor),
            
            graphContainerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            graphContainerView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 2),
            graphContainerView.widthAnchor.constraint(equalTo: mainView.widthAnchor, constant: -4),
            graphContainerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 10/10),
            
            graphView.topAnchor.constraint(equalTo: graphContainerView.topAnchor),
            graphView.leadingAnchor.constraint(equalTo: graphContainerView.leadingAnchor),
            graphView.bottomAnchor.constraint(equalTo: graphContainerView.bottomAnchor, constant: -4),
            graphView.trailingAnchor.constraint(equalTo: graphContainerView.trailingAnchor),
            
            stroke.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -24),
            stroke.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            stroke.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            stroke.heightAnchor.constraint(equalToConstant: 2),
            
            fromDateLabel.topAnchor.constraint(equalTo: stroke.bottomAnchor, constant: 4),
            fromDateLabel.leadingAnchor.constraint(equalTo: stroke.leadingAnchor),
            fromDateLabel.widthAnchor.constraint(equalTo: stroke.widthAnchor, multiplier: 1/3),
            
            toDateLabel.topAnchor.constraint(equalTo: fromDateLabel.topAnchor),
            toDateLabel.trailingAnchor.constraint(equalTo: stroke.trailingAnchor),
            toDateLabel.widthAnchor.constraint(equalTo: fromDateLabel.widthAnchor)
            ])
    }
    
    
    private func updateDateLabels(_ records: [Record]) {
        let fromRecord = records.first
        if let fromDate: Date = fromRecord?.date! as Date? {
            fromDateLabel.text = fromDate.mediumDate()
        }
        
        
        let toRecord = records.last
        if let toDate: Date = toRecord?.date! as Date? {
            toDateLabel.text = toDate.mediumDate()
        }
        
    }

    func animateGraphView() {
                
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            //            self.cellView.layoutIfNeeded()
        }, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDetailGraphCell()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

