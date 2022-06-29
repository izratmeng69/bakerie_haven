#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "uv/heap-inl.h"
#import "uv/idna.h"
#import "uv/queue.h"
#import "uv/strscpy.h"
#import "uv/uv-common.h"
#import "uv/unix/atomic-ops.h"
#import "uv/unix/internal.h"
#import "uv/unix/spinlock.h"
#import "uv/uv.h"
#import "uv/uv/errno.h"
#import "uv/uv/threadpool.h"
#import "uv/uv/version.h"
#import "uv/uv/tree.h"
#import "uv/uv/unix.h"
#import "uv/uv/darwin.h"

FOUNDATION_EXPORT double uvVersionNumber;
FOUNDATION_EXPORT const unsigned char uvVersionString[];

