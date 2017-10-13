//
//  CitySelectVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/30.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "CitySelectVC.h"
#import "MJNIndexView.h"
#import "RegexKitLite.h"
#import "QuDBManager.h"

#define APPEND_CITY_STRING @"开通"
#define STANDARD_STRING @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

@interface CitySelectVC ()<UITableViewDataSource,UITableViewDelegate,MJNIndexViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>


@property (nonatomic, strong) NSMutableString *alphaString;    //索引显示字符串
@property (nonatomic, strong) NSMutableArray *sectionArray;    //列表显示数

@property (nonatomic, strong) NSArray *crayons;                //保留原始数据结果

// MJNIndexView
@property (nonatomic, strong) MJNIndexView *indexView;

@property (nonatomic, strong) UITableView *tableView;


// search
@property (nonatomic, strong) UISearchBar *mSearchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@property (nonatomic, strong) NSMutableArray *searchResultAry;   //搜索结果数组
@property (nonatomic, strong) NSString *searchString;            //搜索关键字

@property (nonatomic, strong) NSString *pinYinSearchString;      //拼音搜索关键字

@end

@implementation CitySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    self.quNavBar.title = @"选择城市";
    
    [self tableAttribute];
    
    
    //初始化搜索条
    self.mSearchBar = [[UISearchBar alloc]init];
    
    self.mSearchBar.backgroundColor = [UIColor clearColor];
    
    [self.mSearchBar setPlaceholder:@"请输入城市中文名称或拼音"];
    self.mSearchBar.delegate = self;
    [self.mSearchBar sizeToFit];
    [self.view addSubview:self.mSearchBar];
    
    [self.mSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.quNavBar.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    //初始化UISearchDisplayController
    self.searchController =[[UISearchDisplayController alloc]initWithSearchBar:self.mSearchBar contentsController:self];
    self.searchController.searchResultsDelegate= self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.delegate = self;
    
    //初始化列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, self.view.bounds.size.width, self.view.bounds.size.height - 108)];
    
    
    [self.tableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    
    //初始化索引条
    self.indexView = [[MJNIndexView alloc]initWithFrame:self.tableView.frame];
    self.indexView.backgroundColor = [UIColor redColor];
    self.indexView.dataSource = self;
    [self indexTalbeAttributesForMJNIndexView];
    [self.view addSubview:self.indexView];
    
    
}

#pragma mark--城市选择后的跳转
- (void)citySelectWithCityModel:(QuCityModel *)model
{
    
//    [[UnitMetiodManager share] setSELECT_CIYT:model.cityName];
//    [[UnitMetiodManager share] setSELECT_CODE:model.areaCode];
//    [[UnitMetiodManager share] setPROVINCE_CODE:model.provinceCode];
//    [[UnitMetiodManager share] setCITY_CODE:model.cityCode];
//
//    if (ACCOUNT.accountInfo) {
//        //如果是切换的是相同城市，则无任何操作
//        if ([model.cityName isEqualToString:ACCOUNT.accountInfo.cityName]) {
//            if (self.navigationController)
//            {
//              [self performSelector:@selector(rollOutSideBar) withObject:nil afterDelay:0.1];
//              [self dismissViewControllerAnimated:NO completion:nil];
//            }
//            return;
//        }
//
//        ACCOUNT.accountInfo.cityName = model.cityName;
//        ACCOUNT.accountInfo.areaCode = model.areaCode;
//        ACCOUNT.accountInfo.ll_m=model.provinceCode;
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//        //ACCOUNT.accountInfo.ProvinceCode =model.provinceCode;
//
//    }
//
//
//    //保存
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
//    [dic setObject:model.cityName forKey:AREA_CITY];
//    [dic setObject:model.areaCode forKey:AREA_CODE];
//    [dic setObject:model.provinceCode forKey:@"PROVINCE_CODE"];
//    if (model.cityCode.length > 0) {
//        [dic setObject:model.cityCode forKey:@"CITY_CODE"];
//    }
//    [[NSFloderManager share]writeDataToFloder:dic withKey:CITY_SELECT_KEY];
//
//    if (self.selectComplete) {
//        self.selectComplete(model);
//    }


    [self.navigationController popViewControllerAnimated:YES];
    
}

//table属性
- (void)tableAttribute
{
    
    [self refreshTable];
}

//设置indexview属性
- (void)indexTalbeAttributesForMJNIndexView
{
    //点击index tableview是否跟着一起滑动
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = NO;
    self.indexView.font = [UIFont systemFontOfSize:10.0f];
    self.indexView.selectedItemFont = [UIFont systemFontOfSize:40.0f];
    self.indexView.backgroundColor = [UIColor clearColor];
    //遮蔽物
    self.indexView.curtainColor = nil;
    self.indexView.curtainFade = 0.0;
    self.indexView.curtainMoves = YES;
//    self.indexView.ergonomicHeight = NO;
    //距离上边距边缘
    self.indexView.upperMargin = 44.0;
    //距离下边距边缘
    self.indexView.lowerMargin = 44.0;
    //距离右边距边缘
    self.indexView.rightMargin = 10.0;
    self.indexView.itemsAligment = NSTextAlignmentCenter;
    //扩展幅度
    self.indexView.maxItemDeflection = 50.0;
    self.indexView.rangeOfDeflection = 5;
    //非选择字体颜色
    self.indexView.fontColor = [UIColor colorWithHexString:@"404040"];
    //选择字体颜色
    self.indexView.selectedItemFontColor = [UIColor blackColor];
    self.indexView.darkening = NO;
    self.indexView.fading = YES;
    
}

//添加开通城市
- (NSArray *)addSupportCity
{
    
    QuCityModel *model = [[QuCityModel alloc]init];
 
    model.cityName = @"苏州";
    model.cityCode = @"320500";
    model.provinceCode = @"3200000";
    
    NSArray *array = [NSArray arrayWithObject:model];
    
    return array;
}

//添加定位城市
- (NSArray *)addLocationCity
{
    
    QuCityModel *model = [[QuCityModel alloc]init];
    
    model.cityName = @"苏州";
    model.cityCode = @"320500";
    model.provinceCode = @"3200000";
    
    NSArray *array = [NSArray arrayWithObject:model];
    
    return array;
}

//属性table
- (void)refreshTable
{
    
    NSMutableArray *rawCrayons = [[QuDBManager shareDataManger]getTheCityAreaCodeWithProvinceCode:nil];
    
    self.searchResultAry = rawCrayons;
    self.crayons = rawCrayons;
    
    self.alphaString = [[NSMutableString alloc]initWithCapacity:0];
    self.sectionArray = [[NSMutableArray alloc]initWithCapacity:0];
    
//    NSMutableArray *ary = [NSMutableArray arrayWithObject:[self addLocationCity]];
//    //添加定位城市
//    if (LOCATION.areaCode.length > 0) {
//        
//        [self.sectionArray addObject:ary];
//        [self.alphaString appendString:@"定位"];
//        
//        //添加最近访问
//        ary = [self addRecentlyCitys];
//        if ([ary count] > 0) {
//            [self.sectionArray addObject:ary];
//            [self.alphaString appendString:@",最近"];
//        }
//        
//        //添加省内其他城市
//        CityAreaModel *model=[self addLocationCity];
//        
//        if([model.provinceCode isEqualToString:@"320000"])
//        {
//            ary = [self addotherProvinceCitys:model.provinceCode];
//            
//            for(int i=0;i<[ary count];i++)
//            {
//                CityAreaModel *tempmodel = [ary objectAtIndex:i];
//                if([tempmodel.cityCode isEqualToString:model.cityCode])
//                {
//                    [ary removeObjectAtIndex:i];
//                    break;
//                }
//            }
//            if ([ary count] > 0) {
//                [self.sectionArray addObject:ary];
//                //加逗号为了方便取索引数组
//                [self.alphaString appendString:@",省内"];
//            }
//        }
//        else
//        {
//            //添加热门城市
//            CityAreaModel *model=[self addLocationCity];
//            ary = [self addHotCitys:model.provinceCode];
//            if ([ary count] > 0) {
//                [self.sectionArray addObject:ary];
//                //加逗号为了方便取索引数组
//                [self.alphaString appendString:@",热门"];
//            }
//            
//        }
//        
//    }
//    else{
//        CityAreaModel *modelLocation = [[CityAreaModel alloc]init];
//        if(LOCATION.isloading){
//            modelLocation.cityName = @"定位中...";
//            
//        }
//        else{
//            modelLocation.cityName = @"定位失败，请点击重试";
//            
//        }
//        NSArray *ary = [NSMutableArray arrayWithObject:modelLocation];
//        [self.sectionArray addObject:ary];
//        [self.alphaString appendString:@"定位"];
//
//        
//    }
    
    //添加开通城市
    NSArray *supportAry = [self addSupportCity];
    if ([supportAry count] > 0) {
        [self.sectionArray addObject:supportAry];
        [self.alphaString appendString:@",开通"];
    }
    
    //添加地市
    [self.sectionArray addObjectsFromArray:[self sortFirstLettersInArray:rawCrayons]];

    [self.tableView reloadData];
    [self.tableView reloadSectionIndexTitles];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:[self.sectionArray count] -1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//匹配拼音搜索
- (NSMutableArray *)fifiterPinYinSearchResultWithStr:(NSString *)str
{
    NSMutableArray *temAry = [NSMutableArray arrayWithCapacity:0];
    NSArray *array;
    //判断是否从原始或者结果搜索中搜索 如果现在搜索的关键字长度小于原来保存的搜索关键字长度 则取原始数组
    if (self.searchString.length < str.length && self.searchString.length > 0) {
        array = [NSArray arrayWithArray:self.searchResultAry];
    }
    else{
        array = [NSArray arrayWithArray:self.crayons];
    }
    for (NSObject *obj in array) {
        QuCityModel *model = (QuCityModel *)obj;
        
        //取名字首字母 如石家庄 则取出SJZ
        NSString *firstPinYinName = [PublicManager getFirsrPingyinString:model.cityName];
        //取名字全拼  如石家庄 则取出SHIJIAZHUANG
        NSString *fullPinYinName = [PublicManager getFullPinyinString:model.cityName];
        //以下key为搜索结果中匹配到的关键字高亮显示 如搜索sh 则石高亮显示 如搜索sj 则石家高亮显示
        //先判断全拼是否以搜索关键字开头
        if ([fullPinYinName hasPrefix:[str uppercaseString]]) {
            
            [temAry addObject:model];
        }
        else{
            //否则判断是否首字母以搜索关键字开头
            if ([firstPinYinName hasPrefix:[str uppercaseString]]) {
                
                [temAry addObject:model];
            }
        }
        
    }
    return temAry;
}

//匹配搜索结果
- (NSMutableArray *)fifiterSearchResultWithStr:(NSString *)str
{
    NSMutableArray *temAry = [NSMutableArray arrayWithCapacity:0];
    NSArray *array;
    //判断是否从原始或者结果搜索中搜索  如果现在搜索的关键字长度小于原来保存的搜索关键字长度 则取原始数组
    if (self.searchString.length < str.length && self.searchString.length > 0) {
        array = [NSArray arrayWithArray:self.searchResultAry];
    }
    else{
        array = [NSArray arrayWithArray:self.crayons];
    }
    for (QuCityModel *model in array) {
        if ([model.cityName hasPrefix:str]) {
            [temAry addObject:model];
        }
    }
    return temAry;
}

# pragma mark data predicate
//根据索引字符串取索引数组
- (NSString *) firstLetter: (NSInteger) section
{
    NSArray *ary = [self.alphaString componentsSeparatedByString:@","];
    return [ary objectAtIndex:section];
}

- (NSMutableArray *) sortFirstLettersInArray:(NSArray *)categoryArray
{
    //创建包含26数组的数组
    NSMutableArray *existingLetters = [NSMutableArray array];
    //初始化数组
    for (NSInteger i = 0; i < STANDARD_STRING.length; i++) {
        NSMutableArray *rowArrays = [NSMutableArray array];
        [existingLetters addObject:rowArrays];
    }
    //整合数组归类 把所有城市按首字母放到对应的数组中
    for (QuCityModel *model in categoryArray) {
        if ([model.cityName isEqualToString:@"长沙"]) {
            NSLog(@"%@",model);
        }
        NSString *name = model.cityName;
        NSString *firstPinYinName = [PublicManager getFullPinyinString:name];//名字首字母
        if (firstPinYinName.length > 0) {
            //找出首拼音字母并大写
            firstPinYinName = [[firstPinYinName substringToIndex:1]uppercaseString];
        }
        NSRange range = [STANDARD_STRING rangeOfString:firstPinYinName];
        [existingLetters[range.location] addObject:model];
    }
    
    //去处无数据的数组
    NSArray *tempAry = [[NSArray alloc]initWithArray:existingLetters];
    NSMutableArray *tempReturnAry = [[NSMutableArray alloc]initWithCapacity:[tempAry count]];
    for (NSArray *array in tempAry) {
        if (array.count > 0) {
            [tempReturnAry addObject:array];
            NSInteger index = [tempAry indexOfObject:array];
            //找到有数组所对应的字母
            NSString *str = [STANDARD_STRING substringWithRange:NSMakeRange(index, 1)];
            if (self.alphaString.length != 0) {
                [self.alphaString appendString:@","];
            }
            [self.alphaString appendString:str];
        }
    }
    if ([self.alphaString hasPrefix:@","]) {
        self.alphaString=(NSMutableString*)[self.alphaString substringFromIndex:1];
    }
    return tempReturnAry;
}

# pragma mark TableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.searchController.searchResultsTableView]) {
        return 1;
    }
    return [self.sectionArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:self.searchController.searchResultsTableView]) {
        
        return 0;
        
    }
    return 20;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchController.searchResultsTableView]) {
        
        return 44;
        
    }
    else{
        
        if([[self firstLetter:indexPath.section] isEqualToString:@"开通城市"])
        {
            NSInteger btCount = [(NSMutableArray*)self.sectionArray[indexPath.section] count];
            
            float cellHight = 10+45*ceilf(btCount/3.0);
            return cellHight;
        }
        else
        {
            return 44;
            
        }
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchController.searchResultsTableView]) {
        if (self.searchString.length == 0) {
            return 0;
        }
        return [self.searchResultAry count];
    }
    if([[self firstLetter:section] isEqualToString:@"开通城市"])
    {
        return 1;
    }
    else
    {
        return [(NSMutableArray*)self.sectionArray[section] count];
    }
    
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchController.searchResultsTableView]) {
        return nil;
    }
    
    //    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    //    headerView.tintColor = self.tableHeaderColor;
    //    headerView.textLabel.textColor = self.tableHeaderTextColor;
    //    [[headerView textLabel] setText:[NSString stringWithFormat:@"     %@",[self firstLetter:section]]];
    //    headerView.textLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_SIZE.width, 20)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UILabel *labelHeaderView = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_SIZE.width, 20)];
    labelHeaderView.font = [UIFont systemFontOfSize:13.0f];
    
    if ([[self firstLetter:section]isEqualToString:@"开通"])
    {
        labelHeaderView.text = [NSString stringWithFormat:@"开通城市"];
    }
    else if ([[self firstLetter:section]isEqualToString:@"定位"])
    {
        labelHeaderView.text = [NSString stringWithFormat:@" "];
        bgView.frame= CGRectMake(0, 0, 0.1f, 0.1f);
    }
    else
    {
        labelHeaderView.text = [NSString stringWithFormat:@"%@",[self firstLetter:section]];
        
    }
    
    labelHeaderView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    labelHeaderView.textColor = [UIColor colorWithHexString:@"#777777"];
    [bgView addSubview:labelHeaderView];
    
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.searchController.searchResultsTableView]) {
        
        static NSString *identifier = @"citySelectCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }

        for (UIView *view in [cell.contentView subviews]) {
            [view removeFromSuperview];
        }
        NSObject *obj = [self.searchResultAry objectAtIndex:indexPath.row];
        
        QuCityModel *model = (QuCityModel *)obj;
        
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",model.cityName];
        cell.textLabel.textColor = HEXCOLOR(@"404040");
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    else
    {
        
        if([[self firstLetter:indexPath.section] isEqualToString:@"开通城市"])
        {
            static NSString *identifier = @"HeaderSelectCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.backgroundColor = [UIColor clearColor];
            
            NSInteger btnCount = [(NSMutableArray*)self.sectionArray[indexPath.section] count];
            
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            //            for(int i = 0;i<btnCount;i++)
            //            {
            //                CitySelectHeaderCellBtn *tempBtn = [CitySelectHeaderCellBtn buttonWithType:UIButtonTypeCustom];
            //                tempBtn.frame = CGRectMake(10+(i%3)*((SCREEN_SIZE.width-40)/3), 10+45*(i/3), (SCREEN_SIZE.width-40)/3-10, 35);
            //                [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //                tempBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
            //                NSArray *currentItems = self.sectionArray[indexPath.section];
            //                CityAreaModel *model = currentItems[i];
            //                [tempBtn setTitle:model.cityName forState:UIControlStateNormal];
            //                tempBtn.backgroundColor = [UIColor whiteColor];
            //                [tempBtn addTarget:self action:@selector(headercityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //                tempBtn.btnIndexpath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            //                [cell.contentView addSubview:tempBtn];
            //            }
            return cell;
        }
        else{
            
            static NSString *identifier = @"citySelectCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
          
            
            QuCityModel *model = [self categoryNameAtIndexPath:indexPath];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",model.cityName];
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = HEXCOLOR(@"404040");
           
            return cell;
            
            
        }
        
    }
    
}

#pragma mark--选择城市响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuCityModel *model;
    if ([tableView isEqual:self.searchController.searchResultsTableView]) {
        NSObject *obj = [self.searchResultAry objectAtIndex:indexPath.row];
        
        model = (QuCityModel *)obj;
        
    }
    else{
        model = [self categoryNameAtIndexPath:indexPath];
    }
    if([tableView isEqual:self.tableView])
    {
        if([[self firstLetter:indexPath.section] isEqualToString:@"定位"]||[[self firstLetter:indexPath.section] isEqualToString:@"开通"])
        {
            return;
        }
        
    }
    
    [self citySelectWithCityModel:model];
    
    
    
}

#pragma mark MJMIndexForTableView datasource methods
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    NSArray *results = [self.alphaString componentsSeparatedByString:@","];
    return results;
}


- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:self.indexView.getSelectedItemsAfterPanGestureIsFinished];
}

#pragma mark UISearchDisplay delegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //如果是汉字搜索
    if ([searchString isMatchedByRegex:@"[\u4e00-\u9fa5]"]){
        self.searchResultAry = [self fifiterSearchResultWithStr:searchString];
        self.pinYinSearchString = @"";
    }
    else{
        self.searchResultAry = [self fifiterPinYinSearchResultWithStr:searchString];
    }
    
    self.searchString = searchString;
    return YES;
}

#pragma mark building sectionArray for the tableView
- (QuCityModel *)categoryNameAtIndexPath: (NSIndexPath *)path
{
    NSArray *currentItems = self.sectionArray[path.section];
    QuCityModel *model = currentItems[path.row];
    return model;
}

//-(void)headercityBtnClick:(CitySelectHeaderCellBtn *)sender
//{
//    CityAreaModel *model;
//    model = [self categoryNameAtIndexPath:sender.btnIndexpath];
//
//    if([model.cityName isEqualToString:@"定位失败，请点击重试"])
//    {
//        if ([CLLocationManager locationServicesEnabled] &&
//            ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
//             || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
//                //定位功能可用，开始定位
//                [[BMKLocationManager share] updateLocation];
//
//            }
//        else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
//
//
//            [OMGToast showWithText:@"定位未开启，请到设置中开启定位"];
//
//        }
//    }
//    else
//    {
//        if (self.busCityBlock) {
//            self.busCityBlock(model);
//            if (self.navigationController) {
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }
//            else{
//                [self dismissViewControllerAnimated:NO completion:nil];
//            }
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshview" object:Nil userInfo:nil];
//        }else{
//            [self citySelectWithCityModel:model];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChannelReload" object:Nil userInfo:nil];
//        }
//
//    }
//    
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
