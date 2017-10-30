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
	query getPosts ($limit: Int, $filter: PostsFilter) {
		posts (limit: $limit, filter: $filter) {
			id
			title
			link
			images
			status
			published
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

export post = gql ["""
	query getPost ($id: String) {
		post (id: $id) {
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


export itemsSubscription = gql ["""
	subscription itemsSubscription {
		ItemChange {
			mutation
			node {
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
	}
"""]

export postsSubscription = gql ["""
	subscription postsSubscription {
		PostChange {
			mutation
			node {
				id
				title
				link
				images
				status
				published
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
		$link: String
		$schemas: String
		$owner: String
		) {
		updateItem(
			id: $id
			active: $active
			name: $name
			full_name: $full_name
			link: $link
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
			link
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

export addItem = gql ["""
	mutation (
		$active: Boolean
		$name: String
		$depth: Int
		$concurrency: Int
		$parseInterval: Int
		$full_name: String
		$link: String
		$schemas: String
		$owner: String
		) {
		addItem(
			active: $active
			name: $name
			full_name: $full_name
			link: $link
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
			link
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
		$published: Boolean
		) {
		updatePost(
			id: $id
			status: $status
			published: $published
		) {
			id
			status
			published
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

export removeItem = gql ["""
	mutation (
		$id: String!
		) {
		removeItem(
			id: $id
		) {
			id
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

export users = gql ["""
	query getUsers {
		users {
			id
			displayName
			username
		}
	}
"""]

export item = gql ["""
	query getItem ($id: String!) {
		item(id: $id) {
			id
			name
			depth
			full_name
			active
			concurrency
			parseInterval
			postsCount
			status
			link
			logo
			loading
			schemas
			data {
				depth
				progress
			}
			owner {
				id
				username
			}
			posts {
				id
				title
			}
		}
	}
"""]
