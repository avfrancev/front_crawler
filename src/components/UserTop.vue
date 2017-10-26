<template lang="pug">
	.user(v-if="$auth.check()")
		span.username {{user.username}}
		//- span {{user}}
		//- img(:style="{background: 'url('+user.avatar_url+')'}")
		router-link(:to="{ name: 'login' }")
			.avatar-image(:style="{ backgroundImage: 'url(' + user.avatar_url + ')' }")
	.user(v-else)
		router-link(:to="{ name: 'login' }") Login
</template>



<script lang="coffee">
export default {
	# data:
	# 	user: ''
	computed:
		user: -> @$auth.user()
	# watch:
	# 	'$'
}
</script>



<style lang="stylus">
	@import './../styles/vars.styl'
	.user
		display: flex
		margin: 0 20px
		justify-content: flex-end
		align-content: center
		align-items: center
		.username
			font-weight: bold
		.avatar-image
			border-radius: 50%
			height: 40px
			width: 40px
			margin: 0 10px 0 20px
			background-size: cover
			box-shadow: 0 0 0 5px $Extra_Light_Gray, 0 0 0 6px $Extra_Light_Silver
			transition: 300ms
			&:hover
				box-shadow: 0 0 0 6px $Extra_Light_Gray, 0 0 0 8px $Extra_Light_Silver

			+sm()
				box-shadow: 0 0 0 3px $Extra_Light_Gray, 0 0 0 5px $Extra_Light_Silver
				height: 33px
				width: 33px

</style>
