//
//  RecordTableViewDetailCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-01-21.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class RecordTableViewDetailCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var records: [Record]? {
        didSet {
            setupCollectionView()
        }
    }
    
    let padding: CGFloat = 8
    
    var detailCollectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
    }
    
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = padding * 2
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        if let records = records {
            let recordCount: CGFloat = CGFloat(records.count)
            let height: CGFloat = bounds.height
            let totalWidth: CGFloat = (bounds.width * recordCount)
            let width: CGFloat = (totalWidth / recordCount) - (2 * padding)
            layout.itemSize = CGSize(width: width, height: height - (2 * padding))
        }
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.isPagingEnabled = true
        detailCollectionView.isScrollEnabled = true
        detailCollectionView.backgroundColor = UIColor.clear
        detailCollectionView.register(RecordDetailHeaderCell.self, forCellWithReuseIdentifier: RecordDetailHeaderCell.identifier)
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailCollectionView)
        
        NSLayoutConstraint.activate([
            detailCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            detailCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            detailCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return records?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let detailHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordDetailHeaderCell.identifier, for: indexPath) as! RecordDetailHeaderCell
        if let records = records {
            detailHeaderCell.records = records
            detailHeaderCell.record = records[indexPath.item]
        }
        return detailHeaderCell
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}













class RecordDetailHeaderCell: UICollectionViewCell {
    
    weak var record: Record? {
        didSet {
            guard let record = record else { return }
            setupRecordHeaderCellData(record: record)
        }
    }
    
    var records: [Record]? {
        didSet {
            if let records = records {
                setupRecordStatCellData(records)
                
            }
        }
    }
    
    
    func setupRecordStatCellData(_ records: [Record]) {
        averageWeightLabel.text = getAverageWeight(records)
        totalRepCountLabel.text = getNumberOfReps(records)
        totalWeightNumberLabel.text = getTotalWeight(records)
        setupViews()
    }
    
    let padding: CGFloat = 12
    
    func setupRecordHeaderCellData(record: Record) {
        numberOfLabel.textColor = ThemeManager.currentTheme().tintColor
        
        if let date: Date = record.date as Date? {
            dateLabel.text = date.mediumDate()
        }
        
        if let mediumFont = UIFont(name: "SFCompactDisplay-Medium", size: 16) {
            let font = UIFontMetrics.default.scaledFont(for: mediumFont)
            exerciseLabel.font = font
            categoryLabel.font = font
            dateLabel.font = font
        }
        
        if let caption = UIFont(name: "SFCompactDisplay-Regular", size: 13) {
            let captionFont = UIFontMetrics.default.scaledFont(for: caption)
            numberOfLabel.font = captionFont
            
        }
        
        if let categoryName = record.categoryName {
            categoryLabel.text = categoryName
        }
        
        if let exerciseName = record.exerciseName?.localizedCapitalized {
            exerciseLabel.text = exerciseName
        }
        
        let sets = String(record.sets)
        let reps = String(record.reps)
        var weight = String(Int(record.weight))
        var weightUnit = ""
        
        repLabel.text = reps
        setLabel.text = sets
        
        if let usersWeightUnit = UserDefaults.standard.string(forKey: weightUnitKey) {
            weightString.text = usersWeightUnit
            weightUnit = usersWeightUnit
            if weightUnit == "kg" {
                weight = String(Int(record.weight))
            } else if weightUnit == "lb" {
                let pounds = (record.weight / poundsMultiplier)
                weight = String(lround(pounds))
            }
        }
        weightLabel.text = weight
        
        let performance = Int(record.rating)
        performanceStackView.performance = performance
        if record.notes == "" {
            notesTextView.text = "Nothing special..."
        } else {
            notesTextView.text = record.notes
        }
        
    }
    
    
    
    
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.currentTheme().tintColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().invertedTextColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    let exerciseLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().invertedTextColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().invertedTextColor.withAlphaComponent(0.9)
        label.backgroundColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.9)
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 16) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    let setLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().invertedTextColor.withAlphaComponent(0.9)
        label.backgroundColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.9)
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 16) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().invertedTextColor.withAlphaComponent(0.9)
        label.backgroundColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.9)
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 16) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    let stroke: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.5)
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let numberOfLabel = SmallTextCenteredLabel()
    
    let performanceStackView = PerformanceStackView()
    
    let notesTextView = DetailRecordTextView()
    
    let repString: UILabel = {
        let label = UILabel()
        label.text = "rep"
        label.textAlignment = .center
        label.textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.5)
        if let myFont = UIFont(name: "SFCompactDisplay-Regular", size: 12) {
            UIFontMetrics(forTextStyle: UIFont.TextStyle.caption1).scaledFont(for: myFont)
            label.font = myFont
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let setString: UILabel = {
        let label = UILabel()
        label.text = "set"
        label.textAlignment = .center
        label.textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.5)
        if let myFont = UIFont(name: "SFCompactDisplay-Regular", size: 12) {
            UIFontMetrics(forTextStyle: UIFont.TextStyle.caption1).scaledFont(for: myFont)
            label.font = myFont
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weightString: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.5)
        if let myFont = UIFont(name: "SFCompactDisplay-Regular", size: 12) {
            UIFontMetrics(forTextStyle: UIFont.TextStyle.caption1).scaledFont(for: myFont)
            label.font = myFont
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let averageLabel: UILabel = {
        let label = UILabel()
        label.text = "Average weight for exercise"
        label.textColor = ThemeManager.currentTheme().textColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let averageWeightLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 24) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "Total number of repetitions"
        label.textColor = ThemeManager.currentTheme().textColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalRepCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 24) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weightStatsLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        label.textAlignment = .left
        label.text = "Total weight lifted"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalWeightNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 24) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        
        addSubview(mainView)
        mainView.addSubview(dateView)
        addSubview(dateLabel)
        addSubview(categoryLabel)
        addSubview(exerciseLabel)
        addSubview(stroke)
        addSubview(repString)
        addSubview(setString)
        addSubview(weightString)
        addSubview(numberOfLabel)
        addSubview(performanceStackView)
        addSubview(notesTextView)
        
        let weightLabels = [repLabel, setLabel, weightLabel]
        
        let height: CGFloat = 28
        let padding: CGFloat = 8
        let numViews = CGFloat(weightLabels.count)
        
        let containerWidth: CGFloat = ((2 * height) + (1.5 * height)) + (numViews + 1) * padding
        
        
        weightLabels.forEach { (label) in
            label.layer.cornerRadius = height / 2
        }
        
        let weightStackView = UIStackView(arrangedSubviews: weightLabels)
        
        weightStackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        weightStackView.isLayoutMarginsRelativeArrangement = true
        weightStackView.axis = .horizontal
        weightStackView.distribution = .equalCentering
        weightStackView.spacing = padding
        weightStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightStackView)
        
        let averageStackView = UIStackView(arrangedSubviews: [averageWeightLabel, averageLabel])
        averageStackView.axis = .horizontal
        averageStackView.distribution = .fillProportionally
        averageStackView.alignment = .firstBaseline
        
        let repsStackView = UIStackView(arrangedSubviews: [totalRepCountLabel, repsLabel])
        repsStackView.axis = .horizontal
        repsStackView.distribution = .fillProportionally
        repsStackView.alignment = .firstBaseline
        
        let totalStackView = UIStackView(arrangedSubviews: [totalWeightNumberLabel, weightStatsLabel])
        totalStackView.axis = .horizontal
        totalStackView.distribution = .fillProportionally
        totalStackView.alignment = .firstBaseline
        
        let statsVerticalStackView = UIStackView(arrangedSubviews: [averageStackView, repsStackView, totalStackView])
        statsVerticalStackView.axis = .vertical
        statsVerticalStackView.distribution = .fillEqually
        statsVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(statsVerticalStackView)
        performanceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            dateView.topAnchor.constraint(equalTo: mainView.topAnchor),
            dateView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            dateView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            dateView.heightAnchor.constraint(equalToConstant: 40),
            
            dateLabel.topAnchor.constraint(equalTo: mainView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dateView.centerXAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            
            exerciseLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor),
            exerciseLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            exerciseLabel.bottomAnchor.constraint(equalTo: stroke.topAnchor),
            exerciseLabel.trailingAnchor.constraint(equalTo: weightStackView.leadingAnchor),
            
            repLabel.widthAnchor.constraint(equalToConstant: height),
            setLabel.widthAnchor.constraint(equalToConstant: height),
            weightLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: height * 1.5),
            weightStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            weightStackView.centerYAnchor.constraint(equalTo: exerciseLabel.centerYAnchor),
            weightStackView.widthAnchor.constraint(equalToConstant: containerWidth),
            weightStackView.heightAnchor.constraint(equalToConstant: height + 2 * padding),
            
            stroke.topAnchor.constraint(equalTo: weightStackView.bottomAnchor, constant: 4),
            stroke.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor),
            stroke.heightAnchor.constraint(equalToConstant: 2),
            stroke.trailingAnchor.constraint(equalTo: exerciseLabel.trailingAnchor),
            repString.centerYAnchor.constraint(equalTo: stroke.centerYAnchor, constant: -2),
            repString.centerXAnchor.constraint(equalTo: repLabel.centerXAnchor),
            setString.topAnchor.constraint(equalTo: repString.topAnchor),
            setString.centerXAnchor.constraint(equalTo: setLabel.centerXAnchor),
            setString.bottomAnchor.constraint(equalTo: repString.bottomAnchor),
            weightString.topAnchor.constraint(equalTo: setString.topAnchor),
            weightString.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor),
            weightString.bottomAnchor.constraint(equalTo: setString.bottomAnchor),
            numberOfLabel.centerYAnchor.constraint(equalTo: exerciseLabel.centerYAnchor),
            numberOfLabel.widthAnchor.constraint(equalToConstant: 24),
            numberOfLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 4),
            
            
            performanceStackView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 6),
            performanceStackView.heightAnchor.constraint(equalToConstant: 71),
            performanceStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
            
            notesTextView.topAnchor.constraint(equalTo: stroke.bottomAnchor, constant: 8),
            notesTextView.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor),
            notesTextView.trailingAnchor.constraint(equalTo: performanceStackView.leadingAnchor, constant: -8), 

            averageWeightLabel.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 2.5/10),
            totalRepCountLabel.widthAnchor.constraint(equalTo: averageWeightLabel.widthAnchor),
            totalWeightNumberLabel.widthAnchor.constraint(equalTo: averageWeightLabel.widthAnchor),
            
            statsVerticalStackView.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: padding),
            statsVerticalStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: padding * 2),
            statsVerticalStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -padding),
            statsVerticalStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -padding),
            statsVerticalStackView.heightAnchor.constraint(equalToConstant: 90)
            ])
    }
    
    
    private func getTotalWeight(_ records: [Record]) -> String {
        
        var weightString = ""
        let formatter = MassFormatter()
        
        var totalWeight: Double = 0
        
        for record in records {
            totalWeight += Double(record.weight)
        }
        
        if let weightUnitString = UserDefaults.standard.string(forKey: weightUnitKey) {
            if weightUnitString == "kg" {
                weightString = formatter.string(fromValue: Double(lround(totalWeight)), unit: .kilogram)
            } else if weightUnitString == "lb" {
                totalWeight /= poundsMultiplier
                weightString = formatter.string(fromValue: Double(lround(totalWeight)), unit: .pound)
            }
        }
        return weightString
    }
    
    
    
    
    private func getNumberOfReps(_ records: [Record]) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.formattingContext  = .standalone
        numberFormatter.numberStyle = .decimal
        
        var totalReps: Int = 0
        
        for record in records {
            let reps = Int(record.reps * record.sets)
            totalReps += reps
        }
        if let repsString = numberFormatter.string(from: NSNumber(value: totalReps)) {
            return repsString
        }
        return ""
    }
    
    
    private func getAverageWeight(_ records: [Record]) -> String {
        var weightString = ""
        
        let formatter = MassFormatter()
        
        var totalWeight:Double = 0
        var exerciseCount:Int = 0
        
        
        for record in records {
            totalWeight += Double(record.weight)
        }
        exerciseCount = records.count
        
        
        if let weightUnitString = UserDefaults.standard.string(forKey: weightUnitKey) {
            if weightUnitString == "kg" {
                let averange = (totalWeight / Double(exerciseCount))
                weightString = formatter.string(fromValue: Double(lround(averange)), unit: .kilogram)
            } else if weightUnitString == "lb" {
                totalWeight /= poundsMultiplier
                let averange = (totalWeight / Double(exerciseCount))
                weightString = formatter.string(fromValue: Double(lround(averange)), unit: .pound)
            }
        }
        return weightString
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
