<template lang="pug">
	.posts
		//- p {{postsIDs}}

		transition-group(name="list" tag='div' style="position: relative")
			div(
				v-for="(post, i) of posts"
				:key="post.id"
				class="list-item"
			)
				//- .status
				.grid-middle-noBottom
					.col-8_md-12
						.image.fll(
							:style="{ backgroundImage: 'url(' + post.images[0] + ')' }"
							)
						h6.mb1.text-muted.text-uppercase {{post.item.full_name}}
						a(:href="post.link")
							h5 {{post.title}} &#x279a;
					.col
						//- el-button-group
						//- 	el-button(size='small') PUBLISH
						//- 	el-button(size='small') PUBLISH
						//- 	el-button(size='small') PUBLISH
				.grid-middle-noBottom.state-bar.text-small
					.col-12
						span.text-small.text-muted
							b {{new Date(post.parsed_at) | moment('YYYY-MM-DD HH:m:ss')}}
						span.slash.text-muted.text-uppercase /
						//- span.text-small Status:
						//- =' '
						span.dot(:style="{backgroundColor: statusColors[post.status]}")
						=' '
						el-dropdown(trigger="click")
							span.el-dropdown-link
								b.text-small.text-uppercase.text-muted {{post.status}}
								//- i.el-icon-caret-bottom.el-icon--right
							el-dropdown-menu(slot="dropdown")
								el-dropdown-item asdasd
								el-dropdown-item asdasd
						span.slash.text-muted.text-uppercase /
						//- span tags: {{post.tags}}
						span(v-for='tag in post.tags' v-if='post.tags.length > 0')  {{tag}} &nbsp;&nbsp;&nbsp;
</template>

<script lang="coffee">

	# import debounce from 'lodash/debounce.js'
	import {posts, removePost} from '@/schemas.coffee'
	import gql from 'graphql-tag'

	export default {
		data: ->
			statusColors:
				pending: 'lightblue'
				published: 'lightgreen'
				disabled: 'lightgrey'

		computed:
			postsIDs: ->
				posts.map (x) ->
					console.log new Date().valueOf()
					x.timestamp = new Date().valueOf()
				@postz.concat @posts

		# methods:
			# log: (x) -> console.log(x)
			# updateCounter: debounce (id, field) ->
			# 	@updateItem(id, field)
			# , 1000
			#
			# removePost: (id) ->
			# 	@$apollo.mutate
			# 		mutation: removePost
			# 		variables: {id: id}
			#
			# updateItem: (id, field) ->
			# 	@$apollo.mutate(
			# 		mutation: updateItem
			# 		variables: Object.assign {id}, field
			# 	).then((data) =>
			# 		@$message
			# 			type: 'success'
			# 			message: "#{data.data.updateItem.full_name} successfuly updated"
			# 		# console.log data
			# 	).catch (err) =>
			# 		@$notify
			# 			duration: 30000
			# 			type: 'error'
			# 			message: err.graphQLErrors[0]?.message || err
			#
			# parse_item: (id) ->
			# 	@axios.get('/parse'
			# 		params: id: id
			# 		).then (console.log)
			#
			# removePosts: (id) ->
			# 	@$apollo.mutate
			# 		mutation: removePosts
			# 		variables: { id: id }

		apollo:
			posts:
				query: posts
				variables:
					limit: 15

		mounted: ->
			postRemove = gql ["""
			 subscription postsRemoveSubscription {
				 PostRemove {
					 id
				 }
			 }
			 """]
			@$apollo.queries.posts.subscribeToMore
				document: postRemove
				updateQuery: ({posts}, { subscriptionData }) =>
					id = subscriptionData.data.PostRemove.id
					@_apollo.queries.posts.refetch()


			postAdd = gql ["""
			 subscription postsAddSubscription {
				 PostAdd {
					 id
				 }
			 }
			 """]
			@$apollo.queries.posts.subscribeToMore
				document: postAdd
				updateQuery: (previousResult, { subscriptionData }) =>
					@_apollo.queries.posts.refetch()


	}
</script>

<style scoped media="screen" lang="postcss">


</style>
