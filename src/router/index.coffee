import Vue from 'vue'
import Router from 'vue-router'

# import Dashboard from '../views/Dashboard'
# import Post from '../views/Post'
# import Posts from '../views/Posts'
# import Item from '../views/Item'
# import Items from '../views/Items'

Vue.use Router

router = new Router
	mode: 'history'
	routes: [
		{
			path: '/'
			name: 'dashboard'
			component: require '@/views/Dashboard'
		}
		{
			path: '/test'
			name: 'test'
			component: require '@/views/Test'
		}
		{
			path: '/login'
			name: 'login'
			component: require '@/views/Login'
			# meta: auth: false
		}
		{
			path: '/items'
			name: 'items'
			components:
				default: require '@/views/Items'
				second: require '@/views/ItemsFilter'
		}
		{
			path: '/item/:id'
			name: 'item_edit'
			component: require '@/views/Item'
			meta: auth: ['authenticated']
		}
		{
			path: '/item_new'
			name: 'item_new'
			component: require '@/views/ItemNew'
		}
		{
			path: '/posts'
			name: 'posts'
			components:
				default: require '@/views/PostsView'
				second: require '@/views/PostsFilter'
		}
		{
			path: '/post/:id'
			name: 'post_view'
			component: require '@/views/PostView'
		}
		# {
		# 	path: '/post/:id'
		# 	name: 'post'
		# 	component: Post
		# }
		# {
		# 	path: '/post/:id/edit'
		# 	name: 'post_edit'
		# 	component: require('@/views/PostForm.vue')
		# }
		{
			path: '/me'
			name: 'me'
			component: require('@/views/UserProfile')
			meta: auth: ['authenticated']
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
			path: '*'
			redirect: '404'
		}
		{
			path: '/502'
			name: 'error-502'
			component: require('@/views/502.vue')
		}
	]



router.afterEach (to, from, next) ->
	routerView = document.querySelector("#router-view")
	window.setTimeout(->
		routerView.scrollTo 0,0
	, 500)
	return


export default router
