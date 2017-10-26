import Vue from 'vue'
import VueViewports from 'vue-viewports'
require('@/hideOnScroll.coffee')

Vue.use VueViewports,
	0: 'xs'
	576: 'sm'
	768: 'md'
	992: 'lg'
	1200: 'xlg'
	1600: 'qhd-desktop'
	3840: 'uhd-desktop'


# import { sync } from 'vuex-router-sync'
# import Layout from '@/views/Layout.vue'
import Layout from '@/views/LayoutCool.vue'
import router from '@/router/index.coffee'
# import store from './store/index.coffee'

import Element from 'element-ui'

Vue.use Element


import VueCodeMirror from 'vue-codemirror-lite'
import 'codemirror/mode/coffeescript/coffeescript.js'
import 'codemirror/theme/dracula.css'
import 'codemirror/addon/comment/comment.js'

Vue.use VueCodeMirror

config =
	crawler_host: 'avfrancev.ddns.net'
	# crawler_host: '192.168.1.5'


# ================= AUTH =================

Vue.router = router
import axios from 'axios'
import VueAxios from 'vue-axios'
import VueAuth from '@websanova/vue-auth'

Vue.use VueAxios, axios

Vue.axios.defaults.baseURL = "https://#{config.crawler_host}:3021"

Vue.use VueAuth,
	http: require('@websanova/vue-auth/drivers/http/axios.1.x.js')
	router: require('@websanova/vue-auth/drivers/router/vue-router.2.x.js')
	refreshData: enabled: false
	rolesVar: 'groups'
	auth:
		request: (req, token) ->
			# console.log req
			@options.http._setHeaders.call(this, req, {Authorization: 'JWT ' + token})
		response: (res) ->
			# console.log res
			(res.data.data || {}).token
	parseUserData: (data) ->
		# console.log data
		data.data


# ================= \AUTH\ =================



#################### APOLLO #######################


import { ApolloClient, createBatchingNetworkInterface } from 'apollo-client'
import { SubscriptionClient, addGraphQLSubscriptions } from 'subscriptions-transport-ws'
# import { SubscriptionClient } from 'subscriptions-transport-ws'
# import { addGraphQLSubscriptions } from 'add-graphql-subscriptions'
import VueApollo from 'vue-apollo'

# import { ApolloClient, createNetworkInterface } from 'apollo-client'
# import { SubscriptionClient, addGraphQLSubscriptions } from 'subscriptions-transport-ws'

networkInterface = createBatchingNetworkInterface(uri: "https://#{config.crawler_host}:3021/graphql")
wsClient = new SubscriptionClient("wss://#{config.crawler_host}:3021/subscriptions", reconnect: true)

networkInterfaceWithSubscriptions = addGraphQLSubscriptions(networkInterface, wsClient)

apolloClient = new ApolloClient(
	networkInterface: networkInterfaceWithSubscriptions
	connectToDevTools: true)

Vue.use(VueApollo)

loading = 0

apolloProvider = new VueApollo(
	clients: a: apolloClient
	defaultClient: apolloClient
	defaultOptions: {}
	# watchLoading: (state, mod) ->
	# 	loading += mod
	# 	console.log 'Global loading', loading, mod
	# 	return
	# errorHandler: (error) ->
	# 	console.log 'Global error handler'
	# 	console.error error
	# 	return
)

###########################################


# sync store, router
import moment from 'moment'
Vue.prototype.$moment = moment
Vue.config.productionTip = false


app = new Vue {
	router
	# store
	apolloProvider
	Layout...
}

app.$mount('#app')
