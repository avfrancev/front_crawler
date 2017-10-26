
<template lang="pug">
	.posts
		transition-group(
			name="list"
			tag='div'
			mode="out-in"
			v-if='posts'
			style="position: relative; min-height: 500px"
			)
			div(
				v-for="(post, i) of posts"
				:key="post.id"
				class="post list-item"
			)
				div.grid(style="overflow: hidden;")
					.col-lg-10.col-md-9.main
						h3 {{post.title}}
					.actions.col-lg-2.col-md-3.col-bleed
						el-button-group.as-column
							el-button() Publish
							el-button( icon="delete" @click="removePostByID(post)") Delete
</template>

<script lang="coffee">

	import Vue from 'Vue'
	import debounce from 'lodash/debounce.js'
	import {posts, postsSubscription, removePost} from '@/schemas.coffee'
	import gql from 'graphql-tag'

	export default {
		data: ->
			statusColors:
				pending: 'lightblue'
				published: 'lightgreen'
				disabled: 'lightgrey'


		methods:
			log: (x) -> console.log(x)
			updateCounter: debounce (id, field) ->
				@updateItem(id, field)
			, 1000

			removePostByID: (post) ->
				@$apollo.mutate
					mutation: removePost
					variables: {id: post.id, itemId: post.item.id}

		apollo:
			posts:
				query: posts
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

.posts
	margin-top: 20px

.post
	width: 100%
	background: #f4f5fa
	background: #fff
	&:not(:last-child)
		margin-bottom: 10px

	.main
		box-shadow: 0px 0 25px #e3e5f2
		border-right: 1px solid #e3e5f2

.as-column
	display: flex
	flex-direction: column
	height: 100%
	background: #f4f5fa

	.el-button
		height: 100%
		width: 100%
		border-bottom-color: transparent
		border: none
		background: transparent
		// &:hover
		// 	border-bottom-color: #20a0ff !important
		// 	background: #e3e5f2
		// 	& + .el-button
		// 		border-top-color: transparent

	// .el-button:first-child
	// 	border-radius: 3px 3px 0 0
	// .el-button:last-child
	// 	border-radius: 0 0 3px 3px
	// 	border-bottom-color: #c4c4c4


</style>
