<template lang="pug">
	#app
		nav#leftnav(v-cloak :class="leftMenuOpened ? 'opened' : '' ")
			.flex.logo
				span(index="0") 🚀 PARSER
				a.close(href="javascript:void(0)" @click="toggleMenu") X


			el-menu(theme="dark" :router="true" :default-active="activeLink")
				router-link.menu-item(:to="{name: 'dashboard'}" active-class="is-active" exact)
					i.el-icon-star-on &nbsp;&nbsp;&nbsp;&nbsp;
					| Dashboard
				router-link.menu-item(:to="{name: 'posts'}" active-class="is-active")
					i.el-icon-message &nbsp;&nbsp;&nbsp;&nbsp;
					| Posts
				//- router-link.menu-item(:to="{name: 'me'}" active-class="is-active")
				//- 	i.el-icon-user &nbsp;&nbsp;&nbsp;&nbsp;
				//- 	| Me
				el-collapse
					el-collapse-item
						template(slot="title")
							i.el-icon-star-on &nbsp;&nbsp;&nbsp;&nbsp;
							a Items
						router-link.menu-item.space-between(
							v-for="item in items"
							:key="item.id"
							:to="{name: 'item_edit', params: {id: item.id} }" active-class="is-active"
						)
							//- .ico(:style="{ backgroundImage: 'url(' + item.logo + ')' }")
							.text {{item.full_name}}
							el-badge(class="mark" :value="item.postsCount || '0'")
						router-link.menu-item.ico-plus(
							:to="{name: 'item_new'}" active-class="is-active"
						)
							i.el-icon-plus &nbsp;&nbsp;&nbsp;&nbsp;
							| New Item

		section#main
			nav#topnav
				div.openMenu
					el-button(@click="toggleMenu") &#9776;
				div
				user

			#router-view
				router-view
</template>

<script lang="coffee">
	import gql from 'graphql-tag'
	import User from '@/components/User'

	export default {

		components:
			user: User
			LogoProgress: require '@/components/LogoProgress'

		watch:
			'$route': ->
				setTimeout ( =>
					@leftMenuOpened = false if @leftMenuOpened
					return
				), 300



		data: ->
			activeLink: @$route.path
			leftMenuOpened: false

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

<style src="@/app.styl" lang="stylus">
</style>
