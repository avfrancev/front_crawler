<template lang="pug">
	div
		pre {{user}}
		//- .inner-content
		//- 	el-row(:gutter="20")
		//- 		each val in [0,1,2,3,4,5,6,7,8,9]
		//- 			//- .item
		//- 			el-col(:lg="6" :md="8" :sm="12")
		//- 				.item
		//- 					.panel-content asdasd
		//- 			//- el-col(:span="7" :xs="12")= val + ' asfas'
		//- 	h1 {{user.displayName || user.username}}
</template>

<script scoped lang="coffee">

	export default {

		computed:
			user: -> @$auth.user()
		# methods:
		# 	logOut: -> @$auth.logout()
	}

</script>

<style lang="stylus">
@import './../styles/vars.styl'

</style>
