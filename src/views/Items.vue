<template lang="pug">
	//- .grid(v-loading="loading")
	avf-transition-group(name="list" tag='div' style="" class="grid"  @before-leave="beforeLeave" v-loading="loading")
		.col-xlg-3.col-lg-4.col-md-6.col-sm-6.col-xs-6(v-for="(item, index) of items" :key="item.id" class="list-item")
			Item(:item="item")
		.col-xlg-3.col-lg-4.col-md-6.col-sm-6.col-xs-6.list-item(key="new" @click="$router.push({name:'item_new'})")
			.new-item
				.plus-icon
</template>

<script lang="coffee">

	# import debounce from 'lodash/debounce.js'
	import {items, itemsSubscription, updateItem, removePost, removePosts} from '@/schemas.coffee'
	import Item from '@/components/Item'
	import gql from 'graphql-tag'

	export default {
		components:
			Item: require '@/components/Item'
			Item: Item
		data: ->
			loading: 0
			# items: []

		computed:
			items: -> @$store.state.items

		methods:
			beforeLeave: (el) ->
				{marginLeft, marginTop, width, height} = window.getComputedStyle(el)
				el.style.left = "#{el.offsetLeft - parseFloat(marginLeft, 10)}px"
				el.style.top = "#{el.offsetTop - parseFloat(marginTop, 10)}px"
				el.style.width = width
				el.style.height = height
				return
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

		# apollo:
		# 	items: ->
		# 		query: items
		# 		loadingKey: 'loading'
		# 		variables:
		# 			limit: 0
		# 		fetchPolicy: 'cache-and-network'
		# 		subscribeToMore: [{
		# 			document: itemsSubscription
		# 			updateQuery: (previousResult, { subscriptionData }) =>
		# 				# console.log @
		# 				data = subscriptionData.data.ItemChange
		# 				if data.mutation is 'DELETED'
		# 					console.log previousResult
		# 					a = previousResult.items.filter (x) -> x.id isnt data.node.id
		# 					console.log a
		#
		# 				# @$apollo.queries.items.refetch()
		# 				return {items: a} || previousResult
		# 		}]

			# $subscribe:
			# 	ItemChange:
			# 		query: itemsSubscription
			# 		update: (data) -> console.log '==============='
			# 		updateQuery: (data) ->
			# 			console.log '!!!!!!!!!!!!!!!!'
			# 			console.log data
			# 			data
			# 			# data.ItemChange

		# mounted: ->
		# 	postRemove = gql ["""
		# 	 subscription postsSubscription {
		# 		 PostRemove {
		# 			 id
		# 		 }
		# 	 }
		# 	 """]
		# 	@$apollo.queries.items.subscribeToMore
		# 		document: postRemove
		# 		# updateQuery: (previousResult, { subscriptionData }) =>
		# 		# 	@_apollo.queries.items.refetch()


	}
</script>

<style lang="stylus">
@import '../styles/vars.styl'

.new-item
	border: 2px dashed $Extra_Light_Gray
	height: 100%
	min-height: 300px
	border-radius: 4px
	background: #fff
	transition: 0.3s
	display: flex
	flex-direction: column
	align-items: center
	justify-content: center
	cursor: pointer

	&:hover
		.plus-icon
			transform: scale(1.2)
			&:after, &:before
				// background: red
				height: 10px

	.plus-icon
		position: relative
		transition: 300ms

		&:after, &:before
			transition: 300ms
			position: absolute
			content: ''
			display: block
			height: 5px
			width: 100px
			left: -50px
			background: $Extra_Light_Gray
			border-radius: 5px
		&:after
			transform: rotate(90deg)
		// &:before
		// 	background: red

</style>
