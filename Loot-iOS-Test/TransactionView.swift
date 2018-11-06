//
//  TransactionView.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import UIKit

class TransactionView: UIView {

    var baseView: UIView = {
        var view = UIView()
        return view
    }()

    lazy var tableView: UITableView = {
        var table = UITableView()
        table.allowsSelection = false
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(baseView)
        baseView.addSubview(tableView)
    }

}
