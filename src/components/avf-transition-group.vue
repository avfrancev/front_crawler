<template lang="pug">
	transition-group(
		:name="name"
		tag="div"
		v-on:before-leave="beforeLeave"
		)
		slot
</template>

<script lang="coffee">
export default {

	props:
		name:
			type: String
			default: 'xxx'

	methods:
		beforeLeave: (el) ->
			{marginLeft, marginTop, width, height} = window.getComputedStyle(el)
			el.style.left = "#{el.offsetLeft - parseFloat(marginLeft, 10)}px"
			el.style.top = "#{el.offsetTop}"
			el.style.width = width
			el.style.height = height
			return


}
</script>

<style lang="stylus">


.xxx-item
	transition: all 400ms
	opacity: 1

.xxx-enter-active
	transition-delay: .2s

.xxx-enter, .xxx-leave-to
	opacity: 0.01
	transform: scaleY(0.2)

.xxx-leave-active
	position: absolute


</style>
