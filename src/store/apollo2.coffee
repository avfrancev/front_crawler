# import ApolloClient from 'apollo-client'
# import { HttpLink } from 'apollo-link-http'
# import { InMemoryCache } from 'apollo-cache-inmemory'
#
#
# client = new ApolloClient(
# 	link: new HttpLink(uri: 'https://avfrancev.ddns.net:3021/graphql')
# 	cache: (new InMemoryCache).restore(window.__APOLLO_STATE__))
#
# import {items} from '../schemas.coffee'
#
# client.query(query: items).then (r) ->
# 	console.log r
# 	return
