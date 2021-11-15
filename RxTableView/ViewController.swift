//
//  ViewController.swift
//  RxTableView
//
//  Created by Dugong on 2021/11/15.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dragInteractionEnabled = true
        table.dragDelegate = self
        table.dropDelegate = self
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        table.backgroundColor = .systemFill
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        bind()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.frame.size = view.frame.size
        tableView.center = view.center
    }

    private func bind() {
        let datasource = Observable.just([
            CellModel(title: "title1", description1: "description1"),
            CellModel(title: "title2", description1: "description2"),
            CellModel(title: "title3", description1: "description3")
        ])
        datasource.bind(to: tableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)){ row, model, cell in
            cell.configureCell(model: model)
        }.disposed(by: disposeBag)

    }

    
}

extension ViewController: UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        return [UIDragItem(itemProvider: NSItemProvider())]
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print(coordinator)
    }


}
