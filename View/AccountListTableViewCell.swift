//
//  AccountListTableViewCell.swift
//  V2ex-Swift
//
//  Created by huangfeng on 2/11/16.
//  Copyright © 2016 Fin. All rights reserved.
//

import UIKit

class AccountListTableViewCell: UITableViewCell {
    var avatarImageView:UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.backgroundColor = UIColor(white: 0.9, alpha: 0.3)
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 22
        return avatarImageView
    }()
    var userNameLabel:UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.textColor = V2EXColor.colors.v2_TopicListUserNameColor
        userNameLabel.font = v2Font(14)
        return userNameLabel
    }()
    var usedLabel:UILabel = {
        let usedLabel = UILabel()
        usedLabel.textColor = V2EXColor.colors.v2_NoticePointColor
        usedLabel.font = v2Font(11)
        usedLabel.text = "正在使用"
        return usedLabel
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup()->Void{
        self.selectionStyle = .None
        self.backgroundColor = V2EXColor.colors.v2_CellWhiteBackgroundColor

        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.userNameLabel)
        self.contentView.addSubview(self.usedLabel)
        let separator = UIImageView(image: createImageWithColor(V2EXColor.colors.v2_SeparatorColor))
        self.contentView.addSubview(separator)

        self.usedLabel.hidden = true;

        self.avatarImageView.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(self.contentView).offset(15)
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(self.avatarImageView.layer.cornerRadius * 2)
        }
        self.userNameLabel.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(self.avatarImageView.snp_right).offset(15)
            make.centerY.equalTo(self.avatarImageView)
        }
        self.usedLabel.snp_makeConstraints{ (make) -> Void in
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.avatarImageView)
        }
        separator.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(self.avatarImageView.snp_right).offset(5)
            make.right.bottom.equalTo(self.contentView)
            make.height.equalTo(SEPARATOR_HEIGHT)
        }
    }
    
    func bind(model:LocalSecurityAccountModel) {
        self.userNameLabel.text = model.username
        if let avatar = model.avatar , let url = NSURL(string: avatar) {
            self.avatarImageView.kf_setImageWithURL(url)
        }
        if V2User.sharedInstance.username == model.username {
            self.usedLabel.hidden = false
        }
        else {
            self.usedLabel.hidden = true
        }
    }
}
