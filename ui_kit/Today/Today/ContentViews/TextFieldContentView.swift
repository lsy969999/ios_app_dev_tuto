//
//  TextFieldContentView.swift
//  Today
//
//  Created by SY L on 1/15/24.
//

import UIKit

class TextFieldContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        var onChange: (String) -> Void = {_ in }
        func makeContentView() -> UIView & UIContentView
        {
            return TextFieldContentView(self)
        }
    }
    
    var configuration: UIContentConfiguration
    {
        didSet {
            congifure(configuration: configuration)
        }
    }
    let textField = UITextField()
    override var intrinsicContentSize: CGSize
    {
        CGSize(
            width: 0,
            height: 44
        )
    }
    
    init(_ configuration: UIContentConfiguration)
    {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(
            textField,
            insets: UIEdgeInsets(
                top: 0,
                left: 16,
                bottom: 0,
                right: 16
            )
        )
        textField.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        textField.clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func congifure(configuration: UIContentConfiguration)
    {
        guard let configuration = configuration as? Configuration else {
            return
        }
        textField.text = configuration.text
    }
    
    @objc private func didChange(_ sender: UITextField) {
        guard let configuration = configuration as? TextFieldContentView.Configuration else {
            return
        }
        configuration.onChange(textField.text ?? "")
    }
}

extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration
    {
        TextFieldContentView.Configuration()
    }
}
