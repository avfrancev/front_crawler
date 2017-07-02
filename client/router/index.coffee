import Vue from 'vue'
import Router from 'vue-router'

import Dashboard from '../views/Dashboard'
import Post from '../views/Post'
import Posts from '../views/Posts'
import Item from '../views/Item'
import Items from '../views/Items'

Vue.use Router

export default new Router
	mode: 'history'
	routes: [
		# {
		# 	path: '/test'
		# 	name: 'test'
		# 	component: Test
		# 	meta: requiresAuth: true
		# }
		{
			path: '/'
			name: 'home'
			component: Dashboard
			meta: requiresAuth: true
		}
		# {
		# 	path: '/login'
		# 	name: 'login'
		# 	component: Login
		# 	meta: layout: 'fullPage'
		# }
		{
			path: '/item/:id'
			name: 'item_edit'
			component: Item
			props: {isNew: false}
		}
		{
			path: '/item_new'
			name: 'item_new'
			component: Item
			props: {isNew: true}
		}
		{
			path: '/posts'
			name: 'posts'
			component: Posts
		}
		{
			path: '/post/:id'
			name: 'post'
			component: Post
		}
		# {
		# 	path: '/posts'
		# 	component: Posts
		# }
		# {
		# 	path: '/items'
		# 	component: Items
		# }
		# {
		# 	path: '/timeline'
		# 	component: Timeline
		# }
	]
