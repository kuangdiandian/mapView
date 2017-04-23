//
//  KGBHomeVC.m
//  MyDiDi
//
//  Created by 邝贵斌 on 17/4/23.
//  Copyright © 2017年 kuangguibin. All rights reserved.
//

#import "KGBHomeVC.h"

#import "KGBFastCarVC.h"
#import "KGBTaxiCarVC.h"
#import "KGBSpeciallyCarVC.h"
#import "KGBPassinglyCarVC.h"
#import "KGBReplaceCarVC.h"
#import "KGBBusCarVC.h"
#import "KGBMyCarVC.h"
#import "KGBTryCarVC.h"
#import "KGBOldCarVC.h"


#import "KGBTextSize.h"
#import "MMBarButtonItem.h"
#import "MMSideslipDrawer.h"

static  NSInteger const barH = 20;
static  NSInteger const titleBarH = 44;
static  NSInteger const btnW = 60;
static  NSInteger const NaVCH = 44;
static  NSInteger const menuW = 40;//标题栏右边预留的宽度
static  NSString* const ID = @"CellID";

@interface KGBHomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,MMSideslipDrawerDelegate>
//侧滑菜单
@property (nonatomic, strong) MMSideslipDrawer *slipDrawer;


/**标题栏底部 scroolView*/
@property(nonatomic,weak) UIScrollView*contentTitleView;
/**保存选中的按钮状态*/
@property(nonatomic,strong) UIButton*  selectBtn;
/**子控制器的个数*/
@property(nonatomic,assign) NSUInteger  subCount;
/**存放子控制器的 View*/
@property(nonatomic,weak) UICollectionView*contentCollectionV;
/**保存所有的标题按钮*/
@property(nonatomic,strong) NSMutableArray*  btnArrM;
@end

@implementation KGBHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加子控制器
    [self  kgb_setupChildViewController];
    //设置标题栏
    [self  setupTitleBar];
    //设置自控制器的 View
    [self  setupSaveSubView];
    
    //设置导航条按钮
    [self drawerNavcbarBtn];
}



#pragma mark ----------------------------------------------
#pragma mark ---抽屉相关
-(void)drawerNavcbarBtn{
    //1.左边按钮
    MMBarButtonItem *leftItem = [[MMBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_left"] target:self action:@selector(leftDrawerButtonPress:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    //2,右边按钮
    MMBarButtonItem *rightItem = [[MMBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_right"] target:self action:@selector(rightDrawerButtonPress:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//设置抽屉里面的内容
- (MMSideslipDrawer *)slipDrawer
{
    if (!_slipDrawer)
    {
        MMSideslipItem *item = [[MMSideslipItem alloc] init];
        item.thumbnailPath = [[NSBundle mainBundle] pathForResource:@"menu_head@2x" ofType:@"png"];
        item.name = @"LEA";
        item.vip = @"普通会员";
        item.vipImageName = @"menu_vip";
        item.textArray = @[@"行程",@"钱包",@"客服",@"设置"];
        item.imageNameArray = @[@"menu_0",@"menu_1",@"menu_2",@"menu_3"];
        
        _slipDrawer = [[MMSideslipDrawer alloc] initWithDelegate:self slipItem:item];
    }
    return _slipDrawer;
}


//监听抽屉里面按钮的店里
- (void)slipDrawer:(MMSideslipDrawer *)slipDrawer didSelectAtIndex:(NSInteger)index
{
    [slipDrawer colseLeftDrawerSide];
    NSLog(@"点击的index:%ld",(long)index);
}

//点击抽屉里面的头像
- (void)didViewUserInformation:(MMSideslipDrawer *)slipDrawer
{
    [slipDrawer colseLeftDrawerSide];
    NSLog(@"点击头像");
}

//点击抽屉里面的会员
- (void)didViewVIPInformation:(MMSideslipDrawer *)slipDrawer
{
    [slipDrawer colseLeftDrawerSide];
    NSLog(@"点击会员");
}



//点击导航条左侧按钮
- (void)leftDrawerButtonPress:(id)sender
{
    [self.slipDrawer openLeftDrawerSide:self.view.window];
}

//点击导航条右侧按钮
- (void)rightDrawerButtonPress:(id)sender
{
    NSLog(@"右边点击");
}



#pragma mark ----------------------------------------------
#pragma mark ---添加子控制器
//添加子控制器
-(void)kgb_setupChildViewController{
    //快车
    KGBFastCarVC*fastVC = [[KGBFastCarVC  alloc] init];
    [self  addChildViewController:fastVC];
    fastVC.title = @"快车";
    
    //出租车
    KGBTaxiCarVC*taxiVC = [[KGBTaxiCarVC  alloc] init];
    [self  addChildViewController:taxiVC];
    taxiVC.title = @"出租车";
    
    //专车
     KGBSpeciallyCarVC*specialVC = [[KGBSpeciallyCarVC  alloc] init];
    [self  addChildViewController:specialVC];
     specialVC.title = @"专车";
    
    //顺风车
    KGBPassinglyCarVC*passingVC = [[KGBPassinglyCarVC  alloc] init];
    [self  addChildViewController:passingVC];
    passingVC.title = @"顺风车";
    
    //代驾
    KGBReplaceCarVC*replaceVC = [[KGBReplaceCarVC  alloc] init];
    [self  addChildViewController:replaceVC];
    replaceVC.title = @"代驾";
    
    //公交
    KGBBusCarVC*busVC = [[KGBBusCarVC  alloc] init];
    [self  addChildViewController:busVC];
    busVC.title = @"公交";
    
    //自驾
    KGBMyCarVC*myVC = [[KGBMyCarVC  alloc] init];
    [self  addChildViewController:myVC];
    myVC.title = @"自驾";
    
    //试驾
    KGBTryCarVC*tryVC = [[KGBTryCarVC  alloc] init];
    [self  addChildViewController:tryVC];
    tryVC.title = @"试驾";
    
    //老年车
    KGBOldCarVC*oldVC = [[KGBOldCarVC  alloc] init];
    [self  addChildViewController:oldVC];
    oldVC.title = @"老年车";
    
}



#pragma mark ----------------------------------------------
#pragma mark ---collectionView 相关
//存放子控制器的 View
-(void)setupSaveSubView{
    CGFloat  collectionY = barH+titleBarH+NaVCH;
    CGFloat  collectionH = KGBScreenH - collectionY ;
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout  alloc] init];
    //设置每个 格子的尺寸
    flowLayout.itemSize=CGSizeMake(KGBScreenW, KGBScreenH-44 -44 +20);
    //设置最小行间距(理解为每一行)
    flowLayout.minimumLineSpacing=0;
    //    设置最小间隔(理解为每一列)
    flowLayout.minimumInteritemSpacing=0;
    //设置滚动方向
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    
    
    UICollectionView*contentCollectionV = [[UICollectionView  alloc] initWithFrame:CGRectMake(0,collectionY , KGBScreenW, collectionH) collectionViewLayout:flowLayout];
    contentCollectionV.pagingEnabled = YES; //分页
    contentCollectionV.dataSource = self;
    contentCollectionV.delegate = self;
    [contentCollectionV  registerClass:[UICollectionViewCell  class] forCellWithReuseIdentifier:ID];
    self.contentCollectionV = contentCollectionV;
    contentCollectionV.bounces = NO; //取消弹簧效果
    
    [self.view  addSubview:contentCollectionV];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell*cell = [collectionView  dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    //添加子控制器的 View
    UIViewController* VC = self.childViewControllers[indexPath.row];
    [cell.contentView  addSubview:VC.view];
    
    return cell;
}

#pragma mark ----------------------------------------------
#pragma mark ---处理 cell 与标题按钮联动
//collectionView 滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //随 cell 的滚动标题按钮选中
    NSInteger  index = self.contentCollectionV.contentOffset.x/self.contentCollectionV.bounds.size.width;
    [self  btnSelect:self.btnArrM[index]];
    
    //随 cell 的滚动让选中按钮居中显示
    [self  offsetCellAndTitleButtonChange:self.btnArrM[index]];
}

//随 cell 的滚动让选中按钮居中显示
-(void)offsetCellAndTitleButtonChange:(UIButton*)btn{
    CGFloat  offsetX = btn.center.x - KGBScreenW*0.5;
    CGFloat  offsetY = self.contentTitleView.contentOffset.y;
    
    //判断左侧滑到低了
    if (offsetX < 0) {
        offsetX = 0;
    }
    //判断右侧滑到低了
    if (offsetX > self.contentTitleView.contentSize.width - (KGBScreenW-menuW)) {
        offsetX = self.contentTitleView.contentSize.width - (KGBScreenW-menuW);
    }
   
    [self.contentTitleView setContentOffset:CGPointMake(offsetX, offsetY)];
    
    
}




#pragma mark ----------------------------------------------
#pragma mark ---标题栏
//标题栏
-(void)setupTitleBar{
    
    self.subCount = self.childViewControllers.count;
    UIScrollView*contentTitleView = [[UIScrollView  alloc] init];
    self.contentTitleView = contentTitleView;
    contentTitleView.contentSize = CGSizeMake(self.subCount * btnW, 0);
    //标题栏 frame
    contentTitleView.frame = CGRectMake(0, titleBarH+barH, KGBScreenW-menuW, titleBarH);
    contentTitleView.backgroundColor = [UIColor whiteColor];
    contentTitleView.showsHorizontalScrollIndicator = NO;
    
    [self.view  addSubview:contentTitleView];
    
    
    //设置标题栏按钮
    [self   setupTitleButton];
}

//设置标题栏按钮
-(void)setupTitleButton
{
    for (int i = 0; i< self.subCount; i++) {
        UIButton*titleBtn = [UIButton  buttonWithType:(UIButtonTypeCustom)];
        [titleBtn  setTitle:self.childViewControllers[i].title forState:(UIControlStateNormal)];
        [titleBtn  setTitleColor:[UIColor  orangeColor] forState:(UIControlStateSelected)];
        [titleBtn  setTitleColor:[UIColor  grayColor] forState:(UIControlStateNormal)];
        [titleBtn  setFont:[UIFont  systemFontOfSize:14]];
        titleBtn.frame = CGRectMake(i*btnW, 0, btnW, titleBarH);
        
        [titleBtn  addTarget:self action:@selector(titleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        titleBtn.tag = i;
        //让第一个按钮成为选中
        if (i==0) {
            [self  titleBtnClick:titleBtn];
        }
        //将按钮保存到数组
        [self.btnArrM   addObject:titleBtn];
        [self.contentTitleView  addSubview:titleBtn];
        
    }
}

//点击标题按钮
-(void)titleBtnClick:(UIButton*)titleBtn{
    //让点击按钮成为选中
    [self  btnSelect:titleBtn];
    
    //让 cell 滚动到按钮对应的控制器
    CGFloat  offsetY = self.contentCollectionV.contentOffset.y;
    [self.contentCollectionV  setContentOffset:CGPointMake(titleBtn.tag* KGBScreenW, offsetY) animated:YES];
    
}

//让点击按钮成为选中
-(void)btnSelect:(UIButton*)btn{
    //让点击按钮成为选中
    self.selectBtn.selected = NO;
    btn.selected = YES;
    //当点击按钮的时候也让被点击的按钮居中
     [self  offsetCellAndTitleButtonChange:btn];
    self.selectBtn = btn;
    
}

@end
