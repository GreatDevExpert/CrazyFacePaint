//
//  NFGeometry.h
//  Pods
//
//  Created by William Locke on 2/20/13.
//
//


#ifndef __NFGeometry__
#define __NFGeometry__

struct NFAngleRange{
    CGFloat min;
    CGFloat max;
};
typedef struct NFAngleRange NFAngleRange;

CG_INLINE NFAngleRange
NFAngleRangeMake(CGFloat min, CGFloat max)
{
    NFAngleRange a; a.min = min; a.max = max; return a;
}


struct NFDirection{
    CGFloat x;
    CGFloat y;
};
typedef struct NFDirection NFDirection;

CG_INLINE NFDirection
NFDirectionMake(CGFloat x, CGFloat y)
{
    NFDirection d; d.x = x; d.y = y; return d;
}

CG_INLINE CGPoint
NFGeometryCGRectCenter(CGRect frame)
{
    return CGPointMake(frame.origin.x + frame.size.width / 2.0, frame.origin.y + frame.size.height / 2.0);
}

CG_INLINE CGPoint
NFGeometryCGRectBottomLeft(CGRect frame)
{
    return CGPointMake(frame.origin.x, frame.origin.y + frame.size.height);
}

CG_INLINE CGPoint
NFGeometryCGRectBottomRight(CGRect frame)
{
    return CGPointMake(frame.origin.x + frame.size.width, frame.origin.y + frame.size.height);
}

CG_INLINE CGFloat
NFGeometryDistanceBetweenCGPoints(CGPoint point1, CGPoint point2)
{
    return sqrt(powf(fabsf(point1.x - point2.x), 2.0) +  powf(fabsf(point1.y - point2.y), 2.0));
}

CG_INLINE CGFloat
NFGeometryHorizontalDistanceBetweenCGPoints(CGPoint point1, CGPoint point2)
{
    return point1.x - point2.x;
}

CG_INLINE CGFloat
NFGeometryVerticalDistanceBetweenCGPoints(CGPoint point1, CGPoint point2)
{
    return point1.y - point2.y;
}

// TODO: Make this function clearer and more accurate. 
CG_INLINE CGFloat
NFGeometryUniversalDistance(CGFloat distance)
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return distance * 2.0;
    }
    return distance;
}

// TODO: Make this function clearer and more accurate.
CG_INLINE CGRect
NFGeometryCGRectShrunkToBottomLeft(CGRect frame)
{
    return CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, 0, 0);
}

CG_INLINE CGRect
NFGeometryCGRectShrunkToBottom(CGRect frame)
{
    return CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, 0);
}

CG_INLINE CGRect
NFGeometryCGRectZeroedOrigin(CGRect frame)
{
    return CGRectMake(0, 0, frame.size.width, frame.size.height);
}

CG_INLINE CGRect
NFGeometryCGRectAddOriginOfSecondFrameToFirst(CGRect frame1, CGRect frame2)
{
    return CGRectMake(frame1.origin.x + frame2.origin.x, frame1.origin.y + frame2.origin.y, frame1.size.width, frame1.size.height);
}

CG_INLINE CGRect
NFGeometryCGRectScale(CGRect frame, CGFloat scale)
{
    CGSize newSize = CGSizeMake(frame.size.width * scale, frame.size.height * scale);

    return CGRectMake(frame.origin.x + (frame.size.width - newSize.width) / 2.0, frame.origin.y + (frame.size.height - newSize.height) / 2.0, newSize.width, newSize.height);
}

CG_INLINE CGRect
NFGeometryCGRectRelativeToRect(CGRect child, CGRect parent)
{
    CGRect rect = CGRectMake(child.origin.x - parent.origin.x, child.origin.y - parent.origin.y, child.size.width, child.size.height);
    return rect;
}


#endif /* defined(__NFGeometry__) */


