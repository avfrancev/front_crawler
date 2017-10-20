<template lang="pug">
	div.user(v-if="$auth.user().id")
		router-link(:to="{name: 'me'}")
			| {{user.displayName || user.username}}
		router-link(:to="{name: 'me'}" style="height: 40px; width: 40px")
			img(style="height: 40px; width: 40px" :src="user.avatar_url")
		//- a(href='#' @click="$auth.logout()") LogOut
	div.user(v-else)
		router-link(:to="{ name: 'login' }") Login
		//- a(href='#' @click="$auth.logout()") LogOut
</template>

<script lang="coffee">

	export default {

		computed:
			user: -> @$auth.user()
		# methods:
		# 	logOut: -> @$auth.logout()
	}

</script>
<style scoped lang="stylus">
	.user
		display: flex
		margin: 0 1rem
		& > *
			margin: auto 0.5rem
			line-height: 56px
		img
			border-radius: 50%
</style>
