//
//  PostCollectionViewCell.swift
//  Cargram
//
//  Created by Ferhan Akkan on 19.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Firebase
import PromiseKit

final class PostCollectionViewCell: UICollectionViewCell {
    
    let senderImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    let usernameLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = .black
        title.numberOfLines = 1
        return title
    }()
    
    let moreView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "more")
        return image
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let likeAnimation: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let deleteImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "trash")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let likeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "nonLike")
        return image
    }()
    
    let commitImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "comment")
        return image
    }()
    
    let likeLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = UIColor.darkGray.withAlphaComponent(0.6)
        title.numberOfLines = 1
        return title
    }()
    
    let senderInitialCommit: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 20)
        title.textColor = .black
        title.numberOfLines = 0
        return title
    }()
    
    let otherUserCommits: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = .black
        title.numberOfLines = 1
        return title
    }()
    
    let howManyTimesAgoLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = UIColor.darkGray.withAlphaComponent(0.6)
        title.numberOfLines = 1
        return title
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: bounds.size.height))
    }
    
    let firebase = FirebasePostService()
    weak var delegate: PostDeleteAction?
    var likeAnimationImages: [UIImage] = []
    var commitArray: [CommitModel] = []
    var likeArray: [LikeModel] = []
    var isLiked = false
    
    var postModel: PostModel? = nil {
        didSet {
            if postModel != nil {
                usernameLabel.text = postModel!.username
                senderInitialCommit.text = postModel!.commit
                senderImageView.kf.setImage(with: URL(string: postModel!.senderProfileImage))
                imageView.kf.setImage(with: URL(string: postModel!.imageUrl))
                
                postModel!.username == Auth.auth().currentUser!.displayName! ?  (deleteImageView.isHidden = false) :  (deleteImageView.isHidden = true)
                howManyTimesAgoLabel.text = Date(timeIntervalSince1970: postModel!.date).calenderTimeSinceNow()
                getCommitDatas()
                getLikeDatas()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        likeAnimationImages = likeAnimationImages.createImageArray(total: 24, imagePrefix: "heart")
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup UI

extension PostCollectionViewCell {
    
    private func setUI() {
        contentView.backgroundColor = .white
        setSenderImageView()
        setUsernameLabel()
        setImageView()
        setLikeAnimation()
        setMore()
        setTrash()
        setLikeImageView()
        setCommitImageView()
        setLikeLabel()
        setSenderInitialCommit()
        setOtherUserCommit()
        setHowManyTimeAgoLabel()
    }
    
    private func setSenderImageView() {
        contentView.addSubview(senderImageView)
        senderImageView.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(30)
        }
        senderImageView.makeRoundWithBorder(borderColor: .black, borderWidth: 1, cornerRadius: 15)
    }
    
    private func setUsernameLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(senderImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(senderImageView.snp.centerY)
        }
    }
    
    private func setImageView() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(senderImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width*9/16)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageDoubleTap))
        tap.numberOfTapsRequired = 2
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    private func setLikeAnimation() {
        imageView.addSubview(likeAnimation)
        likeAnimation.snp.makeConstraints { (make) in
            make.height.width.equalTo(80)
            make.center.equalToSuperview()
        }
        likeAnimation.isHidden = true
    }
    
    private func setTrash() {
        contentView.addSubview(deleteImageView)
        deleteImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(senderImageView.snp.centerY)
            make.trailing.equalTo(moreView.snp.leading).offset(-10)
            make.height.width.equalTo(20)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(deleteButtonPressed))
        deleteImageView.isUserInteractionEnabled = true
        deleteImageView.addGestureRecognizer(gest)
    }
    
    private func setMore() {
        contentView.addSubview(moreView)
        moreView.snp.makeConstraints { (make) in
            make.centerY.equalTo(senderImageView.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(20)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(moreButtonPressed))
        moreView.isUserInteractionEnabled = true
        moreView.addGestureRecognizer(gest)
    }
    
    private func setLikeImageView() {
        contentView.addSubview(likeImageView)
        likeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(30)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(likeButtonPressed))
        likeImageView.isUserInteractionEnabled = true
        likeImageView.addGestureRecognizer(gest)
    }
    
    private func setCommitImageView() {
        contentView.addSubview(commitImageView)
        commitImageView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(likeImageView.snp.trailing).offset(10)
            make.height.width.equalTo(30)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(commitButtonPressed))
        commitImageView.isUserInteractionEnabled = true
        commitImageView.addGestureRecognizer(gest)
    }
    
    private func setLikeLabel() {
        contentView.addSubview(likeLabel)
        likeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(howManyLikeButtonPressed))
        likeLabel.isUserInteractionEnabled = true
        likeLabel.addGestureRecognizer(gest)
    }
    
    private func setSenderInitialCommit() {
        contentView.addSubview(senderInitialCommit)
        senderInitialCommit.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(likeImageView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setOtherUserCommit() {
        contentView.addSubview(otherUserCommits)
        otherUserCommits.snp.makeConstraints { (make) in
            make.top.equalTo(senderInitialCommit.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(commitButtonPressed))
        otherUserCommits.isUserInteractionEnabled = true
        otherUserCommits.addGestureRecognizer(gest)
    }
    
    private func setHowManyTimeAgoLabel() {
        contentView.addSubview(howManyTimesAgoLabel)
        howManyTimesAgoLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(otherUserCommits.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(10)
        }
        let gest = UITapGestureRecognizer(target: self, action: #selector(howManyLikeButtonPressed))
        howManyTimesAgoLabel.isUserInteractionEnabled = true
        howManyTimesAgoLabel.addGestureRecognizer(gest)
    }
}

//MARK: - Actions

extension PostCollectionViewCell {
    
    @objc private func moreButtonPressed() {
        let alert: UIAlertController = UIAlertController(title: "Chose what do you want to do ?", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Report", style: UIAlertAction.Style.default) {
            UIAlertAction in
            LoadingView.show()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                LoadingView.hide()
                AppManager.shared.messagePresent(title: "Thanks", message: "We will inspect the post to control is there anything banned.", type: .success, isInternet: .nonInternetAlert)
            }
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)

        
        let groundView = UIApplication.getPresentedViewController()!.view
        
        alert.popoverPresentationController?.sourceView = groundView!
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: groundView!.bounds.midX, y: groundView!.bounds.midY, width: 0, height: 0)
        UIApplication.getPresentedViewController()!.present(alert, animated: true)

    }
    
    
    @objc private func imageDoubleTap() {
        if !isLiked {
            likeImageView.isUserInteractionEnabled = false
            imageView.isUserInteractionEnabled = false
            likeAnimation.animate(images: likeAnimationImages)
            firstly {
                firebase.postLike(postId: postModel!.documentID, imageUrl: postModel!.senderProfileImage)
            }.done { [unowned self] (_) in
                DispatchQueue.main.async {
                    self.likeImageView.image = UIImage(named: "like")
                    self.getLikeDatas()
                }
            }.ensure {
                self.imageView.isUserInteractionEnabled = true
                self.likeImageView.isUserInteractionEnabled = true
            }.catch { (_) in
                DispatchQueue.main.async {
                    self.likeImageView.image = UIImage(named: "nonLike")
                }
            }
        }
    }
    
    @objc private func likeButtonPressed() {
        if isLiked {
            let myLikeData = likeArray.filter({$0.sender == Auth.auth().currentUser!.displayName!})
            likeImageView.isUserInteractionEnabled = false
            firstly {
                firebase.deleteLike(postId: myLikeData[0].postID, likeId: myLikeData[0].likeID)
            }.done { [unowned self] (_) in
                DispatchQueue.main.async {
                    self.likeImageView.image = UIImage(named: "nonLike")
                    self.getLikeDatas()
                }
            }.ensure {
                self.likeImageView.isUserInteractionEnabled = true
            }.catch { (_) in
                DispatchQueue.main.async {
                    self.likeImageView.image = UIImage(named: "Like")
                }
            }
        } else {
            likeImageView.isUserInteractionEnabled = false
            likeAnimation.animate(images: likeAnimationImages)
            let backupProfileImageUrl = "https://firebasestorage.googleapis.com/v0/b/cargram-c4400.appspot.com/o/profileImage%2Favatar.png?alt=media&token=51c49218-1fea-4216-b997-e075872d2c5a"
            firstly {
                firebase.postLike(postId: postModel!.documentID, imageUrl: Auth.auth().currentUser!.photoURL?.absoluteString ?? backupProfileImageUrl)
            }.done { [unowned self] (_) in
                DispatchQueue.main.async {
                    self.likeImageView.image = UIImage(named: "like")
                    self.getLikeDatas()
                }
            }.ensure {
                self.likeImageView.isUserInteractionEnabled = true
            }.catch { (_) in
                DispatchQueue.main.async {
                    self.likeImageView.image = UIImage(named: "nonLike")
                }
            }
        }
    }
    
    @objc private func commitButtonPressed() {
        let vc = CommitViewController()
        vc.delegate = self
        vc.commitViewModel.commitArray = commitArray
        vc.commitViewModel.postID = postModel?.documentID
        UIApplication.getPresentedViewController()!.present(vc, animated: true)
    }
    
    @objc private func howManyLikeButtonPressed() {
        let vc = LikeViewController()
        vc.likeViewModel.likeArray = likeArray
        vc.delegate = self
        UIApplication.getPresentedViewController()!.present(vc, animated: true)
    }
    
    @objc private func deleteButtonPressed() {
        let alert = UIAlertController(title: "Do you want to delete your post ?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { [unowned self] action in
            LoadingView.show()
            firstly {
                self.firebase.deletePost(postId: self.postModel!.documentID)
            }.done { [unowned self]() in
                self.delegate?.postDeleted()
            }.ensure {
                LoadingView.hide()
            }.catch { (err) in
                AppManager.shared.messagePresent(title: "OOPS", message: err.localizedDescription, type: .error, isInternet: .nonInternetAlert)
            }
        }))
        
        let groundView = UIApplication.getPresentedViewController()!.view
        
        alert.popoverPresentationController?.sourceView = groundView!
        alert.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        alert.popoverPresentationController?.sourceRect = CGRect(x: groundView!.bounds.midX, y: groundView!.bounds.midY, width: 0, height: 0)
        UIApplication.getPresentedViewController()!.present(alert, animated: true)
    }
}

//MARK: - Fetch Commit & Likes

extension PostCollectionViewCell {
    
    func getLikeDatas() {
        firstly {
            firebase.fetchLikes(postID: postModel!.documentID)
        }.done { [unowned self] (likeArrayResponse) in
            self.likeArray = likeArrayResponse
            let count = likeArrayResponse.count
            self.isLiked = likeArrayResponse.contains { (data) -> Bool in
                if data.sender == Auth.auth().currentUser!.displayName! {
                    return true
                } else {
                    return false
                }
            }
            DispatchQueue.main.async {
                self.isLiked ? (self.likeImageView.image = UIImage(named: "like")) : (self.likeImageView.image = UIImage(named: "nonLike"))
                self.likeLabel.text = "\(count) Likes"
            }
        }.catch { (err) in
            AppManager.shared.messagePresent(title: "OOOPS", message: err.localizedDescription, type: .error, isInternet: .nonInternetAlert)
        }
    }
    
    func getCommitDatas() {
        firstly {
            firebase.fetchCommit(postID: postModel!.documentID)
        }.done { [unowned self] (commitArrayResponse) in
            self.commitArray = commitArrayResponse
            let count = commitArrayResponse.count
            self.otherUserCommits.text = "\(count) times commited"
        }.catch { (err) in
            AppManager.shared.messagePresent(title: "OOOPS", message: err.localizedDescription, type: .error, isInternet: .nonInternetAlert)
        }
    }
}

//MARK: - Like Deleted

extension PostCollectionViewCell: LikeDeleted , CommitDeleted {
    func commitDataDeleted() {
        getCommitDatas()
    }
    
    func likeDataDeleted() {
        getLikeDatas()
    }
}

//MARK: - POST Delete Protocol

protocol PostDeleteAction:AnyObject {
    func postDeleted()
}
