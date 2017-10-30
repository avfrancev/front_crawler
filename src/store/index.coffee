export default {
	leftOpened: false
	leftSecondaryOpened: false
	secondNavExisting: false
	postsFilters:
		limit: 10
		itemIds: []
		published: ''
		searchQuery: ''
}


# import Vue from 'vue'
# import Vuex from 'vuex'
# import client from '@/store/apollo.coffee'
# import {items, itemsSubscription, posts, postsSubscription, updateItem} from '@/schemas.coffee'
#
# Vue.use Vuex
#
#
#
# state =
# 	items: {}
# 	posts: {}
# 	postsFilters:
# 		limit: 3
# 		filter: {}
#
# postsSubscriptionObserver = undefined
# mutations =
# 	SET_MODEL: (state, {model, payload}) ->
# 		o = {}
# 		payload.map (item) ->
# 			o[item.id] = item
# 		state[model] = o
# 		return
# 	ADD_MODEL: (state, {model, payload}) ->
# 		Vue.set(state[model], payload.id, payload)
# 		return
# 	UPDATE_MODEL: (state, {model, payload}) ->
# 		Vue.set(state[model], payload.id, payload)
# 		return
# 	DELETE_MODEL: (state, {model, payload}) ->
# 		Vue.delete(state[model], payload.id)
# 		return
# 	UPDATE_POSTSFILTERS: (state, {payload}) ->
# 		state.postsFilters = payload
# 		console.log postsSubscriptionObserver
# 		postsSubscriptionObserver.refetch({variables: payload})
# 		return
#
#
#
# actions =
#
# 	getItems: ({commit, dispatch}) ->
# 		client.query(query: items).then (result) ->
# 			commit('SET_MODEL', {model: 'items', payload: result.data.items})
# 			dispatch 'subscribeToItems'
# 			return
# 		return
#
# 	updateItem: ({commit, dispatch}, payload) ->
# 		# console.log payload
# 		client.mutate(
# 			mutation: updateItem
# 			variables: payload
# 		).then((data) =>
# 			# @iteme.log data
# 		).catch (err) =>
# 			console.error err
# 			return
# 		return
#
# 	getPosts: ({commit, dispatch, state}, p = {limit: 10, filter: {}}) ->
# 		client.query(query: posts, variables: state.postsFilters).then (result) ->
# 			# console.log result
# 			commit('SET_MODEL', {model: 'posts', payload: result.data.posts})
# 			dispatch 'subscribeToPosts'
# 			return
# 		return
#
# 	subscribeToItems: ({commit}) ->
# 		itemsSubscriptionObserver = client.subscribe(query: itemsSubscription).subscribe(
# 			next: (data) ->
# 				# console.log data
# 				switch data.ItemChange.mutation
# 					when 'UPDATED'
# 						commit 'UPDATE_MODEL', {model: 'items', payload: data.ItemChange.node}
# 					when 'CREATED'
# 						commit 'ADD_MODEL', {model: 'items', payload: data.ItemChange.node}
# 					when 'DELETED'
# 						commit 'DELETE_MODEL', {model: 'items', payload: data.ItemChange.node}
# 				return
# 			error: (err) ->
# 				console.error err
# 				return
# 		)
# 		return
#
# 	subscribeToPosts: ({commit}) ->
# 		postsSubscriptionObserver = client.subscribe(query: postsSubscription).subscribe(
# 			next: (data) ->
# 				# console.log data
# 				switch data.PostChange.mutation
# 					when 'UPDATED'
# 						commit 'UPDATE_MODEL', {model: 'posts', payload: data.PostChange.node}
# 					when 'CREATED'
# 						commit 'ADD_MODEL', {model: 'posts', payload: data.PostChange.node}
# 					when 'DELETED'
# 						commit 'DELETE_MODEL', {model: 'posts', payload: data.PostChange.node}
# 				return
# 			error: (err) ->
# 				console.error err
# 				return
# 		)
# 		return
#
# store = new (Vuex.Store)(
# 	state: state
# 	mutations: mutations
# 	actions: actions
# )
#
# store.dispatch 'getItems'
# store.dispatch 'getPosts'
#
#
# export default store
