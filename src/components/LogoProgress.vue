<template>
		<div class="logo_progress" :style="logoProgressStyles" >
			<div @click="aaa">
				<svg viewBox="0 0 100 100">
					<path :d="trackPath" stroke="#eef1f6" :stroke-width="relativeStrokeWidth" fill="none"></path>
					<path :d="trackPath" stroke-linecap="round" :stroke="stroke" :stroke-width="relativeStrokeWidth" fill="none" :style="circlePathStyle"></path>
				</svg>
			</div>

			<!-- <div
				class="el-progress__text"
			>
				<span>asfasf</span
			</div> -->
			<div :ref="id" class="overlay-status" :class="[status, animate]" :style="overlayStatusStyles">
				<i :class='iconClass' :style="iconStyles"></i>
			</div>
		</div>
</template>

<script lang="coffee" >

	import anime from 'animejs'

	export default {

		props:
			id: ''
			bgImg: ''
			width:
				type: Number
				default: 60
			strokeWidth:
				type: Number
				default: 2
			status:
				type: String
				default: ''
			percentage:
				type: Number
				default: 0
				required: true
				validator: (val) -> val >= 0 && val <= 100

		watch:
			status: (newStatus)	->
				if newStatus in ['success', 'error']
					anime(
						targets: @$refs[@id]
						opacity: 1
						scale: [
							{value: [0, 1], delay: 500}
							{value: 0, delay: 3000, elasticity: 0}
						]
						opacity: [
							{value: [0.1,1]}
							{value: 0.1, delay: 3100}
						]
					)


		methods:
			aaa: ->
				anime(
					targets: @$refs[@id]
					opacity: 1
					scale: [
						{value: [0.1, 1]}
						{value: 0, delay: 3000, elasticity: 0}
					]
					opacity: [
						{value: [0.1,1]}
						{value: 0.1, delay: 3100}
					]
				)
				return


		computed:
			logoProgressStyles: ->
				return
					bottom: "-#{@width/2}px"
					'margin-left': "-#{@width/2}px"
					backgroundImage: "url('#{@bgImg}')"
					'background-size': "#{@width - @strokeWidth*4}px"
					'box-shadow': "0 0 0 #{@strokeWidth*2}px #fff, inset 0 0 0 #{@strokeWidth*4}px #fff"
					height: "#{@width}px"
					width: "#{@width}px"
			overlayStatusStyles: ->
				return
					height: "#{@width}px"
					width: "#{@width}px"
			iconStyles: ->
				'line-height': "#{@width}px"
			animate: ->
				if @status in ['success', 'error']
					return 'animate'
			iconClass: ->
				# if @status is 'err'
				switch @status
					when 'success'
						return 'el-icon-check'
					when 'error'
						return 'el-icon-close'



			relativeStrokeWidth: ->
				return (@strokeWidth / @width * 100).toFixed 1
			trackPath: ->
				R = parseInt(50 - (parseFloat(@relativeStrokeWidth)/2), 10)
				return "M 50 50 m 0 -#{R} a #{R} #{R} 0 1 1 0 #{R * 2} a #{R} #{R} 0 1 1 0 -#{R * 2}"
			perimeter: ->
				R = 50 - (parseFloat(@relativeStrokeWidth)/2)
				return 2 * Math.PI * R
			circlePathStyle: ->
				perimeter = @perimeter
				return {
					strokeDasharray: "#{@perimeter}px, #{@perimeter}px"
					strokeDashoffset: (1 - @percentage / 100) * perimeter + 'px'
					transition: 'stroke-dashoffset 0.6s ease 0s, stroke 0.6s ease'
				}
			stroke: ->
				ret = undefined
				switch @status
					when 'success'
						ret = '#13ce66'
						if @percentage is 100
							ret = '#eef1f6'
					# when 'success' and @percentage is 100
					when 'error'
						ret = '#ff4949'
					else
						ret = '#20a0ff'
				return ret

	}

</script>



<style lang="stylus">
	.logo_progress
		position: absolute
		left: 50%
		background: none
		background-color: #fff
		border-radius: 50%
		background-repeat: no-repeat
		background-position: 50% 50%
		box-shadow: 0 0 0 5px #fff, inset 0 0 0 1px #fff

	.overlay-status
		position: absolute
		background: #eef1f6
		border-radius: 50%
		top: 0
		/*transition: 3s*/
		opacity: 0.01
		will-change: transform, opacity
		transform: scale(0)

		/*&.animate
			animation: sss 3s cubic-bezier(.34,-0.48,.51,1.51)*/

		&.success
			background: #13ce66
		&.error
			background: #ff4949

		i
			text-align: center
			color: #fff
			width: 100%


	@keyframes sss
		from, to
			transform: scale(0)
			opacity: 0
		25%, 75%
			opacity: 1
			transform: scale(1.2)


</style>
