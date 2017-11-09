
<template lang="pug">
	.posts(v-loading="loading")
		avf-transition-group(
			v-if='posts'
			)
			div(
				v-for="(post, i) of posts"
				:key="post.id"
				class="post xxx-item"
			)
				Post(:post="post")
</template>

<script lang="coffee">

	import Vue from 'Vue'
	import debounce from 'lodash/debounce.js'
	import {posts, postsSubscription, removePost, updatePost} from '@/schemas.coffee'
	import gql from 'graphql-tag'

	export default {

		components: {
			Post: require '@/components/Post'
		}

		data: ->
			state: require('@/store/index.coffee').default
			loading: 0
			statusColors:
				pending: 'lightblue'
				published: 'lightgreen'
				disabled: 'lightgrey'
			itemsSelect: []
			searchQuery: ''
			published: null

		# computed:
		# 	posts: -> @$store.state.posts
		# 	items: -> @$store.state.items
			# filterVariables: ->
			# 	limit: 10
			#   filter:
			# itemsSelect: ->
			# 	get: -> @item.id
			# 	set: (v) -> @$set(@item, 'owner', Object.assign {}, @item.owner, {id: v})



		methods:
			log: (x) -> console.log(x)
			updateCounter: debounce (id, field) ->
				@updateItem(id, field)
			, 1000

			removePostByID: (post) ->
				@$apollo.mutate
					mutation: removePost
					variables: {id: post.id, itemId: post.item.id, item: {id: '124124124124124124124', name: 'HAHAHAHAHA'}}

			togglePostPublish: (post) ->
				@$apollo.mutate
					mutation: updatePost
					variables: {id: post.id, published: !post.published}

		apollo:
			posts:
				query: posts
				# fetchPolicy: 'network-only'
				fetchPolicy: 'cache-and-network'
				loadingKey: 'loading'
				variables: ->
					limit: @state.postsFilters.limit
					filter:
						itemIds: @state.postsFilters.itemIds
						published: @state.postsFilters.published
						searchQuery: @state.postsFilters.searchQuery
				subscribeToMore: [{
					document: postsSubscription
					updateQuery: (previousResult, { subscriptionData }) =>
						data = subscriptionData.PostChange
						if data.mutation is 'DELETED'
							return { posts: previousResult.posts.filter (x) -> x.id isnt data.node.id }
						if data.mutation is 'CREATED'
							new_posts = [previousResult.posts...]
							new_posts.unshift data.node
							return { posts: new_posts }

						return previousResult
				}]

			items:
				query: require('graphql-tag') ["""
				{
					items {
						id
						full_name
						postsCount
					}
				}
				"""]
			# $subscribe:
			# 	posts:
			# 		query: postsSubscription
			# 		result: (data) ->
			# 			console.log data
			# 			@_apollo.queries.posts.refetch()
			# 			# Vue.set(@posts, 0, {id: '000000', title: '981365981364678'})
			# 			return


		# mounted: ->
		# 	@$apollo.queries.posts.subscribeToMore
		# 		document: postsSubscription
		# 		updateQuery: (previousResult, { subscriptionData }) =>
		# 			@_apollo.queries.posts.refetch()
		# 			return previousResult


	}
</script>

<style scoped media="screen" lang="stylus">

@import './../styles/vars.styl'



</style>
