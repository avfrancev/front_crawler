<template lang="pug">
	.post(
		v-if="post"
		:id="'post-'+post.id"
		:style="borderLeftStyle"
		v-loading="postLoading"
		)
		.post__body
			.post__image(v-if="post.images[0]" :style="{backgroundImage: 'url(' + post.images[0] + ')' }")
			.post__body__content
				h4.title {{post.title}}
				//- img(v-if="post.screenshotSrc" :src="'data:image/jpeg;base64,'+post.screenshotSrc" style="width: 200px")
				//- pre {{post.status}}
				//- div(v-if="post.hasScreenshot") YES
					//- img(style="width: 40px" :src="'https://avfrancev.ddns.net/screenshots/'+ post.item.name + '/' + post.id + '.jpeg' ")
				.text-muted
					b(v-if="post.item") {{post.item.full_name}}
					| &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
					i.el-icon-date &nbsp;
					span {{$moment(+post.stats.start).format("DD.MM.YYYY [at] hh:mm")}}
			//- .post__body__tags(v-if="post.tags")
				el-tag(v-for="tag in post.tags.slice(0,4)" :key="post.id" size="mini" type="info" style="margin: 0 3px 0 0") {{tag}}
		//- .col-lg-3.col-md-4.align-self-center(style="text-align: right")
		el-button-group.post__actions
			el-button(size="mini" :loading="loaders.publishLoader" @click="updatePost('publishLoader', {id: post.id, published: !post.published})") {{post.published ? 'Unpublish' : 'Publish'}}
			el-button(size="mini" @click="$router.push({name:'post_view', params: {id: post.id}})") View
			el-button(size="mini" v-if="$auth.check()" icon="delete" @click="removePost") Delete
</template>

<script lang="coffee">

	import {removePost, updatePost} from '@/schemas.coffee'
	import Counter from '@/components/Counter'
	import anime from 'animejs'
	import moment from 'moment'


	export default {

		components:
			Counter: Counter

		props: ['post']

		data: ->
			# moment: moment
			postLoading: false
			loaders:
				publishLoader: false

		computed:
			borderLeftStyle: ->
				if @post.published
					return { borderLeftColor: '#c0f1e1' }
				else { borderLeftColor: '#EFF2F7' }
			canEdit: ->
				@$auth.user().id is @item.owner.id || @$auth.check('admin')
				# if @$auth.check()
				# # @$auth.user().id is item.id
				# 	return true
				# else
				# 	return false

		methods:

			removePost: ->
				@$apollo.mutate
					mutation: removePost
					variables: {id: @post.id, item: {id: @post.item.id, name: @post.item.name}}

			togglePostPublish: ->
				updatePost 'publishLoader', {id: @post.id, published: !@post.published}
				return
				# @$apollo.mutate
				# 	mutation: updatePost
				# 	variables: {id: post.id, published: !post.published}

			updatePost: (loader, field) ->
				# @postLoading = true
				@loaders[loader] = true
				@$apollo.mutate(
					mutation: updatePost
					variables: Object.assign {id: @post.id}, field
				).then((data) =>
					@loaders[loader] = false
					# @postLoading = false
					# @$message
					# 	type: 'success'
					# 	message: "#{data.data.updateItem.full_name} successfuly updated"
					# console.log data
				).catch (err) =>
					@postLoading = false
					@$notify
						duration: 30000
						type: 'error'
						message: err.graphQLErrors[0]?.message || err


	}
</script>

<style scoped lang="stylus">

	@import './../styles/vars.styl'

	.post
		display: flex
		transition: border-color 400ms
		border: 1px solid $grey_1
		border-left-width: 5px
		border-radius: 3px
		margin: 11px 0
		background: #fff
		transition: 1s
		+sm()
			flex-wrap: wrap

		&:hover .post__actions
			display: flex

	.post__body
		padding: 15px
		display: flex
		flex: 1 100%
		padding-right: 10px

	.post__actions
		align-self: center
		justify-content: flex-end
		display: flex
		margin: 0 0 0 20px
		padding: 15px
		transition: 1s
		+sm()
			// height: 0px
			width: 100%
			margin: 20px 0 0 0
			display: none

		+xs()
			padding: 0
			& > button
				height: 35px
				width: 100%

	.post__image
		flex: 0 0 45px
		margin-right: 15px
		opacity: 0.8
		height: 45px
		width: 45px
		background-size: cover
		border-radius: 50%

	.post__body__content
		flex: 1 100%
		.title
			margin-bottom: 7px

	.post__body__tags
		flex: 1 200px
		align-self: center
		justify-content: flex-end
		+sm()
			display: none

</style>
