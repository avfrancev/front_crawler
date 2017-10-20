<template lang="pug">
  div
    .inner-content
      h1 Login
      hr
      el-form
        el-form-item(label="username")
          el-input(v-model="user.username")
        el-form-item(label="password")
          el-input(v-model="user.password")
      el-button(v-if="!$auth.token()" @click.prevent="login") LOGIN
      el-button(v-if="$auth.token()" @click.prevent="logout") LOG OUT !!!
      hr
      h1(v-if="$auth.check('authenticated')") authenticated
      pre auth.token: {{$auth.token()}}
      pre auth.check: {{$auth.check()}}
      pre auth.user: {{$auth.user()}}
</template>




<script lang="coffee">


  export default {
    data: ->
      user: {}
    methods:
      login: ->
        console.log @user
        @$auth.login
          data: @user
          rememberMe: true
          redirect: '/'
          fetchUser: true
          success: (d) ->
            console.log 'SUCCESS ', d
            # app.$auth.currentToken = d.data.data.token
            # localStorage.setItem 'currentToken', d.data.data.token
            return
          error: (res) ->
            console.error res
            return
      logout: ->
        this.$auth.logout
          makeRequest: false
  }
</script>

<style media="screen">
  .item-link {
    display: block
  }
</style>
