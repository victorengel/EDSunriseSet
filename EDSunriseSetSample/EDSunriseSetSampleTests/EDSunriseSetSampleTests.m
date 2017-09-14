//
//  EDSunriseSetSampleTests.m
//  EDSunriseSetSampleTests
//
//  Created by ernesto on 13/8/15.
//  Copyright (c) 2015 cocoawithchurros. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "EDSunriseSet.h"

@interface EDSunriseSetSampleTests : XCTestCase
@property (nonatomic, strong) NSCalendar *testCalendar;
@property (nonatomic, strong) NSTimeZone *testTimeZone;
@property (nonatomic, strong) NSDate *testDate;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic, strong) EDSunriseSet *testSunriseSet;

@end

@implementation EDSunriseSetSampleTests

- (void)setUp {
    [super setUp];
    NSCalendar *cal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"CDT"];
    cal.timeZone = tz;
    NSDateComponents *comp = [NSDateComponents new];
    comp.year = 2017;
    comp.month = 6;
    comp.day = 15;
    comp.hour = 12;
    comp.minute = 0;
    self.testCalendar = cal;
    self.testTimeZone = tz;
    self.testDate = [cal dateFromComponents:comp];
    self.latitude = 40.f;
    self.longitude = -100.f;
    EDSunriseSet *sunriseSet = [EDSunriseSet sunrisesetWithDate:self.testDate timezone:self.testTimeZone latitude:self.latitude longitude:self.longitude];
    self.testSunriseSet = sunriseSet;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSunriseSunset {
    XCTAssertTrue(self.testSunriseSet.localSunrise.hour == 6);
    XCTAssertTrue(self.testSunriseSet.localSunrise.minute == 10);
    XCTAssertTrue(self.testSunriseSet.localSunrise.second == 31);
    XCTAssertTrue(self.testSunriseSet.localSunset.hour == 21);
    XCTAssertTrue(self.testSunriseSet.localSunset.minute == 10);
    XCTAssertTrue(self.testSunriseSet.localSunset.second == 40);
}

- (void)testCivilTwilight {
    XCTAssertTrue(self.testSunriseSet.localCivilTwilightStart.hour == 5);
    XCTAssertTrue(self.testSunriseSet.localCivilTwilightStart.minute == 37);
    XCTAssertTrue(self.testSunriseSet.localCivilTwilightStart.second == 46);
    XCTAssertTrue(self.testSunriseSet.localCivilTwilightEnd.hour == 21);
    XCTAssertTrue(self.testSunriseSet.localCivilTwilightEnd.minute == 43);
    XCTAssertTrue(self.testSunriseSet.localCivilTwilightEnd.second == 25);
}

- (void)testNauticalTwilight {
    XCTAssertTrue(self.testSunriseSet.localNauticalTwilightStart.hour == 4);
    XCTAssertTrue(self.testSunriseSet.localNauticalTwilightStart.minute == 56);
    XCTAssertTrue(self.testSunriseSet.localNauticalTwilightStart.second == 8);
    XCTAssertTrue(self.testSunriseSet.localNauticalTwilightEnd.hour == 22);
    XCTAssertTrue(self.testSunriseSet.localNauticalTwilightEnd.minute == 25);
    XCTAssertTrue(self.testSunriseSet.localNauticalTwilightEnd.second == 4);
}

- (void)testAstronomicalTwilight {
    XCTAssertTrue(self.testSunriseSet.localAstronomicalTwilightStart.hour == 4);
    XCTAssertTrue(self.testSunriseSet.localAstronomicalTwilightStart.minute == 7);
    XCTAssertTrue(self.testSunriseSet.localAstronomicalTwilightStart.second == 34);
    XCTAssertTrue(self.testSunriseSet.localAstronomicalTwilightEnd.hour == 23);
    XCTAssertTrue(self.testSunriseSet.localAstronomicalTwilightEnd.minute == 13);
    XCTAssertTrue(self.testSunriseSet.localAstronomicalTwilightEnd.second == 38);
}

- (void)testCustomTwilight6DegreesBelow {
    self.testSunriseSet = [EDSunriseSet sunrisesetWithDate:self.testDate timezone:self.testTimeZone latitude:self.latitude longitude:self.longitude forAltitude:-6.0];
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.hour == 5);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.minute == 37);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.second == 46);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.hour == 21);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.minute == 43);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.second == 25);
}

- (void)testCustomTwilight8point3DegreesBelow {
    self.testSunriseSet = [EDSunriseSet sunrisesetWithDate:self.testDate timezone:self.testTimeZone latitude:self.latitude longitude:self.longitude forAltitude:-8.3];
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.hour == 5);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.minute == 22);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.second == 22);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.hour == 21);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.minute == 58);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.second == 50);
}

- (void)testCustomTwilight15DegreesAbove {
    self.testSunriseSet = [EDSunriseSet sunrisesetWithDate:self.testDate timezone:self.testTimeZone latitude:self.latitude longitude:self.longitude forAltitude:15.0];
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.hour == 7);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.minute == 41);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.second == 58);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.hour == 19);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.minute == 39);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightEnd.second == 14);
}

- (void)testCustomTwilightTooHigh {
    self.testSunriseSet = [EDSunriseSet sunrisesetWithDate:self.testDate timezone:self.testTimeZone latitude:self.latitude longitude:self.longitude forAltitude:85.0];
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.hour == self.testSunriseSet.localCustomTwilightEnd.hour);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.minute == self.testSunriseSet.localCustomTwilightEnd.minute);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.second == self.testSunriseSet.localCustomTwilightEnd.second);
}

- (void)testCustomTwilightTooNorth {
    self.testSunriseSet = [EDSunriseSet sunrisesetWithDate:self.testDate timezone:self.testTimeZone latitude:89.5 longitude:self.longitude forAltitude:15.0];
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.hour == self.testSunriseSet.localCustomTwilightEnd.hour);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.minute == self.testSunriseSet.localCustomTwilightEnd.minute);
    XCTAssertTrue(self.testSunriseSet.localCustomTwilightStart.second == self.testSunriseSet.localCustomTwilightEnd.second);
}

- (void)testCustomTwilightAltitudeTooHigh {
    self.testSunriseSet = [EDSunriseSet sunrisesetWithDate:self.testDate timezone:self.testTimeZone latitude:self.latitude longitude:self.longitude forAltitude:95.0];
    // Cannot have an altitude higher than 90 degrees.
    XCTAssertNil(self.testSunriseSet);
}

- (void)testCustomTwilightAltitudeTooLow {
    self.testSunriseSet = [EDSunriseSet sunrisesetWithDate:self.testDate timezone:self.testTimeZone latitude:self.latitude longitude:self.longitude forAltitude:-95.0];
    // Cannot have an altitude lower than 90 degrees.
    XCTAssertNil(self.testSunriseSet);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
