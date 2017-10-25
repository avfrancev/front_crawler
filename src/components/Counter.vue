<template lang="pug">
	//- el-tooltip(:content="tooltip" :disabled="!tooltip" :placement="tooltipPlacement")
	div.counter

		.inc(v-if="editable")
			a.icon(@click="update(+1)")
				i.el-icon-arrow-up

		.pt-perspective
			span(:class="{ 'border-dotted': editable }")
				span.prefix {{prefix}}
				| &nbsp;
				span(
					v-for="n,i in splitedCount"
					class="xxx"
				)
					span.invisible {{n}}
					transition(:name="transitionClass")
						span.anim(:key="i+'_'+n") {{n}}
				| &nbsp;
				span.postfix {{postfix}}

		.name {{name}}

		.dec(v-if="editable")
			a.icon(@click="update(-1)")
				i.el-icon-arrow-down
</template>


<script lang="coffee" >

	export default {

		props:
			value: ''
			name:
				type: String
				default: ''
			editable:
				default: false
			prefix: ''
			postfix: ''
			min:
				type: Number
				default: 1
			max:
				type: Number
				default: 10
			tooltip:
				default: null
			tooltipPlacement:
				type: String
				default: 'top'

		computed:
			splitedCount: ->
				String(@internalValue).split('')

		data: ->
			internalValue: ''
			transitionClass: 'room-from-top'

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

		created: ->
			@internalValue = @value

	}

</script>



<style scoped lang="stylus">
	.counter
		font-family: "Roboto Condensed"
		flex: 1
		text-align: center
		align-self: center
		user-select: none

		.name
			font-weight: 100
			margin-top: 7px
			font-size: 1rem
			letter-spacing: 0.5px
			text-transform: uppercase

		.prefix, .postfix
			font-size: 1rem
			letter-spacing: 0.5px
			font-weight: 100

		.dec, .inc
			visibility: hidden
			opacity: 0
			cursor: pointer
			transition: .2s
			a
				padding: 15px

		.inc
			margin: 0 0 4px 0
			transform: translateY(30%)

		.dec
			margin: 3px 0 0 0
			transform: translateY(-30%)


		&:hover
			.dec, .inc
				visibility: visible
				opacity: 1
				transform: translateY(0px)

		.border-dotted
			border-bottom: 1px dotted

		.pt-perspective
			font-weight: 400
			letter-spacing: -1px
			text-align: center
			font-size: 2rem
			line-height: 2rem

		.invisible
			visibility: hidden

		.anim
			transition: .3s
			position: absolute
			top: 0
			left: 0
			width: 100%
			height: 100%
			will-change: transform
			transform-style: preserve-3d

		.anim > div
			height: 100%
			overflow-y: scroll

		.xxx
			display: inline-block
			position: relative

		.x-enter-active
			transform-origin: 50% 0%
			animation: rotateRoomTopIn .2s both cubic-bezier(0.785, 0.135, 0.15, 0.86)

		.x-leave-active
			transform-origin: 50% 100%
			animation: rotateRoomTopOut .2s both cubic-bezier(0.785, 0.135, 0.15, 0.86)



	.room-from-top-enter-active
		transform-origin: 50% 100%
		animation: rotateRoomBottomIn .2s both cubic-bezier(0.785, 0.135, 0.15, 0.86)

	.room-from-top-leave-active
		transform-origin: 50% 0%
		animation: rotateRoomBottomOut .2s both cubic-bezier(0.785, 0.135, 0.15, 0.86)

	.room-from-bottom-enter-active
		transform-origin: 50% 0%
		animation: rotateRoomTopIn .2s both cubic-bezier(0.785, 0.135, 0.15, 0.86)

	.room-from-bottom-leave-active
		transform-origin: 50% 100%
		animation: rotateRoomTopOut .2s both cubic-bezier(0.785, 0.135, 0.15, 0.86)

	@keyframes rotateRoomTopIn
		from
			opacity: 0
			transform: translateY(100%) rotateX(90deg)

	@keyframes rotateRoomTopOut
		to
			opacity: 0
			transform: translateY(-100%) rotateX(-90deg)

	@keyframes rotateRoomBottomIn
		from
			opacity: 0
			transform: translateY(-100%) rotateX(-90deg)

	@keyframes rotateRoomBottomOut
		to
			opacity: 0
			transform: translateY(100%) rotateX(90deg)


	@keyframes rotateRoomTopIn
		from
			opacity: 0
			transform: translateY(100%) rotateX(90deg)

	@keyframes rotateRoomTopOut
		to
			opacity: 0
			transform: translateY(-100%) rotateX(-90deg)

</style>
