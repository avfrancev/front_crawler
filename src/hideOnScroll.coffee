window.onload = ->
	didScroll = undefined
	lastScrollTop = 0
	delta = 55
	view = document.querySelector('#router-view')
	fakeTop = document.querySelector('#fakeTop')
	navTop = document.querySelector('#top')
	# navbarHeight = navTop.outerHeight()

	view.addEventListener 'scroll', (event) ->
		didScroll = true
		return

	setInterval (->
		if didScroll
			hasScrolled()
			didScroll = false
		return
	), 250

	hasScrolled = ->
		st = view.scrollTop

		if Math.abs(lastScrollTop - st) <= delta
			return

		if st > lastScrollTop and st > 90
			navTop.classList.add 'nav-up'
			fakeTop.classList.add 'nav-up'
			navTop.classList.remove 'nav-down'
			fakeTop.classList.remove 'nav-down'
		else
			navTop.classList.add 'nav-down'
			fakeTop.classList.add 'nav-down'
			navTop.classList.remove 'nav-up'
			fakeTop.classList.remove 'nav-up'

		lastScrollTop = st

		return
