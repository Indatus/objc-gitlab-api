//
//  GLGitlabApi+Private.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"
#import "GLNetworkOperation.h"

@protocol GLJsonProtocol;

@interface GLGitlabApi (Private)

@property (nonatomic, strong) NSURL *hostName;
@property (nonatomic, strong) NSString *privateToken;
@property (nonatomic, strong) NSOperationQueue  *queue;


/**
 *  Queues a request to be completed, adds token header to request if a token has been stored
 *
 *  @param request The request to be executed
 *  @param success Block to be executed upon a successful request
 *  @param failure Block to be executed upon a failed request
 *
 *  @return The operation that will execute the request
 */
- (GLNetworkOperation *)queueOperationWithRequest:(NSMutableURLRequest *)request
                                          success:(GLNetworkOperationSuccessBlock)success
                                          failure:(GLNetworkOperationFailureBlock)failure;


/**
 *  Encodes params into a query string that can be appended to a url
 *
 *  @param params params to be encoded
 *
 *  @return The URL encoded param string
 */
- (NSString *)urlEncodeParamsForGet:(NSDictionary *)params;

/**
 *  Encodes params into a query string and appends them to the endpoint
 *
 *  @param params   params to be encoded
 *  @param endpoint endpoint to append query string to
 *
 *  @return The URL encoded param string
 */
- (NSString *)urlEncodeParamsForGet:(NSDictionary *)params endpoint:(NSString *)endpoint;

/**
 *  Returns the data representation of the params passed in as a url encoded string
 *
 *  @param params Dictionary containing the data to be processed
 *
 *  @return data representation of params
 */
- (NSData *)urlEncodeParams:(NSDictionary *)params;

/**
 *  Processes an array of JSON objects and converts them into an array of model objects
 *
 *  @param jsonArray Array of JSON objects
 *  @param aClass    The class of the model to be parsed
 *
 *  @return An array of model objects
 */
- (NSArray *)processJsonArray:(NSArray *)jsonArray class:(Class<GLJsonProtocol>)aClass;

/**
 *  Retrieves the complete url for the specified endpoint
 *
 *  @param endpoint The endpoint of the url to be created
 *
 *  @return The url for the api call
 */
- (NSURL *)requestUrlForEndPoint:(NSString *)endpoint;

- (GLNetworkOperationFailureBlock)defaultFailureBlock:(GLGitlabFailureBlock)failureCallback;

- (GLNetworkOperationSuccessBlock)singleObjectSuccessBlockForClass:(Class<GLJsonProtocol>)aClass
                                                      successBlock:(GLGitlabSuccessBlock)success;
@end
