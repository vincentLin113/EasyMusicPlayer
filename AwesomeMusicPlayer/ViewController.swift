//
//  ViewController.swift
//  AwesomeMusicPlayer
//
//  Created by Vincent Lin on 2018/9/1.
//  Copyright © 2018 Vincent Lin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public struct Song {
    var songTitle: String = ""
    var songStreamURL: String = ""
    var songAuthor: String = ""
    var converURL: String = ""
    
    public init(json: JSON) {
        self.songTitle = json["songTitle"].stringValue
        self.songStreamURL = json["songStreamURL"].stringValue
        self.songAuthor = json["songAuthor"].stringValue
        self.converURL = json["coverURL"].stringValue
    }
}

class ViewController: UIViewController {
    
    fileprivate var songs: [Song] = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "SongCell", bundle: nil), forCellWithReuseIdentifier: "SongCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        // https://s3-ap-northeast-1.amazonaws.com/itworm/Song0901.json
        if let url = URL(string: "https://s3-ap-northeast-1.amazonaws.com/itworm/Song0901.json") {
            //
            Alamofire.request(url).responseData { (data) in
//                print("data: \(data)")
                let json = JSON(data.data!)
                print("json: \(json)")
                let songs = json["songs"].arrayValue
                for song in songs {
                    let model = Song(json: song)
                    self.songs.append(model)
                }
                print("songsCount: \(self.songs.count)")
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
    }

}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCell", for: indexPath) as? SongCell else {
            assert(false)
            return UICollectionViewCell()
        }
        
        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250.0, height: 250.0)
    }
}











