import UIKit
import SnapKit

final class MovieQuizViewController: UIViewController {
    
    private lazy var questionTitleLabel: UILabel = {
        let label = UILabel(
            text: "Вопрос:",
            font: .ysDisplayMedium,
            size: 20,
            color: .ypWhite
        )
        return label
    }()
    
    private lazy var indexLabel: UILabel = {
        let label = UILabel(
            text: "1/10",
            font: .ysDisplayMedium,
            size: 20,
            color: .ypWhite,
            alignment: .right
        )
        return label
    }()
    
    private lazy var questionsIndexStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [questionTitleLabel, indexLabel])
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Deadpool")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel(
            text: "Рейтинг этого фильма меньше чем 5?",
            font: .ysDisplayBold,
            size: 23,
            color: .ypWhite,
            alignment: .center,
            numberOfLines: 2
        )
        return label
    }()
    
    private lazy var noButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Нет", for: .normal)
        btn.setTitleColor(.ypBlack, for: .normal)
        btn.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .ypWhite
        return btn
    }()
    
    private lazy var yesButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Да", for: .normal)
        btn.setTitleColor(.ypBlack, for: .normal)
        btn.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = .ypWhite
        return btn
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [noButton, yesButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var commonStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                questionsIndexStackView,
                previewImageView,
                questionLabel,
                buttonsStackView
            ]
        )
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .ypBlack
        view.addSubview(commonStackView)
    }
    
    private func setConstraints() {
       
        
        previewImageView.snp.makeConstraints {
            $0.width.equalTo(previewImageView.snp.height).multipliedBy(2.0 / 3.0)
        }
  
        
       
        
        buttonsStackView.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        commonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
