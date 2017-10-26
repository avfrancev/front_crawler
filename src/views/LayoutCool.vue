<template lang="pug">
	#app
		nav#left(:class="{'opened': leftOpened}")
			.logo-row
				.logo 🚀
				span PARSER
				BButton.close-btn.bg-c-none.c-white( type="circle" icon="close" size="large" @click="leftOpened = !leftOpened")
			hr
			.left-menu
				LeftNavIconMenu(name="web-page-home" toName='dashboard' exact) Home
				LeftNavIconMenu(name="earth-globe" toName='items') Items
				LeftNavIconMenu(name="newspaper" toName='posts') Posts
				LeftNavIconMenu(name="group" toName='login') Users

		nav#left-secondary(:class="{'left-secondary-opened': leftSecondaryOpened}")
			#left-secondary-body
				button(@click="leftSecondaryOpened = !leftSecondaryOpened") left secondary
				router-view(name="second")

		section#main(:class="{'left-secondary-opened': leftSecondaryOpened}")
			#fakeTop
			#top
				BButton.bg-c-none.c-rock-l( v-if="secondNavExisting" :icon="!leftSecondaryOpened ? 'arrow-right':'arrow-left'" size="large" @click="leftSecondaryOpened = !leftSecondaryOpened")
				div(v-else)
				div
					UserTop
				BButton.bg-c-none.c-rock-l( icon="menu" size="large" @click="leftOpened = !leftOpened")
					//- BButton.bg-c-green.c-white(type="round" @click="leftOpened = !leftOpened") leasf as fft
					//- BButton.bg-c-blue.c-white(type="round" :loading="leftSecondaryOpened" @click="leftSecondaryOpened = !leftSecondaryOpened") left secondary
			#router-view
				.container
					transition(name="router" mode="out-in")
						router-view.router-item
</template>

<script lang="coffee">

	export default {

		components:
			UserTop: require '@/components/UserTop'
			BButton: require '@/components/Button'
			LogoProgress: require '@/components/LogoProgress'
			LeftNavIconMenu: require '@/components/LeftNavIconMenu'

		data: ->
			leftOpened: false
			leftSecondaryOpened: false
			secondNavExisting: false
			user:
				name: 'username'

		computed:
			secondaryMenuBtnIcon: ->
				'arrow-right'

		watch:
			'$route': (to, from) ->
				if from && to.fullPath isnt from.fullPath
					@secondNavExisting = !!(to.matched[0] && to.matched[0].components.second)
					@leftSecondaryOpened = false
					setTimeout ( =>
						@leftOpened = false
						@leftSecondaryOpened = @secondNavExisting && @$currentViewport.value > 768
						return
					), 500
				return




		methods:
			toggleMenu: -> @leftMenuOpened = !@leftMenuOpened


	}
</script>

<style src="@/styles/layout-cool.styl" lang="stylus">
</style>
