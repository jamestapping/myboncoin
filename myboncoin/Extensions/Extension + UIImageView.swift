//
//  Extention + UIImageView.swift
//  myboncoin
//
//  Created by James Tapping on 04/04/2023.
//

import UIKit

extension UIImageView {
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

