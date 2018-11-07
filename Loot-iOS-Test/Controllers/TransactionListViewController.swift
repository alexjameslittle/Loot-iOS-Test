//
//  ViewController.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import UIKit

class TransactionListViewController: UIViewController {

    var transactionView: TransactionView? { return self.view as? TransactionView }

    var sections: [Date] {
        return DataSingleton.shared.transactionDates
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = TransactionView()
        transactionView?.tableView.dataSource = self
        transactionView?.tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.title = "Recent"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: .DidUpdateTransactions, object: nil)
        DataSingleton.shared.updateTransactions()
    }

    @objc func refreshData() {
        DispatchQueue.main.async {
            if let currentAmount = Double(DataSingleton.shared.transactions.first?.postTransactionBalance ?? "") {
                self.title = currentAmount.currencyFormat
            } else {
                self.title = "Transactions"
            }
            self.transactionView?.tableView.reloadData()
        }
    }
}

extension TransactionListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TransactionCell {
            cell.baseView.popIn()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView {
            if let date = sections[safe: section] {
                header.title = date.readableDate()
            }
            return header
        } else {
            return nil
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let date = sections[safe: section] {
            return DataSingleton.shared.transactionsForDate(date: date).count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell {
            if let date = sections[safe: indexPath.section] {
                let models = DataSingleton.shared.transactionsForDate(date: date)
                cell.model = models[safe: indexPath.row]
                cell.refreshCell = {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TransactionCell {
            if (cell.model?.location) != nil {
                cell.isExpanded = !cell.isExpanded
            }
        }
    }
}
