import gql from 'graphql-tag'

export items = gql ["""
	{
		items {
			id
			name
			full_name
			active
			captureSelector
			link
			logo
			loading
			depth
			status
			concurrency
			parseInterval
			schemas
			postsCount
			nextParseDate
			data {
				depth
				parsedPagePostsCount
				progress
				PagePostsCount
			}
			posts(limit: 10) {
				id
				title
			}
			owner {
				id
				displayName
				username
			}
		}
	}
"""]

export posts = gql ["""
	query getPosts ($limit: Int = 111) {
		posts (limit: $limit) {
			id
			title
			link
			images
			status
			tags
			parsed_at
			item {
				id
				name
				full_name
			}
			stats {
				start
				stop
				parsingTime
				size
			}
			owner {
				id
				displayName
				username
			}
		}
	}
"""]

export postRemove = gql ["""
	subscription postsRemoveSubscription {
	 PostRemove {
		 id
		 item {
			 name
		 }
	 }
	}
	"""]

export postAdd = gql ["""
	subscription postsAddSubscription {
		PostAdd {
			id
		}
	}
	"""]

export itemsSubscription = gql ["""
	subscription itemsSubscription {
		ItemChange {
			id
			name
			active
			full_name
			postsCount
			depth
			status
			concurrency
			nextParseDate
			parseInterval
			loading
			data {
				progress
				depth
			}
		}
	}
"""]

export updateItem = gql ["""
	mutation (
		$id: String!
		$active: Boolean
		$name: String
		$depth: Int
		$concurrency: Int
		$parseInterval: Int
		$full_name: String
		$schemas: String
		$owner: String
		) {
		updateItem(
			id: $id
			active: $active
			name: $name
			full_name: $full_name
			schemas: $schemas
			depth: $depth
			concurrency: $concurrency
			parseInterval: $parseInterval
			owner: $owner
		) {
			id
			active
			name
			full_name
			depth
			schemas
			concurrency
			parseInterval
			owner {
				id
			}
		}
	}
"""]

export updatePost = gql ["""
	mutation (
		$id: String!
		$status: String
		) {
		updatePost(
			id: $id
			status: $status
		) {
			id
		}
	}
"""]

export removePost = gql ["""
	mutation (
		$id: String!
		$itemId: String
		) {
		removePost(
			id: $id
			itemId: $itemId
		) {
			id
			itemId
		}
	}
"""]

export removePosts = gql ["""
	mutation (
		$id: String!
		) {
		removePosts(
			id: $id
		) {
			id
		}
	}
"""]
