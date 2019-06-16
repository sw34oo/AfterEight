//
//  RecordsViewController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-17.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit
import CoreData


class RecordsViewController: UIViewController, NSFetchedResultsControllerDelegate  {
        
    lazy var detailViewController: RecordDetailViewController = {
        let controller = RecordDetailViewController()
        return controller
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    lazy var recordRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = ThemeManager.currentTheme().whiteColor
        let attributedString = NSAttributedString(string: "Fetching All Gains", attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().whiteColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)])
        control.attributedTitle = attributedString
        control.addTarget(self, action: #selector(showAllRecords), for: .valueChanged)
        return control
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.hidesWhenStopped = true
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "No Gains yet,\nhead to the gym!\n\nPull down to refresh..."
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = ThemeManager.currentTheme().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    var numberOfExercises: Int = 7
    
    weak var record: Record?
    
    var dateSorter = false
    var exerciseSorter = false
    var recordSegmentSortControl = UISegmentedControl()
    let moc = DatabaseController.context
    
    var footerData: [RecordFooterController] = [] {
        didSet {
            setupFooter()
        }
    }
    
    
    lazy var recordFetchRequestController: NSFetchedResultsController = { () -> NSFetchedResultsController<Record> in
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: dateSorter)
        let categorySortDescriptor = NSSortDescriptor(key: "categoryName", ascending: false)
        let exerciseSortDescriptor = NSSortDescriptor(key: "exerciseName", ascending: exerciseSorter)
        fetchRequest.sortDescriptors = [dateSortDescriptor, categorySortDescriptor, exerciseSortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DatabaseController.setupDummyData()
        performFetch()
        setupTableview()
        setupNavigationController()
        NotificationCenter.default.addObserver(self, selector: #selector(performFetch), name: weightUnitNotification.name, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performFetch()
    }
    

    
    @objc func performFetch() {
        do {
            try recordFetchRequestController.performFetch()
            setupActivityIndicator()
            setupFooter()
            self.tableView.reloadData()
        } catch let err {
            print("Error fetching records:  \(err.localizedDescription)")
        }
    }

    
    private func setupActivityIndicator() {
        var hasGains = false
        activityIndicatorView.startAnimating()
        if let gains = recordFetchRequestController.fetchedObjects {
            hasGains = gains.count > 0 ? true : false
            if hasGains {
                activityIndicatorView.stopAnimating()
                messageLabel.isHidden = hasGains
            }
        }
        messageLabel.isHidden = hasGains
        activityIndicatorView.isHidden = hasGains
    }
    
    
    func setupTableview() {
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.black
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView.register(RecordsCell.self, forCellReuseIdentifier: RecordsCell.identifier)
        tableView.register(RecordHeaderCell.self, forHeaderFooterViewReuseIdentifier: RecordHeaderCell.identifier)
        tableView.alwaysBounceVertical = true
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        view.addSubview(activityIndicatorView)
        view.addSubview(messageLabel)
        activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -48).isActive = true
        
        messageLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 24).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 8/10).isActive = true
        tableView.refreshControl = recordRefreshControl
        
    }
    
    private func setupFooter() {
        
        let footerContainerView = UIView()
        footerContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(footerContainerView)
        footerContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        footerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        footerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        footerContainerView.heightAnchor.constraint(equalToConstant: 63).isActive = true
        footerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let footerVC = RecordFooterCollectionViewController(collectionViewLayout: layout)
        footerVC.footerData = RecordFooterController.setFooterData()
        addChild(footerVC)
        footerVC.view.translatesAutoresizingMaskIntoConstraints = false
        footerContainerView.addSubview(footerVC.view)
        
        footerVC.view.topAnchor.constraint(equalTo: footerContainerView.topAnchor).isActive = true
        footerVC.view.leadingAnchor.constraint(equalTo: footerContainerView.leadingAnchor).isActive = true
        footerVC.view.bottomAnchor.constraint(equalTo: footerContainerView.bottomAnchor).isActive = true
        footerVC.view.trailingAnchor.constraint(equalTo: footerContainerView.trailingAnchor).isActive = true
        footerVC.didMove(toParent: self)
    }
    
    
    let settingsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        return imageView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupNavigationController() {
        navigationItem.title = "My Gains"
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationItem.largeTitleDisplayMode = .always
        let settings = UIBarButtonItem(image: settingsImageView.image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(settingsTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let addRecordButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: UIBarButtonItem.Style.done, target: self, action: #selector(pushAddRecordVC))
        navigationItem.leftBarButtonItems = [settings, space]
        navigationItem.rightBarButtonItems = [space, addRecordButton]
    }

    
    @objc func pushAddRecordVC() {
        let addRecordViewController = AddRecordViewController()
        addRecordViewController.providesPresentationContextTransitionStyle = true
        addRecordViewController.definesPresentationContext = true
        addRecordViewController.modalPresentationStyle = .overCurrentContext
        addRecordViewController.record = nil
        addRecordViewController.isSchemaRecord = false
        self.present(addRecordViewController, animated: true)
    }
    

    
    lazy var defaultsView: UserDefaultsView = {
        let defaultsView = UserDefaultsView()
        return defaultsView
    }()
    
    @objc func settingsTapped() {
        defaultsView.setupSettingsView()
    }
    
    func configure(_ cell: RecordsCell, at indexPath: IndexPath) {
        cell.recordsViewController = self
        cell.recordDelegate = self
        cell.indexPath = indexPath
        let record = recordFetchRequestController.object(at: indexPath)
        cell.record = record
    }
    
    
    func showDetailForRecord(record: Record) {
        let records = fetchRecords(record: record)
        if let index = records.firstIndex(where: { ($0 == record)}) {
            detailViewController.records = records
            detailViewController.selectedIndex = index
            detailViewController.navigationItem.title = record.exerciseName
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    
    func fetchRecords(record: Record) -> [Record] {
        
        var records: [Record] = []
        let moc = DatabaseController.context
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [dateSortDescriptor]
        fetchRequest.predicate = NSPredicate(format: "exerciseName == %@", (record.exerciseName ?? "Exercise not found"))
        
        do {
            records = try moc.fetch(fetchRequest)
        } catch let err {
            print("Error when fetching data: \(err)")
        }
        return records
    }
    
    
    @objc func sortRecords() {
        
        guard recordFetchRequestController.fetchedObjects?.count != 0 else { return }
        
        let index = recordSegmentSortControl.selectedSegmentIndex
        switch index {
        case 0:
            dateSorter.toggle()
            if dateSorter == true {
                recordSegmentSortControl.setTitle("Date  ▲", forSegmentAt: index)
            } else {
                recordSegmentSortControl.setTitle("Date  ▼", forSegmentAt: index)
            }
            let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: dateSorter)
            recordFetchRequestController.fetchRequest.sortDescriptors = [dateSortDescriptor]
            
        case 1:
            exerciseSorter.toggle()
            if exerciseSorter == true {
                recordSegmentSortControl.setTitle("Exercise  ▲", forSegmentAt: index)
            } else {
                recordSegmentSortControl.setTitle("Exercise  ▼", forSegmentAt: index)
            }
            let exerciseSortDescriptor = NSSortDescriptor(key: "exerciseName", ascending: exerciseSorter)
            let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: dateSorter)
            recordFetchRequestController.fetchRequest.sortDescriptors = [exerciseSortDescriptor, dateSortDescriptor]
            
        default:
            break
        }
        addTapGenerator()
        performFetch()
        scrollToTop()
    }
    
    
    func scrollToTop() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
    
    
    func getTopExercises() -> [String: Int] {
        var exerciseDict: [String: Int] = [:]

        if let exercises = recordFetchRequestController.fetchedObjects {
            for objects in exercises {
                if let exerciseName = objects.exerciseName {
                    if let count = exerciseDict[exerciseName] {
                        exerciseDict[exerciseName] = count + 1
                    } else {
                        exerciseDict[exerciseName] = 1
                    }
                }
            }
        }
        return exerciseDict
    }
    
    
    func reFetchRecordsByCategory(_ name: String) {
        recordFetchRequestController.fetchRequest.predicate = NSPredicate(format: "categoryName like[cd] %@", name)
        addTapGenerator()
        performFetch()
        scrollToTop()
    }
    
    func reFetchRecordsByExercise(_ name: String) {
        recordFetchRequestController.fetchRequest.predicate = NSPredicate(format: "exerciseName like[cd] %@", name)
        addTapGenerator()
        performFetch()
        scrollToTop()
    }
    
    func reFetchRecordsByDate(_ date: NSDate) {
        let threeHoursAgo = date.addingTimeInterval(-10800)
        let threeHoursAfter = date.addingTimeInterval(10800)
        recordFetchRequestController.fetchRequest.predicate = NSPredicate(format: "date >= %@ && date <= %@ ", threeHoursAgo, threeHoursAfter)
        addTapGenerator()
        performFetch()
        scrollToTop()
    }
    
    @objc func showAllRecords() {
        recordFetchRequestController.fetchRequest.predicate = nil
        dateSorter = false
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: dateSorter)
        recordFetchRequestController.fetchRequest.sortDescriptors = [dateSortDescriptor]

        if let count = recordFetchRequestController.fetchedObjects?.count {
            if count > 0 {
                setupActivityIndicator()
                addTapGenerator()
                sortRecords()
            }
        }
        let delay = DispatchTime.now() + .milliseconds(750)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    func addTapGenerator() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    
    private func dateFormatter(_ date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = NSLocale.current
        let dateText = formatter.string(from: date)
        return dateText
    }
    
    private func dateFormatterFromString(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = NSLocale.current
        let date = formatter.date(from: date)!
        return date
    }
    
    @objc func editRecord(record: Record) {
        let addRecordViewController = AddRecordViewController()
        addRecordViewController.providesPresentationContextTransitionStyle = true
        addRecordViewController.definesPresentationContext = true
        addRecordViewController.modalPresentationStyle = .overCurrentContext
        addRecordViewController.record = record
        addRecordViewController.isSchemaRecord = false
        self.present(addRecordViewController, animated: true)
    }
    
    func deleteRecordAction(on vc: UIViewController, record: Record, indexPath: IndexPath) {
        self.recordFetchRequestController.managedObjectContext.delete(record)
        DatabaseController.saveContext()
    }
    
}


extension RecordsViewController: RecordDelegate {
    
    func sortByCategory(indexPath: IndexPath) {
        let record = recordFetchRequestController.object(at: indexPath)
        if let category = record.categoryName {
            reFetchRecordsByCategory(category)
        }
    }
    
    func sortByExercise(indexPath: IndexPath) {
        let record = recordFetchRequestController.object(at: indexPath)
        if let exercise = record.exerciseName {
            reFetchRecordsByExercise(exercise)
        }
    }
    
    func sortByDate(indexPath: IndexPath) {
        let record = recordFetchRequestController.object(at: indexPath)
        if let date = record.date {
            reFetchRecordsByDate(date)
        }
    }
}
