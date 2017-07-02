<template lang="pug">
	div#app
		nav#leftnav(v-cloak)
			.flex.logo
				span(index="0") 🚀 PARSER
				//- a.menu-toggle: i.el-icon-more
				//- a.menu-toggle
					svg(height="21" version="1.1" viewBox="0 0 25 21" width="25" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink")
						path(d="M0 4 l32 0")
						path(d="M0 12 l32 0")
						path(d="M0 20 l32 0")
					//- line(
					//- 	h="10"
					//- 	y="20"
					//- 	style="stroke-linecap: round; stroke-width: 2px; stroke: #fff")
					//- path(  d="M4,10h24c1.104,0,2-0.896,2-2s-0.896-2-2-2H4C2.896,6,2,6.896,2,8S2.896,10,4,10z M28,14H4c-1.104,0-2,0.896-2,2  s0.896,2,2,2h24c1.104,0,2-0.896,2-2S29.104,14,28,14z M28,22H4c-1.104,0-2,0.896-2,2s0.896,2,2,2h24c1.104,0,2-0.896,2-2  S29.104,22,28,22z")

			el-menu(theme="dark" :router="true" :default-active="activeLink")
				//router-link.el-menu-item(tag="li" to="/foo" path="/item/874149a9-5cdb-44df-aeea-56552b04d13b") Github
				//el-menu-item-group(title="Group One")
				router-link.menu-item(:to="{name: 'home'}" active-class="is-active" exact)
					i.el-icon-star-on &nbsp;&nbsp;&nbsp;&nbsp;
					| Dashboard
				router-link.menu-item(:to="{name: 'posts'}" active-class="is-active")
					i.el-icon-message &nbsp;&nbsp;&nbsp;&nbsp;
					| Posts
				el-collapse
					el-collapse-item
						template(slot="title")
							i.el-icon-star-on &nbsp;&nbsp;&nbsp;&nbsp;
							a Items
						router-link.menu-item(
							v-for="item in items"
							:key="item.id"
							:to="{name: 'item_edit', params: {id: item.id} }" active-class="is-active"
						)
							.ico(:style="{ backgroundImage: 'url(' + item.logo + ')' }")
							.text {{item.full_name}}
						router-link.menu-item.ico-plus(
							:to="{name: 'item_new'}" active-class="is-active"
						)
							i.el-icon-plus &nbsp;&nbsp;&nbsp;&nbsp;
							| New Item
				//el-submenu(index="1")
					template(slot="title") Items

					router-link.el-menu-item(
						v-for="item in items"
						tag="li"
						:to="{name: 'item_new'}" active-class="is-active"
					) {{item.full_name}}
					router-link.el-menu-item(
						tag="li"
						:to="{name: 'item_new'}" active-class="is-active"
					) New Item

		section#main
			nav#topnav
				//- user

			#router-view
				router-view
</template>

<script lang="coffee">
	import gql from 'graphql-tag'

	export default {
		# components: {
		# 	user: User
		# }
		#
		data: ->
			activeLink: @$route.path

		apollo:
      items:
        query: gql ["""
          {
            items {
              id
              name
							logo
              full_name
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

<style src="@/app.sss" lang="postcss">
</style>
