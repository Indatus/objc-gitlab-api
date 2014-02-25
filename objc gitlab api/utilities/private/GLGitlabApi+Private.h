//
//  GLGitlabApi+Private.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"
#import "GLNetworkOperation.h"

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
                                             type:(GLNetworkOperationType)type
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
 *  @param aClass    The class of the model to be parsed, must be a subclass of GLBaseObject
 *
 *  @return An array of model objects
 */
- (NSArray *)processJsonArray:(NSArray *)jsonArray class:(Class)aClass;

/**
 *  Retrieves the complete url for the specified endpoint
 *
 *  @param endpoint The endpoint of the url to be created
 *
 *  @return The url for the api call
 */
- (NSURL *)requestUrlForEndPoint:(NSString *)endpoint;

/**
 *  Creates the request for the specified endpoint
 *
 *  @param endpoint The endpoint for the request to be made
 *  @param method   The HTTP Verb for the request
 *
 *  @return Request object for url and method
 */
- (NSMutableURLRequest *)requestForEndPoint:(NSString *)endpoint method:(NSString *)method;

/**
 *  Creates the request for the specified endpoint and parameters
 *
 *  @param endpoint The endpoint for the request to be made
 *  @param params   The parameters for the request to be made
 *  @param method   The HTTP Verb for the request
 *
 *  @return Request object for the specified parameters
 */
- (NSMutableURLRequest *)requestForEndPoint:(NSString *)endpoint params:(NSDictionary *)params method:(NSString *)method;

/**
 *  Method that creates a failure block which calls back to the provided block
 *
 *  @param failureCallback The block to be executed as a call back
 *
 *  @return A network operation failure block that will call back to the provided block
 */
- (GLNetworkOperationFailureBlock)defaultFailureBlock:(GLGitlabFailureBlock)failureCallback;

/**
 *  Returns block to process a single JSON object that is a sublcass of GLBaseObject
 *
 *  @param aClass  A class that is a subclass of GLBaseObject
 *  @param success The block to be executed upon a successful request
 *
 *  @return A network operation success block that will process a single object and call back the specified success block
 */
- (GLNetworkOperationSuccessBlock)singleObjectSuccessBlockForClass:(Class)aClass
                                                      successBlock:(GLGitlabSuccessBlock)success;

/**
 *  Returns block to process a JSON array of objects that is a subclass of GLBaseObject
 *
 *  @param class   A class that is a subclass of GLBaseObject
 *  @param success The block to be executed upon a successful request
 *
 *  @return A network operation success block that will process multiple objects and call back the specified success block
 */
- (GLNetworkOperationSuccessBlock)multipleObjectSuccessBlockForClass:(Class)class
                                                        successBlock:(GLGitlabSuccessBlock)success;
@end
