{def $rootNodeID = ezini( 'NodeSettings', 'RootNode', 'content.ini' )}

{def $rootNode = fetch( 'content', 'node', hash('node_id', $rootNodeID))}

{$rootNode.data_map.analytics_script.data_text}
