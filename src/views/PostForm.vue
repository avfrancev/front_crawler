<template lang="pug">
  div
    p as

    a(:href="post.link")
      h1 {{post.title}}
    pre {{post}}
</template>

<script lang="coffee">
  import gql from 'graphql-tag'


  export default {
    data: ->
      post: ''
    created: ->
      console.log @$route.params.id
    apollo:
      post: ->
        query: gql ["""
          query getPost ($id: String!) {
            post(id: $id) {
              id
              title
              link
              owner {
                username
              }
              item {
                id
                name
                postsCount
                data {
                  depth
                  loading
                }
                posts {
                  title
                  owner {
                    username
                  }
                }
              }
            }
          }
        """]
        variables: ->
          id: @$route.params.id

      $subscribe:
        postChange:
          query: gql ["""
            subscription ppp {
              PostChange {
                id
                title
                link
              }
            }
          """]
          result: (console.log )

  }
</script>
