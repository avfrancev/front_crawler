<template lang="pug">
	.posts
		//- p {{postsIDs}}
		transition-group(name="list" tag='div' style="position: relative" v-if='posts')
			div(
				v-for="(post, i) of posts"
				:key="post.id"
				class="list-item"
			)
				//- .status
				.grid-middle-noBottom
					.col-8_md-12
						//- .image.fll(
						//- 	:style="{ backgroundImage: 'url(' + post.images[0] || '' + ')' }"
						//- 	)
						h6.mb1.text-muted.text-uppercase {{post.item.full_name}}
						a(:href="post.link")
							h5 {{post.title}} &#x279a;
					.col
						el-button-group
							el-button(size='small' @click="removePostByID(post)") DEL
						//- 	el-button(size='small') PUBLISH
						//- 	el-button(size='small') PUBLISH
				.grid-middle-noBottom.state-bar.text-small
					.col-12
						span.text-small.text-muted
							b {{ $moment(new Date(+post.parsed_at)).format('YYYY-MM-DD HH:mm:ss:SSS')}}
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
								el-dropdown-item Published
								el-dropdown-item asdasd
						span.slash.text-muted.text-uppercase /
						//- span tags: {{post.tags}}
						span(v-for='tag in post.tags' v-if='post.tags.length > 0')  {{tag}} &nbsp;&nbsp;&nbsp;
</template>

<script lang="coffee">

	import debounce from 'lodash/debounce.js'
	import {posts, removePost, postRemove, postAdd, updatePost} from '@/schemas.coffee'
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
				# console.log post
				@$apollo.mutate
					mutation: removePost
					variables: {id: post.id, itemId: post.item.id}
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
					limit: 5
		mounted: ->

			@$apollo.queries.posts.subscribeToMore
				document: postRemove
				updateQuery: (previousResult, { subscriptionData }) =>
					id = subscriptionData.data.PostRemove.id
					@_apollo.queries.posts.refetch()
					return previousResult



			@$apollo.queries.posts.subscribeToMore
				document: postAdd
				updateQuery: (previousResult, { subscriptionData }) =>
					@_apollo.queries.posts.refetch()
					return previousResult


	}
</script>

<style scoped media="screen" lang="stylus">

@import '../vars.styl'

.list-item
	margin: 20px 0
	border: 1px solid $Extra_Light_Gray
	border-radius: 4px
	background: #fff
	width: 100%
	overflow: hidden
	&:hover
		box-shadow: 0 0 8px 0 rgba(232,237,250,.6), 0 2px 4px 0 rgba(232,237,250,.5)

	& > *
		padding: 15px

.state-bar
	background: $Extra_Light_Gray
	padding: 10px 15px

.status
	margin: 0
	background: #13CE66
	position: absolute
	height: 100%
	width: 3px

.slash
	margin: 0 10px

.dot
	height: 10px
	width: 10px
	display: inline-block
	border-radius: 50%

.image
	height: 35px
	width: 35px
	margin-right: 10px
	border-radius: 50%
	filter: grey(1)
	border: 1px solid $Extra_Light_Silver
	background-position: 50%
	background-size: cover
	background-repeat: no-repeat

</style>
