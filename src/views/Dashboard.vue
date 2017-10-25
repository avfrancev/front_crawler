<template lang="pug">
	#dashboard
		Items
		br
		br
		h2 Last Posts
		Posts
</template>

<script lang="coffee">

	import gql from 'graphql-tag'

	export default {
		name: 'Dashboard'

		components:
			# ItemPanel: require '@/components/ItemPanel/ItemPanel.vue'
			Items: require '@/views/Items'
			Posts: require '@/views/Posts'
			# Stats: require '@/components/Stats'

		# data: ->
		# 	items: []

		# apollo:
		# 	items: ->
		# 		query: gql ["""
		# 			{
		# 				items {
		# 					id
		# 					name
		# 					full_name
		# 					active
		# 					captureSelector
		# 					link
		# 					logo
		# 					loading
		# 					depth
		# 					concurrency
		# 					parseInterval
		# 					schemas
		# 					postsCount
		# 					nextParseDate
		# 					data {
		# 						depth
		# 						parsedPagePostsCount
		# 						progress
		# 						PagePostsCount
		# 					}
		# 					posts(limit: 10) {
		# 						id
		# 						title
		# 					}
		# 					owner {
		# 						id
		# 						displayName
		# 						username
		# 					}
		# 				}
		# 			}
		# 		"""]
		# 		variables: ->
		# 			limit: 0
		# 		# update: (d) -> d.items
		# 		# update: (data) ->
		# 		# 	console.log data
		# 		# 	data
		# 		# 	# Object.assign {}, data.items
		#
		# 	$subscribe:
		# 		itemChange:
		# 			query: gql ["""
		# 				subscription ppp {
		# 					ItemChange {
		# 						id
		# 						name
		# 						full_name
		# 						postsCount
		# 						loading
		# 						data {
		# 							progress
		# 						}
		# 					}
		# 				}
		# 			"""]

	}

</script>
