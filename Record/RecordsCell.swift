//
//  RecordsCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-17.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

protocol RecordDelegate {
    func sortByCategory(indexPath: IndexPath)
    func sortByExercise(indexPath: IndexPath)
    func sortByDate(indexPath: IndexPath)
}


class RecordsCell: UITableViewCell {
    
    lazy var currentTheme = ThemeManager.currentTheme()
    var recordDelegate: RecordDelegate?
    
    let userDefaults = UserDefaults.standard
    
    var indexPath: IndexPath?
    
    var recordsViewController: RecordsViewController?
    
    weak var record: Record? {
        didSet {
            guard let record = record else { return }
            setupCellData(record: record)
        }
    }
    
    @objc func dateButtonPressed() {
        recordDelegate?.sortByDate(indexPath: indexPath!)
    }
    
    @objc func categoryButtonPressed() {
        recordDelegate?.sortByCategory(indexPath: indexPath!)
    }
    
    @objc func exerciseButtonPressed() {
        recordDelegate?.sortByExercise(indexPath: indexPath!)
    }
    
    
    func setupCellData(record: Record) {
        if let nsDate = record.date {
            let date = nsDate as Date
            dateButton.setTitle(date.mediumDate(), for: .normal)
        }
        
        if let caption = UIFont(name: "SFCompactDisplay-Medium", size: 13) {
            let captionFont = UIFontMetrics.default.scaledFont(for: caption)
            dateButton.titleLabel?.font = captionFont
        }
        
        if let categoryName = record.categoryName {
            if let exerciseName = record.exerciseName {
            exerciseLabel.text = exerciseName.localizedCapitalized
                let exerciseTextAttribute = AttributedText(numberSize: 16, captionSize: 13, firstString: categoryName, secondString: exerciseName, lineHeightMultiple: 1)
                exerciseLabel.attributedText = exerciseTextAttribute.setExerciseAttributedText()
            }
        }
        
        let sets = String(record.sets)
        let reps = String(record.reps)
        var weight = String(lround(record.weight))
        
        repLabel.text = reps
        setLabel.text = sets
        
        if let usersWeightUnit = userDefaults.string(forKey: weightUnitKey) {
            weightString.text = usersWeightUnit
            if usersWeightUnit == "kg" {
                weight = String(lround(record.weight))
            } else if usersWeightUnit == "lb" {
                let pounds = lround(record.weight / poundsMultiplier)
                weight = String(pounds)
            }
        }
        weightLabel.text = weight
        
        let rating = Int(record.rating)
        performanceStackView.performance = rating
        animateCellView()
    }
    
    func animateCellView() {
        UIView.animateKeyframes(withDuration: 0.125, delay: 0, options: UIView.KeyframeAnimationOptions.calculationModeCubic, animations: {
            self.dateButton.transform = CGAffineTransform(translationX: 0, y: 30)
            self.categoryButton.transform = CGAffineTransform(translationX: 0, y: 30)
            self.repLabel.transform = CGAffineTransform(translationX: 0, y: 30)
            self.setLabel.transform = CGAffineTransform(translationX: 0, y: 30)
            self.weightLabel.transform = CGAffineTransform(translationX: 0, y: 30)
            self.exerciseButton.transform = CGAffineTransform(translationX: 0, y: 60)
            self.performanceStackView.transform = CGAffineTransform(translationX: 30, y: 0)
            
        }) { (true) in
            UIView.animateKeyframes(withDuration: 0.125, delay: 0, options: UIView.KeyframeAnimationOptions.calculationModeCubic, animations: {
                self.dateButton.transform = .identity
                self.categoryButton.transform = .identity
                self.repLabel.transform = .identity
                self.setLabel.transform = .identity
                self.weightLabel.transform = .identity
                self.exerciseButton.transform = .identity
                self.performanceStackView.transform = .identity
            })
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
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
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let exerciseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let repLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.9)
        label.backgroundColor = UIColor.black
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 16) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    let setLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.9)
        label.backgroundColor = UIColor.black
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
        label.textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.9)
        label.backgroundColor = UIColor.black
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
    
    let dateButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(ThemeManager.currentTheme().tintColor.withAlphaComponent(0.8), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let categoryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(ThemeManager.currentTheme().textColor.withAlphaComponent(0.7), for: .normal)
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let exerciseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let performanceStackView: PerformanceStackView = {
        let stackView = PerformanceStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
    
    
    func setupViews() {
        
        addSubview(mainView)
        mainView.addSubview(dateView)
        addSubview(categoryView)
        addSubview(exerciseLabel)
        addSubview(stroke)
        addSubview(repString)
        addSubview(setString)
        addSubview(weightString)
        addSubview(dateButton)
        
        addSubview(categoryButton)
        addSubview(exerciseButton)
        
        categoryButton.addTarget(self, action: #selector(categoryButtonPressed), for: .touchUpInside)
        exerciseButton.addTarget(self, action: #selector(exerciseButtonPressed), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
        
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
        addSubview(performanceStackView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            dateView.centerYAnchor.constraint(equalTo: mainView.topAnchor),
            dateView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            dateView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 3.5/10),
            dateView.heightAnchor.constraint(equalToConstant: 40),
            categoryView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 2),
            categoryView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            categoryView.bottomAnchor.constraint(equalTo: dateView.bottomAnchor),
            categoryView.trailingAnchor.constraint(equalTo: dateView.leadingAnchor),
            
            exerciseLabel.topAnchor.constraint(equalTo: categoryView.topAnchor, constant: 8),
            exerciseLabel.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor),
            exerciseLabel.bottomAnchor.constraint(equalTo: stroke.topAnchor),
            exerciseLabel.trailingAnchor.constraint(equalTo: weightStackView.leadingAnchor, constant: -4),
            
            repLabel.widthAnchor.constraint(equalToConstant: height),
            setLabel.widthAnchor.constraint(equalToConstant: height),
            weightLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: height * 1.5),
            weightStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            weightStackView.centerYAnchor.constraint(equalTo: exerciseLabel.centerYAnchor, constant: 8),
            weightStackView.widthAnchor.constraint(equalToConstant: containerWidth),
            weightStackView.heightAnchor.constraint(equalToConstant: height + 2 * padding),
            stroke.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
            stroke.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor),
            stroke.heightAnchor.constraint(equalToConstant: 2),
            stroke.trailingAnchor.constraint(equalTo: exerciseLabel.trailingAnchor),
            repString.centerYAnchor.constraint(equalTo: stroke.centerYAnchor, constant: -2),
            repString.centerXAnchor.constraint(equalTo: repLabel.centerXAnchor),
            repString.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            setString.topAnchor.constraint(equalTo: repString.topAnchor),
            setString.centerXAnchor.constraint(equalTo: setLabel.centerXAnchor),
            setString.bottomAnchor.constraint(equalTo: repString.bottomAnchor),
            weightString.topAnchor.constraint(equalTo: setString.topAnchor),
            weightString.centerXAnchor.constraint(equalTo: weightLabel.centerXAnchor),
            weightString.bottomAnchor.constraint(equalTo: setString.bottomAnchor),
            dateButton.topAnchor.constraint(equalTo: mainView.topAnchor),
            dateButton.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            dateButton.bottomAnchor.constraint(equalTo: dateView.bottomAnchor),
            dateButton.widthAnchor.constraint(equalTo: dateView.widthAnchor),
            
            categoryButton.topAnchor.constraint(equalTo: categoryView.topAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: categoryView.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: categoryView.trailingAnchor),
            categoryButton.bottomAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            exerciseButton.topAnchor.constraint(equalTo: categoryButton.bottomAnchor),
            exerciseButton.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor),
            exerciseButton.trailingAnchor.constraint(equalTo: exerciseLabel.trailingAnchor),
            exerciseButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            performanceStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
            performanceStackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
            ])
    }
}
