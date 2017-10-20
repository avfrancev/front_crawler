<template lang="pug">
  div
    h1 Items
    .item-link(
      v-for="item in items"
      :key="item.id"
    )
      router-link(
        :to="{name: 'item_view', params: {id: item.id} }"
        ) {{item.full_name}} ({{}})
      br
      br
      //div {{item.item.name}}
      hr
</template>

<script lang="coffee">
  import gql from 'graphql-tag'


  export default {
    data: ->
      items: []
    methods:
      log: (x) -> console.log(x)
    apollo:
      items:
        query: gql ["""
          {
            items {
              id
              name
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
          result: (console.log )
  }
</script>

<style media="screen">
  .item-link {
    display: block
  }
</style>
