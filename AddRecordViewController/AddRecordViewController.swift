//
//  AddRecordViewController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-04.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit
import CoreData

class AddRecordViewController: UIViewController {
    
    var lastExerciseView: LastExerciseView = {
        let view = LastExerciseView()
        view.alpha = 0
        let width = Constants.screenWidth
        view.frame = CGRect(x: CGFloat(0), y: -120, width: width, height: CGFloat(130))
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let picker: UIDatePicker = UIDatePicker()
        picker.backgroundColor = ThemeManager.currentTheme().backgroundColor
        picker.datePickerMode = .date
        picker.setValue(ThemeManager.currentTheme().textColor, forKeyPath: "textColor")
        picker.maximumDate = Date()
        picker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return picker
    }()
    
    var exercisePickerView: UIPickerView = {
        let picker: UIPickerView = UIPickerView()
        picker.backgroundColor = ThemeManager.currentTheme().backgroundColor
        return picker
    }()
    
    let weightPickerView: UIPickerView = {
        let picker: UIPickerView = UIPickerView()
        picker.backgroundColor = ThemeManager.currentTheme().backgroundColor
        return picker
    }()
    
    var isSchemaRecord = false {
        didSet {
            if self.isSchemaRecord == false {
                animateBackgroundView(to: ThemeManager.currentTheme().tintColor)
            } else {
                animateBackgroundView(to: ThemeManager.currentTheme().accentColor)
            }
        }
    }
    
    var record: Record?
    
    var schemaRecord: SchemaRecord?
    let exerciseAPIServices = ExerciseAPIServices()
    var categoryModel: Categories?
    var exerciseModel: Exercises?
    var exerciseImageModel: ExerciseImageModel?
    
    var selectedCategoryName: String?
    var selectedExercise: Exercises.Exercise?
    var selectedExerciseName: String?
    
    var selectedSet: Int = 5
    var selectedRep: Int = 12
    var selectedWeight: Double = 87
    
    var exercises: [Exercises.Exercise]?
    
    let repUnit = "rep"
    let setUnit = "set"
    var weightUnit: String = ""
    var weightPickerDataSource: [[String]] = []
    
    var performanceControl = PerformanceControl()
    
    var notes = "add a note..."
    let selectCategoryString = "Select category above"
    
    var dateCell = DateCell()
    var categoryCell = CategoryStackView()
    var exerciseTextCell = ExerciseTextCell()
    var weightTextCell = WeightTextCell()
    var notesTextCell = NotesTextViewCell()
    var ratingCell = PerformanceControl()
    
    var schemaActionCell: [UITableViewCell] = []
    var schemaCellData: [SchemaRecord] = []
    
    var selectedSchemaIndex: Int = 0 {
        didSet {
            getSchemaRecords(for: self.selectedSchemaIndex)
        }
    }
    var isActionCellSaveButtonHidden = false
    var isAddExercisesButtonHidden = false
    var isLastExerciseViewHidden = true

    var dispatchGroup = DispatchGroup()
    
    let alertLabel = AlertLabel()
    let titleLabel = AddRecordTitleLabel()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 6)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        button.layer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        button.addTarget(self, action: #selector(addRecordButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addButtonImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "plus")
        view.tintColor = ThemeManager.currentTheme().tintColor
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 6)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        button.layer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let closeButtonImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "close")
        view.tintColor = ThemeManager.currentTheme().darkAccentColor
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addRecordScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let addRecordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 50
        tableView.separatorColor = UIColor.clear
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bgImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultData()
        weightUnit = getWeightUnit()
        setupTableView()
        setupViews()
        fetchNetworkData()
        toolbar()
        notesTextCell.notesTextView.delegate = self
        categoryCell.categorySelectionDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    func setupViews() {
        
        if Constants.screenHeight < 667 {
            addRecordScrollView.isScrollEnabled = true
        }
        
        setupWeightPickerView()
        exercisePickerView.delegate = self
        exercisePickerView.dataSource = self
        weightPickerView.delegate = self
        weightPickerView.dataSource = self
        
        dateCell.dateTextView.inputView = datePicker
        exerciseTextCell.exerciseTextView.inputView = exercisePickerView
        
        weightTextCell.repsTextLabel.inputView = weightPickerView
        weightTextCell.setsTextLabel.inputView = weightPickerView
        weightTextCell.weightTextLabel.inputView = weightPickerView
        
        view.addSubview(backgroundImageView)
        view.addSubview(alertLabel)
        view.addSubview(addButton)
        view.addSubview(addButtonImageView)
        view.addSubview(closeButton)
        view.addSubview(closeButtonImageView)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(addRecordScrollView)
        
        view.addSubview(lastExerciseView)
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        alertLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        addButton.layer.frame = addButtonImageView.bounds
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -36).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        addButtonImageView.centerXAnchor.constraint(equalTo: addButton.centerXAnchor).isActive = true
        addButtonImageView.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
        addButtonImageView.heightAnchor.constraint(equalTo: addButton.heightAnchor).isActive = true
        addButtonImageView.widthAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true
        
        closeButton.layer.frame = closeButtonImageView.bounds
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        closeButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        closeButtonImageView.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor).isActive = true
        closeButtonImageView.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        closeButtonImageView.heightAnchor.constraint(equalTo: closeButton.heightAnchor).isActive = true
        closeButtonImageView.widthAnchor.constraint(equalTo: closeButton.widthAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: closeButton.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: closeButton.bottomAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        
        [dateCell, categoryCell, exerciseTextCell, weightTextCell, notesTextCell, ratingCell].forEach { (cell) in
            addRecordStackView.addArrangedSubview(cell)
        }
        
        addRecordScrollView.addSubview(addRecordStackView)
        
        addRecordScrollView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 85).isActive = true
        addRecordScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollViewBottomAnchorConstraint = addRecordScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            scrollViewBottomAnchorConstraint?.isActive = true
        addRecordScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        addRecordScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        addRecordStackView.topAnchor.constraint(equalTo: addRecordScrollView.topAnchor, constant: 8).isActive = true
        addRecordStackView.bottomAnchor.constraint(equalTo: addRecordScrollView.bottomAnchor).isActive = true
        addRecordStackView.centerXAnchor.constraint(equalTo: addRecordScrollView.centerXAnchor).isActive = true
        addRecordStackView.widthAnchor.constraint(equalTo: addRecordScrollView.widthAnchor, constant: -32).isActive = true
//        addRecordStackView.heightAnchor.constraint(equalTo: addRecordScrollView.heightAnchor).isActive = true
    }
    
    var scrollViewBottomAnchorConstraint: NSLayoutConstraint?
    
    @objc func handleKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            print(keyboardFrame.height)
            if isKeyboardShowing && notesTextCell.notesTextView.isFirstResponder {
                hideAllCellsButNotesTextCell(true, alpha: 0)
                
            } else {
                hideAllCellsButNotesTextCell(false, alpha: 1)
            }
            scrollViewBottomAnchorConstraint?.constant = isKeyboardShowing ? (keyboardFrame.height + 50) : 0
        }
    }
    
    
    
    @objc func dismissViewController() {
        self.dismiss(animated: true)
    }
    
    func animateBackgroundView(to color: UIColor) {
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = color
        }
    }
    
    

    
    func animateAlertLabel() {
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.alertLabel.transform = CGAffineTransform(translationX: 0, y: -50)
            self.alertLabel.alpha = 1
        }) { (sucess) in
            UIView.animate(withDuration: 1, delay: 3, usingSpringWithDamping: 0.75, initialSpringVelocity: 3, options: [.curveEaseIn, .allowUserInteraction], animations: {
                self.alertLabel.transform = .identity
                self.alertLabel.alpha = 0
            })
        }
    }
    
    
    private func fetchNetworkData() {
        fetchCategoryData()
        fetchExerciseData()
        fetchExerciseImageData()
        dispatchGroup.notify(queue: .main) {
            self.setupCellData()
        }
    }
    
    private func fetchCategoryData() {
        dispatchGroup.enter()
        exerciseAPIServices.fetchGenericData(urlString: categoryUrl) { [weak self] (categories: Categories?, errorMessage) in
            
            guard let self = self else { return }
            
            if let error = errorMessage {
                self.alertLabel.text = error.localizedDescription
                self.animateAlertLabel()
            }
            
            if let categories = categories {
                self.categoryCell.categories = categories.categories
                try? categories.saveToDisk()
            }
            self.dispatchGroup.leave()
        }
        
    }
    
    private func fetchExerciseData() {
        dispatchGroup.enter()
        exerciseAPIServices.fetchGenericData(urlString: exerciseUrl) { [weak self] (exercises: Exercises?, errorMessage) in
            
            guard let self = self else { return }
            
            if let error = errorMessage {
                self.alertLabel.text = error.localizedDescription
                self.animateAlertLabel()
            }
            if let exercises = exercises {
                self.exercises = exercises.exercises
                try? exercises.saveToDisk()
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func fetchExerciseImageData() {
        dispatchGroup.enter()
        exerciseAPIServices.fetchGenericData(urlString: exerciseImageUrl) { [weak self] (exerciseImage: ExerciseImageModel?, errorMessage) in
            guard let self = self else { return }
            
            if let error = errorMessage {
                self.alertLabel.text = error.localizedDescription
                self.animateAlertLabel()
            }
            if let model = exerciseImage {
                self.exerciseImageModel = model
            }
            self.dispatchGroup.leave()
        }   
    }
    
    
    func setupCellData() {
        if isSchemaRecord == false {
            if record == nil {
                setupDefaultData()
            } else if let record = record {
                setupRecordData(for: record)
            }
        } else {
            if schemaRecord == nil {
                setupDefaultData()
            } else if let schemaRecord = schemaRecord {
                setupSchemaRecord(for: schemaRecord)
            }
        }
    }
    
    func setupSchemaRecord(for schema: SchemaRecord) {
        titleLabel.text = "Edit Schema Gain"
        
        let categoryName = schema.categoryName
        selectedCategoryName = categoryName
        let categories = Categories.getCategoriesFromDisk(pathComponent: storedCategoryPath)
        
        let exerciseName = schema.exerciseName
        exerciseTextCell.exerciseTextView.text = exerciseName
        selectedExerciseName = exerciseName
        
        if let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) {
            let id = categories[categoryIndex].id
            let categoryButton = categoryCell.buttons[categoryIndex]
            categoryButton.isSelected = true
            let rect = CGRect(x: view.frame.width / 2, y: 0, width: categoryCell.buttonViews[categoryIndex].frame.width, height: 50)
            self.categoryCell.categoryScrollView.scrollRectToVisible(rect, animated: true)
            
            let allExercises = Exercises.getExercisesFromDisk(pathComponent: storedExercisePath)
            let filteredExercises = allExercises.filter { $0.category == id }
            exercises = filteredExercises
            
            if let exerciseIndex = filteredExercises.firstIndex(where: { $0.name == exerciseName } ) {
                selectedExercise = filteredExercises[exerciseIndex]
                exercisePickerView.reloadAllComponents()
                exercisePickerView.selectRow(exerciseIndex, inComponent: 0, animated: true)
            }
        }
        
        exerciseTextCell.moreInfoButton.isHidden = false
        selectedSet = schema.sets
        selectedRep = schema.reps
        let weightUnit = getWeightUnit()
        let pounds = schema.weight / poundsMultiplier
        
        if weightUnit == "kg" {
            selectedWeight = schema.weight
        } else if weightUnit == "lb"{
            selectedWeight = pounds
        }
        
        let repAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: String(selectedRep), secondString: "rep", lineHeightMultiple: 0.75)
        let setAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: String(selectedSet), secondString: "set", lineHeightMultiple: 0.75)
        let weightAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: String(lround(selectedWeight)), secondString: weightUnit, lineHeightMultiple: 0.75)
        
        weightTextCell.repsTextLabel.attributedText = repAttributedText.setAttributedText()
        weightTextCell.setsTextLabel.attributedText = setAttributedText.setAttributedText()
        weightTextCell.weightTextLabel.attributedText = weightAttributedText.setAttributedText()
        
        
        weightPickerView.selectRow(Int(selectedRep - 1), inComponent: 0, animated: true)
        weightPickerView.selectRow(Int(selectedSet - 1), inComponent: 1, animated: true)
        weightPickerView.selectRow(lround(selectedWeight), inComponent: 2, animated: true)
        
        let recordNotes = schema.notes
        if recordNotes == "" {
            notesTextCell.notesTextView.text = notes
        } else {
            notesTextCell.notesTextView.text = recordNotes
        }
        
        ratingCell.rating = schema.rating
        ratingCell.updateButtonSelectionStates()
    }
    
    
    func setupRecordData(for record: Record) {
        titleLabel.text = "Edit Gain"
        if let date = record.date as Date? {
            datePicker.setDate(date, animated: true)
            dateCell.dateTextView.text = date.fullDate()
        }
        
        let categoryName = record.categoryName
        selectedCategoryName = categoryName
        let categories = Categories.getCategoriesFromDisk(pathComponent: storedCategoryPath)
        categoryCell.categories = categories
        let exerciseName = record.exerciseName
        exerciseTextCell.exerciseTextView.text = record.exerciseName
        selectedExerciseName = exerciseName
        
        if let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) {
            let id = categories[categoryIndex].id
            let categoryButton = categoryCell.buttons[categoryIndex]
            categoryButton.isSelected = true
            categoryCell.categoryScrollView.scrollRectToVisible(categoryButton.frame, animated: true)
            let allExercises = Exercises.getExercisesFromDisk(pathComponent: storedExercisePath)
            let filteredExercises = allExercises.filter { $0.category == id }
            self.exercises = filteredExercises
            if let exerciseIndex = filteredExercises.firstIndex(where: { $0.name == exerciseName } ) {
                exercisePickerView.reloadAllComponents()
                selectedExercise = filteredExercises[exerciseIndex]
                exercisePickerView.selectRow(exerciseIndex, inComponent: 0, animated: true)
            }
        }
        
        exerciseTextCell.moreInfoButton.isHidden = false
        selectedSet = Int(record.sets)
        selectedRep = Int(record.reps)
        let weightUnit = getWeightUnit()
        let pounds = record.weight / Double(poundsMultiplier)
        
        if weightUnit == "kg" {
            selectedWeight = record.weight
        } else if weightUnit == "lb"{
            selectedWeight = pounds
        }
        
        let repAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: String(selectedRep), secondString: "rep", lineHeightMultiple: 0.75)
        let setAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: String(selectedSet), secondString: "set", lineHeightMultiple: 0.75)
        let weightAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: String(lround(selectedWeight)), secondString: weightUnit, lineHeightMultiple: 0.75)
        
        weightTextCell.repsTextLabel.attributedText = repAttributedText.setAttributedText()
        weightTextCell.setsTextLabel.attributedText = setAttributedText.setAttributedText()
        weightTextCell.weightTextLabel.attributedText = weightAttributedText.setAttributedText()
        
        weightPickerView.selectRow(Int(selectedRep - 1), inComponent: 0, animated: true)
        weightPickerView.selectRow(Int(selectedSet - 1), inComponent: 1, animated: true)
        weightPickerView.selectRow(lround(selectedWeight), inComponent: 2, animated: true)
        
        if let recordNotes = record.notes {
            if recordNotes == "" {
                notesTextCell.notesTextView.text = notes
            } else {
                notesTextCell.notesTextView.text = recordNotes
            }
        }
        ratingCell.rating = Int(record.rating)
        ratingCell.updateButtonSelectionStates()
    }
    
    
    private func setupDefaultData() {
        if isSchemaRecord == false {
            titleLabel.text = "Add Gain"
        } else {
            titleLabel.text = "Add Gain to Schema"
        }
        datePicker.date = Date()
        dateCell.dateTextView.text = datePicker.date.fullDate()
        let buttons = categoryCell.buttons
        buttons.forEach { (button) in
            button.isSelected = false
        }
        exerciseTextCell.exerciseTextView.text = selectCategoryString
        selectedExerciseName = nil
        selectedSet = UserDefaults.standard.integer(forKey: setValueKey)
        selectedRep = UserDefaults.standard.integer(forKey: repValueKey)
        
        let weight = UserDefaults.standard.integer(forKey: weightValueKey)
        selectedWeight = Double(weight)
        
        weightTextCell.setupWeightTextCell(vc: self)
        weightPickerView.selectRow(selectedRep - 1, inComponent: 0, animated: true)
        weightPickerView.selectRow(selectedSet - 1, inComponent: 1, animated: true)
        weightPickerView.selectRow(weight, inComponent: 2, animated: true)
        
        notesTextCell.notesTextView.text = notes
        ratingCell.rating = 0
        ratingCell.updateButtonSelectionStates()
    }
    
    
    
    @objc func addRecordButtonTapped() {
        
        if selectedCategoryName == nil {
            alertLabel.text = "Select Category!"
            animateAlertLabel()
            return
        }
        if selectedExerciseName == nil {
            alertLabel.text = "Select Exercise!"
            animateAlertLabel()
            return
        }
        
        if isSchemaRecord == false {
            if record == nil {
                let newRecord = Record(context: DatabaseController.context)
                record = newRecord
            }
            if let record = record {
                record.date = datePicker.date as NSDate
                record.categoryName = selectedCategoryName
                record.exerciseName = exerciseTextCell.exerciseTextView.text
                record.sets = Int16(selectedSet)
                record.reps = Int16(selectedRep)
                
                if weightUnit == "kg" {
                    record.weight = Double(selectedWeight)
                } else {
                    let pounds = selectedWeight * poundsMultiplier
                    record.weight = pounds
                }
                if notesTextCell.notesTextView.text == notes {
                    record.notes = ""
                } else {
                    record.notes = notesTextCell.notesTextView.text
                }
                record.rating = Int16(ratingCell.rating)
                DatabaseController.saveContext()
                dismissViewController()
            }
            return
        } else if isSchemaRecord == true {
            if schemaRecord == nil {
                var storedSchemaRecords = SchemaRecords.getSchemaRecordsFromDisk(pathComponent: schemaRecordPath, schemaId: selectedSchemaIndex)
                
                if weightUnit == "lb" {
                    let kg = selectedWeight * poundsMultiplier
                    selectedWeight = kg
                }
                let newSchema: SchemaRecord = SchemaRecord(schemaId: selectedSchemaIndex, date: Date(), categoryName: selectedCategoryName!, exerciseName: selectedExerciseName!, reps: selectedRep, sets: selectedSet, weight: selectedWeight, notes: notesTextCell.notesTextView.text, rating: ratingCell.rating)
                storedSchemaRecords.append(newSchema)
                SchemaRecords.removeSchemaRecordsFromDisk(pathComponent: schemaRecordPath)
                try? newSchema.saveSchemaRecordToDisk(schemaRecord: storedSchemaRecords)
                if storedSchemaRecords.count > 0 {
                    tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                }
                isSchemaRecord = false
                self.selectedSchemaIndex = newSchema.schemaId
                let schemaNumber = selectedSchemaIndex + 1
                alertLabel.text = "Gain added to schema no: \(schemaNumber)"
                animateAlertLabel()
                
            } else if let schemaRecord = schemaRecord {
                var storedSchemaRecords = SchemaRecords.getSchemaRecordsFromDisk(pathComponent: schemaRecordPath, schemaId: schemaRecord.schemaId)
                let newSchema: SchemaRecord = SchemaRecord(schemaId: selectedSchemaIndex, date: Date(), categoryName: selectedCategoryName!, exerciseName: selectedExercise!.name, reps: selectedRep, sets: selectedSet, weight: selectedWeight, notes: notesTextCell.notesTextView.text, rating: ratingCell.rating)
                guard let index = storedSchemaRecords.firstIndex(where: { $0.date == schemaRecord.date }) else { return }
                storedSchemaRecords.remove(at: index)
                storedSchemaRecords.insert(newSchema, at: index)
                try? newSchema.saveSchemaRecordToDisk(schemaRecord: storedSchemaRecords)
                tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                isSchemaRecord = false
                self.selectedSchemaIndex = newSchema.schemaId
                let schemaNumber = selectedSchemaIndex + 1
                alertLabel.text = "Gain updated to schema no: \(schemaNumber)"
                animateAlertLabel()
            }
        }
    }
    
    
    
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        let date = picker.date
        dateCell.dateTextView.text = date.fullDate()
    }
    
    func toolbar() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        toolbar.sizeToFit()
        toolbar.barStyle = .blackTranslucent
        toolbar.backgroundColor = ThemeManager.currentTheme().tintColor
        let flexSpace = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = ThemeManager.currentTheme().textColor
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        dateCell.dateTextView.inputAccessoryView = toolbar
        
        exerciseTextCell.exerciseTextView.inputAccessoryView = toolbar
        weightTextCell.repsTextLabel.inputAccessoryView = toolbar
        weightTextCell.setsTextLabel.inputAccessoryView = toolbar
        weightTextCell.weightTextLabel.inputAccessoryView = toolbar
        notesTextCell.notesTextView.inputAccessoryView = toolbar
    }
    
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }

    
    @objc func showInfoForExercise() {
        let infoViewController = MoreInfoViewController()
        infoViewController.providesPresentationContextTransitionStyle = true
        infoViewController.definesPresentationContext = true
        infoViewController.modalPresentationStyle = .overCurrentContext
        infoViewController.setNeedsStatusBarAppearanceUpdate()
        if let id = selectedExercise?.id {
            let urls = imageUrl(for: id)
            infoViewController.urls = urls
            infoViewController.exercise = selectedExercise
            self.present(infoViewController, animated: true)
        }
    }
    
    
    func imageUrl(for exerciseId: Int) -> [URL] {
        var urls: [URL] = []
        
        if let imageModel = exerciseImageModel?.images {
            for image in imageModel {
                if image.exercise == exerciseId {
                    if let url = URL(string: image.imageUrl) {
                        urls.append(url)
                    }
                }
            }
        }
        return urls
    }
    
    
    
    func setupLastExerciseText() {
        guard let record = record else { return }
        
        if let lastRecord = record.getLastExercise(selectedExerciseName ?? "") {
            let date = lastRecord.date! as Date
            let dateString = date.fullDate()
            let rep = String(lastRecord.reps)
            let set = String(lastRecord.sets)
            var weight = String(Int(lastRecord.weight))
            
            let pounds = lastRecord.weight / Double(poundsMultiplier)
            let roundedPounds = String(lround(pounds))
            
            if weightUnit == "lb" {
                weight = roundedPounds
            }
            
            let repAttributedText = AttributedText(numberSize: 22, captionSize: 10, firstString: rep, secondString: "rep", lineHeightMultiple: 0.75)
            let setAttributedText = AttributedText(numberSize: 22, captionSize: 10, firstString: set, secondString: "set", lineHeightMultiple: 0.75)
            let weightAttributedText = AttributedText(numberSize: 22, captionSize: 10, firstString: weight, secondString: weightUnit, lineHeightMultiple: 0.75)
            lastExerciseView.repsTextLabel.attributedText = repAttributedText.setAttributedText()
            lastExerciseView.setsTextLabel.attributedText = setAttributedText.setAttributedText()
            lastExerciseView.weightTextLabel.attributedText = weightAttributedText.setAttributedText()

            lastExerciseView.lastExerciseHeader.text = "\(dateString)"
            if isLastExerciseViewHidden {
                animateLastExercise(alpha: 1)
            }
        }
        
    }
    
    
    func animateLastExercise(alpha: CGFloat) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.5, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.lastExerciseView.transform = CGAffineTransform(translationX: 0, y: 110)
            self.lastExerciseView.alpha = alpha
            self.isLastExerciseViewHidden.toggle()
        }) { (success) in
            UIView.animate(withDuration: 1, delay: 3, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.5, options: [.allowUserInteraction, .curveEaseOut], animations: {
                self.lastExerciseView.transform = .identity
                self.lastExerciseView.alpha = 0
                
            }) { (success) in
                self.isLastExerciseViewHidden.toggle()
            }
        }
    }
    
}


extension AddRecordViewController: CategorySelectionDelegate {
    
    func categoryButtonPressed(categoryName: String, categoryId: Int) {
        selectedCategoryName = categoryName
        let allExercises = Exercises.getExercisesFromDisk(pathComponent: storedExercisePath)
        let filteredExercises = allExercises.filter { $0.category == categoryId }
        exercises = filteredExercises
        exercisePickerView.reloadAllComponents()
        exercisePickerView.selectRow(0, inComponent: 0, animated: true)
        let name = filteredExercises[0].name
        selectedExercise = filteredExercises[0]
        exerciseTextCell.moreInfoButton.isHidden = false
        selectedExerciseName = name
        exerciseTextCell.exerciseTextView.text = name
    }
}
