//
//  HJCollectionViewFlowLayout.m
//  UICollectionViewDemo
//
//  Created by HeJun on 10/07/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import "HJCollectionViewFlowLayout.h"

@implementation HJCollectionViewFlowLayout

/**
 * 开始布局
 */
- (void)prepareLayout {
	[super prepareLayout];
	
	self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	
	CGFloat insert = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
	self.sectionInset = UIEdgeInsetsMake(0, insert, 0, insert);
	self.minimumLineSpacing = 50;
}

/**
 * 初始化即将显示的控件，防止跳动
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewLayoutAttributes *attrs = [super layoutAttributesForItemAtIndexPath:indexPath];
	attrs.transform = CGAffineTransformMakeScale(0.5, 0.5);
	return attrs;
}

/**
 * 设置指定区域的控件的属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
	NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
	
	//获取偏移后的中点
	CGFloat centerX = self.collectionView.frame.size.width * 0.5 + self.collectionView.contentOffset.x;
	
	for (UICollectionViewLayoutAttributes *atts in attrsArray) {
		//获取距离偏移后中点距离
		CGFloat delta = fabs(atts.center.x - centerX);
		//获取缩放比例
		CGFloat scale = 1 - delta / self.collectionView.frame.size.width;
		//设置缩放
		atts.transform = CGAffineTransformMakeScale(scale, scale);
	}
	return attrsArray;
}

/**
 * 设置bounds 改变刷新控件
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	return YES;
}

/**
 * 获取手指停止滑动，离开屏幕后的偏移以及滑动方向
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
	//获取当前显示区域
	CGRect rect;
	rect.origin.x = proposedContentOffset.x;
	rect.origin.y = 0;
	rect.size = self.collectionView.frame.size;
	
	//获取当前显示区域所有Attributes
	NSArray<UICollectionViewLayoutAttributes *> *attrsArray = [super layoutAttributesForElementsInRect:rect];
	
	//获取偏移后的中点
	CGFloat centerX = self.collectionView.frame.size.width * 0.5 + proposedContentOffset.x;
	
	//获取距离偏移后中点最小的距离
	CGFloat minDelta = CGFLOAT_MAX;
	for (UICollectionViewLayoutAttributes *attrs in attrsArray) {
		if (fabs(minDelta) > fabs(attrs.center.x - centerX)) {
			minDelta = attrs.center.x - centerX;
		}
	}
	
	//设置修正过的偏移
	proposedContentOffset.x = proposedContentOffset.x + minDelta;
	return proposedContentOffset;
}


@end
