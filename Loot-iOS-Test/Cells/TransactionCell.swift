//
//  TableViewCell.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    static let identifier = "TransactionCell"

    var baseView: UIView = {
        var base = UIView()
        return base
    }()
    var mainStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    var stack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    var descriptionLabel: UILabel = {
        var lab = UILabel()
        lab.font = .systemFont(ofSize: 18, weight: .medium)
        return lab
    }()
    var amountLabel: UILabel = {
        var lab = UILabel()
        lab.font = .systemFont(ofSize: 14, weight: .regular)
        return lab
    }()
    var timeLabel: UILabel = {
        var lab = UILabel()
        lab.textAlignment = .right
        return lab
    }()

    var model: TransactionModel? {
        didSet {
            updateUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(baseView)
        baseView.addSubview(mainStack)
        mainStack.addArrangedSubview(descriptionLabel)
        mainStack.addArrangedSubview(stack)
        stack.addArrangedSubview(amountLabel)
        stack.addArrangedSubview(timeLabel)
    }

    func setupConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.left.right.equalToSuperview().inset(20)
            make.top.right.equalToSuperview()
            make.height.equalTo(80)
        }
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func updateUI() {
        guard let model = model else { return }
        descriptionLabel.text = model.description
        amountLabel.text = model.amountValue?.currencyFormat
        timeLabel.text = model.authDate?.readableTime()
    }
}
