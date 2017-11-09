<template lang="pug">
	.login-page
		.login-page--inner
			//- h1 Login
			//- hr
			el-form
				el-form-item(label="username")
					el-input(v-model="user.username")
				el-form-item(label="password")
					el-input(v-model="user.password")
			el-button(v-if="!$auth.token()" @click.prevent="login") LOG IN
			el-button(v-if="$auth.token()" @click.prevent="logout") LOG OUT
			//- hr
			//- h1(v-if="$auth.check('authenticated')") authenticated
			//- pre auth.token: {{$auth.token()}}
			//- pre auth.check: {{$auth.check()}}
			//- pre auth.user: {{$auth.user()}}
</template>

<style scoped lang="stylus">

	@import '../styles/vars.styl'

	.login-page
		// position: fixed
		// z-index: 11111
		// left: 0
		// top: 0
		// right: 0
		// bottom: 0
		// background: $rock
		display: flex
		flex-direction: column
		align-items: center
		justify-content: center

	.login-page--inner
		max-width: 300px

</style>




<script lang="coffee">


	export default {
		data: ->
			user: {}
		methods:
			login: ->
				console.log @user
				@$auth.login
					data: @user
					rememberMe: true
					redirect: '/'
					fetchUser: true
					success: (d) ->
						console.log 'SUCCESS ', d
						# app.$auth.currentToken = d.data.data.token
						# localStorage.setItem 'currentToken', d.data.data.token
						return
					error: (res) ->
						console.error res
						return
			logout: ->
				this.$auth.logout
					makeRequest: false
	}
</script>
