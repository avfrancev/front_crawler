<template lang="pug">
	div#dashboard
		.container
			//- Stats
			//- br
			//- br
			Items
			br
			br
			h2 Last Posts
			LastPosts
</template>

<script lang="coffee">

	import gql from 'graphql-tag'

	export default {
		name: 'Dashboard'

		components:
			# ItemPanel: require '@/components/ItemPanel/ItemPanel.vue'
			Items: require '@/components/Items'
			LastPosts: require '@/components/Posts'
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

<style lang="postcss">
	/*.items
		margin: 1em 0.5em*/
</style>
