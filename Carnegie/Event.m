//
//  Event.m
//  Carnegie
//
//  Created by Austen McDonald on 1/10/17.
//  Copyright © 2017 Overlord. All rights reserved.
//

#import "Event.h"

#import <EventKit/EventKit.h>

@interface Event ()

@property (nonatomic, copy) NSDictionary<NSString *, id> *participants;
@property (nonatomic, strong) EKEvent *underlyingEvent;

- (void)_setEmailArray:(NSArray *)array;

@end

@implementation Event {
  NSArray *_emailArray;
}

+ (instancetype)eventWithParticipants:(NSDictionary<NSString *, id> *)participants underlyingEvent:(EKEvent *)underlyingEvent
{
  Event *e = [[Event alloc] init];
  e.participants = participants;
  e.underlyingEvent = underlyingEvent;

  // For faster and cleaner access, keep a sorted list of emails.
  [e _setEmailArray:[e.participants.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];

  return e;
}

- (void)_setEmailArray:(NSArray *)array
{
  _emailArray = array;
}

- (NSString *)emailAtIndex:(NSInteger)index
{
  return _emailArray[index];
}

- (id)contactOrNullAtIndex:(NSInteger)index
{
  NSString *email = _emailArray[index];
  return self.participants[email];
}

@end