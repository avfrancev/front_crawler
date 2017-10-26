import { ApolloClient, createBatchingNetworkInterface } from 'apollo-client'
import { SubscriptionClient, addGraphQLSubscriptions } from 'subscriptions-transport-ws'

config =
	crawler_host: 'avfrancev.ddns.net'
	# crawler_host: '192.168.1.5'

networkInterface = createBatchingNetworkInterface(uri: "https://#{config.crawler_host}:3021/graphql")
wsClient = new SubscriptionClient("wss://#{config.crawler_host}:3021/subscriptions", reconnect: true)

networkInterfaceWithSubscriptions = addGraphQLSubscriptions(networkInterface, wsClient)

apolloClient = new ApolloClient(
	networkInterface: networkInterfaceWithSubscriptions
	# connectToDevTools: true
	dataIdFromObject: (o) -> o.id
)

export default apolloClient
