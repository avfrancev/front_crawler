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
						el-select(type="text" v-model="owner")
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
					el-form-item(label="Take screenshot")
						el-switch(v-model='item.takeScreenshot')
					el-form-item(label="Screenshot selector" v-if="item.takeScreenshot")
						el-input(type="text" v-model="item.captureSelector")
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
				el-button(type="primary" @click.prevent="onSubmit") SUBMIT
				el-button(type="danger" @click.prevent="delete_posts") DELETE POSTS
				el-button(type="primary" @click="parse_item") {{item.loading ? 'LOADING...' : 'PARSE'}}
</template>

<script lang="coffee">

	import {users, item, updateItem} from '@/schemas.coffee'

	export default {

		components: {
			Counter: require '@/components/Counter'
			ItemForm: require '@/components/ItemForm'
		}

		data: ->
			loadingQueriesCount: 0
			users: []
			item: null
			editorOptions:
				theme: 'dracula'
				mode: 'coffeescript'
				tabSize: 2
				indentWithTabs: true
				lineNumbers: true
				dragDrop: false


		computed:
			owner:
				get: -> @item.owner.id
				set: (v) -> @$set(@item, 'owner', Object.assign {}, @item.owner, {id: v})

		methods:
			onSubmit: ->
				@$apollo.mutate(
					mutation: updateItem
					variables: {
						@item...
						owner: @item.owner.id
					}
						# id: @item.id
						# concurrency: @item.concurrency
						# full_name: @item.full_name
					# update: (store, { data }) ->
					#   console.log store,data
				).then((data) =>
					console.log data
					# console.log data.updateItem
					@$message
						type: 'success'
						message: "#{data.data.updateItem.full_name} successfuly updated"
					@$router.back()
					# console.log data
				).catch (err) =>
					console.log err
					@$notify
						duration: 30000
						type: 'error'
						message: err
				return

			delete_posts: ->
				@axios.get '/api/remove_item_posts',
					params: id: @item.id
				return

			parse_item: ->
				@axios.get('/parse'
					params: id: @item.id
					).then (console.log)

		apollo:
			users: ->
				query: -> users
			item: ->
				query: -> item
				variables: ->
					id: @$route.params.id
				loadingKey: 'loadingQueriesCount'
				update: (data) ->
					# console.log data
					Object.assign {}, data.item

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
