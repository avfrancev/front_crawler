<template lang="pug">
	div
		el-button(@click="published = !published") {{published}}
		el-button(@click="limit++") +
		el-button(@click="limit--") -
		avf-transition-group(class="posts" name="ooo")
			.ooo-item(v-for="(post, idx) in posts" :key="post.id" :data-post-idx="idx")
				h4 {{post.title}}
				el-button(@click="togglePostPublish(post)") {{post.published}}
		//- 	h3 {{item.name}} || {{item.depth}}
		//- 	input(type="number" :value="item.depth" :data-item-id="item.id" @input="updateCounter")
</template>



<script lang="coffee">

	import {posts, postsSubscription, removePost, updatePost} from '@/schemas.coffee'

	export default {

	data: ->
		postz: [1,2,3,4,5,6,7,8,9]
		limit: 5
		published: false

	methods:
		add: -> @postz.push @postz.length+1
		del: -> @postz.splice 2,1
		togglePostPublish: (post) ->
			@$apollo.mutate
				mutation: updatePost
				variables: {id: post.id, published: !post.published}

	apollo:
		posts:
			query: posts
			# fetchPolicy: 'network-only'
			fetchPolicy: 'cache-and-network'
			loadingKey: 'loading'
			variables: ->
				limit: @limit
				filter:
					published: @published
			subscribeToMore: [{
				document: postsSubscription
				updateQuery: (previousResult, { subscriptionData }) =>
					data = subscriptionData.PostChange
					if data.mutation is 'DELETED'
						return { posts: previousResult.posts.filter (x) -> x.id isnt data.node.id }
					if data.mutation is 'CREATED'
						new_posts = [previousResult.posts...]
						new_posts.unshift data.node
						return { posts: new_posts }

					return previousResult
			}]

	}
</script>

<style media="screen" scoped lang="stylus">

@import './../styles/vars.styl'

.posts
	display: block
	// grid-gap: 10px
	// grid-template-columns: 1fr 1fr 1fr 1fr
	// position: relative
	// transition: 1s
	// +md()
	// 	grid-gap: 2px
	// 	grid-template-columns: 1fr 1fr 1fr
	//
	// .post
	// 	transition: 1s
	// 	padding: 10px
	// 	background: #eee

.ooo-item
	transition: all 2400ms
	opacity: 1
	// position: absolute
	// width: 50px

// .ooo-enter-active
// 	transition-delay: .2s

.ooo-enter, .ooo-leave-to
	opacity: 0.01
	// transform: scaleY(0.2)
	transform: translate3d(20px, 0, 0)

// .ooo-leave-active
// 	position: absolute

</style>
