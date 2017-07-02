<template lang="pug">
  div
    h1 Posts
    .post-link(
      v-for="post in posts"
      :key="post.id"
    )
      b(@click.prevent="log(post)") {{post.item.full_name}}
      br
      br
      router-link(
        :to="{name: 'post', params: {id: post.id} }"
        ) {{post.title}}
      //div {{post.item.name}}
      hr
</template>

<script lang="coffee">
  import gql from 'graphql-tag'


  export default {
    data: ->
      posts: []
      item: {}
    methods:
      log: (x) -> console.log(x)
    apollo:
      posts:
        query: gql ["""
          {
            posts(limit: 122) {
              id
              title
              itemId
              item {
                id
                name
                full_name
              }
            }
          }
        """]
        variables:
          limit: 0

      $subscribe:
        postChange:
          query: gql ["""
            subscription ppp {
              PostChange {
                id
                title
              }
            }
          """]
          result: (console.log )
  }
</script>

<style media="screen">
  .post-link {
    display: block
  }
</style>
