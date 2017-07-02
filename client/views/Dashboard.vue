<template lang="pug">
	div#dashboard
		//- el-row(:gutter="10")
		//- 	el-col(:sm="12" :md="8")
		.items.grid-4-equalHeight_xs-1_sm-2_md-2_lg-3
			.col(v-for="item of items")
				h3 {{item.full_name}}
				//- Item(:item="item")
		//- pre {{items}}
</template>

<script lang="coffee">

	import gql from 'graphql-tag'

	export default {
		name: 'Dashboard'

		data: ->
			items: []

		apollo:
			items:
        query: gql ["""
          {
            items {
              id
              name
							logo
              full_name
            }
          }
        """]
        variables:
          limit: 0

      $subscribe:
        itemChange:
          query: gql ["""
            subscription ppp {
              ItemChange {
                id
                name
                full_name
              }
            }
          """]

	}

</script>

<style lang="postcss">
	.items
		margin: 1em 0.5em
</style>
