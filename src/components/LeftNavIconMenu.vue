<template lang="pug">
	router-link.leftNavIconMenu(:to="{name: toName}" active-class="is-active" exact)
		//- img(:src="imageSource")
		.icon(v-html="imageSource")
		.text
			slot
</template>


<script lang="coffee" >

	export default {

		props:
			exact:
				type: Boolean
				default: false
			name:
				type: String
				default: ''
			toName:
				type: String
				default: 'dashboard'


		data: ->
			internalValue: ''
			transitionClass: 'room-from-top'

		computed:
			imageSource: ->
				require("@/assets/icons/#{@name}.svg")


		methods:
			update: (val) ->
				newVal = +@internalValue + val
				unless ( @min <= newVal <= @max ) then return
				@internalValue = @internalValue + val
				@$emit 'update', {"#{@editable}": @internalValue}

		watch:
			'value': (n,o) -> @internalValue = n
			'internalValue': (newValue, oldValue) ->
				unless ( @min <= newValue <= @max ) then return
				if newValue > oldValue
					@transitionClass = 'room-from-top'
				else
					@transitionClass = 'room-from-bottom'
				return


	}

</script>



<style scoped lang="stylus">

@import './../styles/vars.styl'

.leftNavIconMenu
	color: #6a7582
	fill: #6a7582
	height: 90px
	display: flex
	flex-direction: column
	justify-content: center
	transition: 200ms, border 400ms
	text-decoration: none
	border-left: 0px solid transparent


	&:hover, &.is-active
		color: #fff
		cursor: pointer
		fill: #fff
		// z-index: 1
		// transform: translateX(1px)

	&.is-active
		// border-left: 7px solid #323643
		// background: $rock
		background: $red
		border-radius: 5px 0 0 5px
		transform: translateX(10px)
		padding-right: 10px
		// background-image: linear-gradient(to right, rgba(0, 0, 0, 0) 81%, #0c0c0e 100%)
		box-shadow: 1px 1px 6px hsla(230, 11%, 17%, 1)

		+sm()
			border-radius: 5px
			transform: translateX(0)
			padding-right: 0


	.icon
		width: 23px
		margin: 2px auto
		// padding: 1px
		// padding: 5px
		// +sm()
		// 	width: 18px


	.text
		// font-family: 'Lato', sans-serif
		text-align: center
		// text-shadow: 0 1px 0px #000
		letter-spacing: 0.5px
		font-size: 1em
		font-weight: 700
		+sm()
			font-size: 0.9em
			// font-weight: 400

</style>
