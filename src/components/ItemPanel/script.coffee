import Counter from '../Counter.vue'
import {extend} from 'lodash'
import moment from 'moment'
import anime from 'animejs'
import axios from 'axios'
# import {TweenMax, Elastic, TimelineLite} from "gsap"
completed = true

export default {
	components: {
		Counter
	}

	props: ['yyy']

	data: ->
		dx: 50
		dy: 100
		menuOpened: false
		time: null
		spinner: null
		spinnerSource: ['🕛','🕐','🕑','🕒','🕓','🕔','🕕','🕖','🕗','🕘','🕙','🕚']

	computed:
		item: -> Object.assign {}, @yyy

	methods:

		ttt: ->
			console.log item

		flip: (e) ->
			el = document.querySelector("#item-#{@item.id}")
			aaa =
				dy: @dy

			anime
				targets: aaa
				dy: '+=10'
				duration: 500
				elasticity: 600
				update: =>
					@dy = aaa.dy
					return

			# @dy = 100
			return



		parse_item: ->
			@axios.get('/parse'
				params: id: @item.id
				).then (console.log)
			logo = document.querySelector("#item-#{@item.id} .top .image")
			# console.log logo
			aaa = anime
				targets: logo
				translateY: [
					{ value: '+=50', duration: 1400 }
					{ value: '-=50', duration: 1400 }
				]
				complete: (anim) =>
					if @item.loading
						anim.restart()
					return

		delete_posts: ->
			@axios.get '/api/remove_item_posts',
				params: id: @item.id
			return

		deleteItem: ->
			if confirm("Do you want to delete item #{@item.full_name} ?")
				@$$Item.remove @item.id


		copy: ->
			_item = extend {}, @item
			delete _item.id
			@$$Item.store _item

		updateItem: (value) ->
			_item = extend {}, {id: @item.id}, value
			@$$Item.update _item



}
