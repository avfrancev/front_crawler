<template lang="pug">
	div.posts_filter
		div
			el-input(v-model='state.postsFilters.searchQuery' placeholder="Search ..." prefix-icon="el-icon-search")
		div(style="text-align: center")
			//- span per page
			//- br
			//- br
			//- el-input-number( size="mini" type="number" v-model.number="state.postsFilters.limit")
			Counter(
				name="per page"
				v-model="state.postsFilters.limit"
				:min="1" :max="24"
				@update="updateCounter"
				editable=)
		div
			el-select(v-model="state.postsFilters.itemIds" placeholder='Select item ...' multiple clearable style="width:100%" popper-class='xxx-pop')
				el-option(
					v-for="item in items"
					:key="item.id"
					:value="item.id"
					:label="item.full_name"
					)
					span(style="margin: 0 20px 0 0") [ {{item.postsCount}} ]
					span {{item.full_name}}
			el-select(v-model="state.postsFilters.published" clearable placeholder='Select publish state ...' popper-class='xxx-pop')
				el-option(:value="true" label="Published")
				el-option(:value="false" label="Unpublished")
		//- el-button(@click="$store.commit('UPDATE_POSTSFILTERS', {payload: {limit: 10, filter: {}}})") change state
		//- pre {{postsFilters}}
</template>




<script lang="coffee">
	export default {

		components: {
			Counter: require '@/components/Counter'
		}

		data: ->
			state: require('@/store/index.coffee').default

		methods:
			updateCounter: (field) -> @state.postsFilters.limit = field['editable']

		apollo:
			items:
				query: require('graphql-tag') ["""
				{
					items {
						id
						full_name
						postsCount
					}
				}
				"""]

	}
</script>




<style scoped media="screen" lang="stylus">
	@import './../styles/vars.styl'
	.posts_filter
		--my-reusable-value: 20px
		padding: var(--my-reusable-value)
		color: $Extra_Light_Silver
</style>
