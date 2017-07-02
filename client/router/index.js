import Vue from 'vue'
import Router from 'vue-router'
import Dashboard from '../views/Dashboard'
import Post from '../views/Post'
import Posts from '../views/Posts'
import Item from '../views/Item'
import Items from '../views/Items'


Vue.use(Router)

export default new Router({
  mode: 'hash',
  routes: [
    {
      path: '/',
      component: Dashboard
    },
    {
      path: '/posts',
      component: Posts
    },
    {
      name: 'post_view',
      path: '/post/:id',
      component: Post
    },
    {
      path: '/items',
      component: Items
    },
    {
      name: 'item_view',
      path: '/item/:id',
      component: Item
    }
  ]
})
