<template lang="pug">
	div(v-loading="loadingQueriesCount")
		div(v-if="post")
			img(style="width: 40px" :src="'https://avfrancev.ddns.net/screenshots/'+ post.item.name + '/' + post.id + '.jpeg' ")
			pre {{post}}
</template>

<script scoped lang="coffee">
	import {post} from '@/schemas.coffee'
	export default {

		data: ->
			loadingQueriesCount: 0

		apollo:
			post:
				query: post
				variables: ->
					{
						id: @$route.params.id
					}
				loadingKey: 'loadingQueriesCount'
	}

</script>

<style lang="stylus">
// @import './../styles/vars.styl'

</style>
