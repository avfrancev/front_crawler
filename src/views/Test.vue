<template lang="pug">
	div
		.inner-content
			h1 TEST
			el-button(@click="add") ADD
			el-button(@click="remove") REMOVE
			el-button(@click="shuffle") SHUFFLE
			transition-group(name="xxx" tag="div")
				div(v-for="item in items" :key="item" class="xxx-item")
					div
						h5 {{item}}
			//- <transition-group name="xxx" tag="p">
			//- 	<span v-for="item in items" :key="item" class="xxx-item"> {{ item }} </span>
			//- </transition-group>
</template>

<script lang="coffee">

	import _ from 'lodash'
	import {items, itemsSubscription, updateItem, removePost, removePosts} from '@/schemas.coffee'
	import Counter from '@/components/Counter'
	import gql from 'graphql-tag'

	export default {
		components:
			Counter: Counter
			LogoProgress: require '@/components/LogoProgress'
		data: ->
			items: [0,1,2,3,4,5,6,7,8,9]
			nextNum: 10

		methods:
			randomIndex: ->
				Math.floor Math.random() * @items.length
			add: ->
				@items.splice @randomIndex(), 0, @nextNum++
			remove: ->
				@items.splice @randomIndex(), 1
			shuffle: ->
				@items = _.shuffle(@items)


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
