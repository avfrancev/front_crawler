<template lang="pug">
	div asdasd
		//- pre {{items}}
		//- div(v-for="item in items")
		//- 	h3 {{item.name}} || {{item.depth}}
		//- 	input(type="number" :value="item.depth" :data-item-id="item.id" @input="updateCounter")
</template>



<script lang="coffee">

	import debounce from 'lodash/debounce.js'
	# import _ from 'lodash'
	# import {items, itemsSubscription, updateItem, removePost, removePosts} from '@/schemas.coffee'
	import Counter from '@/components/Counter'
	# import gql from 'graphql-tag'

	export default {
		components:
			Counter: Counter
			# LogoProgress: require '@/components/LogoProgress'
		# data: ->
		# 	# items: [0,1,2,3,4,5,6,7,8,9]
		# 	items: []
		# computed:
			# items: -> @$store.state.items

		# created: ->
		# 	@$store.dispatch 'getItems'

		# methods:
		# 	updateCounter: ({target}) ->
		# 		@$store.dispatch 'updateItem', { id: target.dataset.itemId, depth: target.value }

			# updateCounter: debounce (e) ->
			# 	console.log(e)
			# 	# @$store.dispatch 'updateItem', field
			# , 1000



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
