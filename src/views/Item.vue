<template lang="pug">
#item-form
	h1 {{loadingQueriesCount}}
	p AUTH: {{$auth.check()}}
	p {{$auth.user()}}
	.inner-content(v-if='item')
		el-row
			el-col.tc(:md="6" :sm="24")
				.logo(:style="{ backgroundImage: 'url(' + item.logo + ')' }")
				br
				br
				h3(contenteditable) {{item.full_name}}
			el-col.tc(:md="18" :sm="24")
				section.counters
					Counter(
						name="posts count"
						v-model="item.postsCount")
					Counter(
						name="concurrency"
						v-model="item.concurrency"
						postfix="$"
						editable)
					Counter(
						name="depth"
						v-model="item.depth"
						editable)
					Counter(
						name="Parse Interval"
						v-model="item.parseInterval"
						:min="1" :max="24"
						prefix="every"
						postfix="hours"
						editable)

		hr
		br
		.form.grid
			.c.col-5_md-12
				el-form(:model="item" label-width="25%")
					el-form-item(label="Active")
						el-switch(v-model='item.active' on-text="1" off-text="0" :width="46")

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
					el-form-item(label="Logo")
						el-input(type="text" v-model="item.logo")
					//- el-form-item(label="Capture Selector")
					//-   el-input.input(type="text" v-model="item.captureSelector")
					//- el-form-item(label="Next parse date")
					//-   el-date-picker.input(width="100%" :disabled="!item.active" type="datetime" v-model="item.nextParseDate")

					//-el-form-item
						el-button(type="primary" @click.prevent="submit") SUBMIT
						el-button(type="primary" @click.prevent="logItem") LOG ITEM

			.c.col-7_md-12
				.code
					codemirror(
						v-model="item.schemas"
						:options="editorOptions"
					)
		hr
		br
		.grid
			.col-12.tc
				el-button(type="primary" @click.prevent="onSubmit") SUBMIT
				el-button(type="danger" @click.prevent="delete_posts") DELETE POSTS
				el-button(type="primary" :loading="item.loading" @click="parse_item") {{item.loading ? 'LOADING...' : 'PARSE'}}
				//- el-button(type="primary" @click.prevent="logItem") LOG ITEM
		pre {{item}}
</template>

<script lang="coffee">

	import gql from 'graphql-tag'
	import Counter from '@/components/Counter'

	export default {
		components: {Counter}
		data: ->
			loadingQueriesCount: 0
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
				# console.log @item
				item = @item
				@$apollo.mutate(
					mutation: gql ["""
						mutation (
							$id: String!
							$active: Boolean
							$name: String
							$depth: Int
							$concurrency: Int
							$parseInterval: Int
							$full_name: String
							$schemas: String
							$owner: String
							) {
							updateItem(
								id: $id
								active: $active
								name: $name
								full_name: $full_name
								schemas: $schemas
								depth: $depth
								concurrency: $concurrency
								parseInterval: $parseInterval
								owner: $owner
							) {
								id
								active
								name
								full_name
								depth
								schemas
								concurrency
								parseInterval
								owner {
									id
								}
							}
						}
					"""]
					variables: Object.assign {}, @item, {owner: @item.owner.id}
						# id: @item.id
						# concurrency: @item.concurrency
						# full_name: @item.full_name
					# update: (store, { data }) ->
					#   console.log store,data
				).then((data) =>
					@$message
						type: 'success'
						message: "#{data.data.updateItem.full_name} successfuly updated"
					@$router.back()
					# console.log data
				).catch (err) =>
					@$notify
						duration: 30000
						type: 'error'
						message: err.graphQLErrors[0]?.message || err

			delete_posts: ->
				@axios.get '/api/remove_item_posts',
					params: id: @item.id
				return

			parse_item: ->
				@axios.get('/parse'
					params: id: @item.id
					).then (console.log)

		# apollo:
		# 	users: ->
		# 		query: -> gql ["""
		# 			query getUsers {
		# 				users {
		# 					id
		# 					displayName
		# 					username
		# 				}
		# 			}
		# 		"""]
		# 	item: ->
		# 		query: -> gql ["""
		# 			query getItem ($id: String!) {
		# 				item(id: $id) {
		# 					id
		# 					name
		# 					depth
		# 					full_name
		# 					active
		# 					concurrency
		# 					parseInterval
		# 					postsCount
		# 					status
		# 					link
		# 					logo
		# 					loading
		# 					schemas
		# 					data {
		# 						depth
		# 						progress
		# 					}
		# 					owner {
		# 						id
		# 						username
		# 					}
		# 					posts {
		# 						id
		# 						title
		# 					}
		# 				}
		# 			}
		# 		"""]
		# 		variables: ->
		# 			id: @$route.params.id
		# 		loadingKey: 'loadingQueriesCount'
		# 		update: (data) ->
		# 			# console.log data
		# 			Object.assign {}, data.item

			# $subscribe:
			# 	ItemChange:
			# 		query: gql ["""
			# 			subscription ppp {
			# 				ItemChange {
			# 					id
			# 					name
			# 					active
			# 					full_name
			# 					postsCount
			# 					depth
			# 					status
			# 					concurrency
			# 					loading
			# 					data {
			# 						progress
			# 						depth
			# 					}
			# 					posts {
			# 						id
			# 						title
			# 					}
			# 				}
			# 			}
			# 		"""]
			# 		updateQuery: (previousResult, subscriptionData) ->
			# 			console.log subscriptionData
			# 		result: (x) ->
			# 			console.log x


	}
</script>

<style scoped lang="stylus">

	.form
		margin: 0 -1.5rem
		.c
			padding: 0 1.5rem 2rem

	.logo
		margin: 0 auto
		border-radius: 50%
		background-size: 100%
		background-repeat: no-repeat
		background-position: 50% 50%
		box-shadow: 0 0 0 5px #E5E9F2
		height: 100px
		width: 100px


	section.counters
		display: flex
		flex-direction: row
		.counter
			flex: 1


</style>
