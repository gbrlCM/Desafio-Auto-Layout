import UIKit

class AvatarView: UIView {
    private let avatarImage: UIImageView
    
    init(avatar: UIImage) {
        avatarImage = UIImageView(image: avatar)
        super.init(frame: .zero)
        
        backgroundColor = .white
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.contentMode = .scaleAspectFit
        addSubview(avatarImage)
        
        NSLayoutConstraint.activate([
            avatarImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -10),
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            avatarImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
