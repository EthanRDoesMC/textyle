@interface TXTStyleSelectionController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
- (void)reload;
@end
