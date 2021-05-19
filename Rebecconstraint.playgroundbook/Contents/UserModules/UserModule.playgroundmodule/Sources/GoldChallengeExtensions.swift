
import UIKit

extension UIImageView {
    
    func loadFromUnsplash(_ tag: String) {
        guard let url = URL(string: "https://source.unsplash.com/featured/?camarão".urlValid()) else { 
            print(tag)
            return 
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension String {
    func urlValid() -> String{
        let initialValue = self
        
        let stringWithoutSpecialCharacters = initialValue.map {char in
            return self.replaceSpecialCharacter(char)
        }
        let finalValue = String(stringWithoutSpecialCharacters).replaceBlankSpace()
        
        return finalValue
    }
    
    private func replaceBlankSpace() -> String {
        let string = self
        
        var stringCollection: [String] = []
        
        string.forEach { char in
            if char == " " {
                stringCollection.append("%20")
            } else {
                stringCollection.append(String(char))
            }
        }
        
        return stringCollection.joined(separator: "")
    }
    
    private func replaceSpecialCharacter(_ char: Character) -> Character {
        let lowerCasedChar = char.lowercased()
        
        if lowerCasedChar == "ã" || lowerCasedChar == "á" || lowerCasedChar == "à" || lowerCasedChar == "â" {
            return "a"
        } 
        else if lowerCasedChar == "é" || lowerCasedChar == "è" || lowerCasedChar == "ê" {
            return "e"
        }
        else if lowerCasedChar == "í" || lowerCasedChar == "ì" || lowerCasedChar == "î" {
            return "i"
        }
        if lowerCasedChar == "õ" || lowerCasedChar == "ó" || lowerCasedChar == "ò" || char == "ô" {
            return "o"
        } 
        else if lowerCasedChar == "ú" || lowerCasedChar == "ù" || lowerCasedChar == "û" {
            return "e"
        }
        
        return char
    }
}
