<template lang="pug">
transition
	.item(:id="'item-'+item.id" v-on:mouseleave="debounceCloseMenu" )
		.panel(:class='{"loading": item.loading}' :style="{opacity: item.active ? '1':'0.4'}")
			.panel-content(:class='{"scale-down": menuOpened && !item.loading}')
				section.top
					.image.is-96x96(
						animated
						:style="{ backgroundImage: 'url(' + item.logo + ')' }"
					)
					h4 {{ item.full_name }}
					p
						span.text-small.text-muted by
						=" "
						span.text-muted {{item.owner.displayName || item.owner.username}}


				section.has-text-centered.font-roboto
					//- p(v-if="!item.nextParseDate || (!item.active && item.loading)") Not active
					//- p(v-if="item.active && !item.loading && item.nextParseDate") Next parse in: {{ duration }}
					//- p(v-else-if="item.loading") 🚀 Parsing {{item.data.progress}}%
					//- p(v-else-if="item.status == 'queued'") pending...
					//- br
					el-progress(
						type="circle"
						:percentage="item.data.progress"
						:status="progressStatus"
						:width="70"
					)


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
						//- :loading="item.loading || item.status != ''"
						el-button(
							type="info"
							/*size="small"*/
							:loading="item.loading"
							@click="parse_item") {{item.loading ? 'LOADING...' : item.status ? item.status : 'PARSE'}}
						router-link.el-button.el-button--info.el-button--small(
							:to="{ name: 'item_edit', params: {id: item.id} }"
							tag="button"
							) EDIT
						el-button(type="info" size="small" @click="menuOpened = !menuOpened") &#9776;

				//- section.buttons(v-if="!canEdit")
				//- 	hr
					//- p
					//- 	| Owner:
					//- 	= ' '
					//- 	b: i {{item.owner.displayName || item.owner.username}}

				div(
					v-show="item.loading"
					:style="{	position: 'absolute', bottom: '0', width: item.data.progress + '%', height: '1px', borderBottom: '1px solid red', transition: '0.3s' }"
				)
				//- pre {{canEdit}}
				//- pre {{item.owner}}

			transition(name="menuSlide")
				nav(v-if="menuOpened && !item.loading" @click="menuOpened = false")
					section.buttons
						el-button-group
							el-button(type="danger"  size="small") DEL
							el-button(type="danger"  size="small" @click="removePosts") DEL POSTS
							el-button(type="danger"  size="small") COPY
							//- el-button(type="danger"  size="small" @click="menuOpened = false") X
					//- 	p.control
					//- 		a.button.is-danger(@click="deleteItem") DEL
					//- 	p.control
					//- 		a.button.is-danger(@click="delete_posts") DEL POSTS
					//- 	p.control
					//- 		a.button.is-danger(@click="copy") COPY
					//- 	p.control(style="width: auto")
					//- 		a.button.is-danger(@click="menuOpened = false") X
</template>

<script lang="coffee">

	import debounce from 'lodash/debounce.js'
	import throttle from 'lodash/throttle.js'
	import {items, itemsSubscription, updateItem, removePost, removePosts} from '@/schemas.coffee'
	import Counter from '@/components/Counter'
	import gql from 'graphql-tag'
	import anime from 'animejs'

	export default {

		components:
			Counter: Counter

		props: ['item']
		data: ->
			menuOpened: false
			duration: ''

		created: ->
			@duration = @getNextParseDate()
			interval = 1 * 1000
			setInterval =>
				@duration = @getNextParseDate()
			, interval

		computed:
			progressStatus: ->
				if @item.status is 'error' then return 'exception'
				else if @item.data.progress is 100 then return 'success'

			canEdit: ->
				@$auth.user().id is @item.owner.id || @$auth.check('admin')
				# if @$auth.check()
				# # @$auth.user().id is item.id
				# 	return true
				# else
				# 	return false

		methods:
			log: (x) -> console.log(x)

			getNextParseDate: ->
				# console.log @item.nextParseDate
				next = @$moment(new Date(+@item.nextParseDate))
				diff = @$moment.duration(next.diff @$moment()).asMilliseconds()
				@$moment.utc(diff).format('HH:mm:ss')

			debounceCloseMenu: debounce ->
				@menuOpened = false
			, 500
			updateCounter: debounce (id, field) ->
				@updateItem(id, field)
			, 1000

			# removePost: (id) ->
			# 	@$apollo.mutate
			# 		mutation: removePost
			# 		variables: {id: id}

			updateItem: (field) ->
				@$apollo.mutate(
					mutation: updateItem
					variables: Object.assign {id: @item.id}, field
				).then((data) =>
					@$message
						type: 'success'
						message: "#{data.data.updateItem.full_name} successfuly updated"
					# console.log data
				).catch (err) =>
					@$notify
						duration: 30000
						type: 'error'
						message: err.graphQLErrors[0]?.message || err

			parse_item: ->
				@axios.get('/parse'
					params: id: @item.id
					).then (console.log)

			removePosts: ->
				@$apollo.mutate
					mutation: removePosts
					variables: { id: @item.id }

	}
</script>

<style scoped lang="stylus">

	@import "./../vars.styl"

	.el-button
		text-transform: uppercase

	.item
		border: 1px solid $Extra_Light_Gray
		border-radius: 4px
		transition: .2s
		background: #fff
		transition: 0.2s
		&:hover
			box-shadow: 0 0 8px 0 rgba(232,237,250,.6), 0 2px 4px 0 rgba(232,237,250,.5)

	section
		padding: 10px 20px
		text-align: center
		font-weight: 100

	.panel-content section:nth-last-child(2)
		padding-bottom: 20px


	section.top
		flex: 1
		padding: 20px
		.image
			margin: 0 auto
			margin-bottom: 20px
			border-radius: 50%
			background-size: 100%
			background-repeat: no-repeat
			background-position: 50% 50%
			box-shadow: 0 0 0 5px $Light_Gray
			height: 100px
			width: 100px
			/*&:before
				position: absolute
				content: ''
				width: 100%
				height: 100%
				border-radius: 50%
				border: 12px dashed transparent*/

		.item-name
			margin: 10px 0

	.counters
		display: flex
		flex-direction: row
		.counter
			flex: 1

	section.buttons
		padding: 0 20px 20px
		.el-button-group
			display: flex
			button, a
				width: 100%

	.field:not(:last-child)
		margin-bottom: 0



	nav
		position: absolute
		bottom: 0
		left: 0
		right: 0
		border-top: 1px solid $Extra_Light_Gray
		background: #fff

		transition: 1s
		section.buttons
			padding: 20px

	.menuSlide-leave-active
		transition: .3s

	.menuSlide-enter-active
		transition: .3s

	.menuSlide-enter
		transform: translateY(100px)
		opacity: 0

	.menuSlide-leave-to
		opacity: 0
		transform: translateY(100px)
</style>
