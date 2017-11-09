<template lang="pug">
	//- .ttt(style="padding: 50px; background: grey") {{item.full_name}}
	.item(
		v-if="item"
		:id="'item-'+item.id"
		:class="item.active ? 'active' : 'inactive' "
		v-loading="itemLoading"
		)
		section.head
			el-dropdown.item-dropdown(trigger="click" @command="handleItemCommand" v-if="canEdit")
				span.el-dropdown
					.icon(v-html="menuIcon")
				el-dropdown-menu(slot="dropdown")
					el-dropdown-item(command="switchActiveState") {{ item.active ? 'Deactivate' : 'Activate' }}
					el-dropdown-item(command="removePosts") Remove posts
					el-dropdown-item(command="downloadScreenshots" v-if="item.takeScreenshot") Download screenshots
					el-dropdown-item Publish all posts
					el-dropdown-item Unpublish all posts
					el-dropdown-item(command="removeItem") Delete
			.head__body
				h4: b {{item.full_name}}
				br
				//- span by {{item.owner.displayName || item.owner.username}}
				//- ="   "
				//- //- span {{item.owner.displayName || item.owner.username}}
				//- p
				//- 	| Status: {{' '}}
				//- 	b {{item.status}}
				table
					tr
						td Created by
						td {{item.owner.displayName || item.owner.username}}
					tr
						td Next run at
						td
							b(:ref="'nextParseDate'+item.id" style="display: inline-block") {{$moment(+nextParseDate).fromNow()}}
							//- b(:ref="'nextParseDate'+item.id" style="display: inline-block") {{$moment(+item.nextParseDate).format('HH:mm')}}
			LogoProgress(
				:id="item.id"
				:bgImg="item.logo"
				:percentage="progress"
				:width="80"
				:status="item.status"
				)

		section.body(style="text-align: center")
			h4(v-if="item.status == 'error'" style="color:red; font-weight:bold") ERROR

		section.counters
			Counter(
				name="posts"
				v-model="item.postsCount")
			Counter(
				name="depth"
				v-model="item.depth"
				@update="updateCounter"
				:editable="canEdit ? 'depth': false")
			Counter(
				name="interval"
				v-model="item.parseInterval"
				@update="updateCounter"
				:editable="canEdit ? 'parseInterval': false")

		section.buttons(v-if="canEdit")
			el-button-group
				el-button(
					round
					size="small"
					type="primary"
					:loading="item.loading || item.status == 'queued'"
					@click="parse_item"
					) {{item.loading ? 'LOADING...' : item.status != 'success' ? item.status : 'PARSE'}}
				el-button(
					round
					size="small"
					type="primary"
					@click="$router.push({ name: 'item_edit', params: {id: item.id}})"
					) edit
</template>

<script lang="coffee">

	import Vue from 'vue'
	import debounce from 'lodash/debounce.js'
	import {items, itemsSubscription, updateItem, removePosts, removeItem} from '@/schemas.coffee'
	import Counter from '@/components/Counter'
	import LogoProgress from '@/components/LogoProgress'
	import gql from 'graphql-tag'
	import anime from 'animejs'


	export default {

		components:
			Counter: Counter
			LogoProgress: LogoProgress
			BButton: require '@/components/Button'

		props: ['item']
		data: ->
			itemLoading: false
			menuOpened: false
			duration: ''
			menuIcon: require("@/assets/icons/menu.svg")
			nextParseDate: @item.nextParseDate

		# created: ->
		# 	@duration = @getNextParseDate()
		# 	interval = 1 * 1000
		# 	setInterval =>
		# 		@duration = @getNextParseDate()
		# 	, interval
		# computed:
		# 	nextParseDate: -> +@item.nextParseDate

		watch:
			'item.nextParseDate': (x,y) ->
				setTimeout =>
					@nextParseDate = x
				, 100
				anime
					targets: @$refs['nextParseDate'+@item.id]
					translateX: [
						{value: [0, -15], easing: 'easeInQuad', duration: 100}
						{value: 0, elasticity: 500}
					]
					opacity: [
						{value: [1, 0.01], easing: 'linear', duration: 100}
						{value: 1}
					]
				return

		computed:
			# nextParseDate: ->
			# 	if @item.nextParseDate
			# 		@$moment.utc
			# 		@$moment(new Date(+@item.nextParseDate)).format('HH:mm:ss')
			# 	else 'no date'

			progress: ->
				@item.data.progress || 0

			canEdit: ->
				@$auth.user().id is @item.owner.id || @$auth.check('admin')
				# if @$auth.check()
				# # @$auth.user().id is item.id
				# 	return true
				# else
				# 	return false

		methods:
			log: (x) -> console.log(x)

			debounce: debounce

			getNextParseDate: ->
				unless @item.nextParseDate then return 'not active'
				next = @$moment(new Date(+@item.nextParseDate))
				diff = @$moment.duration(next.diff @$moment()).asMilliseconds()
				@$moment.utc(diff).format('HH:mm:ss')


			downloadScreenshots: ->
				url = "https://avfrancev.ddns.net:3021/get-screenshots/?item=#{@item.name}"
				window.open url, '_blank'
				return

			updateCounter: debounce (_field) ->
				@updateItem(_field)
			, 500

			updateItem: (field) ->
				console.log field
				# @itemLoading = true
				@$apollo.mutate(
					mutation: updateItem
					variables: Object.assign {id: @item.id}, field
				).then((data) =>
					# @itemLoading = false
					# @$message
					# 	type: 'success'
					# 	message: "#{data.data.updateItem.full_name} successfuly updated"
					# console.log data
				).catch (err) =>
					@itemLoading = false
					@$notify
						duration: 30000
						type: 'error'
						message: err.graphQLErrors[0]?.message || err

			parse_item: ->
				@axios.get('/parse'
					params: id: @item.id
					).then (console.log)

			handleItemCommand: (command) ->
				switch command
					when 'removePosts'
						do @removePosts
					when 'removeItem'
						do @removeItem
					when 'downloadScreenshots'
						do @downloadScreenshots
					when 'switchActiveState'
						@updateItem { active: !@item.active }
					else
						return

			removePosts: ->
				this.$confirm("Realy delete all posts from #{@item.full_name}?", 'Warning', {
					confirmButtonText: 'OK'
					cancelButtonText: 'Cancel'
					type: 'warning'
				}).then( =>
					@$apollo.mutate
						mutation: removePosts
						variables: { item: {id: @item.id, name: @item.name} }
				)

			removeItem: ->
				this.$confirm("Realy delete item #{@item.full_name}?", 'Warning', {
					confirmButtonText: 'OK'
					cancelButtonText: 'Cancel'
					type: 'warning'
				}).then( =>
					@$apollo.mutate
						mutation: removeItem
						variables: { id: @item.id }
				)


	}
</script>

<style scoped lang="stylus">

	@import './../styles/vars.styl'

	.item
		border: 1px solid $grey_1
		border-radius: 4px
		background: #fff
		position: relative
		// transition: 0.3s
		height: 100%
		display: flex
		flex-direction: column
		transition: 300ms
		&.active
			opacity: 1
			filter: saturate(1)
		&.inactive
			opacity: 0.4
			filter: saturate(0.2)
			&:hover
				opacity: 0.65
		&:hover
			box-shadow: 0 0 8px 0 rgba(232,237,250,.6), 0 2px 4px 0 rgba(232,237,250,.5)
			opacity: 1
			filter: saturate(1)


		hr
			border: none
			border-top: 1px solid #e6e9f4
			border-bottom: 1px solid #fff

	section
		padding: 0 20px 20px 20px


	section.head
		position: relative
		background: $grey_0
		padding-bottom: 65px
		padding-top: 20px
		margin-bottom: 60px
		flex: 1

		.head__body
			text-align: center
			margin: 0 20px

			table
				width: 100%
				tr
					td
						width: 50%
					td:first-child
						padding-right: 5px
						text-align: right
						color: $Light_Silver
						font-size: 12.5px
						line-height: 20px
					td:last-child
						padding-left: 5px
						text-align: left

		.image
			position: absolute
			left: 50%
			bottom: -30px
			background: #f4f5fa
			margin-left: -25px
			border-radius: 50%
			background-size: 100%
			background-repeat: no-repeat
			background-position: 50% 50%
			box-shadow: 0 0 0 5px #fff
			height: 60px
			width: 60px

	// section.body
	// 	margin-top: 65px





	.el-button
		text-transform: uppercase


	.counters
		display: flex
		flex-direction: row
		.counter
			flex: 1

	section.buttons
		/*padding: 0 20px 20px*/
		.el-button-group
			display: flex
			button, a
				flex: 0 0 1
				width: 100%

	.item-dropdown
		position: absolute
		cursor: pointer
		// padding: 15px 15px 3px 15px
		padding: 0 15px
		right: 0
		// z-index: 1
		fill: $Light_Silver

</style>
