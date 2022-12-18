//
//  CheckBox.swift
//  CustomUIExample
//
//  Created by Leo Ho on 2022/12/18.
//

import UIKit

@MainActor class CheckBox: UIView {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // MARK: - Variables
    
    /// CheckBox 的委任
    weak var delegate: CheckBoxDelegate?
    
    /// CheckBox 是否被勾選
    private var isChecked: Bool = false {
        didSet {
            if isChecked {
                setupImageView(imageName: CheckBoxStatus.checked.imageName)
            } else {
                setupImageView(imageName: CheckBoxStatus.unchecked.imageName)
            }
        }
    }
    
    /// CheckBox 勾選狀態 enum
    enum CheckBoxStatus {
        
        /// 已勾選
        case checked
        
        /// 未勾選
        case unchecked
        
        /// 根據不同的勾選狀態，給予不同的 SF Symbols icon
        /// - Parameters:
        ///   - checked: 已勾選，SF Symbols icon 名稱是 `checkmark.square.fill`
        ///   - unchecked: 未勾選，SF Symbols icon 名稱是 `square`
        var imageName: String {
            switch self {
            case .checked:
                return "checkmark.square.fill"
            case .unchecked:
                return "square"
            }
        }
    }
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        addXibView()
    }
    
    // MARK: - UI Settings
    
    /// 設定 CheckBox UI 初始化
    /// - Parameters:
    ///   - tag: Int，用來判斷是點擊哪一個 CheckBox
    ///   - text: String，用來顯示 CheckBox 上的文字
    ///   - status: Bool，用來設定 CheckBox 是否被勾選
    ///   - delegate: CheckBoxDelegate，用來告知 CheckBox 點擊後的事件要讓哪個畫面／物件來代理
    func setInit(buttonTag tag: Int,
                 text: String,
                 isChecked status: Bool = false,
                 delegate: CheckBoxDelegate) {
        setupButton(tag: tag)
        isChecked = status
        setupLabel(text: text)
        self.delegate = delegate
    }
    
    private func setupButton(tag: Int) {
        button.setTitle("", for: .normal)
        button.tag = tag
    }
    
    private func setupImageView(imageName: String) {
        imageView.image = UIImage(systemName: imageName)
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setupLabel(text: String) {
        label.text = text
    }
    
    // MARK: - IBAction
    
    @IBAction func btnClicked(_ sender: UIButton) {
        isChecked.toggle()
        delegate?.checkBox(self, didTappedAt: sender.tag)
    }
}

// MARK: - Extensions

// 只有這個檔案可以呼叫的 Extension
fileprivate extension CheckBox {
    
    func addXibView() {
        if let loadView = Bundle(for: CheckBox.self).loadNibNamed("CheckBox", owner: self)?.first as? UIView {
            addSubview(loadView)
            loadView.frame = bounds
        }
    }
}

// MARK: - Protocol

protocol CheckBoxDelegate: NSObjectProtocol {
    
    /// 當點擊 CheckBox 時會觸發的 Method
    /// - Parameters:
    ///   - checkBox: CheckBox
    ///   - index: Int，用來判斷是點擊哪一個 CheckBox
    func checkBox(_ checkBox: CheckBox, didTappedAt index: Int)
}
