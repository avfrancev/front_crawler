<template lang="pug">
	div
		h1 Posts
		transition-group(name="list-complete")
			.post-link(
				v-for="(post, i) in posts"
				:key="post.id"
				class='list-complete-item'
			)
				//- b(@click.prevent="log(post)") {{post.item.full_name}}
				//- br
				//- br
				el-button(@click='delPost(post.id)') DEL123
				router-link(
					:to="{name: 'post', params: {id: post.id} }"
					) {{post.title}}
				//- div {{post.item.name}}
				hr
</template>

<script lang="coffee">
	import gql from 'graphql-tag'

	postsQuery = gql ["""
		{
			posts(limit: 122) {
				id
				title
				itemId
				item {
					id
					name
					full_name
				}
			}
		}
	"""]

	export default {
		data: ->
			posts: []
			item: {}
		methods:
			log: (x) -> console.log(x)

			delPost: (id) ->
				console.log id
				@$apollo.mutate(
					mutation: gql ["""
						mutation (
							$id: String!
							) {
							removePost(
								id: $id
							) {
								id
							}
						}
					"""]
					variables: { id: id }
					refetchQueries: [{ query: postsQuery }]
				).then((data) =>
					console.log data
					@$message
						type: 'success'
						message: "#{data.data.removePost}"
				).catch (err) =>
					@$notify
						duration: 30000
						type: 'error'
						message: err.graphQLErrors[0]?.message || err



		apollo:
			posts:
				query: postsQuery
				variables:
					limit: 0

			$subscribe:
				postChange:
					query: gql ["""
						subscription ppp {
							PostChange {
								id
								title
								itemId
								item {
									id
									name
									full_name
								}
							}
						}
					"""]
					result: (console.log )
	}
</script>

<style media="screen">
	/*.post-link {
		display: block
	}*/


</style>
