<template lang="pug">
	//- .items.grid-3-equalHeight_xs-1_sm-2_md-2_lg-3
	//- 	.col(v-for="item of items")
	//- el-row(type="flex" :gutter="20")
	//- 	el-col(:lg="8" :md="12" v-for="item of items" :key="item.id")
	.loading(v-if="loading") LOADING....
	.grid.grid-plain(v-else)
		.col-lg-4.col-md-6.col-sm-6.col-xs-6(v-for="item of items" :key="item.id")
			Item2(:item="item")
		//- .col-lg-4.col-md-6(v-for="item of items" :key="item.id")
		//- 	Item2(:item="item")
	//- div
		div(v-for="item of items")
			//- Item(:item="item", :key="item.id")
	//- el-row(:gutter="20")
	//- 	el-col(:lg="8" :md="12" :sm="12" :xs="24" v-for="item of items")
</template>

<script lang="coffee">

	# import debounce from 'lodash/debounce.js'
	import {items, itemsSubscription, updateItem, removePost, removePosts} from '@/schemas.coffee'
	import Item from '@/components/Item'
	import Item2 from '@/components/Item2'
	import gql from 'graphql-tag'

	export default {
		components:
			Item: Item
			Item2: Item2
		data: ->
			loading: 0
			items: []

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
			items:
				query: items
				loadingKey: 'loading'
				variables:
					limit: 0
				# update: (data) ->
				# 	data.items

			$subscribe:
				ItemChange:
					query: itemsSubscription

		mounted: ->
			postRemove = gql ["""
			 subscription postsSubscription {
				 PostRemove {
					 id
				 }
			 }
			 """]
			@$apollo.queries.items.subscribeToMore
				document: postRemove
				# updateQuery: (previousResult, { subscriptionData }) =>
				# 	@_apollo.queries.items.refetch()


	}
</script>

<style media="screen" lang="stylus">

</style>
