//
//  HJCollectionViewCell.m
//  UICollectionViewDemo
//
//  Created by HeJun on 10/07/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import "HJCollectionViewCell.h"

@interface HJCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation HJCollectionViewCell

- (void)setImageName:(NSString *)imageName {
	_imageName = [imageName copy];
	
	self.iconView.image = [UIImage imageNamed:imageName];
}



@end
