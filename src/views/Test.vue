<template lang="pug">
	div
		.inner-content
			div(v-for="item in [1,2,3,4,5,6,7]")
				LogoProgress(
					:id="item"
					bgImg="http://ya.ru/favicon.ico"
					:percentage="item*10"
					:width="80"
					:status="'success'"
				)
			h1 TEST
			el-button(@click="add") ADD
			el-button(@click="remove") REMOVE
			el-button(@click="shuffle") SHUFFLE
			transition-group(name="list" class='flex')
				div(v-for="item in items" v-bind:key="item" class="list-item") {{item}}
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
