import Vue from 'vue'
import { sync } from 'vuex-router-sync'
import Layout from './views/Layout.vue'
import router from './router/index.coffee'
import store from './store'

import Element from 'element-ui'

import 'element-ui/lib/theme-default/index.css'
Vue.use Element


import VueCodeMirror from 'vue-codemirror-lite'
import 'codemirror/mode/coffeescript/coffeescript.js'
import 'codemirror/theme/dracula.css'
import 'codemirror/addon/comment/comment.js'

Vue.use VueCodeMirror



import { ApolloClient, createNetworkInterface } from 'apollo-client'
import { SubscriptionClient, addGraphQLSubscriptions } from 'subscriptions-transport-ws'
import VueApollo from 'vue-apollo'

networkInterface = createNetworkInterface
  uri: "http://#{location.hostname}:3020/graphql"
  transportBatching: true

wsClient = new SubscriptionClient("ws://#{location.hostname}:3020/subscriptions", reconnect: true)

networkInterfaceWithSubscriptions = addGraphQLSubscriptions(networkInterface, wsClient)


apolloClient = new ApolloClient {
  networkInterface: networkInterfaceWithSubscriptions
  connectToDevTools: true
}

Vue.use VueApollo, apolloClient: apolloClient


Vue.config.productionTip = false


apolloProvider = new VueApollo {
  defaultClient: apolloClient
}



sync store, router



# ================= AUTH =================

Vue.router = router
import axios from 'axios'
import VueAxios from 'vue-axios'
import VueAuth from '@websanova/vue-auth'

Vue.use VueAxios, axios

Vue.axios.defaults.baseURL = "http://#{location.hostname}:3020"

Vue.use VueAuth,
  http: require('@websanova/vue-auth/drivers/http/axios.1.x.js')
  router: require('@websanova/vue-auth/drivers/router/vue-router.2.x.js')
  refreshData: enabled: false
  rolesVar: 'groups'
  auth:
    request: (req, token) ->
      console.log req
      @options.http._setHeaders.call(this, req, {Authorization: 'JWT ' + token})
    response: (res) ->
      console.log res
      (res.data.data || {}).token
  parseUserData: (data) ->
    console.log data
    data.data


# ================= \AUTH\ =================


app = new Vue Object.assign {
  router
  store
  apolloProvider
}, Layout


export { app, router, store }
