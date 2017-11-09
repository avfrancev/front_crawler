<template lang="pug">
	#app
		nav#left(:class="{'opened': leftOpened}")
			.logo-row
				.logo 🚀
				span PARSER
				el-button.close-btn( type="text" size="large" icon="el-icon-circle-close-outline" @click="leftOpened = !leftOpened")
			hr
			.left-menu
				LeftNavIconMenu(name="web-page-home" toName='dashboard' exact) Home
				LeftNavIconMenu(name="earth-globe" toName='items') Items
				LeftNavIconMenu(name="newspaper" toName='posts') Posts
				//- LeftNavIconMenu(name="group" toName='login') Users

		nav#left-secondary(:class="{'left-secondary-opened': leftSecondaryOpened}")
			#left-secondary-body
				router-view(name="second")

		section#main(:class="{'left-secondary-opened': leftSecondaryOpened}")
			#fakeTop
			#top
				//- BButton.bg-c-none.c-rock-l( size="large" @click="$router.back()" v-html="funnelIco")
				//- BButton( v-if="secondNavExisting" v-html="funnelIco" size="large" @click="leftSecondaryOpened = !leftSecondaryOpened")
				//- div
				el-button(v-if="secondNavExisting" size="large" type="text" v-html="funnelIco" @click="leftSecondaryOpened = !leftSecondaryOpened")
				div
				div
				//- div(v-else)
				UserTop
				el-button.show_menu_small(size="large" type="text" icon='el-icon-menu' @click="leftOpened = !leftOpened")
				//- BButton.bg-c-none.c-rock-l( icon="menu" size="large" @click="leftOpened = !leftOpened")
					//- BButton.bg-c-green.c-white(type="round" @click="leftOpened = !leftOpened") leasf as fft
					//- BButton.bg-c-blue.c-white(type="round" :loading="leftSecondaryOpened" @click="leftSecondaryOpened = !leftSecondaryOpened") left secondary
			#router-view
				.container
					transition(name="router" mode="out-in")
						router-view.router-item
</template>

<script lang="coffee">

	import funnelIco from '@/assets/icons/left-alignment.svg'

	# console.log require('@/store/index.coffee').default

	export default {

		components:
			UserTop: require '@/components/UserTop'
			BButton: require '@/components/Button'
			LogoProgress: require '@/components/LogoProgress'
			LeftNavIconMenu: require '@/components/LeftNavIconMenu'

		data: ->
			funnelIco: funnelIco
			leftOpened: false
			leftSecondaryOpened: false
			secondNavExisting: false
			state: require('@/store/index.coffee').default
			postsFilters:
				limit: 10
				filter: {}

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
