
#import "NCTViewController.h"

#import "NCTSample.h"

static NSString *kFileName = @"/hoge.dat";

@implementation NCTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    
    [self saveData];
    [self loadData];
}

- (void)loadData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = paths[0];
    NSString *filePath = [directory stringByAppendingString:kFileName];
    
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];
    NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray *dataArray = [decoder decodeObjectForKey:@"array"];
    [decoder finishDecoding];
    
    NSLog(@"Data array: %@", dataArray[0]);
}

- (void)saveData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = paths[0];
    NSString *filePath  = [directory stringByAppendingString:kFileName];
    
    NSLog(@"file path: %@", filePath);
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        NCTSample *data = [[NCTSample alloc] init];
        data.name = [NSString stringWithFormat:@"My name is Bob%d", i];
        data.age  = i;
        [dataArray addObject:data];
    }
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [encoder encodeObject:dataArray forKey:@"array"];
    [encoder finishEncoding];
    
    [data writeToFile:filePath atomically:YES];
}

@end
