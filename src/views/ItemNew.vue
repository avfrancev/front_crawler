<template lang="pug">
#item-form
	//- h1 {{loadingQueriesCount}}
	//- h1 {{users}}
	.item(v-if='item')
		//- .grid.align-center
			.col-lg-4.col-xs-6
		.logo(:style="{ backgroundImage: 'url(' + item.logo + ')' }")
		h3.item-name {{item.full_name}}
			//- .col-lg-8.col-xs-6


		br
		br
		.grid.align-content-space-between(v-if="item")
			.col-sm-6
				el-form(:model="item" label-width="25%")
					el-form-item(label="Active")
						el-switch(v-model='item.active')

					el-form-item(label="Owner")
						el-select(v-model="owner")
							el-option(
								v-for="user in users"
								:key="user.id"
								:value="user.id"
								:label="user.displayName || user.username"
								)
					el-form-item(label="Name")
						el-input(type="text" v-model="item.name")
					el-form-item(label="Full Name")
						el-input(type="text" v-model="item.full_name")
					el-form-item(label="Start Link")
						el-input(type="text" v-model="item.link")
					el-form-item(label="Logo")
						el-input(type="text" v-model="item.logo")
					//- el-form-item(label="Capture Selector")
					//-   el-input.input(type="text" v-model="item.captureSelector")
					//- el-form-item(label="Next parse date")
					//-   el-date-picker.input(width="100%" :disabled="!item.active" type="datetime" v-model="item.nextParseDate")

					//-el-form-item
						el-button(type="primary" @click.prevent="submit") SUBMIT
						el-button(type="primary" @click.prevent="logItem") LOG ITEM
			.col-sm-6
				//- .counters
				.grid(style="height: 100%")
					Counter.col-6(
						name="posts count"
						v-model="item.postsCount")
					Counter.col-6(
						name="concurrency"
						v-model="item.concurrency"
						editable)
					Counter.col-6(
						name="depth"
						v-model="item.depth"
						editable)
					Counter.col-6(
						name="Parse Interval"
						v-model="item.parseInterval"
						:min="1" :max="24"
						editable)
		br
		br
		.code
			codemirror(
				v-model="item.schemas"
				:options="editorOptions"
			)
		br
		br

		.grid
			.col-12.tc
				el-button(type="primary" @click.prevent="onSubmit") Create
				//- el-button(type="danger" @click.prevent="delete_posts") DELETE POSTS
				//- el-button(type="primary" @click="parse_item") {{item.loading ? 'LOADING...' : 'PARSE'}}
</template>

<script lang="coffee">

	import {users, addItem} from '@/schemas.coffee'
	schemas= """
		Gurkha = require 'gurkha'

		module.exports =
			{
				page: ->
					return new Gurkha(
						posts:
							'$rule': '.post'
							title: '.post__title_link'
							link:
								'$rule': '.post__title_link'
								'$sanitizer': ($elem) ->
									return $elem.attr('href')
							posted_at:
								'$rule': '.post__time_published'
								'$sanitizer': ($elem) ->
									$elem.text()
						next_link:
							'$rule': 'a#next_page'
							'$sanitizer': ($elem) ->
								return 'https://habrahabr.ru/' + $elem.attr('href')
					)
				post: ->
					return new Gurkha(
						images:
							'$rule': '.content img'
							'$sanitizer': ($elem) ->
								return $elem.attr('src')
					)
			}
	"""

	export default {

		components: {
			Counter: require '@/components/Counter'
		}

		data: ->
			loadingQueriesCount: 0
			users: []
			owner: @$auth.user().id
			editorOptions:
				theme: 'dracula'
				mode: 'coffeescript'
				tabSize: 2
				indentWithTabs: true
				lineNumbers: true
				dragDrop: false
			item:
				active: false
				postsCount: 0
				concurrency: 1
				depth: 1
				parseInterval: 1
				schemas: schemas

		methods:
			onSubmit: ->
				# console.log {
				# 	@item...
				# 	owner: @owner
				# }
				@$apollo.mutate(
					mutation: addItem
					variables: {
						@item...
						owner: @owner
					}
				).then((data) =>
					console.log data
					@$message
						type: 'success'
						message: "#{data.data.addItem.full_name} successfuly created"
					@$router.push({name:'items'})
					# console.log data
				).catch (err) =>
					console.error err
					console.log @$message
					@$notify
						duration: 30000
						type: 'error'
						message: err?.graphQLErrors[0]?.message || err
				return


		apollo:
			users: ->
				query: -> users

	}
</script>



<style scoped lang="stylus">

	@import './../styles/vars.styl'

	.logo
		margin: 0 auto
		border-radius: 50%
		background-size: 100%
		background-repeat: no-repeat
		background-position: 50% 50%
		box-shadow: 0 0 0 5px $Extra_Light_Gray
		height: 70px
		width: 70px

	.item-name
		padding: 20px 20px 0 20px
		text-align: center
		font-weight: bold
		+sm()
			padding: 20px 40px 0 40px


	.counters
		display: flex
		flex-direction: row
		flex-wrap: wrap
		.counter
			// max-width: 25%
			// flex: 0 0 25%
			max-width: 50%
			flex: 0 0 50%
			// +md()
	.code
		// height: 300px
		overflow-y: scroll

</style>
