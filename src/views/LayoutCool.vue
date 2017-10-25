<template lang="pug">
	#app
		nav#left(:class="{'opened': leftOpened}")
			.logo-row
				.logo 🚀
				span PARSER
				a.close-btn(type="circle" @click="leftOpened = !leftOpened") X
			//- .grid.grid-bleed
			//- 	.col-auto
			//- 	.col-auto.hidden-lg.hidden-md.hidden-sm
			hr
			.left-menu
				LeftNavIconMenu(name="web-page-home" toName='dashboard' exact) Home
				LeftNavIconMenu(name="earth-globe" toName='items') Items
				LeftNavIconMenu(name="newspaper" toName='posts') Posts
				LeftNavIconMenu(name="group" toName='login') Users
			//- .grid.grid-bleed
			//- 	.col-6.col-lg-12.col-sm-3.col-xs-3
			//- 		LeftNavIconMenu(name="web-page-home" toName='dashboard' exact) Home
			//- 	.col-6.col-lg-12.col-sm-3.col-xs-3
			//- 		LeftNavIconMenu(name="earth-globe" toName='items') Items
			//- 	.col-6.col-lg-12.col-sm-3.col-xs-3
			//- 		LeftNavIconMenu(name="newspaper" toName='posts') Posts
			//- 	.col-6.col-lg-12.col-sm-3.col-xs-3
			//- 		LeftNavIconMenu(name="group" toName='login') Users

		nav#left-secondary(:class="{'left-secondary-opened': leftSecondaryOpened}")
			#left-secondary-body
				button(@click="leftSecondaryOpened = !leftSecondaryOpened") left secondary
				router-view(name="second")

		section#main(:class="{'left-secondary-opened': leftSecondaryOpened}")
			#top
				.btn-group.rounded
					BButton.bg-c-blue.c-white(type="round" size="large" :loading="false" @click="leftSecondaryOpened = !leftSecondaryOpened") left secondary
					BButton.bg-c-red.c-white(type="round" @click="leftOpened = !leftOpened") leftas fsa asf
					BButton.bg-c-green.c-white(type="round" @click="leftOpened = !leftOpened") leasf as fft
					BButton.bg-c-blue.c-white(type="round" :loading="leftSecondaryOpened" @click="leftSecondaryOpened = !leftSecondaryOpened") left secondary
			#router-view
				.container
					transition(name="router" mode="out-in")
						router-view.router-item
</template>

<script lang="coffee">
	import gql from 'graphql-tag'
	import User from '@/components/User'

	export default {

		components:
			user: User
			BButton: require '@/components/Button'
			LogoProgress: require '@/components/LogoProgress'
			LeftNavIconMenu: require '@/components/LeftNavIconMenu'

		data: ->
			leftOpened: false
			leftSecondaryOpened: false

		watch:
			'$route': (to, from) ->
				if from && to.fullPath isnt from.fullPath
					# console.log @$currentViewport
					@leftSecondaryOpened = false
					setTimeout ( =>
						@leftOpened = false
						@leftSecondaryOpened = !!(to.matched[0] && to.matched[0].components.second) && @$currentViewport.value > 768
						return
					), 500
				return




		methods:
			toggleMenu: -> @leftMenuOpened = !@leftMenuOpened


		apollo:
			items:
				query: gql ["""
					{
						items {
							id
							name
							logo
							full_name
							postsCount
						}
					}
				"""]
				variables:
					limit: 0

			$subscribe:
				itemChange:
					query: gql ["""
						subscription ppp {
							ItemChange {
								id
								name
								full_name
							}
						}
					"""]
	}
</script>

<style src="@/styles/layout-cool.styl" lang="stylus">
</style>
