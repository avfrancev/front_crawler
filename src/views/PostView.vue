<template lang="pug">
	pre {{post}}
</template>

<script scoped lang="coffee">
	import {post} from '@/schemas.coffee'
	export default {
		apollo:
			post:
				query: post
				variables: ->
					{
						id: @$route.params.id
						filter: {itemId: '1241254125125124'}
					}
				loadingKey: 'loadingQueriesCount'
	}

</script>

<style lang="stylus">
// @import './../styles/vars.styl'

</style>
