<template lang="pug">
  div
    a(:href="post.link")
      h1 {{post.title}}
    router-link.el-button(
      v-if="canEdit"
      :to="{ name: 'post_edit', params: { id: post.id } }"
      ) Edit
    pre {{post}}
</template>

<script lang="coffee">
  import gql from 'graphql-tag'


  export default {
    data: ->
      post: ''

    computed:
      canEdit: ->
        @post.owner?.id is @$auth.user?.id

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
