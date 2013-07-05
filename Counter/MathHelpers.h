//
//  MathHelpers.h
//  Counter
//
//  Created by Andrew Hulsizer on 7/5/13.
//  Copyright (c) 2013 Classy Monsters. All rights reserved.
//

#ifndef Counter_MathHelpers_h
#define Counter_MathHelpers_h

static inline CGFloat lerp(CGFloat a, CGFloat b, CGFloat p)
{
	return a + (b - a)*p;
}

#endif
