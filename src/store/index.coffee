import Vue from 'vue'
import Vuex from 'vuex'
import client from '@/store/apollo.coffee'
import {items, itemsSubscription, posts, postsSubscription} from '@/schemas.coffee'

Vue.use Vuex



state =
	items: {}
	posts: {}


mutations =
	SET_MODEL: (state, {model, payload}) ->
		o = {}
		payload.map (item) ->
			o[item.id] = item
		state[model] = o
		return
	ADD_MODEL: (state, {model, payload}) ->
		Vue.set(state[model], payload.id, payload)
		return
	UPDATE_MODEL: (state, {model, payload}) ->
		Vue.set(state[model], payload.id, payload)
		return
	DELETE_MODEL: (state, {model, payload}) ->
		Vue.delete(state[model], payload.id)
		return

actions =
	getItems: ({commit}) ->
		client.query(query: items).then (result) ->
			commit('SET_MODEL', {model: 'items', payload: result.data.items})
			return
		return
	getPosts: ({commit}) ->
		client.query(query: posts).then (result) ->
			console.log result
			commit('SET_MODEL', {model: 'posts', payload: result.data.posts})
			return
		return

	subscribeToItems: ({commit}) ->
		itemsSubscriptionObserver = client.subscribe(query: itemsSubscription).subscribe(
			next: (data) ->
				console.log data
				switch data.ItemChange.mutation
					when 'UPDATED'
						commit 'UPDATE_MODEL', {model: 'items', payload: data.ItemChange.node}
				return
			error: (err) ->
				console.error err
				return
		)
		return

	subscribeToPosts: ({commit}) ->
		postsSubscriptionObserver = client.subscribe(query: postsSubscription).subscribe(
			next: (data) ->
				console.log data
				switch data.PostChange.mutation
					when 'UPDATED'
						commit 'UPDATE_MODEL', {model: 'posts', payload: data.PostChange.node}
					when 'CREATED'
						commit 'ADD_MODEL', {model: 'posts', payload: data.PostChange.node}
					when 'DELETED'
						commit 'DELETE_MODEL', {model: 'posts', payload: data.PostChange.node}
				return
			error: (err) ->
				console.error err
				return
		)
		return

store = new (Vuex.Store)(
	state: state
	mutations: mutations
	actions: actions
)


export default store
