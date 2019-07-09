//
//  QuestionsViewController.swift
//  MBCleanSwiftExample
//
//  Created by Jason Tsai on 2019/7/5.
//  Copyright © 2019 Matchbox. All rights reserved.
//

import UIKit
import MBDomain
import RxSwift
import RxCocoa

class QuestionsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: QuestionsViewModel!
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView = UITableView.init(frame: self.view.frame, style: .grouped)
        self.view.addSubview(tableView)
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = QuestionsViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
                                         selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        
        output.questions.drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { tv, viewModel, cell in
                cell.textLabel?.text = viewModel.title
                cell.detailTextLabel?.text = viewModel.subtitle
            }.disposed(by: disposeBag)
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
//        output.createPost
//            .drive()
//            .disposed(by: disposeBag)
//        output.selectedPost
//            .drive()
//            .disposed(by: disposeBag)
    }

}
