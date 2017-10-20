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
		{
			path: '/test'
			name: 'test'
			component: require '@/views/Test'
		}
		{
			path: '/login'
			name: 'login'
			component: require '@/views/Login'
			meta: auth: false
		}
		{
			path: '/'
			name: 'dashboard'
			component: Dashboard
			# meta: auth: ['authenticated']
		}
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
			component: require '@/components/Posts'
		}
		{
			path: '/post/:id'
			name: 'post'
			component: Post
		}
		{
			path: '/post/:id/edit'
			name: 'post_edit'
			component: require('@/views/PostForm.vue')
		}
		{
			path: '/me'
			name: 'me'
			component: require('@/views/Me.vue')
		}
		{
			path: '/403'
			name: 'error-403'
			component: require('@/views/403.vue')
		}
		{
			path: '/404'
			name: 'error-404'
			component: require('@/views/404.vue')
		}
		{
			path: '/502'
			name: 'error-502'
			component: require('@/views/502.vue')
		}
	]
