import Vue from 'vue'
import { sync } from 'vuex-router-sync'
// import App from './components/App'
import Layout from './views/Layout.vue'
import router from './router/index.coffee'
import store from './store'

import Element from 'element-ui'

import 'element-ui/lib/theme-default/index.css'
Vue.use(Element)

import VueCodeMirror from 'vue-codemirror-lite'
import 'codemirror/mode/coffeescript/coffeescript.js'
import 'codemirror/theme/dracula.css'
import 'codemirror/addon/comment/comment.js'

Vue.use(VueCodeMirror)


import { ApolloClient, createNetworkInterface } from 'apollo-client'
// New Imports
import { SubscriptionClient, addGraphQLSubscriptions } from 'subscriptions-transport-ws'
import VueApollo from 'vue-apollo'

// Create the network interface
const networkInterface = createNetworkInterface({
  uri: `http://${location.hostname}:3020/graphql`,
  transportBatching: true,
})

// Create the subscription websocket client
const wsClient = new SubscriptionClient('ws://localhost:3020/subscriptions', {
  reconnect: true,
})

// Extend the network interface with the subscription client
const networkInterfaceWithSubscriptions = addGraphQLSubscriptions(
  networkInterface,
  wsClient,
)

// Create the apollo client with the new network interface
const apolloClient = new ApolloClient({
  networkInterface: networkInterfaceWithSubscriptions,
  connectToDevTools: true,
})

// Install the plugin like before
Vue.use(VueApollo, {
  apolloClient,
})

Vue.config.productionTip = false


const apolloProvider = new VueApollo({
  defaultClient: apolloClient,
})

sync(store, router)

const app = new Vue({
  router,
  store,
  apolloProvider,
  ...Layout
})

export { app, router, store }
