
<template lang="pug">
	div
		//- pre {{state.postsFilters.limit}}
		//- .grid
		//- 	.col-lg-4
		//- 		el-select(v-model="state.postsFilters.itemIds" placeholder='Select item' multiple clearable style="width:100%")
		//- 			el-option(
		//- 				v-for="item in items"
		//- 				:key="item.id"
		//- 				:value="item.id"
		//- 				:label="item.full_name"
		//- 				)
		//- 				b(style="margin: 0 20px 0 0") [ {{item.postsCount}} ]
		//- 				span {{item.full_name}}
		//- 	.col-lg-2
		//- 		el-select(v-model="state.postsFilters.published" clearable placeholder='Select publish state')
		//- 			el-option(:value="true" label="Published")
		//- 			el-option(:value="false" label="Unpublished")
		//- 	.col-lg-6
		//- 		el-input(v-model='state.postsFilters.searchQuery' placeholder="Search...")
		.posts
			avf-transition-group(
				v-if='posts'
				style="position: relative"
				)
				div(
					v-for="(post, i) of posts"
					:key="post.id"
					class="post xxx-item"
				)
					div.grid(style="overflow: hidden;")
						.col-lg-9.col-md-8
							h4 {{post.title}}
							.text-muted
								b {{post.item.full_name}}
							//- pre {{post}}
						.col-lg-3.col-md-4
							el-button-group
								el-button(size="mini" @click="togglePostPublish(post)") {{post.published ? 'Unpublish' : 'Publish'}}
								el-button(size="mini" @click="$router.push({name:'post_view', params: {id: post.id}})") View
								el-button(size="mini" icon="delete" @click="removePostByID(post)") Delete
</template>

<script lang="coffee">

	import Vue from 'Vue'
	import debounce from 'lodash/debounce.js'
	import {posts, postsSubscription, removePost, updatePost} from '@/schemas.coffee'
	import gql from 'graphql-tag'

	export default {
		data: ->
			state: require('@/store/index.coffee').default
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
					variables: {id: post.id, itemId: post.item.id}

			togglePostPublish: (post) ->
				@$apollo.mutate
					mutation: updatePost
					variables: {id: post.id, published: !post.published}

		apollo:
			posts:
				query: posts
				fetchPolicy: 'network-only'
				variables: ->
					limit: @state.postsFilters.limit
					filter:
						itemIds: @state.postsFilters.itemIds
						published: @state.postsFilters.published
						searchQuery: @state.postsFilters.searchQuery
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
			$subscribe:
				posts:
					query: postsSubscription
					result: (data) ->
						@_apollo.queries.posts.refetch()
						# Vue.set(@posts, 0, {id: '000000', title: '981365981364678'})
						return


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

// .posts
// 	margin-top: 20px

// .post
// 	width: 100%
// 	background: #f4f5fa
// 	background: #fff
// 	&:not(:last-child)
// 		margin-bottom: 10px
//
// 	.main
// 		box-shadow: 0px 0 25px #e3e5f2
// 		border-right: 1px solid #e3e5f2

// .as-column
// 	display: flex
// 	flex-direction: column
// 	height: 100%
// 	background: #f4f5fa
//
// 	.el-button
// 		height: 100%
// 		width: 100%
// 		border-bottom-color: transparent
// 		border: none
// 		background: transparent
// 		// &:hover
// 		// 	border-bottom-color: #20a0ff !important
// 		// 	background: #e3e5f2
// 		// 	& + .el-button
// 		// 		border-top-color: transparent
//
// .xxx-item
// 	transition: all 400ms
// 	opacity: 1
// 	width 100%
// 	padding: 10px
// 	background: #eee
// 	margin-bottom: 1px
// 	overflow: hidden
// 	// width 100%
// 	// margin-right: 10px;
//
// .xxx-enter, .xxx-leave-to
// 	opacity: 0.01
// 	transform: scaleY(0.01) translateY(-130px)
// 	// transform: translateX(-30px)
//
// .xxx-leave-active
// 	position: absolute
//
// .xxx-move
// 	transition: transform 400ms


</style>
