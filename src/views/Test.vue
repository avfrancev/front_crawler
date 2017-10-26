<template lang="pug">
	div
		h1 TEST
		//- h1 {{localCount}}
		//- h1 {{count}}
		//- div(v-for="item of items")
		//- 	h2 {{item.full_name}} :: {{item.status}} :: {{item.data.progress}}
		//- hr
		//- div(v-for="post in posts")
		//- 	p {{post.title}}
</template>

<script lang="coffee">

	# import _ from 'lodash'
	# import {items, itemsSubscription, updateItem, removePost, removePosts} from '@/schemas.coffee'
	# import Counter from '@/components/Counter'
	# import gql from 'graphql-tag'
	# import { mapState } from 'vuex'

	export default {
		# components:
		# 	Counter: Counter
		# 	LogoProgress: require '@/components/LogoProgress'
		# data: ->
		# 	nextNum: 10

		# computed: {
		# 	items: -> @$store.state.items
		# 	posts: ->
		# 		console.log @$store.state.posts
		# 		@$store.state.posts
		# 	localCount: ->
		# 		return 99
		# 	mapState(
		# 		count: 'count'
		# 	)...
		# }

		# created: ->
		# 	@$store.dispatch 'getItems'
		# 	@$store.dispatch 'getPosts'
		# 	@$store.dispatch 'subscribeToItems'
		# 	@$store.dispatch 'subscribeToPosts'
		# 	return

	}
</script>

<style media="screen" scoped lang="stylus">

.xxx-item
	transition: all 400ms
	display: block
	opacity: 1
	width 100%
	heigh: 40px
	padding: 10px
	background: #eee
	margin-bottom: 1px
	// width 100%
	// margin-right: 10px;

.xxx-enter, .xxx-leave-to
	opacity: 0.1
	transform: scaleY(0.2)
	// transform: translateX(30px)

.xxx-leave-active
	position: absolute

// .xxx-move
// 	transition: transform 1.2s


</style>
