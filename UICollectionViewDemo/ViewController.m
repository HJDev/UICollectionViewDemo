//
//  ViewController.m
//  UICollectionViewDemo
//
//  Created by HeJun on 10/07/2017.
//  Copyright © 2017 HeJun. All rights reserved.
//

#import "ViewController.h"
#import "HJCollectionViewFlowLayout.h"
#import "HJCollectionCycleLayout.h"
#import "HJCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<NSString *> *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
//	HJCollectionViewFlowLayout *layout = [[HJCollectionViewFlowLayout alloc] init];
//	layout.itemSize = CGSizeMake(150, 130);
//	layout.scrollDirection = UICollectionViewScrollDirectionVertical;
	
	HJCollectionCycleLayout *cycleLayout = [[HJCollectionCycleLayout alloc] init];
	self.collectionView.dataSource = self;
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.collectionViewLayout = cycleLayout;
	[self.collectionView registerNib:[UINib nibWithNibName:@"HJCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([HJCollectionViewCell class])];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	HJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HJCollectionViewCell class]) forIndexPath:indexPath];
	
	if (indexPath.item >= self.dataList.count) {
		return cell;
	}
	NSString *imageName = [self.dataList objectAtIndex:indexPath.item];
	cell.imageName = imageName;
	return cell;
}

#pragma mark - lazyload
- (NSMutableArray<NSString *> *)dataList {
	if (_dataList == nil) {
		_dataList = [NSMutableArray<NSString *> array];
		for (NSInteger i = 1; i <= 20; i++) {
			NSString *imageName = [NSString stringWithFormat:@"%ld", i];
			[_dataList addObject:imageName];
		}
	}
	return _dataList;
}


@end
