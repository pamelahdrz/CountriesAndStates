//
//  CountryTableViewCell.swift
//  CountriesAndStates
//
//  Created by Pamela Hernández on 31/10/23.
//

import SnapKit
import UIKit

final class CountryTableViewCell: UITableViewCell {
    
    static let id: String = "CountryTableViewCell.cell"
    
    public let country           = UILabel()
    public let idLabel           = UILabel()
    public var flagImage         = UIImageView()
    
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        self.configureCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init not working")
    }
    
    func configure(with data: ValuesGetPaises) {
        let countryName = Country(rawValue: data.nombrePais ?? "")
    
        self.country.text = data.nombrePais
        self.idLabel.text = data.idPais?.stringValue
        
        switch countryName {
        case .Mexico:
            self.flagImage.image = UIGeneral.MXFlag
        case .USA:
            self.flagImage.image = UIGeneral.USFlag
        case .none:
            break
        }
    }
    
    private func configureCellView() {
        
        self.country.numberOfLines    = 1
        self.country.textColor        = .label
        self.country.font             = .systemFont(ofSize: 20, weight: .bold)
        self.country.textAlignment    = .left
        
        self.idLabel.textColor        = .systemGray
        self.idLabel.font             = .systemFont(ofSize: 15, weight: .medium)
        self.idLabel.textAlignment    = .left
        
        self.addSubview(self.flagImage)
        self.flagImage.clipsToBounds              = true
        self.flagImage.layer.cornerRadius         = UIGeneral.cornerRadius
        self.flagImage.backgroundColor            = .systemGray4
        self.flagImage.contentMode                = .scaleAspectFill
        self.flagImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIGeneral.padding)
            make.horizontalEdges.equalToSuperview().inset(UIGeneral.padding)
            make.height.equalTo(self.flagImage.snp.width).multipliedBy(UIGeneral.multipliedBy)
        }
        
        let stackView = UIStackView(arrangedSubviews: [self.country, self.idLabel])
        self.addSubview(stackView)
        stackView.distribution  = .fill
        stackView.axis          = .vertical
        stackView.spacing       = 6
        stackView.alignment     = .top
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.flagImage.snp.bottom).inset(-UIGeneral.cellVertical)
            make.left.right.equalTo(self.flagImage)
            make.bottom.equalToSuperview().inset(UIGeneral.lowPadding)
        }
    }
}
