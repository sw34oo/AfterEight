//
//  RecordDetailViewController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-01-21.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit
import CoreData

class RecordDetailViewController: UIViewController {
    
    let swipeGestureRecognizer = UIPanGestureRecognizer()
    var visualEffectView = UIVisualEffectView(effect: nil)
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    var records: [Record]? {
        didSet {
            detailTableView.reloadData()
        }
    }
    
    var selectedIndex: Int = 0
    var averageWeight: Int = 0
    
        
    lazy var detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        records = nil
    }
    
    private func setupTableView() {
        navigationItem.largeTitleDisplayMode = .never
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(RecordTableViewGraphCell.self, forCellReuseIdentifier: RecordTableViewGraphCell.identifier)
        detailTableView.register(RecordTableViewDetailCell.self, forCellReuseIdentifier: RecordTableViewDetailCell.identifier)

        view.addSubview(detailTableView)
        NSLayoutConstraint.activate([
            detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailTableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            detailTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = UIColor.black
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        records = nil
    }
}








