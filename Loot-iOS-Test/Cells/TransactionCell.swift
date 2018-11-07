//
//  TableViewCell.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import UIKit
import MapKit

class TransactionCell: UITableViewCell {

    static let identifier = "TransactionCell"

    var refreshCell:(() -> Void)?

    var baseView: UIView = {
        var base = UIView()
        base.backgroundColor = .white
        base.layer.cornerRadius = 15
        base.clipsToBounds = true
        return base
    }()
    var mainStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
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
        return lab
    }()
    var mapView: MKMapView = {
        var map = MKMapView()
        map.clipsToBounds = true
        map.isUserInteractionEnabled = false
        return map
    }()

    var model: TransactionModel? {
        didSet {
            updateUI()
        }
    }

    var isExpanded: Bool = false {
        didSet {
            isExpanded ? expandCell() : collapseCell()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        setup()
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        addSubview(baseView)
        baseView.addSubview(mainStack)
        baseView.addSubview(mapView)
        mainStack.addArrangedSubview(descriptionLabel)
        mainStack.addArrangedSubview(timeLabel)
        mainStack.addArrangedSubview(amountLabel)
    }

    func setupConstraints() {
        baseView.snp.remakeConstraints { make in
            make.edges.left.right.equalToSuperview().inset(8)
            make.top.right.equalToSuperview().inset(8)
            make.height.equalTo(100)
        }
        mainStack.snp.remakeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(mapView.snp.left)
        }
        mapView.snp.remakeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(baseView.snp.width).multipliedBy(0.25)
        }
    }

    func updateUI() {
        baseView.clipsToBounds = false
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOpacity = 0.2
        baseView.layer.shadowOffset = CGSize.zero
        baseView.layer.shadowRadius = 5
        guard let model = model else { return }
        descriptionLabel.text = model.description
        amountLabel.text = model.amountValue?.currencyFormat
        amountLabel.textColor = (model.amountValue?.isLess(than: 0) ?? false) ? .red : .green
        timeLabel.text = model.authDate?.readableTime()
        if let location = model.location {
            mapView.isHidden = false
            mapView.centerCoordinate = CLLocationCoordinate2D(latitude: Double(location.latitude) ?? 0, longitude: Double(location.longitude) ?? 0)
            let viewRegion = MKCoordinateRegion(center: mapView.centerCoordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
        } else {
            mapView.isHidden = true
        }
    }

    func expandCell() {
        UIView.animate(withDuration: 0.15) {
            self.baseView.snp.updateConstraints { make in
                make.height.equalTo(300)
            }
            self.mapView.snp.remakeConstraints { make in
                make.left.top.right.equalToSuperview()
                make.height.equalTo(200)
            }
            self.mainStack.snp.remakeConstraints { make in
                make.top.equalTo(self.mapView.snp.bottom)
                make.left.right.bottom.equalToSuperview().inset(12)
            }
            self.baseView.layoutIfNeeded()
            self.refreshCell?()
        }
    }

    func collapseCell() {
        setupConstraints()
        refreshCell?()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isExpanded = false
        model = nil
    }
}
