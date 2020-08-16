function! mongodb#completion#collectionMethods(findstart, base) abort
	if a:findstart
		let l:line = getline('.')
		if (match(l:line, 'db\.\w\+\.') >= 0)
			let l:col = match(l:line[:col('.')], '\%(\a\w*\)\?$')
			return l:col != -1 ? l:col : -2
		endif
		return -2
	else
		let len = strlen(a:base)
		return map(
          \  filter(
          \    copy(s:collectionMethods),
          \    {k, v -> strpart(v.word, 0, len) ==# a:base}
          \  ),
					\  {k, v -> extend(v, {'kind': 'f', 'info': ' '}, "keep")}
          \)
	endif
endfunction

let s:collectionMethods = [
			\ {'word': 'aggregate', 'menu': '( [pipeline], <optional params> )', 'info': 'performs an aggregation on a collection; returns a cursor'},
			\ {'word': 'bulkWrite', 'menu': '( operations, <optional params> )', 'info': 'bulk execute write operations, optional parameters are: w, wtimeout, j'},
			\ {'word': 'convertToCapped', 'menu': '( maxBytes )', 'info': 'calls {convertToCapped: "test", size: maxBytes}} command'},
			\ {'word': 'count', 'menu': '( query = {}, <optional params> )', 'info': 'count the number of documents that matches the query, optional parameters are: limit, skip, hint, maxTimeMS'},
			\ {'word': 'countDocuments', 'menu': '( query = {}, <optional params> )', 'info': 'count the number of documents that matches the query, optional parameters are: limit, skip, hint, maxTimeMS'},
			\ {'word': 'createIndex', 'menu': '( keypattern [,options] )'},
			\ {'word': 'createIndexes', 'menu': '( [keypatterns], <options> )'},
			\ {'word': 'dataSize', 'menu': '()'},
			\ {'word': 'deleteMany', 'menu': '( filter, <optional params> )', 'info': 'delete all matching documents, optional parameters are: w, wtimeout, j'},
			\ {'word': 'deleteOne', 'menu': '( filter, <optional params> )', 'info': 'delete first matching document, optional parameters are: w, wtimeout, j'},
			\ {'word': 'distinct', 'menu': '( key, query, <optional params> )', 'info': 'e.g. db.test.distinct( "x" ), optional parameters are: maxTimeMS'},
			\ {'word': 'drop', 'menu': '()', 'info': 'drop the collection'},
			\ {'word': 'dropIndex', 'menu': '( index )', 'info': 'e.g. db.test.dropIndex( "indexName" ) or db.test.dropIndex( { "indexKey": 1 } )'},
			\ {'word': 'dropIndexes', 'menu': '()'},
			\ {'word': 'estimatedDocumentCount', 'menu': '( <optional params> )', 'info': 'estimate the document count using collection metadata, optional parameters are: maxTimeMS'},
			\ {'word': 'find', 'menu': '( [query], [fields] )', 'info': 'query is an optional query filter. fields is optional set of fields to return.'},
			\ {'word': 'findOne', 'menu': '( [query], [fields], [options], [readConcern] )'},
			\ {'word': 'findOneAndDelete', 'menu': '( filter, <optional params> )', 'info': 'delete first matching document, optional parameters are: projection, sort, maxTimeMS'},
			\ {'word': 'findOneAndReplace', 'menu': '( filter, replacement, <optional params> )', 'info': 'replace first matching document, optional parameters are: projection, sort, maxTimeMS, upsert, returnNewDocument'},
			\ {'word': 'findOneAndUpdate', 'menu': '( filter, <update object or pipeline>, <optional params> )', 'info': 'update first matching document, optional parameters are: projection, sort, maxTimeMS, upsert, returnNewDocument'},
			\ {'word': 'getDB', 'menu': '()', 'info': 'get DB object associated with collection'},
			\ {'word': 'getIndexes', 'menu': '()'},
			\ {'word': 'getPlanCache', 'menu': '()', 'info': 'get query plan cache associated with collection'},
			\ {'word': 'getShardDistribution', 'menu': '()', 'info': 'prints statistics about data distribution in the cluster'},
			\ {'word': 'getShardVersion', 'menu': '()', 'info': 'only for use with sharding'},
			\ {'word': 'getSplitKeysForChunks', 'menu': '( <maxChunkSize> )', 'info': 'calculates split points over all chunks and returns splitter function'},
			\ {'word': 'getWriteConcern', 'menu': '()', 'info': 'returns the write concern used for any operations on this collection, inherited from server/db if set'},
			\ {'word': 'insert', 'menu': '( obj )'},
			\ {'word': 'insertMany', 'menu': '( [objects], <optional params> )', 'info': 'insert multiple documents, optional parameters are: w, wtimeout, j'},
			\ {'word': 'insertOne', 'menu': '( obj, <optional params> )', 'info': 'insert a document, optional parameters are: w, wtimeout, j'},
			\ {'word': 'latencyStats', 'menu': '()', 'info': 'display operation latency histograms for this collection'},
			\ {'word': 'mapReduce', 'menu': '( mapFunction , reduceFunction , <optional params> )'},
			\ {'word': 'reIndex', 'menu': '()'},
			\ {'word': 'remove', 'menu': '( query )'},
			\ {'word': 'renameCollection', 'menu': '( newName , <dropTarget> )', 'info': 'renames the collection.'},
			\ {'word': 'replaceOne', 'menu': '( filter, replacement, <optional params> )', 'info': 'replace the first matching document, optional parameters are: upsert, w, wtimeout, j'},
			\ {'word': 'runCommand', 'menu': '( name , <options> )', 'info': 'runs a db command with the given name where the first param is the collection name'},
			\ {'word': 'save', 'menu': '( obj )'},
			\ {'word': 'setWriteConcern', 'menu': '( <write concern doc> )', 'info': 'sets the write concern for writes to the collection'},
			\ {'word': 'stats', 'menu': '( {scale: N, indexDetails: true/false, indexDetailsKey: <index key>, indexDetailsName: <index name>} )'},
			\ {'word': 'storageSize', 'menu': '()', 'info': 'includes free space allocated to this collection'},
			\ {'word': 'totalIndexSize', 'menu': '()', 'info': 'size in bytes of all the indexes'},
			\ {'word': 'totalSize', 'menu': '()', 'info': 'storage allocated for all data and indexes'},
			\ {'word': 'unsetWriteConcern', 'menu': '( <write concern doc> )', 'info': 'unsets the write concern for writes to the collection'},
			\ {'word': 'update', 'menu': '( query, <update object or pipeline>[, upsert_bool, multi_bool] )', 'info': 'instead of two flags, you can pass an object with fields: upsert, multi, hint'},
			\ {'word': 'updateMany', 'menu': '( filter, <update object or pipeline>, <optional params> )', 'info': 'update all matching documents, optional parameters are: upsert, w, wtimeout, j, hint'},
			\ {'word': 'updateOne', 'menu': '( filter, <update object or pipeline>, <optional params> )', 'info': 'update the first matching document, optional parameters are: upsert, w, wtimeout, j, hint'},
			\ {'word': 'validate', 'menu': '( <full> )', 'info': 'SLOW'},
			\]
