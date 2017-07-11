//
//  HJCollectionCycleLayout.m
//  UICollectionViewDemo
//
//  Created by HeJun on 11/07/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import "HJCollectionCycleLayout.h"

@interface HJCollectionCycleLayout()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray;

@end

@implementation HJCollectionCycleLayout

/**
 * 开始布局
 */
- (void)prepareLayout {
	[super prepareLayout];
	
	[self.attrsArray removeAllObjects];
	[self initAttrsArray];
}

/**
 * 返回所有布局属性列表
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
	return self.attrsArray;
}

/**
 * 设置每一个item的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	//设置圆心
	CGFloat cyclePointX = self.collectionView.frame.size.width * 0.5;
	CGFloat cyclePointY = self.collectionView.frame.size.height * 0.5;
	
	//设置圆半径
	CGFloat cycleRadius = self.collectionView.frame.size.width * 0.3;
	
	//设置圆角(根据控件个数均分)
	CGFloat cycleAngle = 2 * M_PI / [self.collectionView numberOfItemsInSection:0];
	//每个item的实际圆角
	CGFloat itemAngle = cycleAngle * indexPath.item;
	
	//获取当前控件的布局属性
	UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
	attrs.center = CGPointMake(cyclePointX + cycleRadius * sinf(itemAngle), cyclePointY + cycleRadius * cosf(itemAngle));
	attrs.size = CGSizeMake(50, 50);
	return attrs;
}

/**
 * 初始化属性列表
 */
- (void)initAttrsArray {
	//我们这里只创建一个section
	NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
	
	for (NSInteger i = 0; i < itemCount; i++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
		UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
		[self.attrsArray addObject:attrs];
	}
}

#pragma mark - lazyload
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attrsArray {
	if (_attrsArray == nil) {
		_attrsArray = [NSMutableArray<UICollectionViewLayoutAttributes *> array];
	}
	return _attrsArray;
}

@end
