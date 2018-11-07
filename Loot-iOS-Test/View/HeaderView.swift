//
//  HeaderView.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    static let identifier = "headerView"

    var baseView: UIView = {
        var base = UIView()
        base.backgroundColor = .white
        return base
    }()

    var headerLabel: UILabel = {
        var lab = UILabel()
        lab.font = .systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        return lab
    }()

    var title: String? {
        didSet {
            headerLabel.text = title
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        tintColor = .white
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(baseView)
        baseView.addSubview(headerLabel)
    }

    func setupConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
    }
}
